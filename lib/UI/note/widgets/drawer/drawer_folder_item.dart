import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/detect_text_direction_to_string.dart';
import '../../../../business_logic/provider/note/note_drawer_provider.dart';
import '../../../../data/deep.dart';
import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';
import 'drawer_total_notes.dart';

class DrawerFolderItem extends StatelessWidget {
  final FolderNoteData folder;
  final IconData icon;
  final IconData activeIcon;
  final int id;
  final int total;

  const DrawerFolderItem(
      {Key key,
      @required this.id,
      @required this.folder,
      @required this.total,
      @required this.icon,
      @required this.activeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = context
        .select((NoteDrawerProvider value) => value.getIndexFolderItem == id);
    final folderName = folder.name;
    final nameDirection =
        folder.nameDirection ?? (detectTextDirection(folderName));

    return Padding(
      key: ValueKey<int>(id),
      padding: const EdgeInsets.only(right: 12.0),
      child: Material(
        color: selected
            ? Theme.of(context).accentColor.withOpacity(0.3)
            : Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: ListTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            onTap: () {
              Navigator.pop(context);
              final drawerProvider = context.read<NoteDrawerProvider>();

              if (!selected && drawerProvider.getIndexDrawerItem != null) {
                drawerProvider.setFolderState = true;
                drawerProvider.setIndexFolderItem = id;
                drawerProvider.setIndexDrawerItem = null;
                drawerProvider.setFolder = folder;
                drawerProvider.setTitleFragment = '$folderName';
              } else if (!selected) {
                drawerProvider.setIndexFolderItem = id;
                drawerProvider.setTitleFragment = '$folderName';
                drawerProvider.setFolder = folder;
              }
            },
            leading: selected
                ? Icon(activeIcon,
                    color: Theme.of(context).accentColor.withOpacity(.87))
                : Icon(icon,
                    color: Theme.of(context).accentColor.withOpacity(.8)),
            trailing: DrawerTotalNotes(total),
            title: Text(
              '$folderName',
              textDirection: nameDirection,
              style: selected
                  ? Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white.withOpacity(0.87),
                      fontSize: SizeHelper.drawerMenuText)
                  : Theme.of(context).textTheme.bodyText1.copyWith(
                      color: themeColorOpacity(context: context, opacity: .7),
                      fontSize: SizeHelper.drawerMenuText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ),
    );
  }
}
