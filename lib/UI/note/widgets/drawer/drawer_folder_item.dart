import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

class DrawerFolderItem extends StatelessWidget {
  final FolderNoteData folder;
  final IconData icon;
  final IconData activeIcon;
  final int index;
  final int total;

  DrawerFolderItem(
      {Key key,
      @required this.index,
      @required this.folder,
      @required this.total,
      @required this.icon,
      @required this.activeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    final folderName = folder.isNotNull ? folder.name : 'Main folder';
    final nameDirection = folder.isNotNull
        ? folder.nameDirection
        : (Bidi.detectRtlDirectionality(folderName)
            ? TextDirection.rtl
            : TextDirection.ltr);

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Selector<NoteDrawerProvider, bool>(
          key: ValueKey<int>(index),
          selector: (context, drawerProvider) =>
              drawerProvider.getIndexFolderItem == index,
          builder: (context, selected, child) {
            return Material(
              color: selected
                  ? Get.theme.accentColor.withOpacity(0.3)
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
                    Get.back();
                    if (!selected &&
                        drawerProvider.getIndexDrawerItem != null) {
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
                      ? Icon(activeIcon, color: Get.theme.accentColor)
                      : Icon(
                          icon,
                          color: Colors.white54,
                        ),
                  trailing: total == null
                      ? const SizedBox()
                      : Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: Text(
                            '$total',
                            style: TextStyle(
                                fontSize: SizeHelper.getBodyText1,
                                fontWeight: FontWeight.w600),
                          )),
                  title: Text(
                    '$folderName',
                    textDirection: nameDirection,
                    style: selected
                        ? Get.textTheme.bodyText1.copyWith(
                        color: Colors.white.withOpacity(0.87),
                        fontSize: SizeHelper.getDrawerMenuText)
                        : Get.textTheme.bodyText1
                        .copyWith(fontSize: SizeHelper.getDrawerMenuText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            );
          }),
    );
  }
}
