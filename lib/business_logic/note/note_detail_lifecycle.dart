import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../utility/extension.dart';
import 'note_creation.dart';
import 'provider/note_detail_provider.dart';

class NoteDetailLifecycle {
  static Future<void> check(
      {@required AppLifecycleState state,
      @required NoteDetailProvider detailProvider,
      @required int folderID,
      @required String folderName}) async {
    if (state == AppLifecycleState.inactive) {
      if (detailProvider.getTempNoteID.isNull &&
          detailProvider.getNote.isNull) {
        // Create note data when user tapping home button
        // and there is no Note data exist in database
        detailProvider.setTempDetail = detailProvider.getDetail;
        detailProvider.setTempNoteID = await NoteCreation.create(
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
          isCopy: detailProvider.getIsCopy,
          isDeleted: detailProvider.getIsDeleted,
        );
      } else {
        if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
          // If note data exist, but detail text is empty
          // when user tap home button,
          // the empty data will deleted automatically
          NoteCreation.deleteEmptyNote(
              noteID: detailProvider.getNote.isNull
                  ? detailProvider.getTempNoteID
                  : detailProvider.getNote.id);
          detailProvider.setTempNoteID = null;
          detailProvider.setNote = null;
        } else if (detailProvider.getNote.isNotNull) {
          // Update note with latest date if there is any changes in detail
          // then user exit the app not using the usual pop
          // like using home button, chat notification, etc
          if (detailProvider.getTempDetail != detailProvider.getDetail) {
            detailProvider.setTempDetail = detailProvider.getDetail;

            await NoteCreation.update(
                noteID: detailProvider.getNote.id,
                detail: detailProvider.getDetail,
                folderID: folderID,
                folderName: folderName,
                modified: DateTime.now(),
                isDeleted: detailProvider.getIsDeleted,
                isCopy: detailProvider.getIsCopy);
          }
        } else {
          // Same as above but this run only when there is no note data provided
          // like when creating new note
          // because of user pressing home button, etc
          // then user continue editing the note,
          // then pressing home button again, etc
          if (detailProvider.getTempDetail != detailProvider.getDetail) {
            detailProvider.setTempDetail = detailProvider.getDetail;

            await NoteCreation.update(
                noteID: detailProvider.getTempNoteID,
                detail: detailProvider.getDetail,
                folderID: folderID,
                folderName: folderName,
                modified: DateTime.now(),
                isDeleted: detailProvider.getIsDeleted,
                isCopy: detailProvider.getIsCopy);
          }
        }
      }
    }
  }
}
