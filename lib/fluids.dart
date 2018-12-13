import 'package:scoped/fluid.dart';
import 'package:flutter/widgets.dart';

// Fluid builder with multiple fluids
typedef Widget FluidsWidgetBuilder(
    BuildContext context, List<Fluid> fluids);

class FluidsBuilder extends StatefulWidget {
  final List<Fluid> fluids;
  final FluidsWidgetBuilder builder;
  FluidsBuilder({this.fluids, this.builder});
  _FluidsBuilderState createState() => new _FluidsBuilderState();
}

class _FluidsBuilderState<T extends Fluid> extends State<FluidsBuilder> {
  void _onChange() => setState(() {});

  void initState() {
    super.initState();
    widget.fluids.forEach((f) => f.addListener(_onChange));
  }

  void dispose() {
    widget.fluids.forEach((f) => f.removeListener(_onChange));
    super.dispose();
  }

  void didUpdateWidget(FluidsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fluids != oldWidget.fluids) {
      oldWidget.fluids.forEach((f) => f.removeListener(_onChange));
      widget.fluids.forEach((f) => f.addListener(_onChange));
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.fluids);
}