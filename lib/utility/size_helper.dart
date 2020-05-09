import 'package:flutter/foundation.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class SizeHelper {
  static double _headline5 = 24.sp;
  static double _headline6 = 20.sp;
  static double _title = 22.sp;
  static double _description = 18.sp;
  static double _drawerMenuText = 17.sp;
  static double _modalDesciption = 17.sp;
  static double _modalTextField = 17.sp;
  static double _toastText = 17.sp;
  static double _bodyText1 = 16.sp;
  static double _bodyText2 = 14.sp;
  static double _modalButton = 18.sp;
  static double _button = 14.sp;
  static double _addButton = 12.sp;
  static double _folder = 14.sp;

  static double get getHeadline5 => _headline5;
  static double get getHeadline6 => _headline6;
  static double get getTitle => _title;
  static double get getDescription => _description;
  static double get getDrawerMenuText => _drawerMenuText;
  static double get getModalDescription => _modalDesciption;
  static double get getModalTextField => _modalTextField;
  static double get getToastText => _toastText;
  static double get getBodyText1 => _bodyText1;
  static double get getBodyText2 => _bodyText2;
  static double get getModalButton => _modalButton;
  static double get getButton => _button;
  static double get getAddButton => _addButton;
  static double get getFolder => _folder;

  static double setTextSize({@required double size}) => size.sp;
  static double setIconSize({@required double size}) => size.sp;
  static double setWidth({@required double size}) => size.w;
  static double setHeight({@required double size}) => size.h;
  static int setWidthCache({@required int size}) => size.w.round();
  static int setHeightCache({@required int size}) => size.h.round();
}
