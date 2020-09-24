import 'package:flutter/foundation.dart';

class UndoModel {
  String currentTyped;
  int currentCursorPosition;

  UndoModel(
      {@required this.currentTyped, @required this.currentCursorPosition});
}
