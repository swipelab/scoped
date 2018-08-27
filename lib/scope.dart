import 'package:flutter/widgets.dart';
import 'package:scoped/store.dart';

///Store provider widget
class Scope extends InheritedWidget {
  final Store _store;
  Scope({Store store, Widget child, Key key})
      : _store = store ?? Store(),
        super(child: child, key: key);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Scope of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Scope) as Scope;

  static T get<T>(BuildContext context) => of(context)._store.get<T>();
  static call<T>(BuildContext context) => of(context)._store.call<T>();
}
