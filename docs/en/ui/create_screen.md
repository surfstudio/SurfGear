[Main](../main.md)

# Checklist for creating a screen/widget

1. Create `WidgetModel`and describe its dependencies in the constructor parameters.

1. Create a `Component`, in which we find the necessary dependencies.

1. We write a `function-builder` that returns a WidgetModel. Inside the builder using Injector we find Component and pass all the dependencies to the WidgetModel constructor.

1. We create `MwwmWidget`, in super we pass the Component builder, the WidgetModel builder and the WidgetState builder.

1. Create `WidgetState`.

Now in WidgetState you can describe the user interface, and in WidgetModel - the logic and set of StreamedState for storing data and Action for processing user input events.