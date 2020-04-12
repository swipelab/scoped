import 'package:scoped/src/fluid.dart';
import 'package:flutter/widgets.dart';

// Fluid builder with multiple fluids
typedef Widget FluidsWidgetBuilder(BuildContext context, List<Fluid> states);

class FluidsBuilder extends StatefulWidget {
  final List<Fluid> states;
  final FluidsWidgetBuilder builder;
  FluidsBuilder({this.states, this.builder});
  _FluidsBuilderState createState() => new _FluidsBuilderState();
}

class _FluidsBuilderState<T extends Fluid> extends State<FluidsBuilder> {
  void _onChange() => setState(() {});

  void initState() {
    super.initState();
    widget.states.forEach((f) => f.listen(_onChange));
  }

  void dispose() {
    widget.states.forEach((f) => f.forget(_onChange));
    super.dispose();
  }

  void didUpdateWidget(FluidsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.states != oldWidget.states) {
      oldWidget.states.forEach((f) => f.forget(_onChange));
      widget.states.forEach((f) => f.listen(_onChange));
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.states);
}
