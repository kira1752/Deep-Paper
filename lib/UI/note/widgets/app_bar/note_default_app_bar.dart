import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/note/widgets/menu_app_bar/menu.dart';
import 'package:deep_paper/UI/note/widgets/search_note_button.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteDefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        SearchNoteButton(),
        Menu(),
      ],
      leading: IconButton(
        tooltip: StringResource.tooltipNoteHamburgerMenu,
          icon: IconResource.darkHamburgerMenu,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          }),
      title: Selector<NoteDrawerProvider, String>(
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
      ),
    );
  }
}
