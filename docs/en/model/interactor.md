[Main](../main.md)

# Interactor

An interactor is an entity that implements the logic of a certain business process. The interactor is platform independent, it only implements the use case logic, without affecting the ui logic.
The interactor is not attached to any screen. The same interactor can be used in multiple screens.

Typical use case:

The application has an authorization screen and an order screen.
It is necessary to check whether the user is currently logged in.
If yes, then when you open the application, transfer to the orders screen and show content that is available only to an authorized user.
If not, then stay on the authorization screen, but give the opportunity to view orders that are available to an unauthorized user.

To solve this problem, you should create an interactor that implements the logic of user authorization verification - AuthInteractor. In this interactor, a local token is obtained through the TokenRepository.
Next, the interactor makes a request to the server through AuthRepository with a check on the validity of the current token and returns the result.
Thus, the interactor combines the work of several repositories and performs the use case that is needed in a particular place.

To check whether the user is currently logged in, AuthInteractor can be used both on the authorization screen and on the order display screen.

Interactors interact with the presentation layer only through the WidgetModel entity.

The public methods of the Interactive API are primarily based on Rx.

## Sample entities belonging to the Interactor layer

Consider the most common entities that belong to this layer.

### 1. Repository

Speaking about repositories, one should remember about the “Repository” design pattern. Its essence is to create a layer of abstraction over any specific data sources, for example, a database or a web service. The task of the repository is to become an intermediary between those who request data and those who give it.
It is important to understand that users of the repository should not know how it is organized and where it gets this data. This can be a network request, a request to the database, or all together, the so-called hybrid request, which involves concatenating requests to the server and cache according to some rule you set.

### 2. Storage

Storage is a wrapper over a data source with single responsibility. For example, you need to save user data to a local device in two different formats: xml and json. The correct solution would be to implement a low-level api to work with the FileSystem file system and two repositories JsonStorage and XmlStorage, which will use the FileSystem to access the file system, and the data storage logic will be implemented directly in these classes.

### 3. Mapper

A class that transform data from one type to another.

### 4. Initialization Interactor

Initialization of the application most often occurs on the splash screen.
Initialization is the execution of a certain set of rules on which the further 
behavior of the application depends. For example, migrating an application to a new 
version or getting and updating a token, getting a location, etc.

It is customary to select this logic in a separate interactor.

The interface of this interactor will be described by just one method - `initialize()`.

### 5. User session change interactor

This interactor is responsible for the actions that must be performed when changing the session or user. 
Such actions may include flushing the cache, requesting a logout, caching a token, etc.

## Events via Interactor

Another case for using interactors: building an event-based model of communication between parts of the application.
For example, some action on screen A should cause data to be updated on screen B.
Moreover, this action is not the result of screen A. 
Then you can forward the event through the common interactor for these screens.
This case shows that it is the priority to use the interactor to update the data, and not the result of the screen.
A route with parameters should be used where the return of the result is obvious, for example, a certain form that returns the completed data to the previous screen.
Forward of this event can be realized through the creation of Subject inside the interactor.

Пример: 
```dart
/// User Session Interactor
class SessionChangedInteractor {
  final AuthInfoStorage _ts;

  final PublishSubject<SessionState> sessionSubject = PublishSubject();

  SessionChangedInteractor(this._ts);

  void onSessionChanged() {
    sessionSubject.add(SessionState.LOGGED_IN);
  }

  void forceLogout() {
    sessionSubject.add(SessionState.LOGGED_OUT);
    silentLogout();
  }

  void silentLogout() {
    _ts.clearData();
  }
}

enum SessionState { LOGGED_IN, LOGGED_OUT }
```
Next, you need to connect the SessionChangedInteractor to WidgetModel and subscribe to the changes to sessionSubject:
```dart

class FirstWidgetModel {
   final SessionChangedInteractor _changeInteractor;
   
   Action sessionChangedAction = Action();
   
   FirstWidgetModel(WidgetModelDependencies baseDependencies,
        this._changeInteractor,) : super(baseDependencies); 
   
    @override
     void onLoad() {
      bind(sessionChangedAction, (_) => _changeInteractor.onSessionChanged());
       super.onLoad();
     }
}

class SecondWidgetModel {
   final SessionChangedInteractor _changeInteractor;
   
   SecondWidgetModel(WidgetModelDependencies baseDependencies,
        this._changeInteractor,) : super(baseDependencies);
   
    @override
     void onLoad() {
       subscribeHandleError(_changeInteractor.sessionSubject, (sessionState){
         print(sessionState.toString());});
       super.onLoad();
     }
}
```