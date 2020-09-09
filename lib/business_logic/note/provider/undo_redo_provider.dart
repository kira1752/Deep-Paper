import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UndoRedoProvider with ChangeNotifier {
  RxInt currentCursorPosition = 0.obs;
  int initialCursorPosition;
  int tempInitialCursorPosition;
  String initialDetail;
  RxString currentTyped = ''.obs;

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

  void addUndo() {
    _undo.add(currentTyped.value);
    _undoCursor.add(currentCursorPosition.value);
  }

  int popUndoCursor() {
    if (_undoCursor.isNotEmpty) {
      if (_undoCursor.last == currentCursorPosition.value) {
        _redoCursor.add(_undoCursor.removeLast());
      }
      if (_undoCursor.isNotEmpty) {
        currentCursorPosition.value = _undoCursor.removeLast();
        _redoCursor.add(currentCursorPosition.value);
        return currentCursorPosition.value;
      } else {
        currentCursorPosition.value = 0;
        return initialCursorPosition;
      }
    } else {
      currentCursorPosition.value = 0;
      return initialCursorPosition;
    }
  }

  int popRedoCursor() {
    if (_redoCursor.last == currentCursorPosition.value) {
      _undoCursor.add(_redoCursor.removeLast());
    }

    if (_redoCursor.isNotEmpty) {
      currentCursorPosition.value = _redoCursor.removeLast();
      _undoCursor.add(currentCursorPosition.value);
    }
    return currentCursorPosition.value;
  }

  String popUndoValue() {
    if (_undo.isNotEmpty) {
      if (_canRedo != true) {
        _canRedo = true;
        notifyListeners();
      }

      if (_undo.last == currentTyped.value) {
        _redo.add(_undo.removeLast());
      }

      if (_undo.isNotEmpty) {
        currentTyped.value = _undo.removeLast();
        _redo.add(currentTyped.value);
        return currentTyped.value;
      } else {
        currentTyped.value = '';
        _canUndo = false;
        if (_canRedo != true) {
          _canRedo = true;
        }

        notifyListeners();
        return initialDetail;
      }
    } else {
      currentTyped.value = '';
      _canUndo = false;
      if (_canRedo != true) {
        _canRedo = true;
      }

      notifyListeners();
      return initialDetail;
    }
  }

  String popRedoValue() {
    if (_redo.last == currentTyped.value) {
      _undo.add(_redo.removeLast());
    }

    if (_redo.isNotEmpty) {
      currentTyped.value = _redo.removeLast();
      _undo.add(currentTyped.value);
    }

    if (_canUndo == false) {
      _canUndo = true;
      notifyListeners();
    }

    if (_redo.isEmpty) {
      _canRedo = false;
      notifyListeners();
    }

    return currentTyped.value;
  }

  String getUndoLastValue() {
    if (_undo.isEmpty) {
      return initialDetail;
    } else {
      return _undo.last;
    }
  }

  String getRedoLastValue() {
    if (_redo.isEmpty) {
      return initialDetail;
    } else {
      return _redo.last;
    }
  }

  void deleteUndoLastValue() {
    if (_undo.isNotEmpty) {
      _undo.removeLast();
    }

    if (_undoCursor.isNotEmpty) {
      _undoCursor.removeLast();
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
