import 'package:moor/moor.dart';

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
}
