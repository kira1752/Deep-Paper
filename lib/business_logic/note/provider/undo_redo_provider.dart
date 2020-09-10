import 'dart:collection';

import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

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
    if (currentCursorPosition.value.isNull) {
      // If user cursor state is already saved because of debounce
      // then, user click undo button.
      // pop the latest value from _undoCursor queue and save it to
      // _redoCursor queue

      _redoCursor.add(_undoCursor.removeLast());
    } else if (currentCursorPosition.value.isNotNull && _redoCursor.isEmpty) {
      // If when user typing, then suddenly user tap Undo button
      // and debounce isn't running properly (not quick enough to save
      // the cursor state),
      // save currentCursorPosition to _redoCursor queue
      if (_undoCursor.isNotEmpty) {
        if (_undoCursor.last != currentCursorPosition.value) {
          _redoCursor.add(currentCursorPosition.value);
        }
      } else {
        _redoCursor.add(currentCursorPosition.value);
      }
    }

    if (_undoCursor.isNotEmpty) {
      if (_undoCursor.last == currentCursorPosition.value) {
        _redoCursor.add(_undoCursor.removeLast());
      }
      if (_undoCursor.isNotEmpty) {
        currentCursorPosition.value = _undoCursor.removeLast();
        _redoCursor.add(currentCursorPosition.value);
        return currentCursorPosition.value;
      } else {
        currentCursorPosition.value = -1;
        return initialCursorPosition;
      }
    } else {
      currentCursorPosition.value = -1;
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
    if (currentTyped.value.isNull) {
      // If user typing state is already saved because of debounce
      // then, user click undo button.
      // pop the latest value from _undo queue and save it to
      // _redo queue
      _redo.add(_undo.removeLast());
    } else if (currentTyped.value.isNotNull && _redo.isEmpty) {
      // If when user typing, then suddenly user tap Undo button
      // and debounce isn't running properly (not quick enough to save
      // the typing state),
      // save currentTyped to _redo queue
      if (_undo.isNotEmpty) {
        if (_undo.last != currentTyped.value) {
          _redo.add(currentTyped.value);
        }
      } else {
        _redo.add(currentTyped.value);
      }
    }

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
