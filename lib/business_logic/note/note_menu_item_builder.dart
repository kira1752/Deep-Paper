import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../UI/note/widgets/modal_field.dart';
import '../../resource/icon_resource.dart';
import '../../resource/string_resource.dart';
import '../../utility/size_helper.dart';
import '../provider/note/note_drawer_provider.dart';

PopupMenuItemBuilder<int> selectionItemBuilder(BuildContext context) {
  final showTrashSelection = context
      .select((NoteDrawerProvider value) => value.getIndexDrawerItem == 1);

  final trashMenu = (BuildContext context) => <PopupMenuEntry<int>>[
    const PopupMenuItem(
            value: 0,
            child: ModalField(
              icon: optionRestore,
              fontSize: SizeHelper.bodyText1,
              title: StringResource.restore,
            )),
    const PopupMenuItem(
        value: 1,
        child: ModalField(
          icon: optionDelete,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.deleteForever,
        ))
      ];

  final normalSelection = (BuildContext context) => <PopupMenuEntry<int>>[
    const PopupMenuItem(
        value: 0,
        child: ModalField(
          icon: optionDelete,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.delete,
        )),
    const PopupMenuItem(
        value: 1,
        child: ModalField(
          icon: optionMoveTo,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.moveTo,
        )),
    const PopupMenuItem(
        value: 2,
        child: ModalField(
          icon: optionCopy,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.copy,
        )),
      ];

  final itemBuilder = showTrashSelection ? trashMenu : normalSelection;

  return itemBuilder;
}

PopupMenuItemBuilder<int> normalItemBuilder(BuildContext context) {
  final showFolderMenu = context.select((NoteDrawerProvider value) =>
      value.getFolder != null && value.getIndexDrawerItem == null);

  final trashMenu = (context) => <PopupMenuEntry<int>>[
    const PopupMenuItem(
        value: 0,
        child: ModalField(
          icon: optionDelete,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.emptyTrashBin,
        ))
      ];

  final folderMenu = (context) => <PopupMenuEntry<int>>[
    const PopupMenuItem(
        value: 0,
        child: ModalField(
          icon: optionRenameFolder,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.rename,
        )),
    const PopupMenuItem(
        value: 1,
        child: ModalField(
          icon: optionDelete,
          fontSize: SizeHelper.bodyText1,
          title: StringResource.delete,
        )),
      ];

  final itemBuilder = showFolderMenu ? folderMenu : trashMenu;

  return itemBuilder;
}
