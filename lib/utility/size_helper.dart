import 'package:flutter/foundation.dart';

// SizeHelper Utility class
class SizeHelper {
  SizeHelper._();

  static const double headline5 = 24;
  static const double headline6 = 20;
  static const double title = 22;
  static const double detail = 17;
  static const double drawerMenuText = 16;
  static const double searchText = 17;
  static const double modalDescription = 17;
  static const double modalTextField = 17;
  static const double toastText = 17;
  static const double bodyText1 = 16;
  static const double bodyText2 = 14;
  static const double modalButton = 18;
  static const double button = 16;
  static const double addButton = 12;
  static const double planBottomButton = 18;
  static const double planTitle = 34;
  static const double folder = 14;

  static double setTextSize({@required double size}) => size;

  static double setIconSize({@required double size}) => size;

  static double setWidth({@required double size}) => size;

  static double setHeight({@required double size}) => size;

  static int setWidthCache({@required int size}) => size.round();

  static int setHeightCache({@required int size}) => size.round();
}
