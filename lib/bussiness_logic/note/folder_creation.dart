import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

class FolderCreation {
  FolderCreation._();

  static void create({@required BuildContext context, @required String name}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    database.folderNoteDao.insertFolder(FolderNoteCompanion(
        name: Value(name), nameDirection: Value(nameDirection)));
  }

  static void update(
      {@required BuildContext context,
      @required NoteDrawerProvider drawerProvider,
      @required String name}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    database.folderNoteDao.updateFolder(drawerProvider.getFolder
        .copyWith(name: name, nameDirection: nameDirection));

    drawerProvider.setTitleFragment = "$name";
    drawerProvider.setFolder = drawerProvider.getFolder
        .copyWith(name: name, nameDirection: nameDirection);

    database.noteDao.renameFolderAssociation(drawerProvider.getFolder);
  }

  static void delete({
    @required BuildContext context,
    @required NoteDrawerProvider drawerProvider,
  }) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final mainFolder = "Main folder";
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
    drawerProvider.setTitleFragment = "NOTE";
  }
}
