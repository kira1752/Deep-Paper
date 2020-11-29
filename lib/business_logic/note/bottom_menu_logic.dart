import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../UI/note/widgets/note_dialog.dart';
import '../../UI/widgets/deep_snack_bar.dart';
import '../../data/deep.dart';
import '../../resource/icon_resource.dart';
import '../../resource/string_resource.dart';
import '../../utility/extension.dart';
import '../provider/note/note_detail_provider.dart';

Future<void> noteInfo(
    {@required BuildContext context, String folderName}) async {
  final created = await context
      .read<DeepPaperDatabase>()
      .noteDao
      .getCreatedDate(context.read<NoteDetailProvider>().getTempNoteID);

  Navigator.pop(context);

  Future.delayed(const Duration(milliseconds: 400), () {
    openNoteInfo(
        context: context,
        folderName: folderName ?? StringResource.mainFolder,
        modified: context.read<NoteDetailProvider>().getNote.isNull
            ? DateTime.now()
            : (context.read<NoteDetailProvider>().getNote.detail !=
                    context.read<NoteDetailProvider>().getDetail
                ? DateTime.now()
                : context.read<NoteDetailProvider>().getNote.modified),
        created: context.read<NoteDetailProvider>().getTempNoteID.isNull
            ? (context.read<NoteDetailProvider>().getNote.isNull
                ? DateTime.now()
                : context.read<NoteDetailProvider>().getNote.created)
            : created);
  });
}

void onCopy({@required BuildContext context}) {
  if (context.read<NoteDetailProvider>().getDetail.isNullEmptyOrWhitespace) {
    Navigator.pop(context);

    showSnack(
        context: context,
        icon: info(context: context),
        description: 'Cannot copy empty note');
  } else {
    context.read<NoteDetailProvider>().isCopy = true;

    Navigator.pop(context);

    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.maybePop(context);
      showSnack(
          context: context,
          icon: successful(context: context),
          description: 'Note copied successfully');
    });
  }
}

void onDelete({@required BuildContext context}) {
  if (!context.read<NoteDetailProvider>().getDetail.isNullEmptyOrWhitespace) {
    context
        .read<NoteDetailProvider>()
        .isDeleted = true;

    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.maybePop(context);
      showSnack(
          context: context,
          icon: info(context: context),
          description: 'Note moved to Trash Bin');
    });
  } else if (context.read<NoteDetailProvider>().getTempNoteID.isNull &&
      context.read<NoteDetailProvider>().getNote.isNull) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.maybePop(context);
      showSnack(
          context: context,
          icon: info(context: context),
          description: 'Empty note deleted');
    });
  } else {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.maybePop(context);
    });
  }
}
