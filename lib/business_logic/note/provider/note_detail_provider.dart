import 'package:deep_paper/data/deep.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NoteDetailProvider with ChangeNotifier {
  bool _isTextTyped = false;
  bool _isDetailRTL = false;
  bool _isCopy = false;
  bool _isDeleted = false;
  int _detailCount;
  int _tempNoteID;
  String _detail = '';
  String _tempDetail = '';
  Note _note;

  bool get isTextTyped => _isTextTyped;

  bool get getDetailDirection => _isDetailRTL;

  bool get getIsCopy => _isCopy;

  bool get getIsDeleted => _isDeleted;

  /// Use this to get the latest value of [DetailField]
  String get getDetail => _detail;

  /// Use this to get the temporary value of [DetailField]
  /// This getter usually return the older value of [DetailField]
  ///
  /// This usually used to compare the old value of [DetailField]
  /// with newer value of [getDetail] getter
  ///
  /// This getter used heavily to determine the auto save mechanism
  String get getTempDetail => _tempDetail;

  int get getDetailCount => _detailCount;

  Note get getNote => _note;

  int get getTempNoteID => _tempNoteID;

  /// Use this setter to update the value returned by [getDetail]
  set setDetail(String value) => _detail = value;

  /// Use this setter to update the value returned by [getTempDetail]
  set setTempDetail(String value) => _tempDetail = value;

  set setDetailCount(int value) => _detailCount = value;

  set setNote(Note newNote) => _note = newNote;

  set setTempNoteID(int newNoteID) => _tempNoteID = newNoteID;

  set setIsCopy(bool value) => _isCopy = value;

  set setIsDeleted(bool value) => _isDeleted = value;

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
