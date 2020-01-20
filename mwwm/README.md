# MWWM

Software architectural pattern for flutter apps.

## Description

This architecture is based on fundamental principles of Clean Architecture and is a variation *MVVM*.

Can highlight that parts: *Widget*, *WidgetModel*, *Model*, *BusinessLogic*.

**Widget** - representation layer, that contains only daclaration of UI. This layer interact with WidgetModel by way like a binding in mvvm.

**WidgetModel** - communication layer between representation layer and business logic. It use Model layer for handle logic.

**Model** - set of contracts (performers) that it can execute. Performer is a link of business logic part. Widget model calls model do anything by changes. Model finds performer that appropriate with this change and execute it.

**BusinessLogic** - business logic layer. Pure dart code. Not depend from flutter.

![](doc/images/mwwm.png) 