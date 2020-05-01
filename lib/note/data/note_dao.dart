import 'package:deep_paper/note/data/deep.dart';
import 'package:moor/moor.dart';

part 'note_dao.g.dart';

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<DeepPaperDatabase> with _$NoteDaoMixin {
  NoteDao(this.db) : super(db);

  final DeepPaperDatabase db;

  Stream<List<Note>> watchAllNotes() {
    return (select(notes)
          ..where((n) => n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.date)]))
        .watch();
  }

  Future<List<Note>> getAllNotes() => (select(notes)).get();

  Stream<List<Note>> watchAllDeletedNotes() => (select(notes)
        ..where((n) => n.isDeleted.equals(true))
        ..orderBy([(n) => OrderingTerm.desc(n.date)]))
      .watch();

  Stream<List<Note>> watchNoteInsideFolder(FolderNoteData folder) =>
      (select(notes)
            ..where((n) => n.folderID.equals(folder.id))
            ..where((n) => n.isDeleted.equals(false))
            ..orderBy([(n) => OrderingTerm.desc(n.date)]))
          .watch();

  Future<void> insertNote(NotesCompanion entry) => into(notes).insert(entry);

  Future<void> insertNoteBatch(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.insert(
            notes,
            NotesCompanion(
                title: Value(note.title),
                detail: Value(note.detail),
                titleDirection: Value(note.titleDirection),
                detailDirection: Value(note.detailDirection),
                folderID: Value(note.folderID),
                date: Value(DateTime.now())));
      });
    });
  }

  Future<void> updateNote(Note entry) => update(notes).replace(entry);

  Future<void> moveToTrash(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.replace(notes, note.copyWith(isDeleted: true));
      });
    });
  }

  Future<void> restoreFromTrash(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.replace(notes, note.copyWith(isDeleted: false));
      });
    });
  }

  Future<void> deleteForever(Map<int, Note> selectedNote) async {
    selectedNote.forEach((key, note) {
      delete(notes).delete(note);
    });
  }

  Future<void> emptyTrashBin() async {
    delete(notes)
      ..where((n) => n.isDeleted.equals(true))
      ..go();
  }

  Future<void> deleteNotesInsideFolderForever(FolderNoteData folder) async {
    delete(notes)
      ..where((n) => n.folderID.equals(folder.id))
      ..go();
  }

  Future deleteFolderRelationWhenNoteInTrash(FolderNoteData folder) async {
    (update(notes)
          ..where((n) => n.folderID.equals(folder.id))
          ..where((n) => n.isDeleted.equals(true)))
        .write(NotesCompanion(folderID: Value(null)));
  }

  Future<void> deleteNote(Note entry) => delete(notes).delete(entry);
}
