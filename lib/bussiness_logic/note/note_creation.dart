import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

class NoteCreation {
  NoteCreation._();

  static Future<int> create(
      {@required BuildContext context,
      @required String detail,
      @required TextDirection detailDirection,
      @required int folderID,
      @required String folderName,
      @required TextDirection folderNameDirection,
      @required bool isDeleted,
      @required bool isCopy}) async {
    int noteID;
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final folderNameDirection = Bidi.detectRtlDirectionality(folderName)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (isCopy) {
      copy(
          context: context,
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

  static Future<void> copySelectedNotes(
      {@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.insertNoteBatch(selectedNote);
  }

  static Future<void> update(
      {@required BuildContext context,
      @required int noteID,
      @required String detail,
      @required int folderID,
      @required String folderName,
      @required DateTime modified,
      @required bool isDeleted,
        @required bool isCopy}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final folderNameDirection = Bidi.detectRtlDirectionality(folderName)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final created = await database.noteDao.getCreatedDate(noteID);

    if (isCopy) {
      copy(
          context: context,
          detail: detail,
          detailDirection: detailDirection,
          folderID: folderID,
          folderName: folderName,
          folderNameDirection: folderNameDirection);
    }

    database.noteDao.updateNote(
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

  static void copy({
    @required BuildContext context,
    @required String detail,
    @required TextDirection detailDirection,
    @required int folderID,
    @required String folderName,
    @required TextDirection folderNameDirection,
  }) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final folderNameDirection = Bidi.detectRtlDirectionality(folderName)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (!detail.isNullEmptyOrWhitespace) {
      debugPrintSynchronously("create note");
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

  static void deleteEmptyNote({
    @required BuildContext context,
    @required int noteID,
  }) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    database.noteDao.deleteNote(noteID);
  }

  static Future<void> moveToTrashBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.moveToTrash(selectedNote);
  }

  static Future<void> moveToFolderBatch(
      {@required BuildContext context,
      @required FolderNoteData folder,
      @required SelectionProvider selectionProvider,
      @required DeepPaperDatabase database}) async {
    final selectedNote = selectionProvider.getSelected;
    final folderID = folder.isNotNull ? folder.id : 0;
    final folderName = folder.isNotNull ? folder.name : "Main folder";
    final folderNameDirection = Bidi.detectRtlDirectionality(folderName)
        ? TextDirection.rtl
        : TextDirection.ltr;

    await database.noteDao
        .moveToFolder(selectedNote, folderID, folderName, folderNameDirection);
  }
}
