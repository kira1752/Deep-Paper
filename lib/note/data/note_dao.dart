import 'dart:ui';

import 'package:deep_paper/note/data/deep.dart';
import 'package:moor/moor.dart';
import 'package:deep_paper/utility/extension.dart';

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

  Stream<List<Note>> watchNoteInsideFolder(FolderNoteData folder) {
    final folderID = folder.isNotNull ? folder.id : 0;
    return (select(notes)
          ..where((n) => n.folderID.equals(folderID))
          ..where((n) => n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.date)]))
        .watch();
  }

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
                folderName: Value(note.folderName),
                folderNameDirection: Value(note.folderNameDirection),
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

  Future<void> renameFolderAssociation(FolderNoteData folder) async {
    update(notes)
      ..where((n) => n.folderID.equals(folder.id))
      ..write(NotesCompanion(
          title: Value.absent(),
          detail: Value.absent(),
          date: Value.absent(),
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

  Future deleteFolderRelationWhenNoteInTrash(FolderNoteData folder,
      String mainFolder, TextDirection folderNameDirection) async {
    (update(notes)
          ..where((n) => n.folderID.equals(folder.id))
          ..where((n) => n.isDeleted.equals(true)))
        .write(NotesCompanion(
            folderID: Value(0),
            folderName: Value(mainFolder),
            folderNameDirection: Value(folderNameDirection)));
  }

  Future<void> deleteNote(Note entry) => delete(notes).delete(entry);
}
