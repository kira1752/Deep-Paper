import 'dart:io';
import 'package:deep_paper/note/data/folder_note_dao.dart';
import 'package:deep_paper/note/data/note_dao.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'deep.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get folderID => integer().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get detail => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get containAudio => boolean().withDefault(const Constant(false))();
  BoolColumn get containImage => boolean().withDefault(const Constant(false))();
  DateTimeColumn get date => dateTime()();
}

class AudioNote extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteID => integer()();
  TextColumn get name => text()();
}

class ImageNote extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteID => integer()();
  TextColumn get name => text()();
}

class FolderNote extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'deep_paper.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Notes, FolderNote, AudioNote, ImageNote], daos: [NoteDao, FolderNoteDao])
class DeepPaperDatabase extends _$DeepPaperDatabase {
  DeepPaperDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}