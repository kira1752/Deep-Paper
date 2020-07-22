import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'note_creation.dart';

class NoteDetailLifecycle {
  static Future<void> check(
      {@required BuildContext context,
      @required AppLifecycleState state,
      @required NoteDetailProvider detailProvider,
      @required int folderID,
      @required String folderName}) async {
    if (state == AppLifecycleState.inactive) {
      if (detailProvider.getNoteID.isNull && detailProvider.getNote.isNull) {
        // Create note data when user tapping home button
        // and there is no Note data exist in database
        detailProvider.setTempDetail = detailProvider.getDetail;
        detailProvider.setNoteID = await NoteCreation.create(
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
          isCopy: detailProvider.getIsCopy,
          isDeleted: detailProvider.getIsDeleted,
        );
      } else {
        if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
          NoteCreation.deleteEmptyNote(
              context: context,
              noteID: detailProvider.getNote.isNull
                  ? detailProvider.getNoteID
                  : detailProvider.getNote.id);
          detailProvider.setNoteID = null;
          detailProvider.setNote = null;
        } else if (detailProvider.getNote.isNotNull) {
          // Update note with latest date if there is any changes in detail
          // then user exit the app not using the usual pop
          // like using home button, chat notification, etc
          if (detailProvider.getTempDetail != detailProvider.getDetail) {
            detailProvider.setTempDetail = detailProvider.getDetail;

            NoteCreation.update(
                context: context,
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
          // like when creating new note because of user pressing home button, etc
          // then user continue editing the note,
          // then pressing home button again, etc
          if (detailProvider.getTempDetail != detailProvider.getDetail) {
            detailProvider.setTempDetail = detailProvider.getDetail;

            NoteCreation.update(
                context: context,
                noteID: detailProvider.getNoteID,
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
