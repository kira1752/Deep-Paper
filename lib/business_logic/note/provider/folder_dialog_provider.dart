import 'package:flutter/widgets.dart';

class FolderDialogProvider with ChangeNotifier {
  bool _isNameTyped = false;

  bool get isNameTyped => _isNameTyped;

  set setIsNameTyped(bool value) {
    if (value != _isNameTyped) {
      _isNameTyped = value;
      notifyListeners();
    }
  }
}
