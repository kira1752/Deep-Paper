import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:moor/moor.dart';

import '../../data/deep.dart';
import 'provider/note_drawer_provider.dart';

void create({@required DeepPaperDatabase database, @required String name}) {
  final nameDirection = intl.Bidi.detectRtlDirectionality(name)
      ? TextDirection.rtl
      : TextDirection.ltr;

  database.folderNoteDao.insertFolder(FolderNoteCompanion(
      name: Value(name), nameDirection: Value(nameDirection)));
}

void update(
    {@required DeepPaperDatabase database,
    @required NoteDrawerProvider drawerProvider,
    @required String name}) {
  final nameDirection = intl.Bidi.detectRtlDirectionality(name)
      ? TextDirection.rtl
      : TextDirection.ltr;

  database.folderNoteDao.updateFolder(drawerProvider.getFolder
      .copyWith(name: name, nameDirection: nameDirection));

  drawerProvider.setTitleFragment = '$name';
  drawerProvider.setFolder = drawerProvider.getFolder
      .copyWith(name: name, nameDirection: nameDirection);

  database.noteDao.renameFolderAssociation(drawerProvider.getFolder);
}

Future<void> delete({
  @required DeepPaperDatabase database,
  @required NoteDrawerProvider drawerProvider,
}) async {
  await database.noteDao.moveNoteToTrash(drawerProvider.getFolder);

  await database.folderNoteDao.deleteFolder(drawerProvider.getFolder);

  drawerProvider.setFolderState = false;
  drawerProvider.setIndexFolderItem = null;
  drawerProvider.setFolder = null;
  drawerProvider.setIndexDrawerItem = 0;
  drawerProvider.setTitleFragment = 'NOTE';
}
