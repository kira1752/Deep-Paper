import 'package:get/get.dart' hide Value;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

import '../../data/deep.dart';
import 'provider/selection_provider.dart';

class TrashManagement {
  TrashManagement._();

  static Future<void> empty() async {
    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    await database.noteDao.emptyTrashBin();
  }

  static Future<void> restore({@required Note data}) async {
    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

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

  static Future<void> restoreBatch(
      {@required SelectionProvider selectionProvider}) async {
    final selectedNote = selectionProvider.getSelected;

    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    await database.noteDao.restoreFromTrash(selectedNote);
  }

  static Future<void> deleteBatch(
      {@required SelectionProvider selectionProvider}) async {
    final selectedNote = selectionProvider.getSelected;

    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    await database.noteDao.deleteForever(selectedNote);
  }
}
