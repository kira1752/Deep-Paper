import 'package:flutter/foundation.dart';

class TextModel {
  String currentTyped;
  int currentCursorPosition;

  TextModel(
      {@required this.currentTyped, @required this.currentCursorPosition});
}
