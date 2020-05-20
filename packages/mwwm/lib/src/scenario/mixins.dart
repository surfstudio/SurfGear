/// Миксмн для вызова функции
mixin CallerFunction<R> {
    void callFn<R>(Function fn, [R data]) {
      fn?.call(data);
    }
}