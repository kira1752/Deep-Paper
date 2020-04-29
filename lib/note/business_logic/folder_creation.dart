import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

class FolderCreation {
  static void create({@required BuildContext context, @required String name}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    database.folderNoteDao.insertFolder(FolderNoteCompanion(
        name: Value(name), nameDirection: Value(nameDirection)));

    Navigator.of(context).pop();
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

    Navigator.of(context).pop();
  }

  static void delete({
    @required BuildContext context,
    @required NoteDrawerProvider drawerProvider,
  }) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao
        .deleteFolderRelationWhenNoteInTrash(drawerProvider.getFolder);

    await database.noteDao
        .deleteNotesInsideFolderForever(drawerProvider.getFolder);

    await database.folderNoteDao.deleteFolder(drawerProvider.getFolder);

    drawerProvider.setFolderState = false;
    drawerProvider.setIndexFolderItem = null;
    drawerProvider.setFolder = null;
    drawerProvider.setIndexDrawerItem = 0;
    drawerProvider.setTitleFragment = "NOTE";

    Navigator.of(context).pop();

    DeepToast.showToast(description: "Folder deleted successfully");
  }
}
