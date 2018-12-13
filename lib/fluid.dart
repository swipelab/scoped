import 'dart:async';
import 'package:flutter/widgets.dart';

typedef Widget FluidWidgetBuilder<T extends Fluid>(
    BuildContext context, T fluid);

///Subscribes to a Fluid model to build for each notification
class FluidBuilder<T extends Fluid> extends StatefulWidget {
  final T fluid;
  final FluidWidgetBuilder<T> builder;
  FluidBuilder({this.fluid, this.builder});
  _FluidBuilderState createState() => new _FluidBuilderState<T>();
}

class _FluidBuilderState<T extends Fluid> extends State<FluidBuilder<T>> {
  void _onChange() => setState(() {});

  void initState() {
    super.initState();
    widget.fluid.addListener(_onChange);
  }

  void dispose() {
    widget.fluid.removeListener(_onChange);
    super.dispose();
  }

  void didUpdateWidget(FluidBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fluid != oldWidget.fluid) {
      oldWidget.fluid.removeListener(_onChange);
      widget.fluid.addListener(_onChange);
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.fluid);
}

///Listanable implementation for models
abstract class Fluid extends Listenable {
  final Set<VoidCallback> _listeners = Set<VoidCallback>();
  void addListener(VoidCallback listener) => _listeners.add(listener);
  void removeListener(VoidCallback listener)  => _listeners.remove(listener);

  int _currentVersion = 0;
  int _targetVersion = 0;
  @protected
  void notify() {
    if (_targetVersion == _currentVersion) {
      _targetVersion++;
      scheduleMicrotask(() {
        _targetVersion = ++_currentVersion;
        _listeners.toList().forEach((VoidCallback listener) => listener());
      });
    }
  }
}