// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int id;
  final int folderID;
  final String folderName;
  final TextDirection folderNameDirection;
  final String detail;
  final TextDirection detailDirection;
  final bool isDeleted;
  final bool containAudio;
  final bool containImage;
  final DateTime date;
  Note(
      {@required this.id,
      @required this.folderID,
      @required this.folderName,
      @required this.folderNameDirection,
      @required this.detail,
      @required this.detailDirection,
      @required this.isDeleted,
      @required this.containAudio,
      @required this.containImage,
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
      folderName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_name']),
      folderNameDirection: $NotesTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(
              data['${effectivePrefix}folder_name_direction'])),
      detail:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}detail']),
      detailDirection: $NotesTable.$converter1.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}detail_direction'])),
      isDeleted: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_deleted']),
      containAudio: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}contain_audio']),
      containImage: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}contain_image']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || folderID != null) {
      map['folder_i_d'] = Variable<int>(folderID);
    }
    if (!nullToAbsent || folderName != null) {
      map['folder_name'] = Variable<String>(folderName);
    }
    if (!nullToAbsent || folderNameDirection != null) {
      final converter = $NotesTable.$converter0;
      map['folder_name_direction'] =
          Variable<String>(converter.mapToSql(folderNameDirection));
    }
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    if (!nullToAbsent || detailDirection != null) {
      final converter = $NotesTable.$converter1;
      map['detail_direction'] =
          Variable<String>(converter.mapToSql(detailDirection));
    }
    if (!nullToAbsent || isDeleted != null) {
      map['is_deleted'] = Variable<bool>(isDeleted);
    }
    if (!nullToAbsent || containAudio != null) {
      map['contain_audio'] = Variable<bool>(containAudio);
    }
    if (!nullToAbsent || containImage != null) {
      map['contain_image'] = Variable<bool>(containImage);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      folderID: folderID == null && nullToAbsent
          ? const Value.absent()
          : Value(folderID),
      folderName: folderName == null && nullToAbsent
          ? const Value.absent()
          : Value(folderName),
      folderNameDirection: folderNameDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(folderNameDirection),
      detail:
          detail == null && nullToAbsent ? const Value.absent() : Value(detail),
      detailDirection: detailDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(detailDirection),
      isDeleted: isDeleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isDeleted),
      containAudio: containAudio == null && nullToAbsent
          ? const Value.absent()
          : Value(containAudio),
      containImage: containImage == null && nullToAbsent
          ? const Value.absent()
          : Value(containImage),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      folderID: serializer.fromJson<int>(json['folderID']),
      folderName: serializer.fromJson<String>(json['folderName']),
      folderNameDirection:
          serializer.fromJson<TextDirection>(json['folderNameDirection']),
      detail: serializer.fromJson<String>(json['detail']),
      detailDirection:
          serializer.fromJson<TextDirection>(json['detailDirection']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      containAudio: serializer.fromJson<bool>(json['containAudio']),
      containImage: serializer.fromJson<bool>(json['containImage']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folderID': serializer.toJson<int>(folderID),
      'folderName': serializer.toJson<String>(folderName),
      'folderNameDirection':
          serializer.toJson<TextDirection>(folderNameDirection),
      'detail': serializer.toJson<String>(detail),
      'detailDirection': serializer.toJson<TextDirection>(detailDirection),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'containAudio': serializer.toJson<bool>(containAudio),
      'containImage': serializer.toJson<bool>(containImage),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Note copyWith(
          {int id,
          int folderID,
          String folderName,
          TextDirection folderNameDirection,
          String detail,
          TextDirection detailDirection,
          bool isDeleted,
          bool containAudio,
          bool containImage,
          DateTime date}) =>
      Note(
        id: id ?? this.id,
        folderID: folderID ?? this.folderID,
        folderName: folderName ?? this.folderName,
        folderNameDirection: folderNameDirection ?? this.folderNameDirection,
        detail: detail ?? this.detail,
        detailDirection: detailDirection ?? this.detailDirection,
        isDeleted: isDeleted ?? this.isDeleted,
        containAudio: containAudio ?? this.containAudio,
        containImage: containImage ?? this.containImage,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('folderID: $folderID, ')
          ..write('folderName: $folderName, ')
          ..write('folderNameDirection: $folderNameDirection, ')
          ..write('detail: $detail, ')
          ..write('detailDirection: $detailDirection, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('containAudio: $containAudio, ')
          ..write('containImage: $containImage, ')
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
              folderName.hashCode,
              $mrjc(
                  folderNameDirection.hashCode,
                  $mrjc(
                      detail.hashCode,
                      $mrjc(
                          detailDirection.hashCode,
                          $mrjc(
                              isDeleted.hashCode,
                              $mrjc(
                                  containAudio.hashCode,
                                  $mrjc(containImage.hashCode,
                                      date.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.folderID == this.folderID &&
          other.folderName == this.folderName &&
          other.folderNameDirection == this.folderNameDirection &&
          other.detail == this.detail &&
          other.detailDirection == this.detailDirection &&
          other.isDeleted == this.isDeleted &&
          other.containAudio == this.containAudio &&
          other.containImage == this.containImage &&
          other.date == this.date);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> folderID;
  final Value<String> folderName;
  final Value<TextDirection> folderNameDirection;
  final Value<String> detail;
  final Value<TextDirection> detailDirection;
  final Value<bool> isDeleted;
  final Value<bool> containAudio;
  final Value<bool> containImage;
  final Value<DateTime> date;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.folderID = const Value.absent(),
    this.folderName = const Value.absent(),
    this.folderNameDirection = const Value.absent(),
    this.detail = const Value.absent(),
    this.detailDirection = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.containAudio = const Value.absent(),
    this.containImage = const Value.absent(),
    this.date = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.folderID = const Value.absent(),
    @required String folderName,
    @required TextDirection folderNameDirection,
    @required String detail,
    @required TextDirection detailDirection,
    this.isDeleted = const Value.absent(),
    this.containAudio = const Value.absent(),
    this.containImage = const Value.absent(),
    @required DateTime date,
  })  : folderName = Value(folderName),
        folderNameDirection = Value(folderNameDirection),
        detail = Value(detail),
        detailDirection = Value(detailDirection),
        date = Value(date);
  static Insertable<Note> custom({
    Expression<int> id,
    Expression<int> folderID,
    Expression<String> folderName,
    Expression<String> folderNameDirection,
    Expression<String> detail,
    Expression<String> detailDirection,
    Expression<bool> isDeleted,
    Expression<bool> containAudio,
    Expression<bool> containImage,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folderID != null) 'folder_i_d': folderID,
      if (folderName != null) 'folder_name': folderName,
      if (folderNameDirection != null)
        'folder_name_direction': folderNameDirection,
      if (detail != null) 'detail': detail,
      if (detailDirection != null) 'detail_direction': detailDirection,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (containAudio != null) 'contain_audio': containAudio,
      if (containImage != null) 'contain_image': containImage,
      if (date != null) 'date': date,
    });
  }

  NotesCompanion copyWith(
      {Value<int> id,
      Value<int> folderID,
      Value<String> folderName,
      Value<TextDirection> folderNameDirection,
      Value<String> detail,
      Value<TextDirection> detailDirection,
      Value<bool> isDeleted,
      Value<bool> containAudio,
      Value<bool> containImage,
      Value<DateTime> date}) {
    return NotesCompanion(
      id: id ?? this.id,
      folderID: folderID ?? this.folderID,
      folderName: folderName ?? this.folderName,
      folderNameDirection: folderNameDirection ?? this.folderNameDirection,
      detail: detail ?? this.detail,
      detailDirection: detailDirection ?? this.detailDirection,
      isDeleted: isDeleted ?? this.isDeleted,
      containAudio: containAudio ?? this.containAudio,
      containImage: containImage ?? this.containImage,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (folderID.present) {
      map['folder_i_d'] = Variable<int>(folderID.value);
    }
    if (folderName.present) {
      map['folder_name'] = Variable<String>(folderName.value);
    }
    if (folderNameDirection.present) {
      final converter = $NotesTable.$converter0;
      map['folder_name_direction'] =
          Variable<String>(converter.mapToSql(folderNameDirection.value));
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (detailDirection.present) {
      final converter = $NotesTable.$converter1;
      map['detail_direction'] =
          Variable<String>(converter.mapToSql(detailDirection.value));
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (containAudio.present) {
      map['contain_audio'] = Variable<bool>(containAudio.value);
    }
    if (containImage.present) {
      map['contain_image'] = Variable<bool>(containImage.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
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
    return GeneratedIntColumn('folder_i_d', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _folderNameMeta = const VerificationMeta('folderName');
  GeneratedTextColumn _folderName;
  @override
  GeneratedTextColumn get folderName => _folderName ??= _constructFolderName();
  GeneratedTextColumn _constructFolderName() {
    return GeneratedTextColumn(
      'folder_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _folderNameDirectionMeta =
      const VerificationMeta('folderNameDirection');
  GeneratedTextColumn _folderNameDirection;
  @override
  GeneratedTextColumn get folderNameDirection =>
      _folderNameDirection ??= _constructFolderNameDirection();
  GeneratedTextColumn _constructFolderNameDirection() {
    return GeneratedTextColumn(
      'folder_name_direction',
      $tableName,
      false,
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
      false,
    );
  }

  final VerificationMeta _detailDirectionMeta =
      const VerificationMeta('detailDirection');
  GeneratedTextColumn _detailDirection;
  @override
  GeneratedTextColumn get detailDirection =>
      _detailDirection ??= _constructDetailDirection();
  GeneratedTextColumn _constructDetailDirection() {
    return GeneratedTextColumn(
      'detail_direction',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isDeletedMeta = const VerificationMeta('isDeleted');
  GeneratedBoolColumn _isDeleted;
  @override
  GeneratedBoolColumn get isDeleted => _isDeleted ??= _constructIsDeleted();
  GeneratedBoolColumn _constructIsDeleted() {
    return GeneratedBoolColumn('is_deleted', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _containAudioMeta =
      const VerificationMeta('containAudio');
  GeneratedBoolColumn _containAudio;
  @override
  GeneratedBoolColumn get containAudio =>
      _containAudio ??= _constructContainAudio();
  GeneratedBoolColumn _constructContainAudio() {
    return GeneratedBoolColumn('contain_audio', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _containImageMeta =
      const VerificationMeta('containImage');
  GeneratedBoolColumn _containImage;
  @override
  GeneratedBoolColumn get containImage =>
      _containImage ??= _constructContainImage();
  GeneratedBoolColumn _constructContainImage() {
    return GeneratedBoolColumn('contain_image', $tableName, false,
        defaultValue: Constant(false));
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
  List<GeneratedColumn> get $columns => [
        id,
        folderID,
        folderName,
        folderNameDirection,
        detail,
        detailDirection,
        isDeleted,
        containAudio,
        containImage,
        date
      ];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('folder_i_d')) {
      context.handle(_folderIDMeta,
          folderID.isAcceptableOrUnknown(data['folder_i_d'], _folderIDMeta));
    }
    if (data.containsKey('folder_name')) {
      context.handle(
          _folderNameMeta,
          folderName.isAcceptableOrUnknown(
              data['folder_name'], _folderNameMeta));
    } else if (isInserting) {
      context.missing(_folderNameMeta);
    }
    context.handle(
        _folderNameDirectionMeta, const VerificationResult.success());
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail'], _detailMeta));
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    context.handle(_detailDirectionMeta, const VerificationResult.success());
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted'], _isDeletedMeta));
    }
    if (data.containsKey('contain_audio')) {
      context.handle(
          _containAudioMeta,
          containAudio.isAcceptableOrUnknown(
              data['contain_audio'], _containAudioMeta));
    }
    if (data.containsKey('contain_image')) {
      context.handle(
          _containImageMeta,
          containImage.isAcceptableOrUnknown(
              data['contain_image'], _containImageMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
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
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }

  static TypeConverter<TextDirection, String> $converter0 =
      const TextDirectionConverter();
  static TypeConverter<TextDirection, String> $converter1 =
      const TextDirectionConverter();
}

class FolderNoteData extends DataClass implements Insertable<FolderNoteData> {
  final int id;
  final String name;
  final TextDirection nameDirection;
  FolderNoteData(
      {@required this.id, @required this.name, @required this.nameDirection});
  factory FolderNoteData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return FolderNoteData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      nameDirection: $FolderNoteTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}name_direction'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || nameDirection != null) {
      final converter = $FolderNoteTable.$converter0;
      map['name_direction'] =
          Variable<String>(converter.mapToSql(nameDirection));
    }
    return map;
  }

  FolderNoteCompanion toCompanion(bool nullToAbsent) {
    return FolderNoteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      nameDirection: nameDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(nameDirection),
    );
  }

  factory FolderNoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FolderNoteData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameDirection: serializer.fromJson<TextDirection>(json['nameDirection']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameDirection': serializer.toJson<TextDirection>(nameDirection),
    };
  }

  FolderNoteData copyWith({int id, String name, TextDirection nameDirection}) =>
      FolderNoteData(
        id: id ?? this.id,
        name: name ?? this.name,
        nameDirection: nameDirection ?? this.nameDirection,
      );
  @override
  String toString() {
    return (StringBuffer('FolderNoteData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameDirection: $nameDirection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, nameDirection.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FolderNoteData &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameDirection == this.nameDirection);
}

class FolderNoteCompanion extends UpdateCompanion<FolderNoteData> {
  final Value<int> id;
  final Value<String> name;
  final Value<TextDirection> nameDirection;
  const FolderNoteCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameDirection = const Value.absent(),
  });
  FolderNoteCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required TextDirection nameDirection,
  })  : name = Value(name),
        nameDirection = Value(nameDirection);
  static Insertable<FolderNoteData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> nameDirection,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameDirection != null) 'name_direction': nameDirection,
    });
  }

  FolderNoteCompanion copyWith(
      {Value<int> id, Value<String> name, Value<TextDirection> nameDirection}) {
    return FolderNoteCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameDirection: nameDirection ?? this.nameDirection,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameDirection.present) {
      final converter = $FolderNoteTable.$converter0;
      map['name_direction'] =
          Variable<String>(converter.mapToSql(nameDirection.value));
    }
    return map;
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

  final VerificationMeta _nameDirectionMeta =
      const VerificationMeta('nameDirection');
  GeneratedTextColumn _nameDirection;
  @override
  GeneratedTextColumn get nameDirection =>
      _nameDirection ??= _constructNameDirection();
  GeneratedTextColumn _constructNameDirection() {
    return GeneratedTextColumn(
      'name_direction',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, nameDirection];
  @override
  $FolderNoteTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'folder_note';
  @override
  final String actualTableName = 'folder_note';
  @override
  VerificationContext validateIntegrity(Insertable<FolderNoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_nameDirectionMeta, const VerificationResult.success());
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
  $FolderNoteTable createAlias(String alias) {
    return $FolderNoteTable(_db, alias);
  }

  static TypeConverter<TextDirection, String> $converter0 =
      const TextDirectionConverter();
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || noteID != null) {
      map['note_i_d'] = Variable<int>(noteID);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  AudioNoteCompanion toCompanion(bool nullToAbsent) {
    return AudioNoteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      noteID:
          noteID == null && nullToAbsent ? const Value.absent() : Value(noteID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
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
  static Insertable<AudioNoteData> custom({
    Expression<int> id,
    Expression<int> noteID,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteID != null) 'note_i_d': noteID,
      if (name != null) 'name': name,
    });
  }

  AudioNoteCompanion copyWith(
      {Value<int> id, Value<int> noteID, Value<String> name}) {
    return AudioNoteCompanion(
      id: id ?? this.id,
      noteID: noteID ?? this.noteID,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteID.present) {
      map['note_i_d'] = Variable<int>(noteID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
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
  VerificationContext validateIntegrity(Insertable<AudioNoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('note_i_d')) {
      context.handle(_noteIDMeta,
          noteID.isAcceptableOrUnknown(data['note_i_d'], _noteIDMeta));
    } else if (isInserting) {
      context.missing(_noteIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || noteID != null) {
      map['note_i_d'] = Variable<int>(noteID);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  ImageNoteCompanion toCompanion(bool nullToAbsent) {
    return ImageNoteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      noteID:
          noteID == null && nullToAbsent ? const Value.absent() : Value(noteID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
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
  static Insertable<ImageNoteData> custom({
    Expression<int> id,
    Expression<int> noteID,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteID != null) 'note_i_d': noteID,
      if (name != null) 'name': name,
    });
  }

  ImageNoteCompanion copyWith(
      {Value<int> id, Value<int> noteID, Value<String> name}) {
    return ImageNoteCompanion(
      id: id ?? this.id,
      noteID: noteID ?? this.noteID,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteID.present) {
      map['note_i_d'] = Variable<int>(noteID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
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
  VerificationContext validateIntegrity(Insertable<ImageNoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('note_i_d')) {
      context.handle(_noteIDMeta,
          noteID.isAcceptableOrUnknown(data['note_i_d'], _noteIDMeta));
    } else if (isInserting) {
      context.missing(_noteIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
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
