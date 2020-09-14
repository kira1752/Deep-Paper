import 'package:flutter/widgets.dart';

// SizeConfig Utility class
class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static Orientation orientation;
  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      _screenWidth = MediaQuery.of(context).size.width;
      _screenHeight = MediaQuery.of(context).size.height;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = MediaQuery.of(context).size.height;
      _screenHeight = MediaQuery.of(context).size.width;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
