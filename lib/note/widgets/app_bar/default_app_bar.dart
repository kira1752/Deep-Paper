import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/widgets/menu_app_bar/folder_menu.dart';
import 'package:deep_paper/note/widgets/menu_app_bar/trash_menu.dart';
import 'package:deep_paper/note/widgets/search_note_button.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class DefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        SearchNoteButton(),
        FolderMenu(),
        TrashMenu(),
      ],
      elevation: 0.0,
      centerTitle: true,
      title: Selector<NoteDrawerProvider, String>(
        selector: (context, noteDrawerProvider) =>
            noteDrawerProvider.getTitleFragment,
        builder: (context, title, child) {
          debugPrintSynchronously("Text Title rebuilt");

          final drawerProvider =
              Provider.of<NoteDrawerProvider>(context, listen: false);

          return Text('$title',
              textDirection: Bidi.detectRtlDirectionality(title)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: title == "NOTE"
                  ? Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: SizeHelper.getHeadline5)
                  : drawerProvider.getFolder.isNotNull
                      ? Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeHelper.getTitle)
                      : Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getHeadline5));
        },
      ),
    );
  }
}
