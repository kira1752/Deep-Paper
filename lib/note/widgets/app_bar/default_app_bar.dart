import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/widgets/menu_app_bar/folder_menu.dart';
import 'package:deep_paper/note/widgets/menu_app_bar/trash_menu.dart';
import 'package:deep_paper/note/widgets/search_note_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        builder: (context, title, child) {
          debugPrintSynchronously("Text Title rebuilt");
          return Text('$title',
              style: title == "NOTE"
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontFamily: "Noto Sans"));
        },
        selector: (context, noteDrawerProvider) =>
            noteDrawerProvider.getTitleFragment,
      ),
    );
  }
}
