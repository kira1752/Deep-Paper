import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Value;
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

import '../../data/deep.dart';
import 'provider/note_drawer_provider.dart';

class FolderCreation {
  FolderCreation._();

  static void create({@required String name}) {
    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    database.folderNoteDao.insertFolder(FolderNoteCompanion(
        name: Value(name), nameDirection: Value(nameDirection)));
  }

  static void update(
      {@required NoteDrawerProvider drawerProvider, @required String name}) {
    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    database.folderNoteDao.updateFolder(drawerProvider.getFolder
        .copyWith(name: name, nameDirection: nameDirection));

    drawerProvider.setTitleFragment = '$name';
    drawerProvider.setFolder = drawerProvider.getFolder
        .copyWith(name: name, nameDirection: nameDirection);

    database.noteDao.renameFolderAssociation(drawerProvider.getFolder);
  }

  static Future<void> delete({
    @required NoteDrawerProvider drawerProvider,
  }) async {
    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    const mainFolder = 'Main folder';
    final folderNameDirection = Bidi.detectRtlDirectionality(mainFolder)
        ? TextDirection.rtl
        : TextDirection.ltr;

    await database.noteDao.deleteFolderRelationWhenNoteInTrash(
        drawerProvider.getFolder, mainFolder, folderNameDirection);

    await database.noteDao
        .deleteNotesInsideFolderForever(drawerProvider.getFolder);

    await database.folderNoteDao.deleteFolder(drawerProvider.getFolder);

    drawerProvider.setFolderState = false;
    drawerProvider.setIndexFolderItem = null;
    drawerProvider.setFolder = null;
    drawerProvider.setIndexDrawerItem = 0;
    drawerProvider.setTitleFragment = 'NOTE';
  }
}
