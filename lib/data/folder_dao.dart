import 'package:deep_paper/data/deep.dart';
import 'package:moor/moor.dart';

part 'folder_dao.g.dart';

@UseDao(tables: [Notes,Folders])
class FolderDao extends DatabaseAccessor<DeepPaperDatabase>
    with _$FolderDaoMixin {

  FolderDao(this.db) : super(db);

  final DeepPaperDatabase db;

  Stream watchFolder() => select(folders).watch();
  Future insertFolder(FoldersCompanion entry) => into(folders).insert(entry);
  Future updateFolder(Folder entry) => update(folders).replace(entry);
  Future deleteFolder(Folder entry) => delete(folders).delete(entry);
}