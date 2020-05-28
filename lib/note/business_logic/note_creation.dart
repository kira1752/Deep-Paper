import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteCreation {
  static void create(
      {@required BuildContext context,
      @required String detail,
      @required int folderID,
      @required String folderName}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final folderNameDirection = Bidi.detectRtlDirectionality(folderName)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (!detail.isNullEmptyOrWhitespace) {
      database.noteDao.insertNote(NotesCompanion(
          detail: Value(detail),
          detailDirection: Value(detailDirection),
          folderID: Value(folderID),
          folderName: Value(folderName),
          folderNameDirection: Value(folderNameDirection),
          date: Value(DateTime.now())));
    }
  }

  static Future<void> copySelectedNotes(
      {@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.insertNoteBatch(selectedNote);
  }

  static void update(
      {@required BuildContext context,
      @required Note note,
      @required String detail,
      @required bool isDeleted}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (note.detail != detail && note.isDeleted != isDeleted) {
      if (!detail.isNullEmptyOrWhitespace) {
        database.noteDao.updateNote(note.copyWith(
            detail: detail,
            detailDirection: detailDirection,
            isDeleted: isDeleted,
            date: DateTime.now()));
      } else if (detail.isNullEmptyOrWhitespace) {
        database.noteDao.deleteNote(note);

        DeepToast.showToast(description: "Empty note deleted");
      }
    } else if (note.detail != detail) {
      if (!detail.isNullEmptyOrWhitespace) {
        database.noteDao.updateNote(note.copyWith(
            detail: detail,
            detailDirection: detailDirection,
            date: DateTime.now()));
      } else if (detail.isNullEmptyOrWhitespace) {
        database.noteDao.deleteNote(note);

        DeepToast.showToast(description: "Empty note deleted");
      }
    } else if (note.isDeleted != isDeleted) {
      database.noteDao.updateNote(note.copyWith(
        isDeleted: isDeleted,
      ));
    }
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
