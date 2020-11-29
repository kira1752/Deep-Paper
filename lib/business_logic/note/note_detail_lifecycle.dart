import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../data/deep.dart';
import '../../utility/extension.dart';
import '../provider/note/note_detail_provider.dart';
import 'note_creation.dart' as note_creation;

Future<void> noteDetailLifecycle(
    {@required AppLifecycleState state,
    @required DeepPaperDatabase database,
    @required NoteDetailProvider detailProvider,
    @required int folderID,
    @required String folderName}) async {
  if (state == AppLifecycleState.inactive) {
    if (detailProvider.getTempNoteID.isNull && detailProvider.getNote.isNull) {
      // Create note data when user tapping home button
      // and there is no Note data exist in database
      detailProvider.setTempDetail = detailProvider.getDetail;
      detailProvider.setTempNoteID = await note_creation.create(
        database: database,
        detail: detailProvider.getDetail,
        folderID: folderID,
        folderName: folderName,
        isCopy: detailProvider.isCopy,
        isDeleted: detailProvider.isDeleted,
      );
    } else {
      if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
        // If note data exist, but detail text is empty
        // when user tap home button,
        // the empty data will deleted automatically
        note_creation.deleteEmptyNote(
            noteID: detailProvider.getNote.isNull
                ? detailProvider.getTempNoteID
                : detailProvider.getNote.id,
            database: database);
        detailProvider.setTempNoteID = null;
        detailProvider.setNote = null;
      } else if (detailProvider.getNote.isNotNull) {
        // Update note with latest date if there is any changes in detail
        // then user exit the app not using the usual pop
        // like using home button, chat notification, etc
        if (detailProvider.getTempDetail != detailProvider.getDetail) {
          detailProvider.setTempDetail = detailProvider.getDetail;

          await note_creation.update(
              database: database,
              noteID: detailProvider.getNote.id,
              detail: detailProvider.getDetail,
              folderID: folderID,
              folderName: folderName,
              modified: DateTime.now(),
              isDeleted: detailProvider.isDeleted,
              isCopy: detailProvider.isCopy);
        }
      } else {
        // Same as above but this run only when there is no note data provided
        // like when creating new note
        // because of user pressing home button, etc
        // then user continue editing the note,
        // then pressing home button again, etc
        if (detailProvider.getTempDetail != detailProvider.getDetail) {
          detailProvider.setTempDetail = detailProvider.getDetail;

          await note_creation.update(
              database: database,
              noteID: detailProvider.getTempNoteID,
              detail: detailProvider.getDetail,
              folderID: folderID,
              folderName: folderName,
              modified: DateTime.now(),
              isDeleted: detailProvider.isDeleted,
              isCopy: detailProvider.isCopy);
        }
      }
    }
  }
}
