import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../data/deep.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

class DrawerFolderItem extends StatelessWidget {
  final FolderNoteData folder;
  final IconData icon;
  final IconData activeIcon;
  final int index;
  final Widget total;

  const DrawerFolderItem(
      {Key key,
      @required this.index,
      @required this.folder,
      @required this.total,
      @required this.icon,
      @required this.activeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = context.select(
            (NoteDrawerProvider value) => value.getIndexFolderItem == index);
    final folderName = (folder?.name) ?? StringResource.mainFolder;
    final nameDirection = folder.isNotNull
        ? folder.nameDirection
        : (intl.Bidi.detectRtlDirectionality(folderName)
        ? TextDirection.rtl
        : TextDirection.ltr);

    return Padding(
      key: ValueKey<int>(index),
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

              if (!selected && drawerProvider.getIndexDrawerItem != null) {
                drawerProvider.setFolderState = true;
                drawerProvider.setIndexFolderItem = index;
                drawerProvider.setIndexDrawerItem = null;
                drawerProvider.setFolder = folder;
                drawerProvider.setTitleFragment = '$folderName';
              } else if (!selected) {
                drawerProvider.setIndexFolderItem = index;
                drawerProvider.setTitleFragment = '$folderName';
                drawerProvider.setFolder = folder;
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
              '$folderName',
              textDirection: nameDirection,
              style: selected
                  ? Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(
                  color: Colors.white.withOpacity(0.87),
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
