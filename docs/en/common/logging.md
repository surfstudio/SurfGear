[Main](../main.md)

# Logging

[Logging module discription](../../../packages/surf_logger/README.md)

Be sure to log:

* Url requests and server response status.

* Non-fatal exceptions: the state of the application when something went wrong,
but the application continues to work. For example, incorrect parsing of the server response.

* State's main events.

**IMPORTANT** :

- Logs that do not carry important information should be deleted.

- Rx stream error handlers must not be left empty.