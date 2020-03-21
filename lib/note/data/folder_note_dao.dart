import 'package:deep_paper/note/data/deep.dart';
import 'package:moor/moor.dart';

part 'folder_note_dao.g.dart';

@UseDao(tables: [Notes,FolderNote])
class FolderNoteDao extends DatabaseAccessor<DeepPaperDatabase>
    with _$FolderNoteDaoMixin {

  FolderNoteDao(this.db) : super(db);

  final DeepPaperDatabase db;

  Stream watchFolder() => select(folderNote).watch();
  Future insertFolder(FolderNoteCompanion entry) => into(folderNote).insert(entry);
  Future updateFolder(FolderNoteData entry) => update(folderNote).replace(entry);
  Future deleteFolder(FolderNoteData entry) => delete(folderNote).delete(entry);
}