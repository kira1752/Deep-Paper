import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NoteDetailProvider with ChangeNotifier {
  bool _isTextTyped = false;
  bool _isTitleRTL = false;
  bool _isDetailRTL = false;
  String _title = "";
  String _detail = ""; 

  bool get isTextTyped => _isTextTyped;
  String get getTitle => _title;
  String get getDetail => _detail;
  bool get getTitleDirection => _isTitleRTL;
  bool get getDetailDirection => _isDetailRTL;

  set setTitle(String value) => _title = value;
  set setDetail(String value) => _detail = value;

  set setTextState(bool state) {
    _isTextTyped = state;
    notifyListeners();
  }

  set checkTitleDirection(String text) {
    final newIsRTL = Bidi.detectRtlDirectionality(text);

    if (_isTitleRTL != newIsRTL) {
      _isTitleRTL = newIsRTL;
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
