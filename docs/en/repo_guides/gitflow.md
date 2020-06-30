[Main](../main.md)

# Gitflow in repository

## Commits

All commit masseges must be written in English. The message of the commit should reflect the summary of the changes.

The commit should contain:

- Comprehensive information on changes in **English**

- Link to task in Jira or GitLab at the beginning of the commit

- Enumeration of deprecated code

Example: **"ANNDEP-23 add new LoadState. Deprecated: LoadStateUtil."**

## Branches

- **stable** — main branch of stable packages. Versioning occurs through TAGs.

- **dev** — development branch. All tasks or changes initially merge into this branch.
This branch merges into **stable** without closing.

- **project-*name*** (for example, project-ACME) - project branches. They contain changes that appear during a specific project.

- **task/feature** - other branches for specific tasks. Checkout from **dev** and merged into it.
The branch name **must** contains the identifier of the task or the label **no-task**.

## Stable branch changes

A stable branch is changed through the creation of a pull request. After the merge, the version is upgraded,
a tag is placed for this (see [Semantic Versioning](https://semver.org))

## Versioning project branches

Design branches need to be tagged with changes. 
The tag is set automatically when merging the pull request into the project branch.

Tag format:
```
project-*name*-i, where i is a number that is constantly increasing by one.
```
After changes in the project branch in the pubspec of the project itself, it is necessary to update the tag for all connected modules.
