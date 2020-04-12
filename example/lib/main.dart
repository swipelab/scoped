import 'package:flutter/material.dart';
import 'package:scoped/scoped.dart';

void main() => runApp(Scope(store: Store()..add(AppState()), child: MyApp()));

class AppState {
  final Strip<int> lines = Strip();
  final Ref<int> counter = Ref(0);

  save() {
    lines.add(counter.value);
    counter.value = 0;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
          padding: EdgeInsets.only(left: 12, top: 8, right: 24),
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            context
                .get<AppState>()
                .counter
                .bindValue((context, counter) => Text(
                      '$counter',
                      style: Theme.of(context).textTheme.display1,
                    )),
            Divider(),
            context.get<AppState>().lines.bind((context, lines) => ListBody(
                  children: <Widget>[
                    if (lines.isNotEmpty) Text('History'),
                    ListView.builder(
                      itemBuilder: (context, index) => Text('${lines[index]}'),
                      itemCount: lines.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    )
                  ],
                ))
          ]),
      bottomNavigationBar: Material(
        elevation: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
                child: Icon(Icons.add),
                onPressed: () => context.get<AppState>().counter.value++),
            FlatButton(
              child: Icon(Icons.save),
              onPressed: context.get<AppState>().save,
            ),
          ],
        ),
      ),
    );
  }
}
