import 'package:flutter/widgets.dart';
import 'package:scoped/src/binder.dart';

typedef Widget FluidBuilderFn<T extends Fluid>(
    BuildContext context, T fluid);

typedef Widget FluidBuilderWrapFn<T extends Fluid>(
    BuildContext context, T fluid, Widget child);

///Subscribes to a Fluid model to build for each notification
class FluidBuilder<T extends Fluid> extends StatefulWidget {
  final T fluid;
  final FluidBuilderFn<T> builder;

  FluidBuilder({this.fluid, this.builder});

  _FluidBuilderState createState() => new _FluidBuilderState<T>();
}

class _FluidBuilderState<T extends Fluid> extends State<FluidBuilder<T>> {
  void _onChange() =>  setState(() {});

  void initState() {
    super.initState();
    widget.fluid.bind(_onChange);
  }

  void dispose() {
    widget.fluid.free(_onChange);
    super.dispose();
  }

  void didUpdateWidget(FluidBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fluid != oldWidget.fluid) {
      oldWidget.fluid.free(_onChange);
      widget.fluid.bind(_onChange);
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.fluid);
}

///Listenable implementation for models
abstract class Fluid {
  Binder _binder = Binder();

  void bind(VoidCallback bond) => _binder.bind(bond);

  void free(VoidCallback bond) => _binder.free(bond);

  @protected
  notify() => _binder.notify();
}
