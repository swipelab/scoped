import 'dart:async';

import 'package:flutter/widgets.dart';

typedef Widget FluidBuilderDelegate<T extends Fluid>(BuildContext context, T fluid);

typedef Widget NotifyBuilderChildDelegate<T extends Fluid>(BuildContext context, T fluid, Widget child);

///Subscribes to a Fluid model to build for each notification
class FluidBuilder<T extends Fluid> extends StatefulWidget {
  final T fluid;
  final FluidBuilderDelegate<T> builder;

  FluidBuilder({this.fluid, this.builder});

  _FluidBuilderState createState() => new _FluidBuilderState<T>();
}

class _FluidBuilderState<T extends Fluid> extends State<FluidBuilder<T>> {
  void _onChange() => setState(() {});

  void initState() {
    super.initState();
    widget.fluid.listen(_onChange);
  }

  void dispose() {
    widget.fluid.forget(_onChange);
    super.dispose();
  }

  void didUpdateWidget(FluidBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fluid != oldWidget.fluid) {
      oldWidget.fluid.forget(_onChange);
      widget.fluid.listen(_onChange);
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.fluid);
}

///Listenable implementation for models
abstract class Fluid {
  final Set<VoidCallback> _bonds = Set<VoidCallback>();

  void listen(VoidCallback bond) => _bonds.add(bond);

  void forget(VoidCallback bond) => _bonds.remove(bond);

  int _currentVersion = 0;
  int _targetVersion = 0;

  @protected
  void notify() {
    if (_targetVersion == _currentVersion) {
      _targetVersion++;
      scheduleMicrotask(() {
        _targetVersion = ++_currentVersion;
        _bonds.toList().forEach((VoidCallback bond) => bond());
      });
    }
  }
}
