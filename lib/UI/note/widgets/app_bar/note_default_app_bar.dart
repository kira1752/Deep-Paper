import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/note/widgets/menu_app_bar/menu.dart';
import 'package:deep_paper/UI/note/widgets/menu_app_bar/selection_menu.dart';
import 'package:deep_paper/UI/note/widgets/search_note_button.dart';
import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

class NoteDefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        SearchNoteButton(),
        Selector<SelectionProvider, bool>(
            selector: (context, provider) => provider.getSelection,
            builder: (context, selection, child) {
              if (selection) {
                return SelectionMenu();
              } else
                return Menu();
            }),
      ],
      leading: Selector<SelectionProvider, bool>(
          selector: (context, provider) => provider.getSelection,
          builder: (context, selection, child) {
            if (selection) {
              return IconButton(
                  icon: IconResource.darkClose,
                  onPressed: () {
                    final deepBottomProvider =
                        Provider.of<DeepBottomProvider>(context, listen: false);
                    final selectionProvider =
                        Provider.of<SelectionProvider>(context, listen: false);
                    final fabProvider =
                        Provider.of<FABProvider>(context, listen: false);

                    deepBottomProvider.setSelection = false;
                    selectionProvider.setSelection = false;
                    fabProvider.setScrollDown = false;
                    selectionProvider.getSelected.clear();
                  });
            } else
              return IconButton(
                  tooltip: StringResource.tooltipNoteHamburgerMenu,
                  icon: IconResource.darkHamburgerMenu,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
          }),
      title: Selector<SelectionProvider, bool>(
          selector: (context, provider) => provider.getSelection,
          builder: (context, selection, child) {
            if (selection) {
              return Selector<SelectionProvider, int>(
                selector: (context, provider) => provider.getSelected.length,
                builder: (context, count, child) {
                  return Text(StringResource.selectionAppBar(count),
                      style: AppTheme.darkTitleSelectionAppBar(context));
                },
              );
            } else
              return Selector<NoteDrawerProvider, String>(
                selector: (context, noteDrawerProvider) =>
                    noteDrawerProvider.getTitleFragment,
                builder: (context, title, child) {
                  final drawerProvider =
                      Provider.of<NoteDrawerProvider>(context, listen: false);

                  return Text(StringResource.titleAppBar(title),
                      textDirection: Bidi.detectRtlDirectionality(title)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: title == StringResource.noteAppBar
                          ? AppTheme.darkTitleAppBar(context)
                          : drawerProvider.getFolder.isNotNull
                              ? AppTheme.darkTitleFolderAppBar(context)
                              : AppTheme.darkTitleTrashAppBar(context));
                },
              );
          }),
    );
  }
}
