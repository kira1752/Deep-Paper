import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

class DrawerDefaultItem extends StatelessWidget {
  final String title;
  final int setValue;
  final IconData icon;
  final Widget total;
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
    final selected = context.select(
            (NoteDrawerProvider value) => value.getIndexDrawerItem == setValue);

    return Padding(
      key: ValueKey<int>(setValue),
      padding: const EdgeInsets.only(right: 12.0),
      child: Material(
        color: selected
            ? Theme
            .of(context)
            .accentColor
            .withOpacity(0.3)
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
                drawerProvider.setTitleFragment = StringResource.note;
              } else if (!selected && setValue == 0) {
                drawerProvider.setIndexDrawerItem = setValue;
                drawerProvider.setTitleFragment = StringResource.note;
              }
            },
            leading: selected
                ? Icon(activeIcon, color: Theme
                .of(context)
                .accentColor)
                : Icon(
              icon,
              color: themeColorOpacity(context: context, opacity: .54),
            ),
            trailing: total,
            title: Text(
              title,
              style: selected
                  ? Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(
                  color: themeColorOpacity(context: context, opacity: .87),
                  fontSize: SizeHelper.getDrawerMenuText)
                  : Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(
                  color: themeColorOpacity(context: context, opacity: .7),
                  fontSize: SizeHelper.getDrawerMenuText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ),
    );
  }
}
