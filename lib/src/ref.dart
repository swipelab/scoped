import 'package:scoped/src/reactive.dart';

//Reactive Value
class Ref<T> with Reactive {
  Ref([this._value]);

  T _value;

  T get value => _value;

  bool get hasValue => _value != null;

  set value(T value) {
    _value = value;
    this.notify();
  }
}
