import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UndoRedoProvider with ChangeNotifier {
  Queue<String> _undo = Queue();
  Queue<String> _redo = Queue();
  bool _canUndo = false;
  bool _canRedo = false;
  String _initialDetail;
  String _tempTyped = "";
  int _count = 0;

  set setCanUndo(bool value) {
    _canUndo = value;
    notifyListeners();
  }

  set setInitialDetail(String value) => _initialDetail = value;

  set setCurrentTyped(String value) => _tempTyped = value;

  set setCount(int value) => _count = value;

  String get getCurrentTyped => _tempTyped;

  int get getCount => _count;

  String get getInitialDetail => _initialDetail;

  void addUndo() {
    _undo.add(_tempTyped);
  }

  String getUndoValue() {
    if (_undo.isNotEmpty) {
      if (_count != 0) {
        _count = 0;
      }
      _redo.add(_tempTyped);
      _tempTyped = _undo.removeLast();
      if (_canRedo != true) {
        _canRedo = true;
        notifyListeners();
      }
      debugPrintSynchronously("undo value: $_tempTyped");
      return _tempTyped;
    } else {
      debugPrintSynchronously("undo empty");

      if (_count != 0) {
        _count = 0;
      }

      _canUndo = false;
      if (_canRedo != true) {
        _canRedo = true;
        notifyListeners();
      } else {
        notifyListeners();
      }
      return _initialDetail;
    }
  }

  String getRedoValue() {
    if (_canUndo == false) {
      _canUndo = true;
      notifyListeners();

      if (_redo.isEmpty) {
        _canRedo = false;
        notifyListeners();
      }

      return _tempTyped;
    } else {
      _undo.add(_tempTyped);
      _tempTyped = _redo.removeLast();

      if (_redo.isEmpty) {
        _canRedo = false;
        notifyListeners();
      }

      return _tempTyped;
    }
  }

  void clearRedo() {
    _redo.clear();
    _canRedo = false;
    notifyListeners();
  }

  bool canUndo() {
    return _canUndo;
  }

  bool canRedo() {
    return _canRedo;
  }
}
