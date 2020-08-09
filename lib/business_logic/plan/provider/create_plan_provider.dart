import 'package:flutter/widgets.dart';

class CreatePlanProvider with ChangeNotifier {
  String _date = "";
  String _time = "";

  String get getDate => _date;

  String get getTime => _time;

  set setDate(String date) {
    if (date != _date) {
      _date = date;
      notifyListeners();
    }
  }

  set initiateTime(String time) => _time = time;

  set setTime(String time) {
    if (time != _time) {
      _time = time;
      notifyListeners();
    }
  }
}
