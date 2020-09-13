import 'package:flutter/foundation.dart';

import '../../../UI/plan/utility/repeat_type.dart';

class RepeatDialogProvider with ChangeNotifier {
  RepeatType _tempRepeat;
  String _tempRepeatDialogType;
  int _tempNumberOfRepeat;
  List<bool> _tempWeekDays;
  final List<int> _tempSelectedDays = [];

  RepeatType get getTempRepeat => _tempRepeat;

  String get getTempRepeatDialogType => _tempRepeatDialogType;

  List<bool> get getTempWeekDays => List.from(_tempWeekDays, growable: false);

  List<int> get getTempSelectedDays => _tempSelectedDays;

  int get getTempNumberOfRepeat => _tempNumberOfRepeat;

  set initiateTempWeekDays(List<bool> weekDays) =>
      _tempWeekDays = List.from(weekDays);

  set initiateTempRepeat(RepeatType repeat) => _tempRepeat = repeat;

  set initiateTempNumberOfRepeat(int numberOfRepeat) =>
      _tempNumberOfRepeat = numberOfRepeat;

  set initiateTempRepeatDialogType(String repeatDialogType) =>
      _tempRepeatDialogType = repeatDialogType;

  set setTempRepeat(RepeatType newRepeat) => _tempRepeat = newRepeat;

  set setTempRepeatDialogType(String newValue) {
    if (newValue != _tempRepeatDialogType) {
      _tempRepeatDialogType = newValue;
      notifyListeners();
    }
  }

  set setTempWeekDays(int day) {
    _tempWeekDays[day % 7] = !_tempWeekDays[day % 7];
    notifyListeners();
  }

  set setTempNumberOfRepeat(int newValue) {
    if (newValue != _tempNumberOfRepeat) {
      _tempNumberOfRepeat = newValue;
      notifyListeners();
    }
  }

  set initiateTempSelectedDays(List<int> selectedDays) =>
      _tempSelectedDays.addAll(selectedDays);

  set addSelectedDay(int day) {
    _tempSelectedDays.add(day);
  }

  set removeSelectedDay(int day) {
    _tempSelectedDays.remove(day);
  }
}
