import 'package:flutter/widgets.dart';
import 'package:scoped/src/store.dart';

///Store provider widget
class Scope extends InheritedWidget {
  final Store store;
  Scope({
    required this.store,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Scope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Scope>();

  static T? get<T>(BuildContext context) => of(context)?.store.get<T>();
}
