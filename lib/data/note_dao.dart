import 'package:deep_paper/data/deep.dart';
import 'package:moor/moor.dart';

part 'note_dao.g.dart';

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<DeepPaperDatabase> with _$NoteDaoMixin {
  NoteDao(this.db) : super(db);

  final DeepPaperDatabase db;

  Stream<List<Note>> watchAllNotes() =>
      (select(notes)..orderBy([(n) => OrderingTerm.desc(n.date)])).watch();

  Stream watchNoteInsideFolder(Folder folder) => (select(notes)
        ..where((n) => n.folderID.equals(folder.id))
        ..orderBy([(n) => OrderingTerm.desc(n.date)]))
      .watch();
      
  Future insertNote(NotesCompanion entry) => into(notes).insert(entry);
  Future updateNote(Note entry) => update(notes).replace(entry);
  Future deleteNote(Note entry) => delete(notes).delete(entry);
}
