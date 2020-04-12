# scoped

A very pragmatic way to access your services and state with one goal in mind:

Simplicity

Scoped is a made up of tree main components

- `Store` - a simple service locator
- `Scope` - an inherited widget to help getting access to your store
- `Fluid` - a simple `Listenable` implementation for your models
- `Ref<T>` - observable value
- `Strip<T>` - observable list

I hope you enjoy it.

Example

`pubspec.yaml`

```yaml
dependencies:
  scoped: ^1.9.7
```

`lib\main.dart`

```dart
import 'package:scoped/scoped.dart';
import 'package:scoped/material.dart';

class Service {
  final Ref<String> foo = Ref();
  final Strip<String> foos = Strip();

  final String name;
  Service(this.name);

  change(){
    foo.value = 'bar';
  }
}

void main() => runApp(Scope(
  store:Store()
    ..add(Service('a great service')),
  child: YourApp()));



class YourApp extends StatelessWidget {
  Wiget build(BuildingContext context){
    return Column(
      children:[
        Text(context.get<Service>().name),
        FlatButton(
          child:Text("Change"),
          onPressed:() => context.get<Service>().change(),
        context.get<Service>().foo.bindValue((_,v)=> Text(v))
      ]
    );
  }
}
```
