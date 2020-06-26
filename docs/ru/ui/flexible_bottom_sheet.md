# FlexibleBottomSheet

[Main](../main.md)

This BottomSheet widget has next behaviour:

1. It has a size limits on top and bottom, that can be set as absolute value or part of parent
container.
2. If it has list child, first it resize up and when top limit has been reached it start scrolling
list content. 
3. Use building function for changing view.
4. Can be imperatively called by showFlexibleBottomSheet(), or use for show it special controller.

During development, various options for implementation approaches were tried.

- To control the scroll controller through the GestureDetector. As a result, we got many problems
with switching behavior to scroll and back.
Also scrolling gesture was captured by GestureDetector instead transmit to Scrollable.
- Use Scrollable with set them setCanDrag off or setIgnorePointer. Not worked -
errors of replaceSemanticsActions when building layout.
- Use ViewPort in widget and build them, this option work partially correct, but we lost any physic
and troubles with scroll view in content.
- IgnorePointer with a GestureDetector, troubles like a first option.
- Gesture event generation also not possible. Renders bound with BindingBase, that get events from
engine, so we can't interact with this level.

As a result, we received implementation of DraggableScrollableSheet.
https://api.flutter.dev/flutter/widgets/DraggableScrollableSheet-class.html

During the search for a solution, the principle of operation ScrollableView was studied in detail and we 
have built a schema.
https://drive.google.com/file/d/1i2s49pMOJNh-ZAhkNwMYgRoONX1jjx_y/view?usp=sharing