# Data list

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/datalist)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/SurfGear?flag=datalist&logo=codecov&logoColor=white)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/datalist?logo=dart&logoColor=white)](https://pub.dev/packages/datalist)
[![Pub Likes](https://badgen.net/pub/likes/datalist)](https://pub.dev/packages/datalist)
[![Pub popularity](https://badgen.net/pub/popularity/datalist)](https://pub.dev/packages/datalist/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/datalist)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

## Usage

### Data list limit-offset

The main entity - [`OffsetDataList`][dl_offset] - a list for paginated data through the limit / offset mechanism
Has methods:
  1. `merge (DataList data)`, which allows you to combine 2 data blocks. The input should be only OffsetDataList
  2. `int nextOffset` - returns the offset for the trace of the data block
  3. `bool canGetMore` - indicates whether more data can be loaded
  1. `#transform ()` - to convert data in a list

It can combine two subsequent blocks, and in reverse order.

[dl_offset]: lib/src/impl/datalist_limit_offset.dart

### Data list page-count

The main entity - [`PageCountDataList`][dl_pagecount] - a list of paginated data through the page / count mechanism
Has methods:
  1. `merge (DataList data)`, which allows you to combine 2 data blocks. Input should be only PageCount DataList
  2. `int getNextPage ()` - returns the number of the trace of the data block
  3. `bool canGetMore` - indicates whether more data can be loaded
  1. `#transform ()` - to convert data in a list

It can combine two subsequent blocks, and in reverse order.

[dl_pagecount]: lib/src/impl/datalist_page_count.dart

## Installation

Add `datalist` to your `pubspec.yaml` file:

```yaml
dependencies:
  datalist: ^1.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

For issues, file directly in the [main SurfGear repo](https://github.com/surfstudio/SurfGear).

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
