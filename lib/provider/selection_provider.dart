import 'package:flutter/foundation.dart';

class SelectionProvider with ChangeNotifier {
  bool _selection = false;

  bool get getSelection => _selection;

  set setSelection(bool value) {
    if (_selection != value) {
      _selection = value;
      notifyListeners();
    }
  }

  void update() {
    notifyListeners();
  }

}
