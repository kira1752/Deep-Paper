import 'package:deep_paper/icons/my_icon.dart';
import 'package:flutter/material.dart';

class IconResource {
  IconResource._();

  static final darkSearch = Icon(
    Icons.search,
    color: Colors.white70,
  );

  static final darkClose = Icon(
    Icons.close,
    color: Colors.white70,
  );

  static final darkOptionsMoveTo = Icon(
    MyIcon.move_to,
    color: Colors.white.withOpacity(0.60),
  );

  static final darkOptionsRestore =
      Icon(Icons.restore, color: Colors.white.withOpacity(0.60));

  static final darkOptionsRenameFolder = Icon(
    MyIcon.edit_outline,
    color: Colors.white.withOpacity(0.60),
  );

  static final darkOptionsDelete =
      Icon(MyIcon.trash_empty, color: Colors.white.withOpacity(0.60));

  static final darkHamburgerMenu = Icon(
    Icons.menu,
    color: Colors.white70,
  );

  static final darkOptions = Icon(
    Icons.more_vert,
    color: Colors.white70,
  );

  static final darkOptionsCopy =
      Icon(Icons.content_copy, color: Colors.white.withOpacity(0.60));
}
