import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NoteDetailProvider with ChangeNotifier {
  bool _isTextTyped = false;

  bool get isTextTyped => _isTextTyped;

  set setTextState(bool state) {
    _isTextTyped = state;
    notifyListeners();
  }
}