import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/widgets.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

class TrashManagement {
  static Future<void> empty({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.emptyTrashBin();
  }

  static Future<void> restore(
      {@required BuildContext context, @required Note data}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.updateNote(
        data.id,
        NotesCompanion(
            detail: Value(data.detail),
            detailDirection: Value(data.detailDirection),
            folderID: Value(data.folderID),
            folderName: Value(data.folderName),
            folderNameDirection: Value(data.folderNameDirection),
            isDeleted: Value(false),
            date: Value(data.date)));
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
