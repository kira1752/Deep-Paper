import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/widgets.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

class TrashManagement {
  TrashManagement._();

  static Future<void> empty({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.emptyTrashBin();
  }

  static Future<void> restore(
      {@required BuildContext context, @required Note data}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.updateNote(
        data.id,
        const NotesCompanion(
            detail: Value.absent(),
            detailDirection: Value.absent(),
            folderID: Value.absent(),
            folderName: Value.absent(),
            folderNameDirection: Value.absent(),
            isDeleted: Value(false),
            modified: Value.absent(),
            created: Value.absent()));
  }

  static Future<void> restoreBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.restoreFromTrash(selectedNote);
  }

  static Future<void> deleteBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.deleteForever(selectedNote);
  }
}
