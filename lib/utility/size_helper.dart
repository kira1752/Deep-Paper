import 'package:flutter/foundation.dart';

class SizeHelper {
  SizeHelper._();

  static final double _headline5 = 24;
  static final double _headline6 = 20;
  static final double _title = 22;
  static final double _detail = 17;
  static final double _drawerMenuText = 16;
  static final double _searchText = 17;
  static final double _modalDescription = 17;
  static final double _modalTextField = 17;
  static final double _toastText = 17;
  static final double _bodyText1 = 16;
  static final double _bodyText2 = 14;
  static final double _modalButton = 18;
  static final double _button = 16;
  static final double _addButton = 12;
  static final double _planBottomButton = 18;
  static final double _planTitle = 34;
  static final double _folder = 14;

  static double get getHeadline5 => _headline5;

  static double get getHeadline6 => _headline6;

  static double get getTitle => _title;

  static double get getDetail => _detail;

  static double get getDrawerMenuText => _drawerMenuText;

  static double get getModalDescription => _modalDescription;

  static double get getModalTextField => _modalTextField;

  static double get getToastText => _toastText;

  static double get getBodyText1 => _bodyText1;

  static double get getBodyText2 => _bodyText2;

  static double get getModalButton => _modalButton;

  static double get getButton => _button;

  static double get getAddButton => _addButton;

  static double get getFolder => _folder;

  static double get getSearchText => _searchText;

  static double get getPlanBottomButton => _planBottomButton;

  static double get getPlanTitle => _planTitle;

  static double setTextSize({@required double size}) => size;

  static double setIconSize({@required double size}) => size;

  static double setWidth({@required double size}) => size;

  static double setHeight({@required double size}) => size;

  static int setWidthCache({@required int size}) => size.round();

  static int setHeightCache({@required int size}) => size.round();
}
