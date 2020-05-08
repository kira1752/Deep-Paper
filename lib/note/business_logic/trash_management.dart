import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TrashManagement {
  static Future<void> empty({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    

    await database.noteDao.emptyTrashBin();
  }

  static Future<void> restore(
      {@required BuildContext context, @required Note data}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.updateNote(data.copyWith(isDeleted: false));
  }

  static Future<void> restoreBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.restoreFromTrash(selectedNote);
  }

  static Future<void> deleteBatch({@required BuildContext context}) async {
    final selectedNote =
        Provider.of<SelectionProvider>(context, listen: false).getSelected;

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.deleteForever(selectedNote);
  }
}
