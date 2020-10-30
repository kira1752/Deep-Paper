import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/note_menu_item_builder.dart';
import '../../../business_logic/note/note_menu_selected.dart';
import '../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../business_logic/note/provider/selection_provider.dart';
import '../../../resource/icon_resource.dart';
import '../../../resource/string_resource.dart';

class Menu extends StatelessWidget {
  const Menu();

  @override
  Widget build(BuildContext context) {
    final selection =
        context.select((SelectionProvider value) => value.getSelection);

    final showFolderMenu = context.select((NoteDrawerProvider value) =>
        value.getFolder != null &&
        value.getIndexDrawerItem == null &&
        value.getFolder?.id != 0);

    final showMenuInTrash = context.select((NoteDrawerProvider value) =>
        value.getIndexDrawerItem == 1 && value.isTrashExist);

    final show = selection
        ? selection
        : (showFolderMenu ? showFolderMenu : showMenuInTrash);

    return Visibility(
      visible: show,
      child: const _MenuButton(),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    final selection =
        context.select((SelectionProvider value) => value.getSelection);

    final onSelected =
        selection ? selectionOnSelected(context) : normalOnSelected(context);

    final itemBuilder =
        selection ? selectionItemBuilder(context) : normalItemBuilder(context);

    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        tooltip: StringResource.tooltipFolderMenu,
        icon: options(context: context),
        onSelected: onSelected,
        itemBuilder: itemBuilder);
  }
}
