import 'package:flutter/widgets.dart';
import 'package:scoped/src/ref.dart';
import 'package:scoped/src/scope.dart';
import 'package:scoped/src/reactive.dart';

typedef Widget ValueBuilderDelegate<T>(BuildContext context, T value);

extension ScopedContext on BuildContext {
  T? get<T>() {
    return Scope.get<T>(this);
  }
}

extension RefBuilderExtension<T> on Ref<T> {
  bindValue(ValueBuilderDelegate<T> builder) => ReactiveBuilder<Ref<T>>(
      reactive: this, builder: (context, s) => builder(context, s.value));
}

extension ReactiveBuilderExtension<T extends Reactive> on T {
  bind(ReactiveBuilderDelegate<T> builder) =>
      ReactiveBuilder<T>(reactive: this, builder: builder);
}
