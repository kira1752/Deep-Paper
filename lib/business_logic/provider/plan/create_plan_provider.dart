import 'package:flutter/foundation.dart';

import '../../../UI/plan/utility/repeat_type.dart';
import '../../../resource/string_resource.dart';

class CreatePlanProvider with ChangeNotifier {
  DateTime _date;
  DateTime _time;
  int _numberOfRepeat = 1;
  String _repeatTitle = StringResource.noRepeat;
  String _selectedDaysTitle = '';
  String _repeatDialogType = StringResource.days;
  RepeatType _repeat;
  List<int> _selectedDays = [];
  List<bool> _weekDays = [
    false, // Sunday
    true, // Monday
    false, // Tuesday
    false, // Wednesday
    false, // Thursday
    false, // Friday
    false, // Saturday
  ];

  DateTime get getDate => _date;

  DateTime get getTime => _time;

  String get getRepeatTitle => _repeatTitle;

  String get getSelectedDaysTitle => _selectedDaysTitle;

  String get getRepeatDialogType => _repeatDialogType;

  int get getNumberOfRepeat => _numberOfRepeat;

  RepeatType get getRepeat => _repeat;

  List<bool> get getWeekDays => _weekDays;

  List<int> get getSelectedDays => _selectedDays;

  set setDate(DateTime date) {
    if (date != _date) {
      _date = date;
      notifyListeners();
    }
  }

  set initiateTime(DateTime time) => _time = time;

  set setTime(DateTime time) {
    if (time != _time) {
      _time = time;
      notifyListeners();
    }
  }

  set setNumberOfRepeat(int newValue) => _numberOfRepeat = newValue;

  set setRepeatTitle(String newTitle) {
    if (newTitle != _repeatTitle) {
      _repeatTitle = newTitle;
      notifyListeners();
    }
  }

  set setRepeatDialogType(String newValue) => _repeatDialogType = newValue;

  set setSelectedDaysTitle(String newDay) {
    if (newDay != _selectedDaysTitle) {
      _selectedDaysTitle = newDay;
      notifyListeners();
    }
  }

  set setRepeat(RepeatType newRepeat) => _repeat = newRepeat;

  set setWeekDays(List<bool> newWeekDays) => _weekDays = newWeekDays;

  set setSelectedDays(List<int> newSelectedDays) =>
      _selectedDays = newSelectedDays;
}
