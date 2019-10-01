# datalist limit-offset
The main entity - [`OffsetDataList`] [dl_offset] - a list for paginated data through the limit / offset mechanism
Has methods:
  1. `merge (DataList data)`, which allows you to combine 2 data blocks. The input should be only OffsetDataList
  2. `int nextOffset` - returns the offset for the trace of the data block
  3. `bool canGetMore` - indicates whether more data can be loaded
  1. `#transform ()` - to convert data in a list

It can combine two subsequent blocks, and in reverse order.

[dl_offset]: lib/src/impl/datalist_limit_offset.dart

# DataList page-count
The main entity - [`PageCountDataList`] [dl_pagecount] - a list of paginated data through the page / count mechanism
Has methods:
  1. `merge (DataList data)`, which allows you to combine 2 data blocks. Input should be only PageCount DataList
  2. `int getNextPage ()` - returns the number of the trace of the data block
  3. `bool canGetMore` - indicates whether more data can be loaded
  1. `#transform ()` - to convert data in a list

It can combine two subsequent blocks, and in reverse order.

[dl_pagecount]: lib/src/impl/datalist_page_count.dart