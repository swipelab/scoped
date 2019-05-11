import 'dart:async';
import 'dart:ui';

class Binder {
  final Set<VoidCallback> _bonds = Set<VoidCallback>();

  void bind(VoidCallback bond) => _bonds.add(bond);

  void free(VoidCallback bond) => _bonds.remove(bond);

  int _currentVersion = 0;
  int _targetVersion = 0;

  void notify() {
    if (_targetVersion == _currentVersion) {
      _targetVersion++;
      scheduleMicrotask(() {
        _targetVersion = ++_currentVersion;
        _bonds.toList().forEach((VoidCallback bond) => bond());
      });
    }
  }
}