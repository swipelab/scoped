# scoped

Flutter dependency injection with a scoped store

Example

`pubspec.yaml`
```yaml
dependencies:
  scoped: ^0.0.3
```

`lib\main.dart`
```dart
import 'package:scoped/di.dart';
//...

void main() => runApp(Scope(
  store:Store()
    ..add(Service('a great service')),
  child: YourApp()));

class Service {
  final String name;
  Service(this.name);
}

class YourApp extends StatelessWidget {
  Wiget build(BuildingContext context){
    return Text(Scope.get<Service>().name);
  }
}
```


