import 'dart:async';

import 'package:flutter/widgets.dart';

typedef Widget ReactiveBuilderDelegate<T extends Reactive>(BuildContext context, T reactive);

class ReactiveBuilder<T extends Reactive> extends StatefulWidget {
  final T reactive;
  final ReactiveBuilderDelegate<T> builder;

  ReactiveBuilder({this.reactive, this.builder});

  _ReactiveBuilderState createState() => new _ReactiveBuilderState<T>();
}

class _ReactiveBuilderState<T extends Reactive> extends State<ReactiveBuilder<T>> {
  void _onChange() => setState(() {});

  void initState() {
    super.initState();
    widget.reactive.listen(_onChange);
  }

  void dispose() {
    widget.reactive.forget(_onChange);
    super.dispose();
  }

  void didUpdateWidget(ReactiveBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reactive != oldWidget.reactive) {
      oldWidget.reactive.forget(_onChange);
      widget.reactive.listen(_onChange);
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.reactive);
}

///Listenable implementation for models
abstract class Reactive {
  final Set<VoidCallback> _listeners = Set<VoidCallback>();

  void listen(VoidCallback fn) => _listeners.add(fn);

  void forget(VoidCallback fn) => _listeners.remove(fn);

  int _currentVersion = 0;
  int _targetVersion = 0;

  @protected
  void notify() {
    if (_targetVersion == _currentVersion) {
      _targetVersion++;
      scheduleMicrotask(() {
        _targetVersion = ++_currentVersion;
        _listeners.toList().forEach((fn) => fn());
      });
    }
  }
}
