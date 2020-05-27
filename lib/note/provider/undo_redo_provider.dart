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
  String _initialTitle;
  String _initialDetail;
  bool _fieldChanged = false;
  String _tempFocus = "";
  String _tempTyped = "";
  int _count = 0;

  set setCanUndo(bool value) {
    _canUndo = value;
    notifyListeners();
  }

  set setInitialTitle(String value) => _initialTitle = value;

  set setInitialDetail(String value) => _initialDetail = value;

  set setCurrentTyped(String value) => _tempTyped = value;

  set setCurrentFocus(String value) => _tempFocus = value;

  set setFieldChanged(bool value) => _fieldChanged = value;

  set setCount(int value) => _count = value;

  String get getCurrentTyped => _tempTyped;

  int get getCount => _count;

  String get getCurrentFocus => _tempFocus;

  bool get getFieldChanged => _fieldChanged;

  String get getInitialTitle => _initialTitle;

  String get getInitialDetail => _initialDetail;

  void addUndo() {
    _undo.add(_tempTyped);
    _undoFocus.add(_tempFocus);
  }

  void addUndoForInitialTitle() {
    _undo.add(_initialTitle);
    _undoFocus.add(_tempFocus);
  }

  void addUndoForInitialDetail() {
    _undo.add(_initialDetail);
    _undoFocus.add(_tempFocus);
  }

  void skipCurrentUndo() {
    _redo.add(_tempTyped);
    _tempTyped = _undo.removeLast();
  }

  void skipCurrentRedo() {
    _undo.add(_tempTyped);
    _tempTyped = _redo.removeLast();
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
      return "";
    }
  }

  String getUndoFocus() {
    if (_undoFocus.isNotEmpty) {
      _redoFocus.add(_tempFocus);
      _tempFocus = _undoFocus.removeLast();

      if (_tempFocus == "initialTitle" || _tempFocus == "initialDetail") {
        _fieldChanged = false;
      }
      return _tempFocus;
    } else {
      return "";
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

  String getRedoFocus() {
    if (_canUndo == false) {
      debugPrintSynchronously("this redo focus run");
      return _tempFocus;
    } else {
      _undoFocus.add(_tempFocus);
      _tempFocus = _redoFocus.removeLast();

      if (_tempFocus == "initialTitle" || _tempFocus == "initialDetail") {
        _fieldChanged = true;
      }

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
