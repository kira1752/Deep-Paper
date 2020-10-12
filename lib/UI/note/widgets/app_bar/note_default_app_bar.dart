import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../app_theme.dart';
import '../menu.dart';
import '../search_note_button.dart';

class NoteDefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoteDefaultAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: const <Widget>[SearchNoteButton(), Menu()],
      leading: Selector<SelectionProvider, bool>(
        selector: (context, provider) => provider.getSelection,
        builder: (context, selection, noteMenu) => selection
            ? IconButton(
                icon: close(context: context),
                onPressed: () {
                  final deepBottomProvider =
                      Provider.of<BottomNavBarProvider>(context, listen: false);
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
        builder: (context, selection, titleAppBar) => selection
            ? Selector<SelectionProvider, int>(
                selector: (context, provider) => provider.getSelected.length,
                builder: (context, count, _) => Text(
                    StringResource.selectionAppBar(count),
                    style: appBarStyle(context: context)),
              )
            : titleAppBar,
        child: Selector<NoteDrawerProvider, String>(
          selector: (context, noteDrawerProvider) =>
              noteDrawerProvider.getTitleFragment,
          builder: (context, title, _) {
            return Text(StringResource.titleAppBar(title),
                textDirection: intl.Bidi.detectRtlDirectionality(title)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: appBarStyle(context: context));
          },
        ),
      ),
    );
  }
}
