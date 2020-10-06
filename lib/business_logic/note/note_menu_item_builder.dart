import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../UI/app_theme.dart';
import '../../icons/my_icon.dart';
import '../../resource/icon_resource.dart';
import '../../resource/string_resource.dart';
import '../../utility/size_helper.dart';
import 'provider/note_drawer_provider.dart';

PopupMenuItemBuilder<int> selectionItemBuilder(BuildContext context) {
  final showTrashSelection = context
      .select((NoteDrawerProvider value) => value.getIndexDrawerItem == 1);

  final trashMenu = (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
            value: 0,
            child: ListTile(
              leading: optionRestore(context: context),
              title: Text(
                StringResource.restore,
                style: TextStyle(
                  fontSize: SizeHelper.getBodyText1,
                  color: themeColorOpacity(context: context, opacity: .87),
                ),
              ),
            )),
        PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: Icon(
                MyIcon.trash,
                color: themeColorOpacity(context: context, opacity: .6),
              ),
              title: Text(
                'Delete forever',
                style: TextStyle(
                  fontSize: SizeHelper.getBodyText1,
                  color: themeColorOpacity(context: context, opacity: .87),
                ),
              ),
            ))
      ];

  final normalSelection = (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
            value: 0,
            child: ListTile(
              leading: optionDelete(context: context),
              title: Text(
                StringResource.delete,
                style: menuItemStyle(context: context),
              ),
            )),
        PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: optionMoveTo(context: context),
              title: Text(
                StringResource.moveTo,
                style: menuItemStyle(context: context),
              ),
            )),
        PopupMenuItem(
            value: 2,
            child: ListTile(
              leading: optionCopy(context: context),
              title: Text(
                StringResource.copy,
                style: menuItemStyle(context: context),
              ),
            )),
      ];

  final itemBuilder = showTrashSelection ? trashMenu : normalSelection;

  return itemBuilder;
}

PopupMenuItemBuilder<int> normalItemBuilder(BuildContext context) {
  final showFolderMenu = context.select((NoteDrawerProvider value) =>
      value.getFolder != null && value.getIndexDrawerItem == null);

  final trashMenu = (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
            value: 0,
            child: ListTile(
              leading: optionDelete(context: context),
              title: Text(
                StringResource.emptyTrashBin,
                style: TextStyle(
                  fontSize: SizeHelper.getBodyText1,
                  color: themeColorOpacity(context: context, opacity: .87),
                ),
              ),
            ))
      ];

  final folderMenu = (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
            value: 0,
            child: ListTile(
              leading: optionRenameFolder(context: context),
              title: Text(
                StringResource.renameFolder,
                style: menuItemStyle(context: context),
              ),
            )),
        PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: optionDelete(context: context),
              title: Text(
                StringResource.deleteFolder,
                style: menuItemStyle(context: context),
              ),
            )),
      ];

  final itemBuilder = showFolderMenu ? folderMenu : trashMenu;

  return itemBuilder;
}
