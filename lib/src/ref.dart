import 'package:scoped/src/fluid.dart';

//Observable Value
class Ref<T> with Fluid {
  Ref([this._value]);

  T _value;

  T get value => _value;

  bool get hasValue => _value != null;

  set value(T value) {
    _value = value;
    this.notify();
  }
}
