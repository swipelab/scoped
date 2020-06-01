import 'package:scoped/src/reactive.dart';
import 'package:flutter/widgets.dart';

// Fluid builder with multiple reactive models
typedef Widget ReactivesWidgetBuilder(BuildContext context, List<Reactive> models);

class ReactivesBuilder extends StatefulWidget {
  final List<Reactive> states;
  final ReactivesWidgetBuilder builder;
  ReactivesBuilder({this.states, this.builder});
  _ReactivesBuilderState createState() => new _ReactivesBuilderState();
}

class _ReactivesBuilderState<T extends Reactive> extends State<ReactivesBuilder> {
  void _onChange() => setState(() {});

  void initState() {
    super.initState();
    widget.states.forEach((f) => f.listen(_onChange));
  }

  void dispose() {
    widget.states.forEach((f) => f.forget(_onChange));
    super.dispose();
  }

  void didUpdateWidget(ReactivesBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.states != oldWidget.states) {
      oldWidget.states.forEach((f) => f.forget(_onChange));
      widget.states.forEach((f) => f.listen(_onChange));
    }
  }

  Widget build(BuildContext context) => widget.builder(context, widget.states);
}
