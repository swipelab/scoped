library scoped;

import 'package:flutter/widgets.dart';
import 'package:scoped/src/fluid.dart';
import 'package:scoped/src/scope.dart';

///Bond is a convenient widget to help
class Bond<T extends Fluid> extends StatelessWidget {
  const Bond({this.builder, this.fluid});

  final FluidBuilderDelegate<T> builder;
  final T fluid;

  Widget build(BuildContext context) {
    return FluidBuilder(fluid: fluid ?? Scope.of(context).store.get<T>(), builder: builder);
  }
}
