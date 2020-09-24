import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../../../utility/extension.dart';
import '../undo_model.dart';

class UndoRedoProvider with ChangeNotifier {
  int currentCursorPosition = 0;
  String currentTyped = '';

  /// To store temp value of cursor when user tapping text field
  /// or when user creating new note
  int tempInitCursor;
  int initialCursorPosition;
  String initialDetail;

  final ListQueue<UndoModel> _undo = ListQueue();
  final ListQueue<UndoModel> _redo = ListQueue();
  bool _canUndo = false;
  bool _canRedo = false;

  set setCanUndo(bool value) {
    _canUndo = value;
    notifyListeners();
  }

  void addUndo() {
    final model = UndoModel(
        currentTyped: currentTyped,
        currentCursorPosition: currentCursorPosition);

    _undo.add(model);
  }

  UndoModel popUndoValue() {
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
        if (_undo.last.currentTyped != currentTyped) {
          final model = UndoModel(
              currentTyped: currentTyped,
              currentCursorPosition: currentCursorPosition);

          _redo.add(model);
        }
      } else {
        final model = UndoModel(
            currentTyped: currentTyped,
            currentCursorPosition: currentCursorPosition);

        _redo.add(model);
      }
    }

    if (_undo.isNotEmpty) {
      if (_undo.last.currentTyped == currentTyped) {
        _redo.add(_undo.removeLast());
      }

      if (_undo.isNotEmpty) {
        final model = _undo.removeLast();

        currentTyped = model.currentTyped;
        currentCursorPosition = model.currentCursorPosition;

        _redo.add(model);

        if (_canRedo != true) {
          _canRedo = true;
          notifyListeners();
        }
        return model;
      } else {
        final model = UndoModel(
            currentTyped: initialDetail,
            currentCursorPosition: initialCursorPosition);

        currentTyped = null;
        currentCursorPosition = null;
        _canUndo = false;

        if (_canRedo != true) {
          _canRedo = true;
        }

        notifyListeners();
        return model;
      }
    } else {
      final model = UndoModel(
          currentTyped: initialDetail,
          currentCursorPosition: initialCursorPosition);

      currentTyped = null;
      currentCursorPosition = null;
      _canUndo = false;

      if (_canRedo != true) {
        _canRedo = true;
      }

      notifyListeners();
      return model;
    }
  }

  UndoModel popRedoValue() {
    UndoModel model;
    if (_redo.last.currentTyped == currentTyped) {
      _undo.add(_redo.removeLast());
    }

    if (_redo.isNotEmpty) {
      model = _redo.removeLast();
      currentTyped = model.currentTyped;
      currentCursorPosition = model.currentCursorPosition;

      _undo.add(model);
    }

    if (_canUndo == false) {
      _canUndo = true;
      notifyListeners();
    }

    if (_redo.isEmpty) {
      _canRedo = false;
      notifyListeners();
    }

    return model;
  }

  String getUndoCurrentTyped() {
    if (_undo.isEmpty) {
      return initialDetail;
    } else {
      return _undo.last.currentTyped;
    }
  }

  String getRedoCurrentTyped() {
    if (_redo.isEmpty) {
      return initialDetail;
    } else {
      return _redo.last.currentTyped;
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
