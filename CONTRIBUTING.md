# Contributing rules

Thank you for your help! Before you start, let's take a look at some agreements.

## Pull request rules

Make sure that your code:

1. Does not contain analyzer errors
2. Follows a [official style](https://dart.dev/guides/language/effective-dart/style)
3. Follows the official [style of formatting](https://flutter.dev/docs/development/tools/formatting)
4. Contains no errors
5. New functionality is covered by tests. New functionality passes old tests
6. Create example that demonstrate new functionality if it is possible

## Accepting the changes

After your pull request passes the review code, the project maintainers will merge the changes into the branch to which the pull request was sent.

## Issues

Feel free to report any issues and bugs.

1. To report about the problem, create an issue on GithHub
2. In the issue add the description of the problem
3. Do not forget to mention your development environment, Flutter version, libraries required for illustration of the problem
4. It is necessary to attach the code part that causes an issue or to make a small demo project that shows the issue
5. Attach stack trace so it helps us to deal with the issue
6. If the issue is related to graphics, screen recording is required

## How to update package

All packages uses [semver](https://semver.org/) form for maintaining versions.

Meaning that, versions contains 3 numbers: `MAJOR.MINOR.PATCH`.

For example, you'd like to create a patch, that doesn't break backward compatibility.

1. Create branch from `main` with name describing patch update.
2. Make some package updates.
3. Update package `Changelog` file with following lines:

    ``` markdown
    ## PATCH

    * short summary of proposed changes

    ```

4. Create PR and add reviewer.

When reviewer accepts your PR, and merge it into `main` branch, [GH Actions script](https://github.com/surfstudio/SurfGear/blob/main/.github/workflows/publish_to_pub.yaml) will analyse `Changelog` file for MAJOR, MINOR or PATCH tag. Selecting the highest severity of changes updates the corresponding digit in the package version, then cleans the semver tags from the changelog and publishes the package.

Note that you don't need to update version in pubspec.yaml. The script does it for you.

So, your `Changelog` updates will be replaced with

``` markdown
## latest-stable-version-dev.xx

* short summary of proposed changes (PATCH … )

```
