import 'package:deep_paper/icons/my_icon.dart';
import 'package:flutter/material.dart';

class IconResource {
  final darkSearch = Icon(
    Icons.search,
    color: Colors.white70,
  );

  final darkRenameFolder = Icon(
    MyIcon.edit_outline,
    color: Colors.white.withOpacity(0.60),
  );

  final darkDeleteFolder =
      Icon(MyIcon.trash_empty, color: Colors.white.withOpacity(0.60));

  final darkHamburgerMenu = Icon(
    Icons.menu,
    color: Colors.white70,
  );
}
