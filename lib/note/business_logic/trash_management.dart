import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TrashManagement {
  static Future<void> empty({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.emptyTrashBin();

    DeepToast.showToast(description: "Trash emptied successfully");
  }

  static Future<void> restore(
      {@required BuildContext context, @required Note data}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.updateNote(data.copyWith(isDeleted: false));

    DeepToast.showToast(description: "Note restored successfully");
  }

  static Future<void> restoreBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.restoreFromTrash(selectedNote);

    DeepToast.showToast(description: "Note restored successfully");
  }

  static Future<void> deleteBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.deleteForever(selectedNote);

    DeepToast.showToast(description: "Note deleted successfully");
  }
}
