import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;

import '../../../data/deep.dart';

class NoteDetailProvider with ChangeNotifier {
  bool _isTextTyped = false;
  TextDirection _detailDirection;
  bool _isCopy = false;
  bool _isDeleted = false;
  int _detailCount;
  int _tempNoteID;
  String _detail = '';
  String _tempDetail = '';
  String _folderName;
  int _folderID;
  Note _note;

  bool get isTextTyped => _isTextTyped;

  TextDirection get detailDirection => _detailDirection;

  bool get getIsCopy => _isCopy;

  bool get getIsDeleted => _isDeleted;

  String get folderName => _folderName;

  int get folderID => _folderID;

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

  set folderName(String name) => _folderName = name;

  set folderID(int id) => _folderID = id;

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

  set isTextTyped(bool state) {
    if (_isTextTyped != state) {
      _isTextTyped = state;
      notifyListeners();
    }
  }

  set checkDetailDirection(String text) {
    final newIsRTL = intl.Bidi.detectRtlDirectionality(text)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (_detailDirection != newIsRTL) {
      _detailDirection = newIsRTL;
      notifyListeners();
    }
  }

  set initialDetailDirection(String text) {
    _detailDirection = intl.Bidi.detectRtlDirectionality(text)
        ? TextDirection.rtl
        : TextDirection.ltr;
  }
}
