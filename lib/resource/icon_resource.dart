import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../UI/app_theme.dart';

Icon close({@required BuildContext context}) {
  return Icon(
    FluentIcons.dismiss_24_filled,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon search({@required BuildContext context}) {
  return Icon(
    FluentIcons.search_24_filled,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon optionMoveTo({@required BuildContext context}) {
  return Icon(
    FluentIcons.folder_move_24_filled,
    color: Theme.of(context).accentColor.withOpacity(.87),
  );
}

Icon optionRestore({@required BuildContext context}) {
  return Icon(
    FluentIcons.history_24_filled,
    color: Theme
        .of(context)
        .accentColor
        .withOpacity(.87),
  );
}

Icon optionRenameFolder({@required BuildContext context}) {
  return Icon(
    FluentIcons.edit_24_filled,
    color: Theme
        .of(context)
        .accentColor
        .withOpacity(.87),
  );
}

Icon optionDelete({@required BuildContext context}) {
  return Icon(
    FluentIcons.delete_24_filled,
    color: Theme
        .of(context)
        .accentColor
        .withOpacity(.87),
  );
}

Icon optionCopy({@required BuildContext context}) {
  return Icon(
    FluentIcons.copy_24_filled,
    color: Theme
        .of(context)
        .accentColor
        .withOpacity(.87),
  );
}

Icon hamburgerMenu({@required BuildContext context}) {
  return Icon(
    FluentIcons.text_align_left_24_filled,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon options({@required BuildContext context}) {
  return Icon(
    FluentIcons.more_vertical_24_filled,
    color: themeColorOpacity(context: context, opacity: .7),
  );
}

Icon successful({@required BuildContext context}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return isDark
      ? const Icon(
    FluentIcons.checkmark_24_filled,
    color: Color(0xFF81C784),
  )
      : const Icon(
    FluentIcons.checkmark_24_filled,
    color: Colors.green,
  );
}

Icon info({@required BuildContext context}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return isDark
      ? const Icon(
    FluentIcons.info_24_regular,
    color: Color(0xFF64B5F6),
  )
      : const Icon(
    FluentIcons.info_24_regular,
    color: Colors.blue,
  );
}
