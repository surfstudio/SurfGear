[Main](../main.md)

# Messages

The principle of working with messages is the same with [dialogs](../ui/dialog.md).

To work with messages, you need to connect the implementation
of the abstract class MessageController to WidgetModel. For example MaterialMessageController.
To display the message, you must call the method - `_msgController.show(type, msg: “message“)`.
By default, customizing the design of the message is not necessary, it takes the form of a standard snack.

To customize the design of the message, mixin CustomSnackBarOwner is used.
This entity is implemented on the necessary screen and connected to MessageController,
which is used to display dialogs in WidgetModel. Thus, customization of appearance
messages occur on the ui layer, and processing logic in WidgetModel, while maintaining the principle
of single responsibility.

The implementation of the message invocation logic occurs only in the WidgetModel entity.