import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../UI/style/app_theme.dart';

const optionMoveTo = FluentIcons.folder_move_24_regular;
const optionRestore = FluentIcons.history_24_regular;
const optionRenameFolder = FluentIcons.edit_24_regular;
const optionDelete = FluentIcons.delete_24_regular;
const optionCopy = FluentIcons.copy_24_regular;

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
