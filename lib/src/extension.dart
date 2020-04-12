import 'package:flutter/widgets.dart';
import 'package:scoped/src/bond.dart';
import 'package:scoped/src/mix.dart';
import 'package:scoped/src/ref.dart';
import 'package:scoped/src/scope.dart';
import 'package:scoped/src/fluid.dart';

typedef Widget ValueBuilderDelegate<T>(BuildContext context, T value);
typedef Widget MixBuilderDelegate<T>(BuildContext context, Mix<T> items);

extension ScopedContext on BuildContext {
  T get<T>() {
    return Scope.get<T>(this);
  }
}

extension RefBuilder<T> on Ref<T> {
  bindValue(ValueBuilderDelegate<T> builder) => Bond<Ref<T>>(
      fluid: this, builder: (context, s) => builder(context, s.value));
}

extension MixBuilder<T> on Mix<T> {
  bindMix(MixBuilderDelegate<T> builder) =>
      Bond<Mix<T>>(fluid: this, builder: (context, s) => builder(context, s));
}

extension FluildBuilderExtension<T extends Fluid> on T {
  bind(FluidBuilderDelegate<T> builder) =>
      Bond<T>(fluid: this, builder: builder);
}
