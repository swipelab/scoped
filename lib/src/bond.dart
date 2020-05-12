library scoped;

import 'package:flutter/widgets.dart';
import 'package:scoped/src/reactive.dart';
import 'package:scoped/src/scope.dart';

///Bond is a convenient widget
class Bond<T extends Reactive> extends StatelessWidget {
  const Bond({this.builder, this.reactive});

  final ReactiveBuilderDelegate<T> builder;
  final T reactive;

  Widget build(BuildContext context) {
    return ReactiveBuilder(reactive: reactive ?? Scope.of(context).store.get<T>(), builder: builder);
  }
}
