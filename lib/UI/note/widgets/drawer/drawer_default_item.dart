import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

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
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Selector<NoteDrawerProvider, bool>(
        selector: (context, drawerProvider) =>
            drawerProvider.getIndexDrawerItem == setValue,
        builder: (context, selected, countNotes) => Material(
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
                  drawerProvider.setTitleFragment = 'NOTE';
                } else if (!selected && setValue == 0) {
                  drawerProvider.setIndexDrawerItem = setValue;
                  drawerProvider.setTitleFragment = 'NOTE';
                }
              },
              leading: selected
                  ? Icon(activeIcon, color: Theme.of(context).accentColor)
                  : Icon(
                      icon,
                      color: themeColorOpacity(context: context, opacity: .54),
                    ),
              trailing: total == null ? const SizedBox() : countNotes,
              title: Text(
                title,
                style: selected
                    ? Theme.of(context).textTheme.bodyText1.copyWith(
                        color:
                            themeColorOpacity(context: context, opacity: .87),
                        fontSize: SizeHelper.getDrawerMenuText)
                    : Theme.of(context).textTheme.bodyText1.copyWith(
                        color:
                            themeColorOpacity(context: context, opacity: .87),
                        fontSize: SizeHelper.getDrawerMenuText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Text(
            '$total',
            style: TextStyle(
                color: themeColorOpacity(context: context, opacity: .54),
                fontSize: SizeHelper.getBodyText1,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
