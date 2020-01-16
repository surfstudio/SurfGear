# MWWM

Software architectural pattern for Flutter apps.

## Description

MWWM is based on principles of Clean Architecture and is a variation of *MVVM*.

It consists of three parts: *Widget*, *WidgetModel* and *Model*.

**Widget** — a representation layer that contains only UI related code. 

**WidgetModel** - handles and accumulates all data needed for Widget:
objects of the domain layer, scroll position, text fields values, animation state, etc.
WidgetModel uses Model for interaction with various data sources.

**Model** - a link between WidgetModel and "the external world": data sources,
services or other abstraction layers. It allows to develop both separately and have
a possibility to modify one layer with no need for changing the other. Model is
represented by two components: **Change** (a signal to model which means *what* we want
to achieve) and **Performer** (that knows *how* to achieve it).

![](images/mwwm.png) 