import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteCreation {
  static void create(
      {@required BuildContext context,
      @required String title,
      @required String detail,
      @required int folderID,
      @required String folderName}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    final titleDirection = Bidi.detectRtlDirectionality(title)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final folderNameDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
      database.noteDao.insertNote(NotesCompanion(
          title: Value(title),
          detail: Value(detail),
          titleDirection: Value(titleDirection),
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
      @required String title,
      @required String detail,
      @required bool isDeleted}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    final titleDirection = Bidi.detectRtlDirectionality(title)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (note.title != title ||
        note.detail != detail && note.isDeleted != isDeleted) {
      if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
        debugPrintSynchronously("run full");
        database.noteDao.updateNote(note.copyWith(
            title: title,
            detail: detail,
            titleDirection: titleDirection,
            detailDirection: detailDirection,
            isDeleted: isDeleted,
            date: DateTime.now()));
      } else if (title.isNullEmptyOrWhitespace &&
          detail.isNullEmptyOrWhitespace) {
        database.noteDao.deleteNote(note);
      }
    } else if (note.title != title || note.detail != detail) {
      debugPrintSynchronously("run partial");
      if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
        database.noteDao.updateNote(note.copyWith(
            title: title,
            detail: detail,
            titleDirection: titleDirection,
            detailDirection: detailDirection,
            date: DateTime.now()));
      } else if (title.isNullEmptyOrWhitespace &&
          detail.isNullEmptyOrWhitespace) {
        database.noteDao.deleteNote(note);
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

    await database.noteDao.moveToFolder(selectedNote, folderID, folderName);
  }
}
