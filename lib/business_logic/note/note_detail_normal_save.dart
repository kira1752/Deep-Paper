import 'package:flutter/widgets.dart';

import '../../UI/widgets/deep_snack_bar.dart';
import '../../data/deep.dart';
import '../../resource/icon_resource.dart';
import '../../utility/extension.dart';
import '../detect_text_direction_to_string.dart';
import 'note_creation.dart' as note_creation;
import 'provider/note_detail_provider.dart';

void run(
    {@required BuildContext context,
    @required int noteID,
    @required Note note,
    @required DeepPaperDatabase database,
    @required NoteDetailProvider detailProvider,
    @required int folderID,
    @required String folderName,
    @required bool isDeleted,
    @required bool isCopy}) {
  if (noteID.isNotNull || note.isNotNull) {
    // if detail empty
    // delete this note
    if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
      note_creation.deleteEmptyNote(
          database: database, noteID: note.isNull ? noteID : note.id);

      showSnack(
          context: context,
          icon: info(context: context),
          description: 'Empty note deleted');
    } else if (note.isNotNull) {
      // if there is any changes happen in note
      // update note data
      if (detailProvider.getTempDetail != detailProvider.getDetail) {
        note_creation.update(
            noteID: note.id,
            database: database,
            detail: detailProvider.getDetail,
            folderID: folderID,
            folderName: folderName,
            modified: DateTime.now(),
            isDeleted: isDeleted,
            isCopy: isCopy);
      } else if (isDeleted) {
        // Run only when user move this note to trash bin
        // without changing the content of note
        note_creation.update(
            noteID: note.id,
            database: database,
            detail: detailProvider.getDetail,
            folderID: folderID,
            folderName: folderName,
            modified: note.modified,
            isDeleted: isDeleted,
            isCopy: isCopy);
      } else if (isCopy) {
        // Run only when user make a copy of this note
        // without changing the content of note
        note_creation.copy(
          database: database,
          detail: detailProvider.getDetail,
          detailDirection: detectTextDirection(detailProvider.getDetail),
          folderID: folderID,
          folderName: folderName,
          folderNameDirection: detectTextDirection(folderName),
        );
      }
    } else {
      // Same as the usual note update but this run only when there is
      // no note data provided like when creating new note
      // because of user pressing home button, etc
      // then user continue editing the note,
      // then pressing back button to access the homepage of DeepPaper app
      if (detailProvider.getTempDetail != detailProvider.getDetail) {
        note_creation.update(
            database: database,
            noteID: noteID,
            detail: detailProvider.getDetail,
            folderID: folderID,
            folderName: folderName,
            modified: DateTime.now(),
            isDeleted: isDeleted,
            isCopy: isCopy);
      }
    }
  } else {
    // Create new note when there is no Note data exist in Database
    // or no Note data created
    // because of user tapping home button or there is a call
    note_creation.create(
        database: database,
        detail: detailProvider.getDetail,
        folderID: folderID,
        folderName: folderName,
        isDeleted: isDeleted,
        isCopy: isCopy);
  }
}
