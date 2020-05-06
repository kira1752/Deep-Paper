import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/widgets/list_view/folder_list_view.dart';
import 'package:deep_paper/note/widgets/list_view/note_list_view.dart';
import 'package:deep_paper/note/widgets/list_view/trash_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:deep_paper/utility/extension.dart';

class BuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, Tuple3<int, int, bool>>(
      selector: (context, drawerProvider) => Tuple3(
          drawerProvider.getIndexDrawerItem,
          drawerProvider.getIndexFolderItem,
          drawerProvider.isFolder),
      builder: (context, data, child) {
        if (data.item3 == true) {
          return Scrollbar(
              child: Selector<NoteDrawerProvider, FolderNoteData>(
                  selector: (context, provider) => provider.getFolder,
                  builder: (context, folder, widget) {
                    return FolderListView(
                      key: Key("${folder.isNotNull ? folder.id : 0}"),
                      folder: folder,
                    );
                  }));
        } else
          return _showNote(index: data.item1);
      },
    );
  }

  Widget _showNote({int index}) {
    if (index == 0)
      return Scrollbar(child: NoteListView());
    else
      return Scrollbar(child: TrashListView());
  }
}
