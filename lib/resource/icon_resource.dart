import 'package:flutter/material.dart';

import '../icons/my_icon.dart';

class IconResource {
  IconResource._();

  static const darkSearch = Icon(
    MyIcon.search,
    color: Colors.white70,
  );

  static const darkClose = Icon(
    MyIcon.x,
    color: Colors.white70,
  );

  static const darkOptionsMoveTo = Icon(
    MyIcon.arrow_up_right,
    color: Colors.white54,
  );

  static const darkOptionsRestore = Icon(Icons.restore, color: Colors.white54);

  static const darkOptionsRenameFolder = Icon(
    MyIcon.edit_2,
    color: Colors.white54,
  );

  static const darkOptionsDelete = Icon(MyIcon.trash, color: Colors.white54);

  static const darkHamburgerMenu = Icon(
    MyIcon.menu,
    color: Colors.white70,
  );

  static const darkOptions = Icon(
    MyIcon.more_vertical,
    color: Colors.white70,
  );

  static const darkOptionsCopy = Icon(MyIcon.copy, color: Colors.white60);
}
