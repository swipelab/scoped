# scoped

A very pragmatic way to handle your state with one goal in mind:

Simplicity



Example

`pubspec.yaml`

```yaml
dependencies:
  scoped: ^1.0.0
```

`lib\main.dart`

```dart
import 'package:scoped/scoped.dart';
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
    return Bond<Service>(builder: (context, service)=> Text(service.name));
  }
}
```

`with bonds`
```dart
import 'package:scoped/scoped.dart';
//...

void main() => runApp(Scope(
  store:Store()
    ..add(Service('a great service')),
  child: YourApp()));

class Service extends Fluid {
  String _name;
  String name;
  set name(String value){
    _name = value;
    notify();
  }
  Service(String name):_name=name;
}

class YourApp extends StatelessWidget {
  Wiget build(BuildingContext context){
    return Column(
      children: [
        Bond<Service>(
          builder: (context, service) => Text(service.name)),
        FlatButton(
          child:Text("Change"),
          onPressed:() => Scope.get<Service>(context).name = 'changed')
      ]);
  }
}
```

`with fluid models`
```dart
import 'package:scoped/scoped.dart';
//...

void main() => runApp(Scope(
  store:Store()
    ..add(Service('a great service')),
  child: YourApp()));

class Service extends Fluid {
  String _name;
  String name;
  set name(String value){
    _name = value;
    notify();
  }
  Service(String name):_name=name;
}

class YourApp extends StatelessWidget {
  Wiget build(BuildingContext context){
    return Column(
      children: [
        FluidBuilder<Service>(
          fluid: Scope.get<Service>(context),
          builder: (context, s) => Text(s.name)),
        FlatButton(
          child:Text("Change"),
          onPressed:() => Scope.get<Service>(context).name = 'changed')
      ]);
  }
}
```
