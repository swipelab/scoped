import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped/scoped.dart';

class Source with Reactive {
  Source(int value) : _counter = value;

  int _counter;

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    notify();
  }

  findTheAnswer() {
    counter = 42;
  }
}

void main() {
  test('add and get', () {
    final store = Store()..add("Test");
    expect(store.get<String>(), "Test");
  });

  testWidgets('bond resolve', (WidgetTester tester) async {
    var buttonKey = UniqueKey();
    var source = Source(41);

    await tester.pumpWidget(Scope(
      store: Store()..add(source),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            ReactiveBuilder<Source>(
                builder: (context, source) => Text(source.counter.toString(),
                    textDirection: TextDirection.ltr)),
            ReactiveBuilder<Source>(
                builder: (context, source) => MaterialButton(
                    key: buttonKey,
                    child: Text('get to the correct answer'),
                    onPressed: () {
                      source.findTheAnswer();
                    }))
          ],
        ),
      ),
    ));

    await tester.tap(find.byKey(buttonKey));
    await tester.pump();
    expect(find.text('42'), findsOneWidget);
  });
}
