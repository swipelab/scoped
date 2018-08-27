import 'package:test/test.dart';
import 'package:scoped/di.dart';

void main() {
  test('add and get', () {
    final store = Store()..add("Test");
    expect(store.get<String>(),"Test");
  });
}
