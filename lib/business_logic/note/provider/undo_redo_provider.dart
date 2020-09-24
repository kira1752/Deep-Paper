import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../../../utility/extension.dart';

class UndoRedoProvider with ChangeNotifier {
  int currentCursorPosition = 0;
  int initialCursorPosition;

  /// To store temp value of cursor when user tapping text field
  /// or when user creating new note
  int tempInitCursor;
  String initialDetail;
  String currentTyped = '';

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
    _undo.add(currentTyped);
    _undoCursor.add(currentCursorPosition);
  }

  int popUndoCursor() {
    if (currentCursorPosition.isNull) {
      // If user cursor state is already saved because of debounce
      // then, user click undo button.
      // pop the latest value from _undoCursor queue and save it to
      // _redoCursor queue

      _redoCursor.add(_undoCursor.removeLast());
    } else if (currentCursorPosition.isNotNull && _redoCursor.isEmpty) {
      // If when user typing, then suddenly user tap Undo button
      // and debounce isn't running properly (not quick enough to save
      // the cursor state),
      // save currentCursorPosition to _redoCursor queue
      if (_undoCursor.isNotEmpty) {
        if (_undoCursor.last != currentCursorPosition) {
          _redoCursor.add(currentCursorPosition);
        }
      } else {
        _redoCursor.add(currentCursorPosition);
      }
    }

    if (_undoCursor.isNotEmpty) {
      if (_undoCursor.last == currentCursorPosition) {
        _redoCursor.add(_undoCursor.removeLast());
      }
      if (_undoCursor.isNotEmpty) {
        currentCursorPosition = _undoCursor.removeLast();
        _redoCursor.add(currentCursorPosition);
        return currentCursorPosition;
      } else {
        currentCursorPosition = 0;
        return initialCursorPosition;
      }
    } else {
      currentCursorPosition = 0;
      return initialCursorPosition;
    }
  }

  int popRedoCursor() {
    if (_redoCursor.last == currentCursorPosition) {
      _undoCursor.add(_redoCursor.removeLast());
    }

    if (_redoCursor.isNotEmpty) {
      currentCursorPosition = _redoCursor.removeLast();
      _undoCursor.add(currentCursorPosition);
    }
    return currentCursorPosition;
  }

  String popUndoValue() {
    if (currentTyped.isNull) {
      // If user typing state is already saved because of debounce
      // then, user click undo button.
      // pop the latest value from _undo queue and save it to
      // _redo queue
      _redo.add(_undo.removeLast());
    } else if (currentTyped.isNotNull && _redo.isEmpty) {
      // If when user typing, then suddenly user tap Undo button
      // and debounce isn't running properly (not quick enough to save
      // the typing state),
      // save currentTyped to _redo queue
      if (_undo.isNotEmpty) {
        if (_undo.last != currentTyped) {
          _redo.add(currentTyped);
        }
      } else {
        _redo.add(currentTyped);
      }
    }

    if (_undo.isNotEmpty) {
      if (_undo.last == currentTyped) {
        _redo.add(_undo.removeLast());
      }

      if (_undo.isNotEmpty) {
        currentTyped = _undo.removeLast();
        _redo.add(currentTyped);

        if (_canRedo != true) {
          _canRedo = true;
          notifyListeners();
        }
        return currentTyped;
      } else {
        currentTyped = '';
        _canUndo = false;

        if (_canRedo != true) {
          _canRedo = true;
        }

        notifyListeners();
        return initialDetail;
      }
    } else {
      currentTyped = '';
      _canUndo = false;
      if (_canRedo != true) {
        _canRedo = true;
      }

      notifyListeners();
      return initialDetail;
    }
  }

  String popRedoValue() {
    if (_redo.last == currentTyped) {
      _undo.add(_redo.removeLast());
    }

    if (_redo.isNotEmpty) {
      currentTyped = _redo.removeLast();
      _undo.add(currentTyped);
    }

    if (_canUndo == false) {
      _canUndo = true;
      notifyListeners();
    }

    if (_redo.isEmpty) {
      _canRedo = false;
      notifyListeners();
    }

    return currentTyped;
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
    _redoCursor.clear();
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
