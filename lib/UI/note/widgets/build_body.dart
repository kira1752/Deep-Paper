import 'package:deep_paper/UI/note/widgets/list_view/folder_list_view.dart';
import 'package:deep_paper/UI/note/widgets/list_view/note_list_view.dart';
import 'package:deep_paper/UI/note/widgets/list_view/trash_list_view.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class BuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => _scrollHandler(context, notification),
      child: Selector<NoteDrawerProvider, Tuple2<int, bool>>(
        selector: (context, drawerProvider) =>
            Tuple2(drawerProvider.getIndexDrawerItem, drawerProvider.isFolder),
        builder: (context, data, child) {
          if (data.item2 == true) {
            return Scrollbar(
                child: Selector<NoteDrawerProvider, FolderNoteData>(
                    selector: (context, provider) => provider.getFolder,
                    builder: (context, folder, widget) {
                      return FolderListView(
                        key: Key('${folder.isNotNull ? folder.id : 0}'),
                        folder: folder,
                      );
                    }));
          } else {
            return _showNote(index: data.item1);
          }
        },
      ),
    );
  }

  Widget _showNote({int index}) {
    if (index == 0) {
      return Scrollbar(child: NoteListView());
    } else {
      return Scrollbar(child: TrashListView());
    }
  }

  bool _scrollHandler(BuildContext context, Notification notification) {
    final fabProvider = Provider.of<FABProvider>(context, listen: false);

    if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          fabProvider.setScrollDown = false;
          return true;
          break;
        case ScrollDirection.reverse:
          fabProvider.setScrollDown = true;
          return true;
          break;

        case ScrollDirection.idle:
          return true;
          break;
      }
    }

    return false;
  }
}
