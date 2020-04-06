import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerDefaultItem extends StatelessWidget {
  final String title;
  final int setValue;
  final IconData icon;
  final int total;
  final IconData activeIcon;

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
    return Selector<NoteDrawerProvider, bool>(
        selector: (context, drawerProvier) =>
            drawerProvier.getIndexDrawerItem == setValue,
        builder: (context, selected, child) {
          debugPrintSynchronously("Drawer Item $title rebuilt");

          final drawerProvider =
              Provider.of<NoteDrawerProvider>(context, listen: false);

          return Material(
            clipBehavior: Clip.hardEdge,
            color: selected
                ? Color(0xff5EA3DE).withOpacity(0.3)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  if (!selected &&
                      drawerProvider.getIndexFolderItem != null &&
                      setValue != 0) {
                    drawerProvider.setFolderState = false;
                    drawerProvider.setIndexFolderItem = null;
                    drawerProvider.setFolder = null;
                    drawerProvider.setIndexDrawerItem = setValue;
                    drawerProvider.setTitleFragment = title;
                  } else if (!selected && setValue != 0) {
                    drawerProvider.setIndexDrawerItem = setValue;
                    drawerProvider.setTitleFragment = title;
                  } else if (!selected &&
                      drawerProvider.getIndexFolderItem != null &&
                      setValue == 0) {
                    drawerProvider.setFolderState = false;
                    drawerProvider.setIndexFolderItem = null;
                    drawerProvider.setFolder = null;
                    drawerProvider.setIndexDrawerItem = setValue;
                    drawerProvider.setTitleFragment = "NOTE";
                  } else if (!selected && setValue == 0) {
                    drawerProvider.setIndexDrawerItem = setValue;
                    drawerProvider.setTitleFragment = "NOTE";
                  }
                },
                leading: selected
                    ? Icon(activeIcon, color: Colors.white.withOpacity(0.87))
                    : Icon(icon, color: Colors.white70),
                trailing: total == null
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          "$total",
                          style: TextStyle(fontSize: 16),
                        )),
                title: Text(
                  title,
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
