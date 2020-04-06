import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/utility/detect_text_direction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:provider/provider.dart';

class DrawerFolderItem extends StatelessWidget {
  final FolderNoteData folder;
  final int index;
  final int total;

  DrawerFolderItem(
      {Key key,
      @required this.index,
      @required this.folder,
      @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return Selector<NoteDrawerProvider, bool>(
        key: ValueKey<int>(index),
        selector: (context, drawerProvider) =>
            drawerProvider.getIndexFolderItem == index,
        builder: (context, selected, child) {
          debugPrintSynchronously("Folder ${folder.name} rebuild");
          return Material(
            clipBehavior: Clip.hardEdge,
            color: selected
                ? Theme.of(context).accentColor.withOpacity(0.3)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  if (!selected && drawerProvider.getIndexDrawerItem != null) {
                    drawerProvider.setFolderState = true;
                    drawerProvider.setIndexFolderItem = index;
                    drawerProvider.setIndexDrawerItem = null;
                    drawerProvider.setFolder = folder;
                    drawerProvider.setTitleFragment = "${folder.name}";
                  } else if (!selected) {
                    drawerProvider.setIndexFolderItem = index;
                    drawerProvider.setTitleFragment = "${folder.name}";
                    drawerProvider.setFolder = folder;
                  }
                },
                leading: selected
                    ? Icon(Icons.folder, color: Colors.white.withOpacity(0.87))
                    : Icon(
                        Icons.folder_open,
                        color: Colors.white70,
                      ),
                trailing: total == null
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "$total",
                          style: TextStyle(fontSize: 16),
                        )),
                title: Text(
                  "${folder.name}",
                  textDirection:
                      DetectTextDirection.isRTL(text: "${folder.name}")
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                  style: selected
                      ? Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white.withOpacity(0.87), fontSize: 16.0)
                      : Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white70, fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          );
        });
  }
}
