[Main](../main.md)

# Adding dependencies (before adding to pub.dev)

In the case when you need to connect a dependency that has not yet been published, you need to connect it
locally. If you connect via a direct link to git, you can get the problem of resolving dependencies.
Adding example:

```
  logger:
      path: ../logger
```