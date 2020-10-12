import 'package:moor/moor.dart';

import '../../data/deep.dart';
import 'provider/selection_provider.dart';

Future<void> empty({@required DeepPaperDatabase database}) async {
  await database.noteDao.emptyTrashBin();
}

Future<void> restore(
    {@required Note data, @required DeepPaperDatabase database}) async {
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

Future<void> restoreBatch(
    {@required DeepPaperDatabase database,
    @required SelectionProvider selectionProvider}) async {
  final selectedNote = selectionProvider.getSelected;

  await database.noteDao.restoreFromTrash(selectedNote);
}

Future<void> deleteBatch(
    {@required DeepPaperDatabase database,
    @required SelectionProvider selectionProvider}) async {
  final selectedNote = selectionProvider.getSelected;

  await database.noteDao.deleteForever(selectedNote);
}
