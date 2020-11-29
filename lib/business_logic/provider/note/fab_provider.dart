import 'package:flutter/foundation.dart';

class FABProvider with ChangeNotifier {
  bool _scrollDown = false;

  bool get getScrollDown => _scrollDown;

  set setScrollDown(bool state) {
    if (state != _scrollDown) {
      _scrollDown = state;
      notifyListeners();
    }
  }
}
