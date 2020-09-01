import 'package:deep_paper/icons/my_icon.dart';
import 'package:flutter/material.dart';

class IconResource {
  IconResource._();

  static final darkSearch = const Icon(
    Icons.search,
    color: Colors.white70,
  );

  static final darkClose = const Icon(
    Icons.close,
    color: Colors.white70,
  );

  static final darkOptionsMoveTo = const Icon(
    MyIcon.arrow_up_right,
    color: Colors.white54,
  );

  static final darkOptionsRestore =
      const Icon(Icons.restore, color: Colors.white54);

  static final darkOptionsRenameFolder = const Icon(
    MyIcon.edit,
    color: Colors.white54,
  );

  static final darkOptionsDelete =
      const Icon(MyIcon.trash_2, color: Colors.white54);

  static final darkHamburgerMenu = const Icon(
    Icons.menu,
    color: Colors.white70,
  );

  static final darkOptions = const Icon(
    Icons.more_vert,
    color: Colors.white70,
  );

  static final darkOptionsCopy = const Icon(MyIcon.copy, color: Colors.white60);
}
