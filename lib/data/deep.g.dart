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
  final DateTime date;
  Note(
      {@required this.id,
      this.folderID,
      this.title,
      this.detail,
      @required this.date});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      folderID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}folder_i_d']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      detail:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}detail']),
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
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  Note copyWith(
          {int id, int folderID, String title, String detail, DateTime date}) =>
      Note(
        id: id ?? this.id,
        folderID: folderID ?? this.folderID,
        title: title ?? this.title,
        detail: detail ?? this.detail,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('folderID: $folderID, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(folderID.hashCode,
          $mrjc(title.hashCode, $mrjc(detail.hashCode, date.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.folderID == this.folderID &&
          other.title == this.title &&
          other.detail == this.detail &&
          other.date == this.date);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> folderID;
  final Value<String> title;
  final Value<String> detail;
  final Value<DateTime> date;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.folderID = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.date = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.folderID = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    @required DateTime date,
  }) : date = Value(date);
  NotesCompanion copyWith(
      {Value<int> id,
      Value<int> folderID,
      Value<String> title,
      Value<String> detail,
      Value<DateTime> date}) {
    return NotesCompanion(
      id: id ?? this.id,
      folderID: folderID ?? this.folderID,
      title: title ?? this.title,
      detail: detail ?? this.detail,
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
  List<GeneratedColumn> get $columns => [id, folderID, title, detail, date];
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

class Folder extends DataClass implements Insertable<Folder> {
  final int id;
  final String name;
  Folder({@required this.id, @required this.name});
  factory Folder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Folder(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory Folder.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Folder(
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
  FoldersCompanion createCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  Folder copyWith({int id, String name}) => Folder(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Folder(')
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
      (other is Folder && other.id == this.id && other.name == this.name);
}

class FoldersCompanion extends UpdateCompanion<Folder> {
  final Value<int> id;
  final Value<String> name;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  FoldersCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  FoldersCompanion copyWith({Value<int> id, Value<String> name}) {
    return FoldersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoldersTable(this._db, [this._alias]);
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
  $FoldersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'folders';
  @override
  final String actualTableName = 'folders';
  @override
  VerificationContext validateIntegrity(FoldersCompanion d,
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
  Folder map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Folder.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FoldersCompanion d) {
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
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(_db, alias);
  }
}

abstract class _$DeepPaperDatabase extends GeneratedDatabase {
  _$DeepPaperDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  $FoldersTable _folders;
  $FoldersTable get folders => _folders ??= $FoldersTable(this);
  NoteDao _noteDao;
  NoteDao get noteDao => _noteDao ??= NoteDao(this as DeepPaperDatabase);
  FolderDao _folderDao;
  FolderDao get folderDao =>
      _folderDao ??= FolderDao(this as DeepPaperDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes, folders];
}
