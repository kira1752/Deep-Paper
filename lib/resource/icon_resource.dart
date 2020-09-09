import 'package:deep_paper/icons/my_icon.dart';
import 'package:flutter/material.dart';

class IconResource {
  IconResource._();

  static final darkSearch = const Icon(
    MyIcon.search,
    color: Colors.white70,
  );

  static final darkClose = const Icon(
    MyIcon.x,
    color: Colors.white70,
  );

  static final darkOptionsMoveTo = const Icon(
    MyIcon.arrow_up_right,
    color: Colors.white54,
  );

  static final darkOptionsRestore =
      const Icon(Icons.restore, color: Colors.white54);

  static final darkOptionsRenameFolder = const Icon(
    MyIcon.edit_2,
    color: Colors.white54,
  );

  static final darkOptionsDelete =
      const Icon(MyIcon.trash, color: Colors.white54);

  static final darkHamburgerMenu = const Icon(
    MyIcon.menu,
    color: Colors.white70,
  );

  static final darkOptions = const Icon(
    MyIcon.more_vertical,
    color: Colors.white70,
  );

  static final darkOptionsCopy = const Icon(MyIcon.copy, color: Colors.white60);
}
