import 'package:deep_paper/UI/widgets/deep_toast.dart';
import 'package:deep_paper/business_logic/note/note_creation.dart';
import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class NoteDetailNormalSave {
  NoteDetailNormalSave._();

  static void run(
      {@required BuildContext context,
      @required int noteID,
      @required Note note,
      @required NoteDetailProvider detailProvider,
      @required int folderID,
      @required String folderName,
      @required bool isDeleted,
      @required bool isCopy}) {
    if (noteID.isNotNull || note.isNotNull) {
      // if detail empty
      // delete this note
      if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
        NoteCreation.deleteEmptyNote(
            context: context, noteID: note.isNull ? noteID : note.id);

        DeepToast.showToast(description: "Empty note deleted");
      } else if (note.isNotNull) {
        // if there is any changes happen in note
        // update note data
        if (detailProvider.getTempDetail != detailProvider.getDetail) {
          NoteCreation.update(
              context: context,
              noteID: note.id,
              detail: detailProvider.getDetail,
              folderID: folderID,
              folderName: folderName,
              modified: DateTime.now(),
              isDeleted: isDeleted,
              isCopy: isCopy);
        } else if (isDeleted) {
          // Run only when user move this note to trash bin
          // without changing the content of note
          NoteCreation.update(
              context: context,
              noteID: note.id,
              detail: detailProvider.getDetail,
              folderID: folderID,
              folderName: folderName,
              modified: note.modified,
              isDeleted: isDeleted,
              isCopy: isCopy);
        } else if (isCopy) {
          // Run only when user make a copy of this note
          // without changing the content of note
          NoteCreation.copy(
            context: context,
            detail: detailProvider.getDetail,
            detailDirection:
                Bidi.detectRtlDirectionality(detailProvider.getDetail)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            folderID: folderID,
            folderName: folderName,
            folderNameDirection: Bidi.detectRtlDirectionality(folderName)
                ? TextDirection.rtl
                : TextDirection.ltr,
          );
        }
      } else {
        // Same as the usual note update but this run only when there is no note data provided
        // like when creating new note because of user pressing home button, etc
        // then user continue editing the note,
        // then pressing back button to access the homepage of DeepPaper app
        if (detailProvider.getTempDetail != detailProvider.getDetail) {
          NoteCreation.update(
              context: context,
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
      // or no Note data created because of user tapping home button or there is a call
      NoteCreation.create(
          context: context,
          detail: detailProvider.getDetail,
          detailDirection:
              Bidi.detectRtlDirectionality(detailProvider.getDetail)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          folderID: folderID,
          folderName: folderName,
          folderNameDirection: Bidi.detectRtlDirectionality(folderName)
              ? TextDirection.rtl
              : TextDirection.ltr,
          isDeleted: isDeleted,
          isCopy: isCopy);
    }
  }
}
