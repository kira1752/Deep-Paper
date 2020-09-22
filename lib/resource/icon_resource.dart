import 'package:flutter/material.dart';

import '../UI/app_theme.dart';
import '../icons/my_icon.dart';

Icon close({@required BuildContext context}) {
  return Icon(
    MyIcon.x,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon search({@required BuildContext context}) {
  return Icon(
    MyIcon.search,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon optionMoveTo({@required BuildContext context}) {
  return Icon(
    MyIcon.arrow_up_right,
    color: themeColorOpacity(context: context, opacity: .54),
  );
}

Icon optionRestore({@required BuildContext context}) {
  return Icon(
    Icons.restore,
    color: themeColorOpacity(context: context, opacity: .54),
  );
}

Icon optionRenameFolder({@required BuildContext context}) {
  return Icon(
    MyIcon.edit_2,
    color: themeColorOpacity(context: context, opacity: .54),
  );
}

Icon optionDelete({@required BuildContext context}) {
  return Icon(
    MyIcon.trash,
    color: themeColorOpacity(context: context, opacity: .54),
  );
}

Icon optionCopy({@required BuildContext context}) {
  return Icon(
    MyIcon.copy,
    color: themeColorOpacity(context: context, opacity: .54),
  );
}

Icon hamburgerMenu({@required BuildContext context}) {
  return Icon(
    MyIcon.menu,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon options({@required BuildContext context}) {
  return Icon(
    MyIcon.more_vertical,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon successful({@required BuildContext context}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return isDark
      ? const Icon(
          Icons.check,
          color: Color(0xFF81C784),
        )
      : const Icon(
          Icons.check,
          color: Colors.green,
        );
}

Icon info({@required BuildContext context}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return isDark
      ? const Icon(
          MyIcon.info,
          color: Color(0xFF64B5F6),
        )
      : const Icon(
          Icons.check,
          color: Colors.blue,
        );
}
