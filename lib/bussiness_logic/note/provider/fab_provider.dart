import 'package:flutter/widgets.dart';

class FABProvider with ChangeNotifier {
  bool _scroll = false;

  bool get getScroll => _scroll;

  set setScroll(bool state) {
    if (state != _scroll) {
      _scroll = state;
      notifyListeners();
    }
  }
}
