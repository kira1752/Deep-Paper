import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/provider/note/note_drawer_provider.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';
import 'drawer_total_notes.dart';

class DrawerDefaultItem extends StatelessWidget {
  final String title;
  final int setValue;
  final IconData icon;
  final IconData activeIcon;
  final int total;

  const DrawerDefaultItem(
      {Key key,
      @required this.title,
      @required this.setValue,
      @required this.icon,
      @required this.activeIcon,
      @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = context.select(
        (NoteDrawerProvider value) => value.getIndexDrawerItem == setValue);

    return Padding(
      key: ValueKey<int>(setValue),
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

              if (!selected && drawerProvider.getIndexFolderItem != null) {
                drawerProvider.setFolderState = false;
                drawerProvider.setIndexFolderItem = null;
                drawerProvider.setFolder = null;
                drawerProvider.setIndexDrawerItem = setValue;
                drawerProvider.setTitleFragment = title;

                if (title == StringResource.trash) {
                  if (total == 0) {
                    context.read<NoteDrawerProvider>().setTrashExist = false;
                  } else {
                    context.read<NoteDrawerProvider>().setTrashExist = true;
                  }
                }
              } else if (!selected) {
                drawerProvider.setIndexDrawerItem = setValue;
                drawerProvider.setTitleFragment = title;

                if (title == StringResource.trash) {
                  if (total == 0) {
                    context.read<NoteDrawerProvider>().setTrashExist = false;
                  } else {
                    context.read<NoteDrawerProvider>().setTrashExist = true;
                  }
                }
              }
            },
            leading: selected
                ? Icon(activeIcon,
                    color: Theme.of(context).accentColor.withOpacity(.87))
                : Icon(icon,
                    color: Theme.of(context).accentColor.withOpacity(.8)),
            trailing: DrawerTotalNotes(total),
            title: Text(
              title,
              style: selected
                  ? Theme.of(context).textTheme.bodyText1.copyWith(
                      color: themeColorOpacity(context: context, opacity: .87),
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
