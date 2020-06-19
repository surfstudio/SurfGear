[Main](../main.md)

# Architecture

The architecture of the projects is based on the adapted Clean Architecture.
The UI layer is based on a variation of MVVM + a bit of MVI.

Identified the following layers:

**Widget** - UI layer, contains only declarative logic. Interacts with WidgetModel through *Action* and *StreamedState* (in fact analog binding in mvvm).

**WidgetModel** - associates a widget layer with business logic through a model. May contain the logic needed for the UI layer.

**Model** - WidgetModel link layer with pure business logic. It is a set of contracts (performer) that a model can execute. Each contract is an isolated atomic part of the business logic. WidgetModel initiates an action with a change message (change). The model searches for the contract corresponding to this change and executes it.

**BusinessLogic** - the business logic layer, contains pure dart logic, is completely independent of Flutter.

![](../images/mwwm.png) 

The business logic layer usually contains the following types of entities, each of which has its own area of responsibility.

**Interactor**

An interactor is an entity that implements the logic of some business process. The interactor is platform independent, it only implements the use case logic.

**Repository**

Speaking about repositories, we should recall the pattern, which is actually called the “Repository”. The main idea is to create a layer of abstraction over any specific data sources, for example, a database or a web service. The purpose of the repository is to become an intermediary between those who request data and those who give it. It is important to understand that everything above the repository should not know how it is organized and where it gets this data from. This can be a network request, a request to the database, or all together, the so-called hybrid request, which implies the concatenation of requests to the server and cache according to some rule you set.

**Storage**

Data Source Wrap. Following the principles of SOLID, each class must have a single responsibility. You cannot mix the logic of several classes into one. The Storage entity is designed to abstract the operation of data storage. For example, there is a case when you need to save user data to a local device. You have to do it in various formats. For example xml and json. In this case, the correct solution would be to implement a separately low-level api for working with the device’s file system - FileSystem. Then implement two "wrappers" JsonStorage and XmlStorage, which will use the FileSystem to access the file system, and the data storage logic will be implemented directly in these classes.

**Mapper**

An object that transform one data type to another.