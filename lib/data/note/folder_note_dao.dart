import 'package:moor/moor.dart';

import '../../model/note/drawer_folder_model.dart';
import '../deep.dart';

part 'folder_note_dao.g.dart';

@UseDao(tables: [FolderNote, Notes])
class FolderNoteDao extends DatabaseAccessor<DeepPaperDatabase>
    with _$FolderNoteDaoMixin {
  FolderNoteDao(this.db) : super(db);

  final DeepPaperDatabase db;

  Stream<List<FolderNoteData>> watchFolder() => select(folderNote).watch();

  Future<List<FolderNoteData>> getFolder() => select(folderNote).get();

  Future insertFolder(FolderNoteCompanion entry) =>
      into(folderNote).insert(entry);

  Future updateFolder(FolderNoteData entry) =>
      update(folderNote).replace(entry);

  Future deleteFolder(FolderNoteData entry) => delete(folderNote).delete(entry);

  Stream<List<DrawerFolderModel>> watchFolderWithCount() {
    /// notes is your usual table that basically store note id and folder id
    /// for simple example purpose
    final availableNotesCount =
        notes.id.count(filter: notes.isDeleted.equals(false));

    /// folderNote is your usual table that basically store folder id and folder name
    /// for simple example purpose
    final folderQuery = select(folderNote).join([
      leftOuterJoin(notes, notes.folderID.equalsExp(folderNote.id),
          useColumns: false)
    ]);

    folderQuery
      ..addColumns([availableNotesCount])
      ..groupBy([folderNote.id]);

    /// i replace get() with watch() for reactive purpose
    final folderList = folderQuery.watch().map((list) => list
        .map((row) => DrawerFolderModel(
            folder: row.readTable(folderNote),
            count: row.read(availableNotesCount)))
        .toList());

    return folderList;
  }
}
