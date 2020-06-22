[Main](../main.md)

# UI Structure

In the presentation layer in studio projects, two main entities are used:

1. [Widget](widget.md) — user interface description

1. [WidgetModel](widget_model.md) — logic implementation

Each screen or widget that independently receives data from a network or local storage necessarily contains both components. If the screen or widget is quite simple, and all the necessary data can be obtained through the constructor, then WidgetModel is optional.