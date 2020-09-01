import 'dart:io';
import 'dart:ui';

import 'package:deep_paper/data/note/folder_note_dao.dart';
import 'package:deep_paper/data/note/note_dao.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'deep.g.dart';

class TextDirectionConverter extends TypeConverter<TextDirection, String> {
  const TextDirectionConverter();
  @override
  TextDirection mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }

    return fromDb == 'TextDirection.ltr'
        ? TextDirection.ltr
        : TextDirection.rtl;
  }

  @override
  String mapToSql(TextDirection value) {
    if (value == null) {
      return null;
    }
    return '$value';
  }
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get folderID => integer().withDefault(const Constant(0))();

  TextColumn get folderName => text()();

  TextColumn get folderNameDirection =>
      text().map(const TextDirectionConverter())();

  TextColumn get detail => text()();

  TextColumn get detailDirection =>
      text().map(const TextDirectionConverter())();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  BoolColumn get containAudio => boolean().withDefault(const Constant(false))();

  BoolColumn get containImage => boolean().withDefault(const Constant(false))();

  DateTimeColumn get modified => dateTime()();

  DateTimeColumn get created => dateTime()();
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
  TextColumn get nameDirection => text().map(const TextDirectionConverter())();
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

@UseMoor(
    tables: [Notes, FolderNote, AudioNote, ImageNote],
    daos: [NoteDao, FolderNoteDao])
class DeepPaperDatabase extends _$DeepPaperDatabase {
  DeepPaperDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
