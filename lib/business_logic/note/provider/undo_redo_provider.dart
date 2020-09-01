import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UndoRedoProvider with ChangeNotifier {
  int currentCursorPosition = 0;
  int initialCursorPosition;
  int tempInitialCursorPosition;
  String initialDetail;
  String currentTyped = '';
  bool space = false;
  int count = 0;

  final Queue<String> _undo = Queue();
  final Queue<String> _redo = Queue();
  final Queue<int> _undoCursor = Queue();
  final Queue<int> _redoCursor = Queue();
  bool _canUndo = false;
  bool _canRedo = false;

  set setCanUndo(bool value) {
    _canUndo = value;
    notifyListeners();
  }

  set setContainSpace(bool value) {
    if (space != value) {
      space = value;
    }
  }

  void addUndo() {
    _undo.add(currentTyped);
    _undoCursor.add(currentCursorPosition);
  }

  int getUndoCursor() {
    if (_undoCursor.isNotEmpty) {
      _redoCursor.add(currentCursorPosition);
      currentCursorPosition = _undoCursor.removeLast();
      return currentCursorPosition;
    } else {
      _redoCursor.add(currentCursorPosition);
      currentCursorPosition = null;

      return initialCursorPosition;
    }
  }

  int getRedoCursor() {
    if (_canUndo == false) {
      currentCursorPosition = _redoCursor.removeLast();
    } else {
      _undoCursor.add(currentCursorPosition);
      currentCursorPosition = _redoCursor.removeLast();
    }

    return currentCursorPosition;
  }

  String getUndoValue() {
    if (_undo.isNotEmpty) {
      if (count != 0) {
        count = 0;
      }
      _redo.add(currentTyped);
      currentTyped = _undo.removeLast();
      if (_canRedo != true) {
        _canRedo = true;
        notifyListeners();
      }
      return currentTyped;
    } else {
      if (count != 0) {
        count = 0;
      }

      _redo.add(currentTyped);
      currentTyped = null;

      _canUndo = false;
      if (_canRedo != true) {
        _canRedo = true;
      }

      notifyListeners();
      return initialDetail;
    }
  }

  String getRedoValue() {
    if (_canUndo == false) {
      _canUndo = true;
      notifyListeners();
      currentTyped = _redo.removeLast();
    } else {
      _undo.add(currentTyped);
      currentTyped = _redo.removeLast();
    }

    if (_redo.isEmpty) {
      _canRedo = false;
      notifyListeners();
    }

    return currentTyped;
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
