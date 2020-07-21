import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NoteDetailProvider with ChangeNotifier {
  bool _isTextTyped = false;
  bool _isDetailRTL = false;
  int _detailCount;
  String _detail = "";

  bool get isTextTyped => _isTextTyped;
  bool get getDetailDirection => _isDetailRTL;
  String get getDetail => _detail;

  int get getDetailCount => _detailCount;

  set setDetail(String value) => _detail = value;

  set setDetailCount(int value) => _detailCount = value;

  set setDetailCountNotify(int value) {
    if (value != _detailCount) {
      _detailCount = value;
      notifyListeners();
    }
  }

  set setTextState(bool state) {
    if (_isTextTyped != state) {
      _isTextTyped = state;
      notifyListeners();
    }
  }

  set checkDetailDirection(String text) {
    final newIsRTL = Bidi.detectRtlDirectionality(text);

    if (_isDetailRTL != newIsRTL) {
      _isDetailRTL = newIsRTL;
      notifyListeners();
    }
  }
}
