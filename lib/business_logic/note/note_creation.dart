import 'dart:ui';

import 'package:moor/moor.dart';

import '../../data/deep.dart';
import '../../resource/string_resource.dart';
import '../../utility/extension.dart';
import '../detect_text_direction_to_string.dart';
import '../provider/note/selection_provider.dart';

Future<int> create(
    {@required DeepPaperDatabase database,
    @required String detail,
    @required int folderID,
    @required String folderName,
    @required bool isDeleted,
    @required bool isCopy}) async {
  int noteID;
  final detailDirection = detectTextDirection(detail);
  final folderNameDirection = detectTextDirection(folderName);

  if (isCopy) {
    await copy(
        database: database,
        detail: detail,
        detailDirection: detailDirection,
        folderID: folderID,
        folderName: folderName,
        folderNameDirection: folderNameDirection);
  }

  if (!detail.isNullEmptyOrWhitespace) {
    noteID = await database.noteDao.insertNote(NotesCompanion(
        detail: Value(detail),
        detailDirection: Value(detailDirection),
        folderID: Value(folderID),
        folderName: Value(folderName),
        folderNameDirection: Value(folderNameDirection),
        isDeleted: Value(isDeleted),
        modified: Value(DateTime.now()),
        created: Value(DateTime.now())));
  }

  return noteID;
}

Future<void> copySelectedNotes(
    {@required DeepPaperDatabase database,
    @required SelectionProvider selectionProvider}) async {
  final selectedNote = selectionProvider.getSelected;

  await database.noteDao.insertNoteBatch(selectedNote);
}

Future<void> update({@required DeepPaperDatabase database,
  @required int noteID,
  @required String detail,
  @required int folderID,
  @required String folderName,
  @required DateTime modified,
  @required bool isDeleted,
  @required bool isCopy}) async {
  final detailDirection = detectTextDirection(detail);

  final folderNameDirection = detectTextDirection(folderName);

  final created = await database.noteDao.getCreatedDate(noteID);

  if (isCopy) {
    await copy(
        database: database,
        detail: detail,
        detailDirection: detailDirection,
        folderID: folderID,
        folderName: folderName,
        folderNameDirection: folderNameDirection);
  }

  await database.noteDao.updateNote(
      noteID,
      NotesCompanion(
          detail: Value(detail),
          detailDirection: Value(detailDirection),
          folderID: Value(folderID),
          folderName: Value(folderName),
          folderNameDirection: Value(folderNameDirection),
          isDeleted: Value(isDeleted),
          modified: Value(modified),
          created: Value(created)));
}

Future<void> copy({@required DeepPaperDatabase database,
  @required String detail,
  @required TextDirection detailDirection,
  @required int folderID,
  @required String folderName,
  @required TextDirection folderNameDirection}) async {
  if (!detail.isNullEmptyOrWhitespace) {
    await database.noteDao.insertNote(NotesCompanion(
        detail: Value(detail),
        detailDirection: Value(detailDirection),
        folderID: Value(folderID),
        folderName: Value(folderName),
        folderNameDirection: Value(folderNameDirection),
        modified: Value(DateTime.now()),
        created: Value(DateTime.now())));
  }
}

void deleteEmptyNote({
  @required DeepPaperDatabase database,
  @required int noteID,
}) {
  database.noteDao.deleteNote(noteID);
}

Future<void> moveToTrashBatch({@required DeepPaperDatabase database,
  @required SelectionProvider selectionProvider}) async {
  final selectedNote = selectionProvider.getSelected;

  await database.noteDao.moveToTrash(selectedNote);
}

Future<void> moveToFolderBatch({@required FolderNoteData folder,
  @required SelectionProvider selectionProvider,
  @required DeepPaperDatabase database}) async {
  final selectedNote = selectionProvider.getSelected;
  final folderID = (folder?.id) ?? 0;
  final folderName = (folder?.name) ?? StringResource.mainFolder;
  final folderNameDirection = detectTextDirection(folderName);

  await database.noteDao
      .moveToFolder(selectedNote, folderID, folderName, folderNameDirection);
}
