[Main](../main.md)

# Model

Model - a layer between [WidgetModel](../ui/widget_model.md) and business logic, which abstracts
the receiver of data (WidgetModel) from their provider (repository, service, storage, etc.). 
The Model allows you to describe the interaction contract between the presentation layer 
and the service layer and develop them independently from each other. Consists of two main parts:

**Change** — a signal sent to the model that you need to perform some action: for example, upload or send data.

**Performer** — class responsible for handling a specific **Change**. 
It is the link between WidgetModel, which requests a specific data set, and the source of this data.

The model itself simply passes the incoming **Change** to **Performer**, which can handle it.