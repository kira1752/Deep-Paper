import 'dart:ui';

import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:moor/moor.dart';

part 'note_dao.g.dart';

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<DeepPaperDatabase> with _$NoteDaoMixin {
  NoteDao(this.db) : super(db);

  final DeepPaperDatabase db;

  Stream<List<Note>> watchAllNotes() {
    return (select(notes)
          ..where((n) => n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.modified)]))
        .watch();
  }

  Future<List<Note>> getAllNotes() => (select(notes)).get();

  Stream<List<Note>> watchAllDeletedNotes() => (select(notes)
        ..where((n) => n.isDeleted.equals(true))
        ..orderBy([(n) => OrderingTerm.desc(n.modified)]))
      .watch();

  Stream<List<Note>> watchNoteInsideFolder(FolderNoteData folder) {
    final folderID = folder.isNotNull ? folder.id : 0;
    return (select(notes)
      ..where((n) => n.folderID.equals(folderID))..where((n) =>
          n.isDeleted.equals(false))
      ..orderBy([(n) => OrderingTerm.desc(n.modified)]))
        .watch();
  }

  Future<int> insertNote(NotesCompanion entry) => into(notes).insert(entry);

  Future<void> insertNoteBatch(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.insert(
            notes,
            NotesCompanion(
                detail: Value(note.detail),
                detailDirection: Value(note.detailDirection),
                folderID: Value(note.folderID),
                folderName: Value(note.folderName),
                folderNameDirection: Value(note.folderNameDirection),
                modified: Value(DateTime.now()),
                created: Value(DateTime.now())));
      });
    });
  }

  Future<void> updateNote(int noteID, NotesCompanion entry) =>
      (update(notes)..where((tbl) => tbl.id.equals(noteID))).write(entry);

  Future<void> moveToTrash(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.replace(notes, note.copyWith(isDeleted: true));
      });
    });
  }

  Future<void> moveToFolder(Map<int, Note> selectedNote, int folderID,
      String folderName, TextDirection folderNameDirection) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.replace(
            notes,
            note.copyWith(
                folderID: folderID,
                folderName: folderName,
                folderNameDirection: folderNameDirection));
      });
    });
  }

  void renameFolderAssociation(FolderNoteData folder) {
    update(notes)
      ..where((n) => n.folderID.equals(folder.id))
      ..write(NotesCompanion(
          detail: const Value.absent(),
          modified: const Value.absent(),
          created: const Value.absent(),
          folderName: Value(folder.name),
          folderNameDirection: Value(folder.nameDirection)));
  }

  Future<void> restoreFromTrash(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.replace(notes, note.copyWith(isDeleted: false));
      });
    });
  }

  Future<void> deleteForever(Map<int, Note> selectedNote) async {
    await batch((b) {
      selectedNote.forEach((key, note) {
        b.delete(notes, note);
      });
    });
  }

  void emptyTrashBin() {
    delete(notes)
      ..where((n) => n.isDeleted.equals(true))
      ..go();
  }

  void deleteNotesInsideFolderForever(FolderNoteData folder) {
    delete(notes)
      ..where((n) => n.folderID.equals(folder.id))
      ..go();
  }

  void deleteFolderRelationWhenNoteInTrash(FolderNoteData folder,
      String mainFolder, TextDirection folderNameDirection) {
    (update(notes)
      ..where((n) => n.folderID.equals(folder.id))..where((n) =>
          n.isDeleted.equals(true)))
        .write(NotesCompanion(
        folderID: const Value(0),
        folderName: Value(mainFolder),
        folderNameDirection: Value(folderNameDirection)));
  }

  void deleteNote(int noteID) {
    delete(notes)
      ..where((n) => n.id.equals(noteID))
      ..go();
  }

  Future<DateTime> getCreatedDate(int noteID) async {
    final query = await (select(notes)
      ..where((tbl) => tbl.id.equals(noteID)))
        .getSingle();

    return query?.created;
  }
}
