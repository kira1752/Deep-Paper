import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;

import '../../../data/deep.dart';

class NoteDetailProvider with ChangeNotifier {
  NoteDetailProvider(
      {@required Note note,
      @required int folderID,
      @required String folderName,
      @required Future<String> date})
      : _note = note,
        _folderID = folderID,
        _folderName = folderName,
        _date = date;

  TextDirection _detailDirection;
  bool _isCopy = false;
  bool _isDeleted = false;
  bool _isTextTyped = false;
  bool _isNoteScrolling = false;
  Future<String> _date;
  String _detail = '';
  String _tempDetail = '';
  String _folderName;
  int _tempNoteID;
  int _folderID;
  int _detailCount;
  Note _note;

  int get folderID => _folderID;

  int get getTempNoteID => _tempNoteID;

  int get getDetailCount => _detailCount;

  bool get isTextTyped => _isTextTyped;

  bool get isCopy => _isCopy;

  bool get isDeleted => _isDeleted;

  bool get isNoteScrolling => _isNoteScrolling;

  TextDirection get detailDirection => _detailDirection;

  String get folderName => _folderName;

  Future<String> get date => _date;

  /// Use this to get the latest value of [DetailField]
  String get getDetail => _detail;

  /// Use this to get the temporary value of [getDetail]
  /// This getter usually return the older value of [getDetail].
  ///
  /// This usually used to compare the old value of [getDetail]
  /// with newer value of [getDetail] getter.
  ///
  /// This getter used heavily in [NoteDetail] lifecycle state.
  String get getTempDetail => _tempDetail;

  Note get getNote => _note;

  /// Use this setter to update the value returned by [getDetail]
  set setDetail(String value) => _detail = value;

  /// This setter is used to store [getDetail] value
  /// that later used to compare the new value of [getDetail]
  /// when saving note data in [AppLifecycleState]
  set setTempDetail(String value) => _tempDetail = value;

  set setDetailCount(int value) => _detailCount = value;

  set folderName(String name) => _folderName = name;

  set date(Future<String> value) => _date = value;

  set folderID(int id) => _folderID = id;

  set setNote(Note newNote) => _note = newNote;

  set setTempNoteID(int newNoteID) => _tempNoteID = newNoteID;

  set isCopy(bool value) => _isCopy = value;

  set isDeleted(bool value) => _isDeleted = value;

  set isNoteScrolling(bool value) => _isNoteScrolling = value;

  set isTextTyped(bool state) {
    if (_isTextTyped != state) {
      _isTextTyped = state;
      notifyListeners();
    }
  }

  set setDetailCountNotify(int value) {
    if (value != _detailCount) {
      _detailCount = value;
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
