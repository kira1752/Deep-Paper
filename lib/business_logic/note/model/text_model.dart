import 'package:meta/meta.dart';

class TextModel {
  String currentTyped;
  int currentCursorPosition;

  TextModel(
      {@required this.currentTyped, @required this.currentCursorPosition});
}
