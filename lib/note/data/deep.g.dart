// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int id;
  final int folderID;
  final String title;
  final String detail;
  final bool isDeleted;
  final DateTime date;
  Note(
      {@required this.id,
      this.folderID,
      this.title,
      this.detail,
      @required this.isDeleted,
      @required this.date});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      folderID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}folder_i_d']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      detail:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}detail']),
      isDeleted: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_deleted']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      folderID: serializer.fromJson<int>(json['folderID']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String>(json['detail']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folderID': serializer.toJson<int>(folderID),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String>(detail),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      folderID: folderID == null && nullToAbsent
          ? const Value.absent()
          : Value(folderID),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      detail:
          detail == null && nullToAbsent ? const Value.absent() : Value(detail),
      isDeleted: isDeleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isDeleted),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  Note copyWith(
          {int id,
          int folderID,
          String title,
          String detail,
          bool isDeleted,
          DateTime date}) =>
      Note(
        id: id ?? this.id,
        folderID: folderID ?? this.folderID,
        title: title ?? this.title,
        detail: detail ?? this.detail,
        isDeleted: isDeleted ?? this.isDeleted,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('folderID: $folderID, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          folderID.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(detail.hashCode,
                  $mrjc(isDeleted.hashCode, date.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.folderID == this.folderID &&
          other.title == this.title &&
          other.detail == this.detail &&
          other.isDeleted == this.isDeleted &&
          other.date == this.date);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> folderID;
  final Value<String> title;
  final Value<String> detail;
  final Value<bool> isDeleted;
  final Value<DateTime> date;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.folderID = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.date = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.folderID = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.isDeleted = const Value.absent(),
    @required DateTime date,
  }) : date = Value(date);
  NotesCompanion copyWith(
      {Value<int> id,
      Value<int> folderID,
      Value<String> title,
      Value<String> detail,
      Value<bool> isDeleted,
      Value<DateTime> date}) {
    return NotesCompanion(
      id: id ?? this.id,
      folderID: folderID ?? this.folderID,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      isDeleted: isDeleted ?? this.isDeleted,
      date: date ?? this.date,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _folderIDMeta = const VerificationMeta('folderID');
  GeneratedIntColumn _folderID;
  @override
  GeneratedIntColumn get folderID => _folderID ??= _constructFolderID();
  GeneratedIntColumn _constructFolderID() {
    return GeneratedIntColumn(
      'folder_i_d',
      $tableName,
      true,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      true,
    );
  }

  final VerificationMeta _detailMeta = const VerificationMeta('detail');
  GeneratedTextColumn _detail;
  @override
  GeneratedTextColumn get detail => _detail ??= _constructDetail();
  GeneratedTextColumn _constructDetail() {
    return GeneratedTextColumn(
      'detail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isDeletedMeta = const VerificationMeta('isDeleted');
  GeneratedBoolColumn _isDeleted;
  @override
  GeneratedBoolColumn get isDeleted => _isDeleted ??= _constructIsDeleted();
  GeneratedBoolColumn _constructIsDeleted() {
    return GeneratedBoolColumn('is_deleted', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, folderID, title, detail, isDeleted, date];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.folderID.present) {
      context.handle(_folderIDMeta,
          folderID.isAcceptableValue(d.folderID.value, _folderIDMeta));
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    }
    if (d.detail.present) {
      context.handle(
          _detailMeta, detail.isAcceptableValue(d.detail.value, _detailMeta));
    }
    if (d.isDeleted.present) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableValue(d.isDeleted.value, _isDeletedMeta));
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.folderID.present) {
      map['folder_i_d'] = Variable<int, IntType>(d.folderID.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.detail.present) {
      map['detail'] = Variable<String, StringType>(d.detail.value);
    }
    if (d.isDeleted.present) {
      map['is_deleted'] = Variable<bool, BoolType>(d.isDeleted.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class FolderNoteData extends DataClass implements Insertable<FolderNoteData> {
  final int id;
  final String name;
  FolderNoteData({@required this.id, @required this.name});
  factory FolderNoteData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return FolderNoteData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory FolderNoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FolderNoteData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  FolderNoteCompanion createCompanion(bool nullToAbsent) {
    return FolderNoteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  FolderNoteData copyWith({int id, String name}) => FolderNoteData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('FolderNoteData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FolderNoteData &&
          other.id == this.id &&
          other.name == this.name);
}

class FolderNoteCompanion extends UpdateCompanion<FolderNoteData> {
  final Value<int> id;
  final Value<String> name;
  const FolderNoteCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  FolderNoteCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  FolderNoteCompanion copyWith({Value<int> id, Value<String> name}) {
    return FolderNoteCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $FolderNoteTable extends FolderNote
    with TableInfo<$FolderNoteTable, FolderNoteData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FolderNoteTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $FolderNoteTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'folder_note';
  @override
  final String actualTableName = 'folder_note';
  @override
  VerificationContext validateIntegrity(FolderNoteCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolderNoteData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FolderNoteData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FolderNoteCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $FolderNoteTable createAlias(String alias) {
    return $FolderNoteTable(_db, alias);
  }
}

class AudioNoteData extends DataClass implements Insertable<AudioNoteData> {
  final int id;
  final int noteID;
  final String name;
  AudioNoteData(
      {@required this.id, @required this.noteID, @required this.name});
  factory AudioNoteData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AudioNoteData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      noteID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}note_i_d']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory AudioNoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AudioNoteData(
      id: serializer.fromJson<int>(json['id']),
      noteID: serializer.fromJson<int>(json['noteID']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteID': serializer.toJson<int>(noteID),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  AudioNoteCompanion createCompanion(bool nullToAbsent) {
    return AudioNoteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      noteID:
          noteID == null && nullToAbsent ? const Value.absent() : Value(noteID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  AudioNoteData copyWith({int id, int noteID, String name}) => AudioNoteData(
        id: id ?? this.id,
        noteID: noteID ?? this.noteID,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('AudioNoteData(')
          ..write('id: $id, ')
          ..write('noteID: $noteID, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(noteID.hashCode, name.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AudioNoteData &&
          other.id == this.id &&
          other.noteID == this.noteID &&
          other.name == this.name);
}

class AudioNoteCompanion extends UpdateCompanion<AudioNoteData> {
  final Value<int> id;
  final Value<int> noteID;
  final Value<String> name;
  const AudioNoteCompanion({
    this.id = const Value.absent(),
    this.noteID = const Value.absent(),
    this.name = const Value.absent(),
  });
  AudioNoteCompanion.insert({
    this.id = const Value.absent(),
    @required int noteID,
    @required String name,
  })  : noteID = Value(noteID),
        name = Value(name);
  AudioNoteCompanion copyWith(
      {Value<int> id, Value<int> noteID, Value<String> name}) {
    return AudioNoteCompanion(
      id: id ?? this.id,
      noteID: noteID ?? this.noteID,
      name: name ?? this.name,
    );
  }
}

class $AudioNoteTable extends AudioNote
    with TableInfo<$AudioNoteTable, AudioNoteData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudioNoteTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _noteIDMeta = const VerificationMeta('noteID');
  GeneratedIntColumn _noteID;
  @override
  GeneratedIntColumn get noteID => _noteID ??= _constructNoteID();
  GeneratedIntColumn _constructNoteID() {
    return GeneratedIntColumn(
      'note_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, noteID, name];
  @override
  $AudioNoteTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audio_note';
  @override
  final String actualTableName = 'audio_note';
  @override
  VerificationContext validateIntegrity(AudioNoteCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.noteID.present) {
      context.handle(
          _noteIDMeta, noteID.isAcceptableValue(d.noteID.value, _noteIDMeta));
    } else if (isInserting) {
      context.missing(_noteIDMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioNoteData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AudioNoteData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AudioNoteCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.noteID.present) {
      map['note_i_d'] = Variable<int, IntType>(d.noteID.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $AudioNoteTable createAlias(String alias) {
    return $AudioNoteTable(_db, alias);
  }
}

class ImageNoteData extends DataClass implements Insertable<ImageNoteData> {
  final int id;
  final int noteID;
  final String name;
  ImageNoteData(
      {@required this.id, @required this.noteID, @required this.name});
  factory ImageNoteData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ImageNoteData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      noteID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}note_i_d']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory ImageNoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ImageNoteData(
      id: serializer.fromJson<int>(json['id']),
      noteID: serializer.fromJson<int>(json['noteID']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'noteID': serializer.toJson<int>(noteID),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  ImageNoteCompanion createCompanion(bool nullToAbsent) {
    return ImageNoteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      noteID:
          noteID == null && nullToAbsent ? const Value.absent() : Value(noteID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  ImageNoteData copyWith({int id, int noteID, String name}) => ImageNoteData(
        id: id ?? this.id,
        noteID: noteID ?? this.noteID,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ImageNoteData(')
          ..write('id: $id, ')
          ..write('noteID: $noteID, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(noteID.hashCode, name.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ImageNoteData &&
          other.id == this.id &&
          other.noteID == this.noteID &&
          other.name == this.name);
}

class ImageNoteCompanion extends UpdateCompanion<ImageNoteData> {
  final Value<int> id;
  final Value<int> noteID;
  final Value<String> name;
  const ImageNoteCompanion({
    this.id = const Value.absent(),
    this.noteID = const Value.absent(),
    this.name = const Value.absent(),
  });
  ImageNoteCompanion.insert({
    this.id = const Value.absent(),
    @required int noteID,
    @required String name,
  })  : noteID = Value(noteID),
        name = Value(name);
  ImageNoteCompanion copyWith(
      {Value<int> id, Value<int> noteID, Value<String> name}) {
    return ImageNoteCompanion(
      id: id ?? this.id,
      noteID: noteID ?? this.noteID,
      name: name ?? this.name,
    );
  }
}

class $ImageNoteTable extends ImageNote
    with TableInfo<$ImageNoteTable, ImageNoteData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ImageNoteTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _noteIDMeta = const VerificationMeta('noteID');
  GeneratedIntColumn _noteID;
  @override
  GeneratedIntColumn get noteID => _noteID ??= _constructNoteID();
  GeneratedIntColumn _constructNoteID() {
    return GeneratedIntColumn(
      'note_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, noteID, name];
  @override
  $ImageNoteTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'image_note';
  @override
  final String actualTableName = 'image_note';
  @override
  VerificationContext validateIntegrity(ImageNoteCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.noteID.present) {
      context.handle(
          _noteIDMeta, noteID.isAcceptableValue(d.noteID.value, _noteIDMeta));
    } else if (isInserting) {
      context.missing(_noteIDMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImageNoteData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ImageNoteData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ImageNoteCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.noteID.present) {
      map['note_i_d'] = Variable<int, IntType>(d.noteID.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $ImageNoteTable createAlias(String alias) {
    return $ImageNoteTable(_db, alias);
  }
}

abstract class _$DeepPaperDatabase extends GeneratedDatabase {
  _$DeepPaperDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  $FolderNoteTable _folderNote;
  $FolderNoteTable get folderNote => _folderNote ??= $FolderNoteTable(this);
  $AudioNoteTable _audioNote;
  $AudioNoteTable get audioNote => _audioNote ??= $AudioNoteTable(this);
  $ImageNoteTable _imageNote;
  $ImageNoteTable get imageNote => _imageNote ??= $ImageNoteTable(this);
  NoteDao _noteDao;
  NoteDao get noteDao => _noteDao ??= NoteDao(this as DeepPaperDatabase);
  FolderNoteDao _folderNoteDao;
  FolderNoteDao get folderNoteDao =>
      _folderNoteDao ??= FolderNoteDao(this as DeepPaperDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [notes, folderNote, audioNote, imageNote];
}
