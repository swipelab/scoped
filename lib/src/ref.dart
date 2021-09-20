import 'package:scoped/src/reactive.dart';

class ReactiveController {
  final _reactives = <Reactive>[];

  add(Reactive reactive) => _reactives.add(reactive);
  remove(Reactive reactive) => _reactives.remove(reactive);
}

//Reactive Value
class Ref<T> with Reactive {
  Ref({
    required T value,
    ReactiveController? controller,
  })  : _value = value,
        _controller = controller {
    _controller?.add(this);
  }

  final ReactiveController? _controller;

  T _value;

  T get value => _value;

  bool get hasValue => _value != null;

  set value(T value) {
    _value = value;
    this.notify();
  }

  void dispose() {
    _controller?.remove(this);
  }
}
