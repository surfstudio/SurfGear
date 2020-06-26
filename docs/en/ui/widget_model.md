[Main](../main.md)

[UI Structure](structure.md)

# WidgetModel

This entity is a ViewModel of MVVM.
This entity describes the logic of a particular screen.
You can also draw an analogy with BLoC, but only in terms of the mechanism of interaction.

Working with View (Widget) is done through the stream. 
WM knows nothing about the specific widget that uses it.

Core WidgetModel components — `Events`:
 - Action — Stream representation of an action, for example, clicking on a button or changing focus.
 - StreamedState — streaming representation of a property, for example, a product counter or the enable state of a button.
 - EntityStreamedState - inherits StreamedState, additionally has a load state and errors.
 - additional logic that links Action and State.

WM is an intermediate link between Model (in any its variant) and Widget.

Dependencies from Model are also delivered to WM via the constructor.
In our projects, [Injector](../../../packages/injector/lib/src/injector.dart) is used to provide DI.
Dependencies for WidgetModel are configured in the screen component.
The object [WidgetModelDependencies](../../../packages/mwwm/lib/src/dependencies/wm_dependencies.dart) is used for this. It contains an ErrorHandler - an object responsible for handling errors for reactive streams.
Without WidgetModelDependencies configuration, error handling will not work in WidgetModel.