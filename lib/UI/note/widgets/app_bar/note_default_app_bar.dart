import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/extension.dart';
import '../../../app_theme.dart';
import '../menu_app_bar/menu.dart';
import '../menu_app_bar/selection_menu.dart';
import '../search_note_button.dart';

class NoteDefaultAppBar extends StatelessWidget {
  const NoteDefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        const SearchNoteButton(),
        Selector<SelectionProvider, bool>(
            selector: (context, provider) => provider.getSelection,
            child: const Menu(),
            builder: (context, selection, menu) =>
                selection ? const SelectionMenu() : menu),
      ],
      leading: Selector<SelectionProvider, bool>(
        selector: (context, provider) => provider.getSelection,
        builder: (context, selection, noteMenu) => selection
            ? IconButton(
                icon: close(context: context),
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
                })
            : noteMenu,
        child: IconButton(
            tooltip: StringResource.tooltipNoteHamburgerMenu,
            icon: hamburgerMenu(context: context),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }),
      ),
      title: Selector<SelectionProvider, bool>(
        selector: (context, provider) => provider.getSelection,
        builder: (context, selection, titleAppBar) =>
        selection
            ? Selector<SelectionProvider, int>(
          selector: (context, provider) => provider.getSelected.length,
          builder: (context, count, _) =>
              Text(
                  StringResource.selectionAppBar(count),
                  style: selectionAppBarStyle(context: context)),
        )
            : titleAppBar,
        child: Selector<NoteDrawerProvider, String>(
          selector: (context, noteDrawerProvider) =>
          noteDrawerProvider.getTitleFragment,
          builder: (context, title, _) {
            final drawerProvider =
            Provider.of<NoteDrawerProvider>(context, listen: false);

            return Text(StringResource.titleAppBar(title),
                textDirection: intl.Bidi.detectRtlDirectionality(title)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: title == StringResource.note
                    ? appBarStyle(context: context)
                    : drawerProvider.getFolder.isNotNull
                    ? folderAppBarStyle(context: context)
                    : trashAppBarStyle(context: context));
          },
        ),
      ),
    );
  }
}
