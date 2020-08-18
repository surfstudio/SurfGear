# API Testing

To verify the execution of the request, you need to use api testing.

For this it is necessary:
- add interactor (including all its dependencies) with test method to MockAppComponent
- through expect(request, emits(*what we expect from the request*));

Testing is based on checking the value of Observable.
MockAppComponent is a component of testing the service layer.
Implements Interactor behavior by substituting test data.