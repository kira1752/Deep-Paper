import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../business_logic/note/selection_menu_logic.dart';
import '../../../../data/deep.dart';
import '../../../../icons/my_icon.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

class SelectionMenu extends StatelessWidget {
  const SelectionMenu();

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) => provider.getIndexDrawerItem == 1,
      builder: (context, showTrashSelection, normalSelectionMenu) =>
          showTrashSelection ? const _TrashMenu() : normalSelectionMenu,
      child: const _NormalSelectionMenu(),
    );
  }
}

class _TrashMenu extends StatelessWidget {
  const _TrashMenu();

  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);
    final deepBottomProvider =
        Provider.of<DeepBottomProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);

    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        tooltip: StringResource.tooltipSelectionMenu,
        icon: options(context: context),
        onSelected: (choice) {
          final database =
              Provider.of<DeepPaperDatabase>(context, listen: false);

          menuTrashSelected(
              context: context,
              database: database,
              selectionProvider: selectionProvider,
              deepBottomProvider: deepBottomProvider,
              fabProvider: fabProvider,
              choice: choice);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: optionRestore(context: context),
                    title: Text(
                      StringResource.restore,
                      style: TextStyle(
                        fontSize: SizeHelper.getBodyText1,
                        color:
                            themeColorOpacity(context: context, opacity: .87),
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
                        color:
                            themeColorOpacity(context: context, opacity: .87),
                      ),
                    ),
                  ))
            ]);
  }
}

class _NormalSelectionMenu extends StatelessWidget {
  const _NormalSelectionMenu();

  @override
  Widget build(BuildContext context) {
    final deepBottomProvider =
    Provider.of<DeepBottomProvider>(context, listen: false);
    final selectionProvider =
    Provider.of<SelectionProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);
    final drawerProvider =
    Provider.of<NoteDrawerProvider>(context, listen: false);
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        tooltip: StringResource.tooltipSelectionMenu,
        icon: options(context: context),
        onSelected: (choice) {
          menuSelectionSelected(
              context: context,
              database: database,
              deepBottomProvider: deepBottomProvider,
              selectionProvider: selectionProvider,
              fabProvider: fabProvider,
              drawerProvider: drawerProvider,
              choice: choice);
        },
        itemBuilder: (context) =>
        [
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
        ]);
  }
}
