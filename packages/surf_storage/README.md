#### [SurfGear](https://github.com/surfstudio/SurfGear)

# surf_storage

Data storage wrap.
Based on LocalStorage data storage wrap, simple json storage.

## Discription

Main class:
1. [JsonStorage](lib/impl/json_storage.dart)

#### Usage
`key` is used as a filename
```
Storage storage = JsonStorage(key);
```

Saves object by `key` to a storage. 
`value` should be json encodable.(`json.encode()` is called under the hood).
```
    storage.put(key, value);
```

Removes object from storage by key
```
    storage.remove(key);
```

Get object or null if it doesn't exist
```
storage.get(key);
```

Removes all object from localstorage
```
storage.clean();
```