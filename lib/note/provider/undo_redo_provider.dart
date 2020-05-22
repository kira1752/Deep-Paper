import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UndoRedoProvider with ChangeNotifier {
  Queue<String> _undo = Queue();
  Queue<String> _undoFocus = Queue();
  Queue<String> _redo = Queue();
  Queue<String> _redoFocus = Queue();
  bool _canUndo = false;
  bool _canRedo = false;
  String _tempFocus = "";
  String _tempTyped = "";

  set setCanUndo(bool value) {
    _canUndo = value;
    notifyListeners();
  }

  set setCurrentTyped(String value) => _tempTyped = value;

  set setCurrentFocus(String value) => _tempFocus = value;

  String get getCurrentTyped => _tempTyped;
  String get getCurrentFocus => _tempFocus;

  void addUndo() {
    _undo.add(_tempTyped);
    _undoFocus.add(_tempFocus);
  }

  String getUndoValue() {
    if (_undo.isNotEmpty) {
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
      _canUndo = false;
      if (_canRedo != true) {
        _canRedo = true;
        notifyListeners();
      } else {
        notifyListeners();
      }
      return "";
    }
  }

  String getUndoFocus() {
    if (_undoFocus.isNotEmpty) {
      _redoFocus.add(_tempFocus);
      _tempFocus = _undoFocus.removeLast();
      return _tempFocus;
    } else {
      return "";
    }
  }

  String getRedoValue() {
    if (_canUndo == false) {
      _canUndo = true;
      notifyListeners();
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

  String getRedoFocus() {
    if (_canUndo == false) {
      return _tempFocus;
    } else {
      _undoFocus.add(_tempFocus);
      _tempFocus = _redoFocus.removeLast();
      return _tempFocus;
    }
  }

  String lastFocus() {
    return _redoFocus.isEmpty ? _tempFocus : _redoFocus.last;
  }

  void clearRedo() {
    _redo.clear();
    _redoFocus.clear();
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
