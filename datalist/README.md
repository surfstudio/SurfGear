# datalist limit-offset
Основная сущность - [`OffsetDataList`][dl_offset] - список для пагинируемых данных через механизм limit/offset
Имеет методы:
 1. `merge(DataList data)`, позволяющий обьединять 2 блока данных. На вход должен быть только OffsetDataList
 2. `int nextOffset` - возвращает смещение для след блока данных
 3. `bool canGetMore` - обозначает, можно ли загрузить еще данные
 1. `#transform()` - для преобразования данных в списке

Может объединять два последующих блока, так и в обратном порядке.

[dl_offset]: lib/src/datalist_offset.dart

# DataList page-count
Основная сущность - [`PageCountDataList`][dl_pagecount] - список для пагинируемых данных через механизм page/count
Имеет методы:
 1. `merge(DataList data)`, позволяющий обьединять 2 блока данных.  На вход должен быть только PageCount DataList
 2. `int getNextPage()` - возвращает номер след блока данных
 3. `bool canGetMore` - обозначает, можно ли загрузить еще данные
 1. `#transform()` - для преобразования данных в списке

Может объединять два последующих блока, так и в обратном порядке.

[dl_pagecount]: lib/src/datalist_pagecount.dart