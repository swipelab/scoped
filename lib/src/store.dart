enum _StoreFactoryType { transient, lazy, instance }

typedef StoreFactoryFunc<T> = T Function();

///Simple instance store
class Store {
  final _map = new Map<Type, _StoreFactory<dynamic>>();

  T get<T>() {
    _StoreFactory<T> sf = _map[T];
    if (sf == null) {
      throw new Exception("${T.toString()} is not mapped in store.");
    }
    return sf.instance;
  }

  call<T>() => get<T>();

  ///registers transient instances ( a new instance is provider per request )
  addTransient<T>(StoreFactoryFunc<T> func) {
    _map[T] = _StoreFactory<T>(_StoreFactoryType.transient, func: func);
  }

  ///registers lazy instances ( they get instantiated on first use )
  addLazy<T>(StoreFactoryFunc<T> func) {
    _map[T] = _StoreFactory<T>(_StoreFactoryType.lazy, func: func);
  }

  ///registers singleton instances
  add<T>(T instance) {
    _map[T] = _StoreFactory<T>(_StoreFactoryType.instance, instance: instance);
  }

  clear() {
    _map.clear();
  }
}

///StoreFactory
///a little functor to help provide the right instance
class _StoreFactory<T> {
  _StoreFactoryType type;
  final StoreFactoryFunc _func;
  Object _instance;

  _StoreFactory(this.type, {func, instance})
      : _func = func,
        _instance = instance;

  T get instance {
    try {
      switch (type) {
        case _StoreFactoryType.instance:
          return _instance as T;
        case _StoreFactoryType.lazy:
          if (_instance == null) {
            _instance = _func();
          }
          return _instance as T;
        case _StoreFactoryType.transient:
          return _func() as T;
      }
    } catch (e, s) {
      print("Error while creating ${T.toString()}");
      print('Stack trace:\n $s');
      rethrow;
    }
    return null; //this is only to silence the analyser
  }
}
