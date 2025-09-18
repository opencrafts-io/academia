// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserProfileTable extends UserProfile
    with TableInfo<$UserProfileTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _termsAcceptedMeta = const VerificationMeta(
    'termsAccepted',
  );
  @override
  late final GeneratedColumn<bool> termsAccepted = GeneratedColumn<bool>(
    'terms_accepted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("terms_accepted" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _onboardedMeta = const VerificationMeta(
    'onboarded',
  );
  @override
  late final GeneratedColumn<bool> onboarded = GeneratedColumn<bool>(
    'onboarded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarded" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _nationalIDMeta = const VerificationMeta(
    'nationalID',
  );
  @override
  late final GeneratedColumn<String> nationalID = GeneratedColumn<String>(
    'national_i_d',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vibePointsMeta = const VerificationMeta(
    'vibePoints',
  );
  @override
  late final GeneratedColumn<int> vibePoints = GeneratedColumn<int>(
    'vibe_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    username,
    email,
    termsAccepted,
    onboarded,
    nationalID,
    avatarUrl,
    bio,
    phone,
    vibePoints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('terms_accepted')) {
      context.handle(
        _termsAcceptedMeta,
        termsAccepted.isAcceptableOrUnknown(
          data['terms_accepted']!,
          _termsAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('onboarded')) {
      context.handle(
        _onboardedMeta,
        onboarded.isAcceptableOrUnknown(data['onboarded']!, _onboardedMeta),
      );
    }
    if (data.containsKey('national_i_d')) {
      context.handle(
        _nationalIDMeta,
        nationalID.isAcceptableOrUnknown(
          data['national_i_d']!,
          _nationalIDMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('vibe_points')) {
      context.handle(
        _vibePointsMeta,
        vibePoints.isAcceptableOrUnknown(data['vibe_points']!, _vibePointsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      termsAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}terms_accepted'],
      )!,
      onboarded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarded'],
      )!,
      nationalID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_i_d'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      vibePoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vibe_points'],
      )!,
    );
  }

  @override
  $UserProfileTable createAlias(String alias) {
    return $UserProfileTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String? username;
  final String email;
  final bool termsAccepted;
  final bool onboarded;
  final String? nationalID;
  final String? avatarUrl;
  final String? bio;
  final String? phone;
  final int vibePoints;
  const UserProfileData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.username,
    required this.email,
    required this.termsAccepted,
    required this.onboarded,
    this.nationalID,
    this.avatarUrl,
    this.bio,
    this.phone,
    required this.vibePoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['email'] = Variable<String>(email);
    map['terms_accepted'] = Variable<bool>(termsAccepted);
    map['onboarded'] = Variable<bool>(onboarded);
    if (!nullToAbsent || nationalID != null) {
      map['national_i_d'] = Variable<String>(nationalID);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['vibe_points'] = Variable<int>(vibePoints);
    return map;
  }

  UserProfileCompanion toCompanion(bool nullToAbsent) {
    return UserProfileCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      email: Value(email),
      termsAccepted: Value(termsAccepted),
      onboarded: Value(onboarded),
      nationalID: nationalID == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalID),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      vibePoints: Value(vibePoints),
    );
  }

  factory UserProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      name: serializer.fromJson<String>(json['name']),
      username: serializer.fromJson<String?>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      termsAccepted: serializer.fromJson<bool>(json['terms_accepted']),
      onboarded: serializer.fromJson<bool>(json['onboarded']),
      nationalID: serializer.fromJson<String?>(json['national_id']),
      avatarUrl: serializer.fromJson<String?>(json['avatar_url']),
      bio: serializer.fromJson<String?>(json['bio']),
      phone: serializer.fromJson<String?>(json['phone']),
      vibePoints: serializer.fromJson<int>(json['vibe_points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'username': serializer.toJson<String?>(username),
      'email': serializer.toJson<String>(email),
      'terms_accepted': serializer.toJson<bool>(termsAccepted),
      'onboarded': serializer.toJson<bool>(onboarded),
      'national_id': serializer.toJson<String?>(nationalID),
      'avatar_url': serializer.toJson<String?>(avatarUrl),
      'bio': serializer.toJson<String?>(bio),
      'phone': serializer.toJson<String?>(phone),
      'vibe_points': serializer.toJson<int>(vibePoints),
    };
  }

  UserProfileData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    Value<String?> username = const Value.absent(),
    String? email,
    bool? termsAccepted,
    bool? onboarded,
    Value<String?> nationalID = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    int? vibePoints,
  }) => UserProfileData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    username: username.present ? username.value : this.username,
    email: email ?? this.email,
    termsAccepted: termsAccepted ?? this.termsAccepted,
    onboarded: onboarded ?? this.onboarded,
    nationalID: nationalID.present ? nationalID.value : this.nationalID,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    bio: bio.present ? bio.value : this.bio,
    phone: phone.present ? phone.value : this.phone,
    vibePoints: vibePoints ?? this.vibePoints,
  );
  UserProfileData copyWithCompanion(UserProfileCompanion data) {
    return UserProfileData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      termsAccepted: data.termsAccepted.present
          ? data.termsAccepted.value
          : this.termsAccepted,
      onboarded: data.onboarded.present ? data.onboarded.value : this.onboarded,
      nationalID: data.nationalID.present
          ? data.nationalID.value
          : this.nationalID,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      bio: data.bio.present ? data.bio.value : this.bio,
      phone: data.phone.present ? data.phone.value : this.phone,
      vibePoints: data.vibePoints.present
          ? data.vibePoints.value
          : this.vibePoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('termsAccepted: $termsAccepted, ')
          ..write('onboarded: $onboarded, ')
          ..write('nationalID: $nationalID, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bio: $bio, ')
          ..write('phone: $phone, ')
          ..write('vibePoints: $vibePoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    username,
    email,
    termsAccepted,
    onboarded,
    nationalID,
    avatarUrl,
    bio,
    phone,
    vibePoints,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.username == this.username &&
          other.email == this.email &&
          other.termsAccepted == this.termsAccepted &&
          other.onboarded == this.onboarded &&
          other.nationalID == this.nationalID &&
          other.avatarUrl == this.avatarUrl &&
          other.bio == this.bio &&
          other.phone == this.phone &&
          other.vibePoints == this.vibePoints);
}

class UserProfileCompanion extends UpdateCompanion<UserProfileData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String?> username;
  final Value<String> email;
  final Value<bool> termsAccepted;
  final Value<bool> onboarded;
  final Value<String?> nationalID;
  final Value<String?> avatarUrl;
  final Value<String?> bio;
  final Value<String?> phone;
  final Value<int> vibePoints;
  final Value<int> rowid;
  const UserProfileCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.termsAccepted = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.nationalID = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.phone = const Value.absent(),
    this.vibePoints = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfileCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    this.username = const Value.absent(),
    required String email,
    this.termsAccepted = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.nationalID = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.phone = const Value.absent(),
    this.vibePoints = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       email = Value(email);
  static Insertable<UserProfileData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? email,
    Expression<bool>? termsAccepted,
    Expression<bool>? onboarded,
    Expression<String>? nationalID,
    Expression<String>? avatarUrl,
    Expression<String>? bio,
    Expression<String>? phone,
    Expression<int>? vibePoints,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (termsAccepted != null) 'terms_accepted': termsAccepted,
      if (onboarded != null) 'onboarded': onboarded,
      if (nationalID != null) 'national_i_d': nationalID,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bio != null) 'bio': bio,
      if (phone != null) 'phone': phone,
      if (vibePoints != null) 'vibe_points': vibePoints,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfileCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String?>? username,
    Value<String>? email,
    Value<bool>? termsAccepted,
    Value<bool>? onboarded,
    Value<String?>? nationalID,
    Value<String?>? avatarUrl,
    Value<String?>? bio,
    Value<String?>? phone,
    Value<int>? vibePoints,
    Value<int>? rowid,
  }) {
    return UserProfileCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      onboarded: onboarded ?? this.onboarded,
      nationalID: nationalID ?? this.nationalID,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      vibePoints: vibePoints ?? this.vibePoints,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (termsAccepted.present) {
      map['terms_accepted'] = Variable<bool>(termsAccepted.value);
    }
    if (onboarded.present) {
      map['onboarded'] = Variable<bool>(onboarded.value);
    }
    if (nationalID.present) {
      map['national_i_d'] = Variable<String>(nationalID.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (vibePoints.present) {
      map['vibe_points'] = Variable<int>(vibePoints.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('termsAccepted: $termsAccepted, ')
          ..write('onboarded: $onboarded, ')
          ..write('nationalID: $nationalID, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bio: $bio, ')
          ..write('phone: $phone, ')
          ..write('vibePoints: $vibePoints, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TokenTable extends Token with TableInfo<$TokenTable, TokenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TokenTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accessTokenMeta = const VerificationMeta(
    'accessToken',
  );
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
    'access_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refreshTokenMeta = const VerificationMeta(
    'refreshToken',
  );
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
    'refresh_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accessToken,
    refreshToken,
    provider,
    expiresAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'token';
  @override
  VerificationContext validateIntegrity(
    Insertable<TokenData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('access_token')) {
      context.handle(
        _accessTokenMeta,
        accessToken.isAcceptableOrUnknown(
          data['access_token']!,
          _accessTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accessTokenMeta);
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
        _refreshTokenMeta,
        refreshToken.isAcceptableOrUnknown(
          data['refresh_token']!,
          _refreshTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_refreshTokenMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TokenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TokenData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accessToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}access_token'],
      )!,
      refreshToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refresh_token'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TokenTable createAlias(String alias) {
    return $TokenTable(attachedDatabase, alias);
  }
}

class TokenData extends DataClass implements Insertable<TokenData> {
  final int id;
  final String accessToken;
  final String refreshToken;
  final String provider;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TokenData({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.provider,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['access_token'] = Variable<String>(accessToken);
    map['refresh_token'] = Variable<String>(refreshToken);
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TokenCompanion toCompanion(bool nullToAbsent) {
    return TokenCompanion(
      id: Value(id),
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
      provider: Value(provider),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TokenData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TokenData(
      id: serializer.fromJson<int>(json['id']),
      accessToken: serializer.fromJson<String>(json['access_token']),
      refreshToken: serializer.fromJson<String>(json['refresh_token']),
      provider: serializer.fromJson<String>(json['provider']),
      expiresAt: serializer.fromJson<DateTime?>(json['expires_at']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'access_token': serializer.toJson<String>(accessToken),
      'refresh_token': serializer.toJson<String>(refreshToken),
      'provider': serializer.toJson<String>(provider),
      'expires_at': serializer.toJson<DateTime?>(expiresAt),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TokenData copyWith({
    int? id,
    String? accessToken,
    String? refreshToken,
    String? provider,
    Value<DateTime?> expiresAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TokenData(
    id: id ?? this.id,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    provider: provider ?? this.provider,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TokenData copyWithCompanion(TokenCompanion data) {
    return TokenData(
      id: data.id.present ? data.id.value : this.id,
      accessToken: data.accessToken.present
          ? data.accessToken.value
          : this.accessToken,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      provider: data.provider.present ? data.provider.value : this.provider,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TokenData(')
          ..write('id: $id, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('provider: $provider, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accessToken,
    refreshToken,
    provider,
    expiresAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TokenData &&
          other.id == this.id &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.provider == this.provider &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TokenCompanion extends UpdateCompanion<TokenData> {
  final Value<int> id;
  final Value<String> accessToken;
  final Value<String> refreshToken;
  final Value<String> provider;
  final Value<DateTime?> expiresAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TokenCompanion({
    this.id = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.provider = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TokenCompanion.insert({
    this.id = const Value.absent(),
    required String accessToken,
    required String refreshToken,
    required String provider,
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : accessToken = Value(accessToken),
       refreshToken = Value(refreshToken),
       provider = Value(provider);
  static Insertable<TokenData> custom({
    Expression<int>? id,
    Expression<String>? accessToken,
    Expression<String>? refreshToken,
    Expression<String>? provider,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (provider != null) 'provider': provider,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TokenCompanion copyWith({
    Value<int>? id,
    Value<String>? accessToken,
    Value<String>? refreshToken,
    Value<String>? provider,
    Value<DateTime?>? expiresAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TokenCompanion(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      provider: provider ?? this.provider,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokenCompanion(')
          ..write('id: $id, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('provider: $provider, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChirpUserTableTable extends ChirpUserTable
    with TableInfo<$ChirpUserTableTable, ChirpUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChirpUserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vibepointsMeta = const VerificationMeta(
    'vibepoints',
  );
  @override
  late final GeneratedColumn<int> vibepoints = GeneratedColumn<int>(
    'vibepoints',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    email,
    vibepoints,
    avatarUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chirp_user_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChirpUserData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('vibepoints')) {
      context.handle(
        _vibepointsMeta,
        vibepoints.isAcceptableOrUnknown(data['vibepoints']!, _vibepointsMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChirpUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChirpUserData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      vibepoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vibepoints'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
    );
  }

  @override
  $ChirpUserTableTable createAlias(String alias) {
    return $ChirpUserTableTable(attachedDatabase, alias);
  }
}

class ChirpUserData extends DataClass implements Insertable<ChirpUserData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String email;
  final int vibepoints;
  final String? avatarUrl;
  const ChirpUserData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.email,
    required this.vibepoints,
    this.avatarUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['vibepoints'] = Variable<int>(vibepoints);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    return map;
  }

  ChirpUserTableCompanion toCompanion(bool nullToAbsent) {
    return ChirpUserTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      email: Value(email),
      vibepoints: Value(vibepoints),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
    );
  }

  factory ChirpUserData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChirpUserData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      vibepoints: serializer.fromJson<int>(json['vibepoints']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'vibepoints': serializer.toJson<int>(vibepoints),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
    };
  }

  ChirpUserData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? email,
    int? vibepoints,
    Value<String?> avatarUrl = const Value.absent(),
  }) => ChirpUserData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    email: email ?? this.email,
    vibepoints: vibepoints ?? this.vibepoints,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
  );
  ChirpUserData copyWithCompanion(ChirpUserTableCompanion data) {
    return ChirpUserData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      vibepoints: data.vibepoints.present
          ? data.vibepoints.value
          : this.vibepoints,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChirpUserData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('vibepoints: $vibepoints, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, name, email, vibepoints, avatarUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChirpUserData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.email == this.email &&
          other.vibepoints == this.vibepoints &&
          other.avatarUrl == this.avatarUrl);
}

class ChirpUserTableCompanion extends UpdateCompanion<ChirpUserData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String> email;
  final Value<int> vibepoints;
  final Value<String?> avatarUrl;
  final Value<int> rowid;
  const ChirpUserTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.vibepoints = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChirpUserTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required String email,
    this.vibepoints = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       email = Value(email);
  static Insertable<ChirpUserData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? email,
    Expression<int>? vibepoints,
    Expression<String>? avatarUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (vibepoints != null) 'vibepoints': vibepoints,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChirpUserTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String>? email,
    Value<int>? vibepoints,
    Value<String?>? avatarUrl,
    Value<int>? rowid,
  }) {
    return ChirpUserTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      email: email ?? this.email,
      vibepoints: vibepoints ?? this.vibepoints,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (vibepoints.present) {
      map['vibepoints'] = Variable<int>(vibepoints.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChirpUserTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('vibepoints: $vibepoints, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageTableTable extends MessageTable
    with TableInfo<$MessageTableTable, MessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chirp_user_table (id)',
    ),
  );
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chirp_user_table (id)',
    ),
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    content,
    senderId,
    recipientId,
    sentAt,
    isRead,
    imageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recipientIdMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_sentAtMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
    );
  }

  @override
  $MessageTableTable createAlias(String alias) {
    return $MessageTableTable(attachedDatabase, alias);
  }
}

class MessageData extends DataClass implements Insertable<MessageData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final String senderId;
  final String recipientId;
  final DateTime sentAt;
  final bool isRead;
  final String? imageUrl;
  const MessageData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    required this.senderId,
    required this.recipientId,
    required this.sentAt,
    required this.isRead,
    this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['content'] = Variable<String>(content);
    map['sender_id'] = Variable<String>(senderId);
    map['recipient_id'] = Variable<String>(recipientId);
    map['sent_at'] = Variable<DateTime>(sentAt);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    return map;
  }

  MessageTableCompanion toCompanion(bool nullToAbsent) {
    return MessageTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      content: Value(content),
      senderId: Value(senderId),
      recipientId: Value(recipientId),
      sentAt: Value(sentAt),
      isRead: Value(isRead),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
    );
  }

  factory MessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      content: serializer.fromJson<String>(json['content']),
      senderId: serializer.fromJson<String>(json['senderId']),
      recipientId: serializer.fromJson<String>(json['recipientId']),
      sentAt: serializer.fromJson<DateTime>(json['sentAt']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'content': serializer.toJson<String>(content),
      'senderId': serializer.toJson<String>(senderId),
      'recipientId': serializer.toJson<String>(recipientId),
      'sentAt': serializer.toJson<DateTime>(sentAt),
      'isRead': serializer.toJson<bool>(isRead),
      'imageUrl': serializer.toJson<String?>(imageUrl),
    };
  }

  MessageData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? content,
    String? senderId,
    String? recipientId,
    DateTime? sentAt,
    bool? isRead,
    Value<String?> imageUrl = const Value.absent(),
  }) => MessageData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    content: content ?? this.content,
    senderId: senderId ?? this.senderId,
    recipientId: recipientId ?? this.recipientId,
    sentAt: sentAt ?? this.sentAt,
    isRead: isRead ?? this.isRead,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
  );
  MessageData copyWithCompanion(MessageTableCompanion data) {
    return MessageData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      content: data.content.present ? data.content.value : this.content,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('content: $content, ')
          ..write('senderId: $senderId, ')
          ..write('recipientId: $recipientId, ')
          ..write('sentAt: $sentAt, ')
          ..write('isRead: $isRead, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    content,
    senderId,
    recipientId,
    sentAt,
    isRead,
    imageUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.content == this.content &&
          other.senderId == this.senderId &&
          other.recipientId == this.recipientId &&
          other.sentAt == this.sentAt &&
          other.isRead == this.isRead &&
          other.imageUrl == this.imageUrl);
}

class MessageTableCompanion extends UpdateCompanion<MessageData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> content;
  final Value<String> senderId;
  final Value<String> recipientId;
  final Value<DateTime> sentAt;
  final Value<bool> isRead;
  final Value<String?> imageUrl;
  final Value<int> rowid;
  const MessageTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.content = const Value.absent(),
    this.senderId = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.isRead = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String content,
    required String senderId,
    required String recipientId,
    required DateTime sentAt,
    this.isRead = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       content = Value(content),
       senderId = Value(senderId),
       recipientId = Value(recipientId),
       sentAt = Value(sentAt);
  static Insertable<MessageData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? content,
    Expression<String>? senderId,
    Expression<String>? recipientId,
    Expression<DateTime>? sentAt,
    Expression<bool>? isRead,
    Expression<String>? imageUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (content != null) 'content': content,
      if (senderId != null) 'sender_id': senderId,
      if (recipientId != null) 'recipient_id': recipientId,
      if (sentAt != null) 'sent_at': sentAt,
      if (isRead != null) 'is_read': isRead,
      if (imageUrl != null) 'image_url': imageUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? content,
    Value<String>? senderId,
    Value<String>? recipientId,
    Value<DateTime>? sentAt,
    Value<bool>? isRead,
    Value<String?>? imageUrl,
    Value<int>? rowid,
  }) {
    return MessageTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('content: $content, ')
          ..write('senderId: $senderId, ')
          ..write('recipientId: $recipientId, ')
          ..write('sentAt: $sentAt, ')
          ..write('isRead: $isRead, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationTableTable extends ConversationTable
    with TableInfo<$ConversationTableTable, ConversationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chirp_user_table (id)',
    ),
  );
  static const VerificationMeta _lastMessageIdMeta = const VerificationMeta(
    'lastMessageId',
  );
  @override
  late final GeneratedColumn<String> lastMessageId = GeneratedColumn<String>(
    'last_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES message_table (id)',
    ),
  );
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    userId,
    lastMessageId,
    lastMessageAt,
    unreadCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConversationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('last_message_id')) {
      context.handle(
        _lastMessageIdMeta,
        lastMessageId.isAcceptableOrUnknown(
          data['last_message_id']!,
          _lastMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConversationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      lastMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_id'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
    );
  }

  @override
  $ConversationTableTable createAlias(String alias) {
    return $ConversationTableTable(attachedDatabase, alias);
  }
}

class ConversationData extends DataClass
    implements Insertable<ConversationData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final String? lastMessageId;
  final DateTime? lastMessageAt;
  final int unreadCount;
  const ConversationData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.lastMessageId,
    this.lastMessageAt,
    required this.unreadCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || lastMessageId != null) {
      map['last_message_id'] = Variable<String>(lastMessageId);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    return map;
  }

  ConversationTableCompanion toCompanion(bool nullToAbsent) {
    return ConversationTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userId: Value(userId),
      lastMessageId: lastMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageId),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCount: Value(unreadCount),
    );
  }

  factory ConversationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      userId: serializer.fromJson<String>(json['userId']),
      lastMessageId: serializer.fromJson<String?>(json['lastMessageId']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'userId': serializer.toJson<String>(userId),
      'lastMessageId': serializer.toJson<String?>(lastMessageId),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCount': serializer.toJson<int>(unreadCount),
    };
  }

  ConversationData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    Value<String?> lastMessageId = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    int? unreadCount,
  }) => ConversationData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userId: userId ?? this.userId,
    lastMessageId: lastMessageId.present
        ? lastMessageId.value
        : this.lastMessageId,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
  );
  ConversationData copyWithCompanion(ConversationTableCompanion data) {
    return ConversationData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      lastMessageId: data.lastMessageId.present
          ? data.lastMessageId.value
          : this.lastMessageId,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    userId,
    lastMessageId,
    lastMessageAt,
    unreadCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId &&
          other.lastMessageId == this.lastMessageId &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCount == this.unreadCount);
}

class ConversationTableCompanion extends UpdateCompanion<ConversationData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> userId;
  final Value<String?> lastMessageId;
  final Value<DateTime?> lastMessageAt;
  final Value<int> unreadCount;
  final Value<int> rowid;
  const ConversationTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String userId,
    this.lastMessageId = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId);
  static Insertable<ConversationData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<String>? lastMessageId,
    Expression<DateTime>? lastMessageAt,
    Expression<int>? unreadCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (lastMessageId != null) 'last_message_id': lastMessageId,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? userId,
    Value<String?>? lastMessageId,
    Value<DateTime?>? lastMessageAt,
    Value<int>? unreadCount,
    Value<int>? rowid,
  }) {
    return ConversationTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (lastMessageId.present) {
      map['last_message_id'] = Variable<String>(lastMessageId.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupTableTable extends GroupTable
    with TableInfo<$GroupTableTable, GroupEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creatorIdMeta = const VerificationMeta(
    'creatorId',
  );
  @override
  late final GeneratedColumn<String> creatorId = GeneratedColumn<String>(
    'creator_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creatorNameMeta = const VerificationMeta(
    'creatorName',
  );
  @override
  late final GeneratedColumn<String> creatorName = GeneratedColumn<String>(
    'creator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminsMeta = const VerificationMeta('admins');
  @override
  late final GeneratedColumn<String> admins = GeneratedColumn<String>(
    'admins',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminNamesMeta = const VerificationMeta(
    'adminNames',
  );
  @override
  late final GeneratedColumn<String> adminNames = GeneratedColumn<String>(
    'admin_names',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moderatorsMeta = const VerificationMeta(
    'moderators',
  );
  @override
  late final GeneratedColumn<String> moderators = GeneratedColumn<String>(
    'moderators',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moderatorNamesMeta = const VerificationMeta(
    'moderatorNames',
  );
  @override
  late final GeneratedColumn<String> moderatorNames = GeneratedColumn<String>(
    'moderator_names',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _membersMeta = const VerificationMeta(
    'members',
  );
  @override
  late final GeneratedColumn<String> members = GeneratedColumn<String>(
    'members',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberNamesMeta = const VerificationMeta(
    'memberNames',
  );
  @override
  late final GeneratedColumn<String> memberNames = GeneratedColumn<String>(
    'member_names',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bannedUsersMeta = const VerificationMeta(
    'bannedUsers',
  );
  @override
  late final GeneratedColumn<String> bannedUsers = GeneratedColumn<String>(
    'banned_users',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bannedUserNamesMeta = const VerificationMeta(
    'bannedUserNames',
  );
  @override
  late final GeneratedColumn<String> bannedUserNames = GeneratedColumn<String>(
    'banned_user_names',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
  );
  static const VerificationMeta _rulesMeta = const VerificationMeta('rules');
  @override
  late final GeneratedColumn<String> rules = GeneratedColumn<String>(
    'rules',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<String> logo = GeneratedColumn<String>(
    'logo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bannerMeta = const VerificationMeta('banner');
  @override
  late final GeneratedColumn<String> banner = GeneratedColumn<String>(
    'banner',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bannerUrlMeta = const VerificationMeta(
    'bannerUrl',
  );
  @override
  late final GeneratedColumn<String> bannerUrl = GeneratedColumn<String>(
    'banner_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userRoleMeta = const VerificationMeta(
    'userRole',
  );
  @override
  late final GeneratedColumn<String> userRole = GeneratedColumn<String>(
    'user_role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canPostMeta = const VerificationMeta(
    'canPost',
  );
  @override
  late final GeneratedColumn<bool> canPost = GeneratedColumn<bool>(
    'can_post',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_post" IN (0, 1))',
    ),
  );
  static const VerificationMeta _canModerateMeta = const VerificationMeta(
    'canModerate',
  );
  @override
  late final GeneratedColumn<bool> canModerate = GeneratedColumn<bool>(
    'can_moderate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_moderate" IN (0, 1))',
    ),
  );
  static const VerificationMeta _canAdminMeta = const VerificationMeta(
    'canAdmin',
  );
  @override
  late final GeneratedColumn<bool> canAdmin = GeneratedColumn<bool>(
    'can_admin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_admin" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    description,
    creatorId,
    creatorName,
    admins,
    adminNames,
    moderators,
    moderatorNames,
    members,
    memberNames,
    bannedUsers,
    bannedUserNames,
    isPrivate,
    rules,
    logo,
    banner,
    logoUrl,
    bannerUrl,
    userRole,
    canPost,
    canModerate,
    canAdmin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('creator_id')) {
      context.handle(
        _creatorIdMeta,
        creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creatorIdMeta);
    }
    if (data.containsKey('creator_name')) {
      context.handle(
        _creatorNameMeta,
        creatorName.isAcceptableOrUnknown(
          data['creator_name']!,
          _creatorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creatorNameMeta);
    }
    if (data.containsKey('admins')) {
      context.handle(
        _adminsMeta,
        admins.isAcceptableOrUnknown(data['admins']!, _adminsMeta),
      );
    } else if (isInserting) {
      context.missing(_adminsMeta);
    }
    if (data.containsKey('admin_names')) {
      context.handle(
        _adminNamesMeta,
        adminNames.isAcceptableOrUnknown(data['admin_names']!, _adminNamesMeta),
      );
    } else if (isInserting) {
      context.missing(_adminNamesMeta);
    }
    if (data.containsKey('moderators')) {
      context.handle(
        _moderatorsMeta,
        moderators.isAcceptableOrUnknown(data['moderators']!, _moderatorsMeta),
      );
    } else if (isInserting) {
      context.missing(_moderatorsMeta);
    }
    if (data.containsKey('moderator_names')) {
      context.handle(
        _moderatorNamesMeta,
        moderatorNames.isAcceptableOrUnknown(
          data['moderator_names']!,
          _moderatorNamesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_moderatorNamesMeta);
    }
    if (data.containsKey('members')) {
      context.handle(
        _membersMeta,
        members.isAcceptableOrUnknown(data['members']!, _membersMeta),
      );
    } else if (isInserting) {
      context.missing(_membersMeta);
    }
    if (data.containsKey('member_names')) {
      context.handle(
        _memberNamesMeta,
        memberNames.isAcceptableOrUnknown(
          data['member_names']!,
          _memberNamesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_memberNamesMeta);
    }
    if (data.containsKey('banned_users')) {
      context.handle(
        _bannedUsersMeta,
        bannedUsers.isAcceptableOrUnknown(
          data['banned_users']!,
          _bannedUsersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bannedUsersMeta);
    }
    if (data.containsKey('banned_user_names')) {
      context.handle(
        _bannedUserNamesMeta,
        bannedUserNames.isAcceptableOrUnknown(
          data['banned_user_names']!,
          _bannedUserNamesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bannedUserNamesMeta);
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    } else if (isInserting) {
      context.missing(_isPrivateMeta);
    }
    if (data.containsKey('rules')) {
      context.handle(
        _rulesMeta,
        rules.isAcceptableOrUnknown(data['rules']!, _rulesMeta),
      );
    } else if (isInserting) {
      context.missing(_rulesMeta);
    }
    if (data.containsKey('logo')) {
      context.handle(
        _logoMeta,
        logo.isAcceptableOrUnknown(data['logo']!, _logoMeta),
      );
    }
    if (data.containsKey('banner')) {
      context.handle(
        _bannerMeta,
        banner.isAcceptableOrUnknown(data['banner']!, _bannerMeta),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('banner_url')) {
      context.handle(
        _bannerUrlMeta,
        bannerUrl.isAcceptableOrUnknown(data['banner_url']!, _bannerUrlMeta),
      );
    }
    if (data.containsKey('user_role')) {
      context.handle(
        _userRoleMeta,
        userRole.isAcceptableOrUnknown(data['user_role']!, _userRoleMeta),
      );
    }
    if (data.containsKey('can_post')) {
      context.handle(
        _canPostMeta,
        canPost.isAcceptableOrUnknown(data['can_post']!, _canPostMeta),
      );
    } else if (isInserting) {
      context.missing(_canPostMeta);
    }
    if (data.containsKey('can_moderate')) {
      context.handle(
        _canModerateMeta,
        canModerate.isAcceptableOrUnknown(
          data['can_moderate']!,
          _canModerateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canModerateMeta);
    }
    if (data.containsKey('can_admin')) {
      context.handle(
        _canAdminMeta,
        canAdmin.isAcceptableOrUnknown(data['can_admin']!, _canAdminMeta),
      );
    } else if (isInserting) {
      context.missing(_canAdminMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      creatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creator_id'],
      )!,
      creatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creator_name'],
      )!,
      admins: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admins'],
      )!,
      adminNames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admin_names'],
      )!,
      moderators: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moderators'],
      )!,
      moderatorNames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moderator_names'],
      )!,
      members: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}members'],
      )!,
      memberNames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_names'],
      )!,
      bannedUsers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banned_users'],
      )!,
      bannedUserNames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banned_user_names'],
      )!,
      isPrivate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_private'],
      )!,
      rules: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rules'],
      )!,
      logo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo'],
      ),
      banner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner'],
      ),
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      bannerUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner_url'],
      ),
      userRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_role'],
      ),
      canPost: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_post'],
      )!,
      canModerate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_moderate'],
      )!,
      canAdmin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_admin'],
      )!,
    );
  }

  @override
  $GroupTableTable createAlias(String alias) {
    return $GroupTableTable(attachedDatabase, alias);
  }
}

class GroupEntity extends DataClass implements Insertable<GroupEntity> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final String creatorId;
  final String creatorName;
  final String admins;
  final String adminNames;
  final String moderators;
  final String moderatorNames;
  final String members;
  final String memberNames;
  final String bannedUsers;
  final String bannedUserNames;
  final bool isPrivate;
  final String rules;
  final String? logo;
  final String? banner;
  final String? logoUrl;
  final String? bannerUrl;
  final String? userRole;
  final bool canPost;
  final bool canModerate;
  final bool canAdmin;
  const GroupEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.creatorId,
    required this.creatorName,
    required this.admins,
    required this.adminNames,
    required this.moderators,
    required this.moderatorNames,
    required this.members,
    required this.memberNames,
    required this.bannedUsers,
    required this.bannedUserNames,
    required this.isPrivate,
    required this.rules,
    this.logo,
    this.banner,
    this.logoUrl,
    this.bannerUrl,
    this.userRole,
    required this.canPost,
    required this.canModerate,
    required this.canAdmin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['creator_id'] = Variable<String>(creatorId);
    map['creator_name'] = Variable<String>(creatorName);
    map['admins'] = Variable<String>(admins);
    map['admin_names'] = Variable<String>(adminNames);
    map['moderators'] = Variable<String>(moderators);
    map['moderator_names'] = Variable<String>(moderatorNames);
    map['members'] = Variable<String>(members);
    map['member_names'] = Variable<String>(memberNames);
    map['banned_users'] = Variable<String>(bannedUsers);
    map['banned_user_names'] = Variable<String>(bannedUserNames);
    map['is_private'] = Variable<bool>(isPrivate);
    map['rules'] = Variable<String>(rules);
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String>(logo);
    }
    if (!nullToAbsent || banner != null) {
      map['banner'] = Variable<String>(banner);
    }
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || bannerUrl != null) {
      map['banner_url'] = Variable<String>(bannerUrl);
    }
    if (!nullToAbsent || userRole != null) {
      map['user_role'] = Variable<String>(userRole);
    }
    map['can_post'] = Variable<bool>(canPost);
    map['can_moderate'] = Variable<bool>(canModerate);
    map['can_admin'] = Variable<bool>(canAdmin);
    return map;
  }

  GroupTableCompanion toCompanion(bool nullToAbsent) {
    return GroupTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      description: Value(description),
      creatorId: Value(creatorId),
      creatorName: Value(creatorName),
      admins: Value(admins),
      adminNames: Value(adminNames),
      moderators: Value(moderators),
      moderatorNames: Value(moderatorNames),
      members: Value(members),
      memberNames: Value(memberNames),
      bannedUsers: Value(bannedUsers),
      bannedUserNames: Value(bannedUserNames),
      isPrivate: Value(isPrivate),
      rules: Value(rules),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
      banner: banner == null && nullToAbsent
          ? const Value.absent()
          : Value(banner),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      bannerUrl: bannerUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(bannerUrl),
      userRole: userRole == null && nullToAbsent
          ? const Value.absent()
          : Value(userRole),
      canPost: Value(canPost),
      canModerate: Value(canModerate),
      canAdmin: Value(canAdmin),
    );
  }

  factory GroupEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupEntity(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      creatorId: serializer.fromJson<String>(json['creator_id']),
      creatorName: serializer.fromJson<String>(json['creator_name']),
      admins: serializer.fromJson<String>(json['admins']),
      adminNames: serializer.fromJson<String>(json['admin_names']),
      moderators: serializer.fromJson<String>(json['moderators']),
      moderatorNames: serializer.fromJson<String>(json['moderator_names']),
      members: serializer.fromJson<String>(json['members']),
      memberNames: serializer.fromJson<String>(json['member_names']),
      bannedUsers: serializer.fromJson<String>(json['banned_users']),
      bannedUserNames: serializer.fromJson<String>(json['banned_user_names']),
      isPrivate: serializer.fromJson<bool>(json['is_private']),
      rules: serializer.fromJson<String>(json['rules']),
      logo: serializer.fromJson<String?>(json['logo']),
      banner: serializer.fromJson<String?>(json['banner']),
      logoUrl: serializer.fromJson<String?>(json['logo_url']),
      bannerUrl: serializer.fromJson<String?>(json['banner_url']),
      userRole: serializer.fromJson<String?>(json['user_role']),
      canPost: serializer.fromJson<bool>(json['can_post']),
      canModerate: serializer.fromJson<bool>(json['can_moderate']),
      canAdmin: serializer.fromJson<bool>(json['can_admin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'creator_id': serializer.toJson<String>(creatorId),
      'creator_name': serializer.toJson<String>(creatorName),
      'admins': serializer.toJson<String>(admins),
      'admin_names': serializer.toJson<String>(adminNames),
      'moderators': serializer.toJson<String>(moderators),
      'moderator_names': serializer.toJson<String>(moderatorNames),
      'members': serializer.toJson<String>(members),
      'member_names': serializer.toJson<String>(memberNames),
      'banned_users': serializer.toJson<String>(bannedUsers),
      'banned_user_names': serializer.toJson<String>(bannedUserNames),
      'is_private': serializer.toJson<bool>(isPrivate),
      'rules': serializer.toJson<String>(rules),
      'logo': serializer.toJson<String?>(logo),
      'banner': serializer.toJson<String?>(banner),
      'logo_url': serializer.toJson<String?>(logoUrl),
      'banner_url': serializer.toJson<String?>(bannerUrl),
      'user_role': serializer.toJson<String?>(userRole),
      'can_post': serializer.toJson<bool>(canPost),
      'can_moderate': serializer.toJson<bool>(canModerate),
      'can_admin': serializer.toJson<bool>(canAdmin),
    };
  }

  GroupEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? description,
    String? creatorId,
    String? creatorName,
    String? admins,
    String? adminNames,
    String? moderators,
    String? moderatorNames,
    String? members,
    String? memberNames,
    String? bannedUsers,
    String? bannedUserNames,
    bool? isPrivate,
    String? rules,
    Value<String?> logo = const Value.absent(),
    Value<String?> banner = const Value.absent(),
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> bannerUrl = const Value.absent(),
    Value<String?> userRole = const Value.absent(),
    bool? canPost,
    bool? canModerate,
    bool? canAdmin,
  }) => GroupEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    description: description ?? this.description,
    creatorId: creatorId ?? this.creatorId,
    creatorName: creatorName ?? this.creatorName,
    admins: admins ?? this.admins,
    adminNames: adminNames ?? this.adminNames,
    moderators: moderators ?? this.moderators,
    moderatorNames: moderatorNames ?? this.moderatorNames,
    members: members ?? this.members,
    memberNames: memberNames ?? this.memberNames,
    bannedUsers: bannedUsers ?? this.bannedUsers,
    bannedUserNames: bannedUserNames ?? this.bannedUserNames,
    isPrivate: isPrivate ?? this.isPrivate,
    rules: rules ?? this.rules,
    logo: logo.present ? logo.value : this.logo,
    banner: banner.present ? banner.value : this.banner,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    bannerUrl: bannerUrl.present ? bannerUrl.value : this.bannerUrl,
    userRole: userRole.present ? userRole.value : this.userRole,
    canPost: canPost ?? this.canPost,
    canModerate: canModerate ?? this.canModerate,
    canAdmin: canAdmin ?? this.canAdmin,
  );
  GroupEntity copyWithCompanion(GroupTableCompanion data) {
    return GroupEntity(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      creatorId: data.creatorId.present ? data.creatorId.value : this.creatorId,
      creatorName: data.creatorName.present
          ? data.creatorName.value
          : this.creatorName,
      admins: data.admins.present ? data.admins.value : this.admins,
      adminNames: data.adminNames.present
          ? data.adminNames.value
          : this.adminNames,
      moderators: data.moderators.present
          ? data.moderators.value
          : this.moderators,
      moderatorNames: data.moderatorNames.present
          ? data.moderatorNames.value
          : this.moderatorNames,
      members: data.members.present ? data.members.value : this.members,
      memberNames: data.memberNames.present
          ? data.memberNames.value
          : this.memberNames,
      bannedUsers: data.bannedUsers.present
          ? data.bannedUsers.value
          : this.bannedUsers,
      bannedUserNames: data.bannedUserNames.present
          ? data.bannedUserNames.value
          : this.bannedUserNames,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      rules: data.rules.present ? data.rules.value : this.rules,
      logo: data.logo.present ? data.logo.value : this.logo,
      banner: data.banner.present ? data.banner.value : this.banner,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      bannerUrl: data.bannerUrl.present ? data.bannerUrl.value : this.bannerUrl,
      userRole: data.userRole.present ? data.userRole.value : this.userRole,
      canPost: data.canPost.present ? data.canPost.value : this.canPost,
      canModerate: data.canModerate.present
          ? data.canModerate.value
          : this.canModerate,
      canAdmin: data.canAdmin.present ? data.canAdmin.value : this.canAdmin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupEntity(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('creatorId: $creatorId, ')
          ..write('creatorName: $creatorName, ')
          ..write('admins: $admins, ')
          ..write('adminNames: $adminNames, ')
          ..write('moderators: $moderators, ')
          ..write('moderatorNames: $moderatorNames, ')
          ..write('members: $members, ')
          ..write('memberNames: $memberNames, ')
          ..write('bannedUsers: $bannedUsers, ')
          ..write('bannedUserNames: $bannedUserNames, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('rules: $rules, ')
          ..write('logo: $logo, ')
          ..write('banner: $banner, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('userRole: $userRole, ')
          ..write('canPost: $canPost, ')
          ..write('canModerate: $canModerate, ')
          ..write('canAdmin: $canAdmin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    createdAt,
    updatedAt,
    name,
    description,
    creatorId,
    creatorName,
    admins,
    adminNames,
    moderators,
    moderatorNames,
    members,
    memberNames,
    bannedUsers,
    bannedUserNames,
    isPrivate,
    rules,
    logo,
    banner,
    logoUrl,
    bannerUrl,
    userRole,
    canPost,
    canModerate,
    canAdmin,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.creatorId == this.creatorId &&
          other.creatorName == this.creatorName &&
          other.admins == this.admins &&
          other.adminNames == this.adminNames &&
          other.moderators == this.moderators &&
          other.moderatorNames == this.moderatorNames &&
          other.members == this.members &&
          other.memberNames == this.memberNames &&
          other.bannedUsers == this.bannedUsers &&
          other.bannedUserNames == this.bannedUserNames &&
          other.isPrivate == this.isPrivate &&
          other.rules == this.rules &&
          other.logo == this.logo &&
          other.banner == this.banner &&
          other.logoUrl == this.logoUrl &&
          other.bannerUrl == this.bannerUrl &&
          other.userRole == this.userRole &&
          other.canPost == this.canPost &&
          other.canModerate == this.canModerate &&
          other.canAdmin == this.canAdmin);
}

class GroupTableCompanion extends UpdateCompanion<GroupEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String> description;
  final Value<String> creatorId;
  final Value<String> creatorName;
  final Value<String> admins;
  final Value<String> adminNames;
  final Value<String> moderators;
  final Value<String> moderatorNames;
  final Value<String> members;
  final Value<String> memberNames;
  final Value<String> bannedUsers;
  final Value<String> bannedUserNames;
  final Value<bool> isPrivate;
  final Value<String> rules;
  final Value<String?> logo;
  final Value<String?> banner;
  final Value<String?> logoUrl;
  final Value<String?> bannerUrl;
  final Value<String?> userRole;
  final Value<bool> canPost;
  final Value<bool> canModerate;
  final Value<bool> canAdmin;
  final Value<int> rowid;
  const GroupTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorName = const Value.absent(),
    this.admins = const Value.absent(),
    this.adminNames = const Value.absent(),
    this.moderators = const Value.absent(),
    this.moderatorNames = const Value.absent(),
    this.members = const Value.absent(),
    this.memberNames = const Value.absent(),
    this.bannedUsers = const Value.absent(),
    this.bannedUserNames = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.rules = const Value.absent(),
    this.logo = const Value.absent(),
    this.banner = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    this.userRole = const Value.absent(),
    this.canPost = const Value.absent(),
    this.canModerate = const Value.absent(),
    this.canAdmin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required String description,
    required String creatorId,
    required String creatorName,
    required String admins,
    required String adminNames,
    required String moderators,
    required String moderatorNames,
    required String members,
    required String memberNames,
    required String bannedUsers,
    required String bannedUserNames,
    required bool isPrivate,
    required String rules,
    this.logo = const Value.absent(),
    this.banner = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    this.userRole = const Value.absent(),
    required bool canPost,
    required bool canModerate,
    required bool canAdmin,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       creatorId = Value(creatorId),
       creatorName = Value(creatorName),
       admins = Value(admins),
       adminNames = Value(adminNames),
       moderators = Value(moderators),
       moderatorNames = Value(moderatorNames),
       members = Value(members),
       memberNames = Value(memberNames),
       bannedUsers = Value(bannedUsers),
       bannedUserNames = Value(bannedUserNames),
       isPrivate = Value(isPrivate),
       rules = Value(rules),
       canPost = Value(canPost),
       canModerate = Value(canModerate),
       canAdmin = Value(canAdmin);
  static Insertable<GroupEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? creatorId,
    Expression<String>? creatorName,
    Expression<String>? admins,
    Expression<String>? adminNames,
    Expression<String>? moderators,
    Expression<String>? moderatorNames,
    Expression<String>? members,
    Expression<String>? memberNames,
    Expression<String>? bannedUsers,
    Expression<String>? bannedUserNames,
    Expression<bool>? isPrivate,
    Expression<String>? rules,
    Expression<String>? logo,
    Expression<String>? banner,
    Expression<String>? logoUrl,
    Expression<String>? bannerUrl,
    Expression<String>? userRole,
    Expression<bool>? canPost,
    Expression<bool>? canModerate,
    Expression<bool>? canAdmin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (creatorId != null) 'creator_id': creatorId,
      if (creatorName != null) 'creator_name': creatorName,
      if (admins != null) 'admins': admins,
      if (adminNames != null) 'admin_names': adminNames,
      if (moderators != null) 'moderators': moderators,
      if (moderatorNames != null) 'moderator_names': moderatorNames,
      if (members != null) 'members': members,
      if (memberNames != null) 'member_names': memberNames,
      if (bannedUsers != null) 'banned_users': bannedUsers,
      if (bannedUserNames != null) 'banned_user_names': bannedUserNames,
      if (isPrivate != null) 'is_private': isPrivate,
      if (rules != null) 'rules': rules,
      if (logo != null) 'logo': logo,
      if (banner != null) 'banner': banner,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (bannerUrl != null) 'banner_url': bannerUrl,
      if (userRole != null) 'user_role': userRole,
      if (canPost != null) 'can_post': canPost,
      if (canModerate != null) 'can_moderate': canModerate,
      if (canAdmin != null) 'can_admin': canAdmin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String>? description,
    Value<String>? creatorId,
    Value<String>? creatorName,
    Value<String>? admins,
    Value<String>? adminNames,
    Value<String>? moderators,
    Value<String>? moderatorNames,
    Value<String>? members,
    Value<String>? memberNames,
    Value<String>? bannedUsers,
    Value<String>? bannedUserNames,
    Value<bool>? isPrivate,
    Value<String>? rules,
    Value<String?>? logo,
    Value<String?>? banner,
    Value<String?>? logoUrl,
    Value<String?>? bannerUrl,
    Value<String?>? userRole,
    Value<bool>? canPost,
    Value<bool>? canModerate,
    Value<bool>? canAdmin,
    Value<int>? rowid,
  }) {
    return GroupTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      admins: admins ?? this.admins,
      adminNames: adminNames ?? this.adminNames,
      moderators: moderators ?? this.moderators,
      moderatorNames: moderatorNames ?? this.moderatorNames,
      members: members ?? this.members,
      memberNames: memberNames ?? this.memberNames,
      bannedUsers: bannedUsers ?? this.bannedUsers,
      bannedUserNames: bannedUserNames ?? this.bannedUserNames,
      isPrivate: isPrivate ?? this.isPrivate,
      rules: rules ?? this.rules,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      userRole: userRole ?? this.userRole,
      canPost: canPost ?? this.canPost,
      canModerate: canModerate ?? this.canModerate,
      canAdmin: canAdmin ?? this.canAdmin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<String>(creatorId.value);
    }
    if (creatorName.present) {
      map['creator_name'] = Variable<String>(creatorName.value);
    }
    if (admins.present) {
      map['admins'] = Variable<String>(admins.value);
    }
    if (adminNames.present) {
      map['admin_names'] = Variable<String>(adminNames.value);
    }
    if (moderators.present) {
      map['moderators'] = Variable<String>(moderators.value);
    }
    if (moderatorNames.present) {
      map['moderator_names'] = Variable<String>(moderatorNames.value);
    }
    if (members.present) {
      map['members'] = Variable<String>(members.value);
    }
    if (memberNames.present) {
      map['member_names'] = Variable<String>(memberNames.value);
    }
    if (bannedUsers.present) {
      map['banned_users'] = Variable<String>(bannedUsers.value);
    }
    if (bannedUserNames.present) {
      map['banned_user_names'] = Variable<String>(bannedUserNames.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (rules.present) {
      map['rules'] = Variable<String>(rules.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    if (banner.present) {
      map['banner'] = Variable<String>(banner.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (bannerUrl.present) {
      map['banner_url'] = Variable<String>(bannerUrl.value);
    }
    if (userRole.present) {
      map['user_role'] = Variable<String>(userRole.value);
    }
    if (canPost.present) {
      map['can_post'] = Variable<bool>(canPost.value);
    }
    if (canModerate.present) {
      map['can_moderate'] = Variable<bool>(canModerate.value);
    }
    if (canAdmin.present) {
      map['can_admin'] = Variable<bool>(canAdmin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('creatorId: $creatorId, ')
          ..write('creatorName: $creatorName, ')
          ..write('admins: $admins, ')
          ..write('adminNames: $adminNames, ')
          ..write('moderators: $moderators, ')
          ..write('moderatorNames: $moderatorNames, ')
          ..write('members: $members, ')
          ..write('memberNames: $memberNames, ')
          ..write('bannedUsers: $bannedUsers, ')
          ..write('bannedUserNames: $bannedUserNames, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('rules: $rules, ')
          ..write('logo: $logo, ')
          ..write('banner: $banner, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('userRole: $userRole, ')
          ..write('canPost: $canPost, ')
          ..write('canModerate: $canModerate, ')
          ..write('canAdmin: $canAdmin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PostTableTable extends PostTable
    with TableInfo<$PostTableTable, PostEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES group_table (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likeCountMeta = const VerificationMeta(
    'likeCount',
  );
  @override
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
    'like_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentCountMeta = const VerificationMeta(
    'commentCount',
  );
  @override
  late final GeneratedColumn<int> commentCount = GeneratedColumn<int>(
    'comment_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isLikedMeta = const VerificationMeta(
    'isLiked',
  );
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
    'is_liked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_liked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    groupId,
    userId,
    userName,
    email,
    avatarUrl,
    content,
    likeCount,
    commentCount,
    isLiked,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'post_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PostEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('like_count')) {
      context.handle(
        _likeCountMeta,
        likeCount.isAcceptableOrUnknown(data['like_count']!, _likeCountMeta),
      );
    } else if (isInserting) {
      context.missing(_likeCountMeta);
    }
    if (data.containsKey('comment_count')) {
      context.handle(
        _commentCountMeta,
        commentCount.isAcceptableOrUnknown(
          data['comment_count']!,
          _commentCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_commentCountMeta);
    }
    if (data.containsKey('is_liked')) {
      context.handle(
        _isLikedMeta,
        isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      likeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}like_count'],
      )!,
      commentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comment_count'],
      )!,
      isLiked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_liked'],
      )!,
    );
  }

  @override
  $PostTableTable createAlias(String alias) {
    return $PostTableTable(attachedDatabase, alias);
  }
}

class PostEntity extends DataClass implements Insertable<PostEntity> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String groupId;
  final String userId;
  final String userName;
  final String email;
  final String? avatarUrl;
  final String content;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  const PostEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.email,
    this.avatarUrl,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['group_id'] = Variable<String>(groupId);
    map['user_id'] = Variable<String>(userId);
    map['user_name'] = Variable<String>(userName);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['content'] = Variable<String>(content);
    map['like_count'] = Variable<int>(likeCount);
    map['comment_count'] = Variable<int>(commentCount);
    map['is_liked'] = Variable<bool>(isLiked);
    return map;
  }

  PostTableCompanion toCompanion(bool nullToAbsent) {
    return PostTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      groupId: Value(groupId),
      userId: Value(userId),
      userName: Value(userName),
      email: Value(email),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      content: Value(content),
      likeCount: Value(likeCount),
      commentCount: Value(commentCount),
      isLiked: Value(isLiked),
    );
  }

  factory PostEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostEntity(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      groupId: serializer.fromJson<String>(json['groupId']),
      userId: serializer.fromJson<String>(json['user_id']),
      userName: serializer.fromJson<String>(json['user_name']),
      email: serializer.fromJson<String>(json['email']),
      avatarUrl: serializer.fromJson<String?>(json['avatar_url']),
      content: serializer.fromJson<String>(json['content']),
      likeCount: serializer.fromJson<int>(json['like_count']),
      commentCount: serializer.fromJson<int>(json['comment_count']),
      isLiked: serializer.fromJson<bool>(json['is_liked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'groupId': serializer.toJson<String>(groupId),
      'user_id': serializer.toJson<String>(userId),
      'user_name': serializer.toJson<String>(userName),
      'email': serializer.toJson<String>(email),
      'avatar_url': serializer.toJson<String?>(avatarUrl),
      'content': serializer.toJson<String>(content),
      'like_count': serializer.toJson<int>(likeCount),
      'comment_count': serializer.toJson<int>(commentCount),
      'is_liked': serializer.toJson<bool>(isLiked),
    };
  }

  PostEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? groupId,
    String? userId,
    String? userName,
    String? email,
    Value<String?> avatarUrl = const Value.absent(),
    String? content,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) => PostEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    groupId: groupId ?? this.groupId,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    email: email ?? this.email,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    content: content ?? this.content,
    likeCount: likeCount ?? this.likeCount,
    commentCount: commentCount ?? this.commentCount,
    isLiked: isLiked ?? this.isLiked,
  );
  PostEntity copyWithCompanion(PostTableCompanion data) {
    return PostEntity(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      email: data.email.present ? data.email.value : this.email,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      content: data.content.present ? data.content.value : this.content,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
      commentCount: data.commentCount.present
          ? data.commentCount.value
          : this.commentCount,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostEntity(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('groupId: $groupId, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('content: $content, ')
          ..write('likeCount: $likeCount, ')
          ..write('commentCount: $commentCount, ')
          ..write('isLiked: $isLiked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    groupId,
    userId,
    userName,
    email,
    avatarUrl,
    content,
    likeCount,
    commentCount,
    isLiked,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.groupId == this.groupId &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.email == this.email &&
          other.avatarUrl == this.avatarUrl &&
          other.content == this.content &&
          other.likeCount == this.likeCount &&
          other.commentCount == this.commentCount &&
          other.isLiked == this.isLiked);
}

class PostTableCompanion extends UpdateCompanion<PostEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> groupId;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String> email;
  final Value<String?> avatarUrl;
  final Value<String> content;
  final Value<int> likeCount;
  final Value<int> commentCount;
  final Value<bool> isLiked;
  final Value<int> rowid;
  const PostTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.groupId = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.content = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.commentCount = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    this.avatarUrl = const Value.absent(),
    required String content,
    required int likeCount,
    required int commentCount,
    this.isLiked = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       groupId = Value(groupId),
       userId = Value(userId),
       userName = Value(userName),
       email = Value(email),
       content = Value(content),
       likeCount = Value(likeCount),
       commentCount = Value(commentCount);
  static Insertable<PostEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? groupId,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? email,
    Expression<String>? avatarUrl,
    Expression<String>? content,
    Expression<int>? likeCount,
    Expression<int>? commentCount,
    Expression<bool>? isLiked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (groupId != null) 'group_id': groupId,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (email != null) 'email': email,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (content != null) 'content': content,
      if (likeCount != null) 'like_count': likeCount,
      if (commentCount != null) 'comment_count': commentCount,
      if (isLiked != null) 'is_liked': isLiked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? groupId,
    Value<String>? userId,
    Value<String>? userName,
    Value<String>? email,
    Value<String?>? avatarUrl,
    Value<String>? content,
    Value<int>? likeCount,
    Value<int>? commentCount,
    Value<bool>? isLiked,
    Value<int>? rowid,
  }) {
    return PostTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
    }
    if (commentCount.present) {
      map['comment_count'] = Variable<int>(commentCount.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('groupId: $groupId, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('content: $content, ')
          ..write('likeCount: $likeCount, ')
          ..write('commentCount: $commentCount, ')
          ..write('isLiked: $isLiked, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentTableTable extends AttachmentTable
    with TableInfo<$AttachmentTableTable, AttachmentEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
    'post_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES post_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _attachmentTypeMeta = const VerificationMeta(
    'attachmentType',
  );
  @override
  late final GeneratedColumn<String> attachmentType = GeneratedColumn<String>(
    'attachment_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileMeta = const VerificationMeta('file');
  @override
  late final GeneratedColumn<String> file = GeneratedColumn<String>(
    'file',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<double> size = GeneratedColumn<double>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    postId,
    attachmentType,
    file,
    name,
    size,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachment_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('post_id')) {
      context.handle(
        _postIdMeta,
        postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta),
      );
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('attachment_type')) {
      context.handle(
        _attachmentTypeMeta,
        attachmentType.isAcceptableOrUnknown(
          data['attachment_type']!,
          _attachmentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attachmentTypeMeta);
    }
    if (data.containsKey('file')) {
      context.handle(
        _fileMeta,
        file.isAcceptableOrUnknown(data['file']!, _fileMeta),
      );
    } else if (isInserting) {
      context.missing(_fileMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      postId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}post_id'],
      )!,
      attachmentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_type'],
      )!,
      file: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}size'],
      )!,
    );
  }

  @override
  $AttachmentTableTable createAlias(String alias) {
    return $AttachmentTableTable(attachedDatabase, alias);
  }
}

class AttachmentEntity extends DataClass
    implements Insertable<AttachmentEntity> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String postId;
  final String attachmentType;
  final String file;
  final String name;
  final double size;
  const AttachmentEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.postId,
    required this.attachmentType,
    required this.file,
    required this.name,
    required this.size,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['post_id'] = Variable<String>(postId);
    map['attachment_type'] = Variable<String>(attachmentType);
    map['file'] = Variable<String>(file);
    map['name'] = Variable<String>(name);
    map['size'] = Variable<double>(size);
    return map;
  }

  AttachmentTableCompanion toCompanion(bool nullToAbsent) {
    return AttachmentTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      postId: Value(postId),
      attachmentType: Value(attachmentType),
      file: Value(file),
      name: Value(name),
      size: Value(size),
    );
  }

  factory AttachmentEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentEntity(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      postId: serializer.fromJson<String>(json['post_id']),
      attachmentType: serializer.fromJson<String>(json['attachment_type']),
      file: serializer.fromJson<String>(json['file_url']),
      name: serializer.fromJson<String>(json['original_filename']),
      size: serializer.fromJson<double>(json['file_size_mb']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'post_id': serializer.toJson<String>(postId),
      'attachment_type': serializer.toJson<String>(attachmentType),
      'file_url': serializer.toJson<String>(file),
      'original_filename': serializer.toJson<String>(name),
      'file_size_mb': serializer.toJson<double>(size),
    };
  }

  AttachmentEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? postId,
    String? attachmentType,
    String? file,
    String? name,
    double? size,
  }) => AttachmentEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    postId: postId ?? this.postId,
    attachmentType: attachmentType ?? this.attachmentType,
    file: file ?? this.file,
    name: name ?? this.name,
    size: size ?? this.size,
  );
  AttachmentEntity copyWithCompanion(AttachmentTableCompanion data) {
    return AttachmentEntity(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      postId: data.postId.present ? data.postId.value : this.postId,
      attachmentType: data.attachmentType.present
          ? data.attachmentType.value
          : this.attachmentType,
      file: data.file.present ? data.file.value : this.file,
      name: data.name.present ? data.name.value : this.name,
      size: data.size.present ? data.size.value : this.size,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentEntity(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('postId: $postId, ')
          ..write('attachmentType: $attachmentType, ')
          ..write('file: $file, ')
          ..write('name: $name, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    postId,
    attachmentType,
    file,
    name,
    size,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.postId == this.postId &&
          other.attachmentType == this.attachmentType &&
          other.file == this.file &&
          other.name == this.name &&
          other.size == this.size);
}

class AttachmentTableCompanion extends UpdateCompanion<AttachmentEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> postId;
  final Value<String> attachmentType;
  final Value<String> file;
  final Value<String> name;
  final Value<double> size;
  final Value<int> rowid;
  const AttachmentTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.postId = const Value.absent(),
    this.attachmentType = const Value.absent(),
    this.file = const Value.absent(),
    this.name = const Value.absent(),
    this.size = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String postId,
    required String attachmentType,
    required String file,
    required String name,
    required double size,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       postId = Value(postId),
       attachmentType = Value(attachmentType),
       file = Value(file),
       name = Value(name),
       size = Value(size);
  static Insertable<AttachmentEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? postId,
    Expression<String>? attachmentType,
    Expression<String>? file,
    Expression<String>? name,
    Expression<double>? size,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (postId != null) 'post_id': postId,
      if (attachmentType != null) 'attachment_type': attachmentType,
      if (file != null) 'file': file,
      if (name != null) 'name': name,
      if (size != null) 'size': size,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? postId,
    Value<String>? attachmentType,
    Value<String>? file,
    Value<String>? name,
    Value<double>? size,
    Value<int>? rowid,
  }) {
    return AttachmentTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postId: postId ?? this.postId,
      attachmentType: attachmentType ?? this.attachmentType,
      file: file ?? this.file,
      name: name ?? this.name,
      size: size ?? this.size,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (attachmentType.present) {
      map['attachment_type'] = Variable<String>(attachmentType.value);
    }
    if (file.present) {
      map['file'] = Variable<String>(file.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (size.present) {
      map['size'] = Variable<double>(size.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('postId: $postId, ')
          ..write('attachmentType: $attachmentType, ')
          ..write('file: $file, ')
          ..write('name: $name, ')
          ..write('size: $size, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PostReplyTableTable extends PostReplyTable
    with TableInfo<$PostReplyTableTable, PostReplyEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostReplyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES post_reply_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
    'post_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES post_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userAvatarMeta = const VerificationMeta(
    'userAvatar',
  );
  @override
  late final GeneratedColumn<String> userAvatar = GeneratedColumn<String>(
    'user_avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    parentId,
    postId,
    userId,
    userName,
    userAvatar,
    content,
    depth,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'post_reply_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PostReplyEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('post_id')) {
      context.handle(
        _postIdMeta,
        postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta),
      );
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('user_avatar')) {
      context.handle(
        _userAvatarMeta,
        userAvatar.isAcceptableOrUnknown(data['user_avatar']!, _userAvatarMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostReplyEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostReplyEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      postId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}post_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      userAvatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_avatar'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
    );
  }

  @override
  $PostReplyTableTable createAlias(String alias) {
    return $PostReplyTableTable(attachedDatabase, alias);
  }
}

class PostReplyEntity extends DataClass implements Insertable<PostReplyEntity> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? parentId;
  final String postId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String content;
  final int depth;
  const PostReplyEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
    required this.postId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.content,
    required this.depth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['post_id'] = Variable<String>(postId);
    map['user_id'] = Variable<String>(userId);
    map['user_name'] = Variable<String>(userName);
    if (!nullToAbsent || userAvatar != null) {
      map['user_avatar'] = Variable<String>(userAvatar);
    }
    map['content'] = Variable<String>(content);
    map['depth'] = Variable<int>(depth);
    return map;
  }

  PostReplyTableCompanion toCompanion(bool nullToAbsent) {
    return PostReplyTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      postId: Value(postId),
      userId: Value(userId),
      userName: Value(userName),
      userAvatar: userAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(userAvatar),
      content: Value(content),
      depth: Value(depth),
    );
  }

  factory PostReplyEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostReplyEntity(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      parentId: serializer.fromJson<String?>(json['parent_id']),
      postId: serializer.fromJson<String>(json['post_id']),
      userId: serializer.fromJson<String>(json['user_id']),
      userName: serializer.fromJson<String>(json['user_name']),
      userAvatar: serializer.fromJson<String?>(json['user_avatar']),
      content: serializer.fromJson<String>(json['content']),
      depth: serializer.fromJson<int>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'parent_id': serializer.toJson<String?>(parentId),
      'post_id': serializer.toJson<String>(postId),
      'user_id': serializer.toJson<String>(userId),
      'user_name': serializer.toJson<String>(userName),
      'user_avatar': serializer.toJson<String?>(userAvatar),
      'content': serializer.toJson<String>(content),
      'depth': serializer.toJson<int>(depth),
    };
  }

  PostReplyEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> parentId = const Value.absent(),
    String? postId,
    String? userId,
    String? userName,
    Value<String?> userAvatar = const Value.absent(),
    String? content,
    int? depth,
  }) => PostReplyEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    parentId: parentId.present ? parentId.value : this.parentId,
    postId: postId ?? this.postId,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    userAvatar: userAvatar.present ? userAvatar.value : this.userAvatar,
    content: content ?? this.content,
    depth: depth ?? this.depth,
  );
  PostReplyEntity copyWithCompanion(PostReplyTableCompanion data) {
    return PostReplyEntity(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      postId: data.postId.present ? data.postId.value : this.postId,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      userAvatar: data.userAvatar.present
          ? data.userAvatar.value
          : this.userAvatar,
      content: data.content.present ? data.content.value : this.content,
      depth: data.depth.present ? data.depth.value : this.depth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostReplyEntity(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('parentId: $parentId, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('userAvatar: $userAvatar, ')
          ..write('content: $content, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    parentId,
    postId,
    userId,
    userName,
    userAvatar,
    content,
    depth,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostReplyEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.parentId == this.parentId &&
          other.postId == this.postId &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.userAvatar == this.userAvatar &&
          other.content == this.content &&
          other.depth == this.depth);
}

class PostReplyTableCompanion extends UpdateCompanion<PostReplyEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> parentId;
  final Value<String> postId;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String?> userAvatar;
  final Value<String> content;
  final Value<int> depth;
  final Value<int> rowid;
  const PostReplyTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.parentId = const Value.absent(),
    this.postId = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.userAvatar = const Value.absent(),
    this.content = const Value.absent(),
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostReplyTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.parentId = const Value.absent(),
    required String postId,
    required String userId,
    required String userName,
    this.userAvatar = const Value.absent(),
    required String content,
    required int depth,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       postId = Value(postId),
       userId = Value(userId),
       userName = Value(userName),
       content = Value(content),
       depth = Value(depth);
  static Insertable<PostReplyEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? parentId,
    Expression<String>? postId,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? userAvatar,
    Expression<String>? content,
    Expression<int>? depth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (parentId != null) 'parent_id': parentId,
      if (postId != null) 'post_id': postId,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (userAvatar != null) 'user_avatar': userAvatar,
      if (content != null) 'content': content,
      if (depth != null) 'depth': depth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostReplyTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? parentId,
    Value<String>? postId,
    Value<String>? userId,
    Value<String>? userName,
    Value<String?>? userAvatar,
    Value<String>? content,
    Value<int>? depth,
    Value<int>? rowid,
  }) {
    return PostReplyTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parentId: parentId ?? this.parentId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      depth: depth ?? this.depth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (userAvatar.present) {
      map['user_avatar'] = Variable<String>(userAvatar.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostReplyTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('parentId: $parentId, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('userAvatar: $userAvatar, ')
          ..write('content: $content, ')
          ..write('depth: $depth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TodoTable extends Todo with TableInfo<$TodoTable, TodoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<DateTime> completed = GeneratedColumn<DateTime>(
    'completed',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime> due = GeneratedColumn<DateTime>(
    'due',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hiddenMeta = const VerificationMeta('hidden');
  @override
  late final GeneratedColumn<bool> hidden = GeneratedColumn<bool>(
    'hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hidden" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
    'owner',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<String> parent = GeneratedColumn<String>(
    'parent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selfLinkMeta = const VerificationMeta(
    'selfLink',
  );
  @override
  late final GeneratedColumn<String> selfLink = GeneratedColumn<String>(
    'self_link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  @override
  late final GeneratedColumn<DateTime> updated = GeneratedColumn<DateTime>(
    'updated',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _webViewLinkMeta = const VerificationMeta(
    'webViewLink',
  );
  @override
  late final GeneratedColumn<String> webViewLink = GeneratedColumn<String>(
    'web_view_link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    completed,
    deleted,
    due,
    etag,
    hidden,
    id,
    kind,
    notes,
    owner,
    parent,
    position,
    selfLink,
    status,
    title,
    updated,
    webViewLink,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('due')) {
      context.handle(
        _dueMeta,
        due.isAcceptableOrUnknown(data['due']!, _dueMeta),
      );
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    } else if (isInserting) {
      context.missing(_etagMeta);
    }
    if (data.containsKey('hidden')) {
      context.handle(
        _hiddenMeta,
        hidden.isAcceptableOrUnknown(data['hidden']!, _hiddenMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('owner')) {
      context.handle(
        _ownerMeta,
        owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    if (data.containsKey('parent')) {
      context.handle(
        _parentMeta,
        parent.isAcceptableOrUnknown(data['parent']!, _parentMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('self_link')) {
      context.handle(
        _selfLinkMeta,
        selfLink.isAcceptableOrUnknown(data['self_link']!, _selfLinkMeta),
      );
    } else if (isInserting) {
      context.missing(_selfLinkMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    }
    if (data.containsKey('web_view_link')) {
      context.handle(
        _webViewLinkMeta,
        webViewLink.isAcceptableOrUnknown(
          data['web_view_link']!,
          _webViewLinkMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_webViewLinkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoData(
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed'],
      ),
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      due: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due'],
      ),
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      )!,
      hidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hidden'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      owner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner'],
      )!,
      parent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      selfLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}self_link'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      updated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated'],
      ),
      webViewLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}web_view_link'],
      )!,
    );
  }

  @override
  $TodoTable createAlias(String alias) {
    return $TodoTable(attachedDatabase, alias);
  }
}

class TodoData extends DataClass implements Insertable<TodoData> {
  final DateTime? completed;
  final bool deleted;
  final DateTime? due;
  final String etag;
  final bool hidden;
  final String id;
  final String kind;
  final String? notes;
  final String owner;
  final String? parent;
  final String position;
  final String selfLink;
  final String status;
  final String title;
  final DateTime? updated;
  final String webViewLink;
  const TodoData({
    this.completed,
    required this.deleted,
    this.due,
    required this.etag,
    required this.hidden,
    required this.id,
    required this.kind,
    this.notes,
    required this.owner,
    this.parent,
    required this.position,
    required this.selfLink,
    required this.status,
    required this.title,
    this.updated,
    required this.webViewLink,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<DateTime>(completed);
    }
    map['deleted'] = Variable<bool>(deleted);
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<DateTime>(due);
    }
    map['etag'] = Variable<String>(etag);
    map['hidden'] = Variable<bool>(hidden);
    map['id'] = Variable<String>(id);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['owner'] = Variable<String>(owner);
    if (!nullToAbsent || parent != null) {
      map['parent'] = Variable<String>(parent);
    }
    map['position'] = Variable<String>(position);
    map['self_link'] = Variable<String>(selfLink);
    map['status'] = Variable<String>(status);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime>(updated);
    }
    map['web_view_link'] = Variable<String>(webViewLink);
    return map;
  }

  TodoCompanion toCompanion(bool nullToAbsent) {
    return TodoCompanion(
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      deleted: Value(deleted),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      etag: Value(etag),
      hidden: Value(hidden),
      id: Value(id),
      kind: Value(kind),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      owner: Value(owner),
      parent: parent == null && nullToAbsent
          ? const Value.absent()
          : Value(parent),
      position: Value(position),
      selfLink: Value(selfLink),
      status: Value(status),
      title: Value(title),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      webViewLink: Value(webViewLink),
    );
  }

  factory TodoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoData(
      completed: serializer.fromJson<DateTime?>(json['completed']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      due: serializer.fromJson<DateTime?>(json['due']),
      etag: serializer.fromJson<String>(json['etag']),
      hidden: serializer.fromJson<bool>(json['hidden']),
      id: serializer.fromJson<String>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      notes: serializer.fromJson<String?>(json['notes']),
      owner: serializer.fromJson<String>(json['owner_id']),
      parent: serializer.fromJson<String?>(json['parent']),
      position: serializer.fromJson<String>(json['position']),
      selfLink: serializer.fromJson<String>(json['self_link']),
      status: serializer.fromJson<String>(json['status']),
      title: serializer.fromJson<String>(json['title']),
      updated: serializer.fromJson<DateTime?>(json['updated']),
      webViewLink: serializer.fromJson<String>(json['web_view_link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'completed': serializer.toJson<DateTime?>(completed),
      'deleted': serializer.toJson<bool>(deleted),
      'due': serializer.toJson<DateTime?>(due),
      'etag': serializer.toJson<String>(etag),
      'hidden': serializer.toJson<bool>(hidden),
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(kind),
      'notes': serializer.toJson<String?>(notes),
      'owner_id': serializer.toJson<String>(owner),
      'parent': serializer.toJson<String?>(parent),
      'position': serializer.toJson<String>(position),
      'self_link': serializer.toJson<String>(selfLink),
      'status': serializer.toJson<String>(status),
      'title': serializer.toJson<String>(title),
      'updated': serializer.toJson<DateTime?>(updated),
      'web_view_link': serializer.toJson<String>(webViewLink),
    };
  }

  TodoData copyWith({
    Value<DateTime?> completed = const Value.absent(),
    bool? deleted,
    Value<DateTime?> due = const Value.absent(),
    String? etag,
    bool? hidden,
    String? id,
    String? kind,
    Value<String?> notes = const Value.absent(),
    String? owner,
    Value<String?> parent = const Value.absent(),
    String? position,
    String? selfLink,
    String? status,
    String? title,
    Value<DateTime?> updated = const Value.absent(),
    String? webViewLink,
  }) => TodoData(
    completed: completed.present ? completed.value : this.completed,
    deleted: deleted ?? this.deleted,
    due: due.present ? due.value : this.due,
    etag: etag ?? this.etag,
    hidden: hidden ?? this.hidden,
    id: id ?? this.id,
    kind: kind ?? this.kind,
    notes: notes.present ? notes.value : this.notes,
    owner: owner ?? this.owner,
    parent: parent.present ? parent.value : this.parent,
    position: position ?? this.position,
    selfLink: selfLink ?? this.selfLink,
    status: status ?? this.status,
    title: title ?? this.title,
    updated: updated.present ? updated.value : this.updated,
    webViewLink: webViewLink ?? this.webViewLink,
  );
  TodoData copyWithCompanion(TodoCompanion data) {
    return TodoData(
      completed: data.completed.present ? data.completed.value : this.completed,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      due: data.due.present ? data.due.value : this.due,
      etag: data.etag.present ? data.etag.value : this.etag,
      hidden: data.hidden.present ? data.hidden.value : this.hidden,
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      notes: data.notes.present ? data.notes.value : this.notes,
      owner: data.owner.present ? data.owner.value : this.owner,
      parent: data.parent.present ? data.parent.value : this.parent,
      position: data.position.present ? data.position.value : this.position,
      selfLink: data.selfLink.present ? data.selfLink.value : this.selfLink,
      status: data.status.present ? data.status.value : this.status,
      title: data.title.present ? data.title.value : this.title,
      updated: data.updated.present ? data.updated.value : this.updated,
      webViewLink: data.webViewLink.present
          ? data.webViewLink.value
          : this.webViewLink,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoData(')
          ..write('completed: $completed, ')
          ..write('deleted: $deleted, ')
          ..write('due: $due, ')
          ..write('etag: $etag, ')
          ..write('hidden: $hidden, ')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('notes: $notes, ')
          ..write('owner: $owner, ')
          ..write('parent: $parent, ')
          ..write('position: $position, ')
          ..write('selfLink: $selfLink, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('updated: $updated, ')
          ..write('webViewLink: $webViewLink')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    completed,
    deleted,
    due,
    etag,
    hidden,
    id,
    kind,
    notes,
    owner,
    parent,
    position,
    selfLink,
    status,
    title,
    updated,
    webViewLink,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoData &&
          other.completed == this.completed &&
          other.deleted == this.deleted &&
          other.due == this.due &&
          other.etag == this.etag &&
          other.hidden == this.hidden &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.notes == this.notes &&
          other.owner == this.owner &&
          other.parent == this.parent &&
          other.position == this.position &&
          other.selfLink == this.selfLink &&
          other.status == this.status &&
          other.title == this.title &&
          other.updated == this.updated &&
          other.webViewLink == this.webViewLink);
}

class TodoCompanion extends UpdateCompanion<TodoData> {
  final Value<DateTime?> completed;
  final Value<bool> deleted;
  final Value<DateTime?> due;
  final Value<String> etag;
  final Value<bool> hidden;
  final Value<String> id;
  final Value<String> kind;
  final Value<String?> notes;
  final Value<String> owner;
  final Value<String?> parent;
  final Value<String> position;
  final Value<String> selfLink;
  final Value<String> status;
  final Value<String> title;
  final Value<DateTime?> updated;
  final Value<String> webViewLink;
  final Value<int> rowid;
  const TodoCompanion({
    this.completed = const Value.absent(),
    this.deleted = const Value.absent(),
    this.due = const Value.absent(),
    this.etag = const Value.absent(),
    this.hidden = const Value.absent(),
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.notes = const Value.absent(),
    this.owner = const Value.absent(),
    this.parent = const Value.absent(),
    this.position = const Value.absent(),
    this.selfLink = const Value.absent(),
    this.status = const Value.absent(),
    this.title = const Value.absent(),
    this.updated = const Value.absent(),
    this.webViewLink = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodoCompanion.insert({
    this.completed = const Value.absent(),
    this.deleted = const Value.absent(),
    this.due = const Value.absent(),
    required String etag,
    this.hidden = const Value.absent(),
    required String id,
    required String kind,
    this.notes = const Value.absent(),
    required String owner,
    this.parent = const Value.absent(),
    required String position,
    required String selfLink,
    required String status,
    required String title,
    this.updated = const Value.absent(),
    required String webViewLink,
    this.rowid = const Value.absent(),
  }) : etag = Value(etag),
       id = Value(id),
       kind = Value(kind),
       owner = Value(owner),
       position = Value(position),
       selfLink = Value(selfLink),
       status = Value(status),
       title = Value(title),
       webViewLink = Value(webViewLink);
  static Insertable<TodoData> custom({
    Expression<DateTime>? completed,
    Expression<bool>? deleted,
    Expression<DateTime>? due,
    Expression<String>? etag,
    Expression<bool>? hidden,
    Expression<String>? id,
    Expression<String>? kind,
    Expression<String>? notes,
    Expression<String>? owner,
    Expression<String>? parent,
    Expression<String>? position,
    Expression<String>? selfLink,
    Expression<String>? status,
    Expression<String>? title,
    Expression<DateTime>? updated,
    Expression<String>? webViewLink,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (completed != null) 'completed': completed,
      if (deleted != null) 'deleted': deleted,
      if (due != null) 'due': due,
      if (etag != null) 'etag': etag,
      if (hidden != null) 'hidden': hidden,
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (notes != null) 'notes': notes,
      if (owner != null) 'owner': owner,
      if (parent != null) 'parent': parent,
      if (position != null) 'position': position,
      if (selfLink != null) 'self_link': selfLink,
      if (status != null) 'status': status,
      if (title != null) 'title': title,
      if (updated != null) 'updated': updated,
      if (webViewLink != null) 'web_view_link': webViewLink,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodoCompanion copyWith({
    Value<DateTime?>? completed,
    Value<bool>? deleted,
    Value<DateTime?>? due,
    Value<String>? etag,
    Value<bool>? hidden,
    Value<String>? id,
    Value<String>? kind,
    Value<String?>? notes,
    Value<String>? owner,
    Value<String?>? parent,
    Value<String>? position,
    Value<String>? selfLink,
    Value<String>? status,
    Value<String>? title,
    Value<DateTime?>? updated,
    Value<String>? webViewLink,
    Value<int>? rowid,
  }) {
    return TodoCompanion(
      completed: completed ?? this.completed,
      deleted: deleted ?? this.deleted,
      due: due ?? this.due,
      etag: etag ?? this.etag,
      hidden: hidden ?? this.hidden,
      id: id ?? this.id,
      kind: kind ?? this.kind,
      notes: notes ?? this.notes,
      owner: owner ?? this.owner,
      parent: parent ?? this.parent,
      position: position ?? this.position,
      selfLink: selfLink ?? this.selfLink,
      status: status ?? this.status,
      title: title ?? this.title,
      updated: updated ?? this.updated,
      webViewLink: webViewLink ?? this.webViewLink,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (completed.present) {
      map['completed'] = Variable<DateTime>(completed.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (hidden.present) {
      map['hidden'] = Variable<bool>(hidden.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (parent.present) {
      map['parent'] = Variable<String>(parent.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (selfLink.present) {
      map['self_link'] = Variable<String>(selfLink.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (webViewLink.present) {
      map['web_view_link'] = Variable<String>(webViewLink.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoCompanion(')
          ..write('completed: $completed, ')
          ..write('deleted: $deleted, ')
          ..write('due: $due, ')
          ..write('etag: $etag, ')
          ..write('hidden: $hidden, ')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('notes: $notes, ')
          ..write('owner: $owner, ')
          ..write('parent: $parent, ')
          ..write('position: $position, ')
          ..write('selfLink: $selfLink, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('updated: $updated, ')
          ..write('webViewLink: $webViewLink, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventTableTable extends EventTable
    with TableInfo<$EventTableTable, EventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizerMeta = const VerificationMeta(
    'organizer',
  );
  @override
  late final GeneratedColumn<String> organizer = GeneratedColumn<String>(
    'organizer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfAttendeesMeta = const VerificationMeta(
    'numberOfAttendees',
  );
  @override
  late final GeneratedColumn<int> numberOfAttendees = GeneratedColumn<int>(
    'number_of_attendees',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizerIdMeta = const VerificationMeta(
    'organizerId',
  );
  @override
  late final GeneratedColumn<String> organizerId = GeneratedColumn<String>(
    'organizer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
    'genre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterMeta = const VerificationMeta('poster');
  @override
  late final GeneratedColumn<String> poster = GeneratedColumn<String>(
    'poster',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bannerMeta = const VerificationMeta('banner');
  @override
  late final GeneratedColumn<String> banner = GeneratedColumn<String>(
    'banner',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    description,
    url,
    location,
    time,
    date,
    organizer,
    imageUrl,
    numberOfAttendees,
    organizerId,
    genre,
    poster,
    banner,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('organizer')) {
      context.handle(
        _organizerMeta,
        organizer.isAcceptableOrUnknown(data['organizer']!, _organizerMeta),
      );
    } else if (isInserting) {
      context.missing(_organizerMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('number_of_attendees')) {
      context.handle(
        _numberOfAttendeesMeta,
        numberOfAttendees.isAcceptableOrUnknown(
          data['number_of_attendees']!,
          _numberOfAttendeesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfAttendeesMeta);
    }
    if (data.containsKey('organizer_id')) {
      context.handle(
        _organizerIdMeta,
        organizerId.isAcceptableOrUnknown(
          data['organizer_id']!,
          _organizerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizerIdMeta);
    }
    if (data.containsKey('genre')) {
      context.handle(
        _genreMeta,
        genre.isAcceptableOrUnknown(data['genre']!, _genreMeta),
      );
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('poster')) {
      context.handle(
        _posterMeta,
        poster.isAcceptableOrUnknown(data['poster']!, _posterMeta),
      );
    }
    if (data.containsKey('banner')) {
      context.handle(
        _bannerMeta,
        banner.isAcceptableOrUnknown(data['banner']!, _bannerMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      organizer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organizer'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      numberOfAttendees: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_attendees'],
      )!,
      organizerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organizer_id'],
      )!,
      genre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre'],
      )!,
      poster: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster'],
      ),
      banner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner'],
      ),
    );
  }

  @override
  $EventTableTable createAlias(String alias) {
    return $EventTableTable(attachedDatabase, alias);
  }
}

class EventData extends DataClass implements Insertable<EventData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final String url;
  final String location;
  final String time;
  final String date;
  final String organizer;
  final String imageUrl;
  final int numberOfAttendees;
  final String organizerId;
  final String genre;
  final String? poster;
  final String? banner;
  const EventData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.url,
    required this.location,
    required this.time,
    required this.date,
    required this.organizer,
    required this.imageUrl,
    required this.numberOfAttendees,
    required this.organizerId,
    required this.genre,
    this.poster,
    this.banner,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['url'] = Variable<String>(url);
    map['location'] = Variable<String>(location);
    map['time'] = Variable<String>(time);
    map['date'] = Variable<String>(date);
    map['organizer'] = Variable<String>(organizer);
    map['image_url'] = Variable<String>(imageUrl);
    map['number_of_attendees'] = Variable<int>(numberOfAttendees);
    map['organizer_id'] = Variable<String>(organizerId);
    map['genre'] = Variable<String>(genre);
    if (!nullToAbsent || poster != null) {
      map['poster'] = Variable<String>(poster);
    }
    if (!nullToAbsent || banner != null) {
      map['banner'] = Variable<String>(banner);
    }
    return map;
  }

  EventTableCompanion toCompanion(bool nullToAbsent) {
    return EventTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      description: Value(description),
      url: Value(url),
      location: Value(location),
      time: Value(time),
      date: Value(date),
      organizer: Value(organizer),
      imageUrl: Value(imageUrl),
      numberOfAttendees: Value(numberOfAttendees),
      organizerId: Value(organizerId),
      genre: Value(genre),
      poster: poster == null && nullToAbsent
          ? const Value.absent()
          : Value(poster),
      banner: banner == null && nullToAbsent
          ? const Value.absent()
          : Value(banner),
    );
  }

  factory EventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      url: serializer.fromJson<String>(json['url']),
      location: serializer.fromJson<String>(json['location']),
      time: serializer.fromJson<String>(json['time']),
      date: serializer.fromJson<String>(json['date']),
      organizer: serializer.fromJson<String>(json['organizer']),
      imageUrl: serializer.fromJson<String>(json['event_card_image']),
      numberOfAttendees: serializer.fromJson<int>(json['number_of_attendees']),
      organizerId: serializer.fromJson<String>(json['organizer_id']),
      genre: serializer.fromJson<String>(json['genre']),
      poster: serializer.fromJson<String?>(json['poster']),
      banner: serializer.fromJson<String?>(json['banner']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'url': serializer.toJson<String>(url),
      'location': serializer.toJson<String>(location),
      'time': serializer.toJson<String>(time),
      'date': serializer.toJson<String>(date),
      'organizer': serializer.toJson<String>(organizer),
      'event_card_image': serializer.toJson<String>(imageUrl),
      'number_of_attendees': serializer.toJson<int>(numberOfAttendees),
      'organizer_id': serializer.toJson<String>(organizerId),
      'genre': serializer.toJson<String>(genre),
      'poster': serializer.toJson<String?>(poster),
      'banner': serializer.toJson<String?>(banner),
    };
  }

  EventData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? description,
    String? url,
    String? location,
    String? time,
    String? date,
    String? organizer,
    String? imageUrl,
    int? numberOfAttendees,
    String? organizerId,
    String? genre,
    Value<String?> poster = const Value.absent(),
    Value<String?> banner = const Value.absent(),
  }) => EventData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    description: description ?? this.description,
    url: url ?? this.url,
    location: location ?? this.location,
    time: time ?? this.time,
    date: date ?? this.date,
    organizer: organizer ?? this.organizer,
    imageUrl: imageUrl ?? this.imageUrl,
    numberOfAttendees: numberOfAttendees ?? this.numberOfAttendees,
    organizerId: organizerId ?? this.organizerId,
    genre: genre ?? this.genre,
    poster: poster.present ? poster.value : this.poster,
    banner: banner.present ? banner.value : this.banner,
  );
  EventData copyWithCompanion(EventTableCompanion data) {
    return EventData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      url: data.url.present ? data.url.value : this.url,
      location: data.location.present ? data.location.value : this.location,
      time: data.time.present ? data.time.value : this.time,
      date: data.date.present ? data.date.value : this.date,
      organizer: data.organizer.present ? data.organizer.value : this.organizer,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      numberOfAttendees: data.numberOfAttendees.present
          ? data.numberOfAttendees.value
          : this.numberOfAttendees,
      organizerId: data.organizerId.present
          ? data.organizerId.value
          : this.organizerId,
      genre: data.genre.present ? data.genre.value : this.genre,
      poster: data.poster.present ? data.poster.value : this.poster,
      banner: data.banner.present ? data.banner.value : this.banner,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('location: $location, ')
          ..write('time: $time, ')
          ..write('date: $date, ')
          ..write('organizer: $organizer, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('numberOfAttendees: $numberOfAttendees, ')
          ..write('organizerId: $organizerId, ')
          ..write('genre: $genre, ')
          ..write('poster: $poster, ')
          ..write('banner: $banner')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    description,
    url,
    location,
    time,
    date,
    organizer,
    imageUrl,
    numberOfAttendees,
    organizerId,
    genre,
    poster,
    banner,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.url == this.url &&
          other.location == this.location &&
          other.time == this.time &&
          other.date == this.date &&
          other.organizer == this.organizer &&
          other.imageUrl == this.imageUrl &&
          other.numberOfAttendees == this.numberOfAttendees &&
          other.organizerId == this.organizerId &&
          other.genre == this.genre &&
          other.poster == this.poster &&
          other.banner == this.banner);
}

class EventTableCompanion extends UpdateCompanion<EventData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String> description;
  final Value<String> url;
  final Value<String> location;
  final Value<String> time;
  final Value<String> date;
  final Value<String> organizer;
  final Value<String> imageUrl;
  final Value<int> numberOfAttendees;
  final Value<String> organizerId;
  final Value<String> genre;
  final Value<String?> poster;
  final Value<String?> banner;
  final Value<int> rowid;
  const EventTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.url = const Value.absent(),
    this.location = const Value.absent(),
    this.time = const Value.absent(),
    this.date = const Value.absent(),
    this.organizer = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.numberOfAttendees = const Value.absent(),
    this.organizerId = const Value.absent(),
    this.genre = const Value.absent(),
    this.poster = const Value.absent(),
    this.banner = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required String description,
    required String url,
    required String location,
    required String time,
    required String date,
    required String organizer,
    required String imageUrl,
    required int numberOfAttendees,
    required String organizerId,
    required String genre,
    this.poster = const Value.absent(),
    this.banner = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       url = Value(url),
       location = Value(location),
       time = Value(time),
       date = Value(date),
       organizer = Value(organizer),
       imageUrl = Value(imageUrl),
       numberOfAttendees = Value(numberOfAttendees),
       organizerId = Value(organizerId),
       genre = Value(genre);
  static Insertable<EventData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? url,
    Expression<String>? location,
    Expression<String>? time,
    Expression<String>? date,
    Expression<String>? organizer,
    Expression<String>? imageUrl,
    Expression<int>? numberOfAttendees,
    Expression<String>? organizerId,
    Expression<String>? genre,
    Expression<String>? poster,
    Expression<String>? banner,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (url != null) 'url': url,
      if (location != null) 'location': location,
      if (time != null) 'time': time,
      if (date != null) 'date': date,
      if (organizer != null) 'organizer': organizer,
      if (imageUrl != null) 'image_url': imageUrl,
      if (numberOfAttendees != null) 'number_of_attendees': numberOfAttendees,
      if (organizerId != null) 'organizer_id': organizerId,
      if (genre != null) 'genre': genre,
      if (poster != null) 'poster': poster,
      if (banner != null) 'banner': banner,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String>? description,
    Value<String>? url,
    Value<String>? location,
    Value<String>? time,
    Value<String>? date,
    Value<String>? organizer,
    Value<String>? imageUrl,
    Value<int>? numberOfAttendees,
    Value<String>? organizerId,
    Value<String>? genre,
    Value<String?>? poster,
    Value<String?>? banner,
    Value<int>? rowid,
  }) {
    return EventTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      location: location ?? this.location,
      time: time ?? this.time,
      date: date ?? this.date,
      organizer: organizer ?? this.organizer,
      imageUrl: imageUrl ?? this.imageUrl,
      numberOfAttendees: numberOfAttendees ?? this.numberOfAttendees,
      organizerId: organizerId ?? this.organizerId,
      genre: genre ?? this.genre,
      poster: poster ?? this.poster,
      banner: banner ?? this.banner,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (organizer.present) {
      map['organizer'] = Variable<String>(organizer.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (numberOfAttendees.present) {
      map['number_of_attendees'] = Variable<int>(numberOfAttendees.value);
    }
    if (organizerId.present) {
      map['organizer_id'] = Variable<String>(organizerId.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (poster.present) {
      map['poster'] = Variable<String>(poster.value);
    }
    if (banner.present) {
      map['banner'] = Variable<String>(banner.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('location: $location, ')
          ..write('time: $time, ')
          ..write('date: $date, ')
          ..write('organizer: $organizer, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('numberOfAttendees: $numberOfAttendees, ')
          ..write('organizerId: $organizerId, ')
          ..write('genre: $genre, ')
          ..write('poster: $poster, ')
          ..write('banner: $banner, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendeeTableTable extends AttendeeTable
    with TableInfo<$AttendeeTableTable, AttendeeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendeeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES event_table (id)',
    ),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    firstName,
    middleName,
    lastName,
    eventId,
    email,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendee_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendeeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendeeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendeeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
    );
  }

  @override
  $AttendeeTableTable createAlias(String alias) {
    return $AttendeeTableTable(attachedDatabase, alias);
  }
}

class AttendeeData extends DataClass implements Insertable<AttendeeData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String eventId;
  final String email;
  const AttendeeData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.eventId,
    required this.email,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || middleName != null) {
      map['middle_name'] = Variable<String>(middleName);
    }
    map['last_name'] = Variable<String>(lastName);
    map['event_id'] = Variable<String>(eventId);
    map['email'] = Variable<String>(email);
    return map;
  }

  AttendeeTableCompanion toCompanion(bool nullToAbsent) {
    return AttendeeTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      firstName: Value(firstName),
      middleName: middleName == null && nullToAbsent
          ? const Value.absent()
          : Value(middleName),
      lastName: Value(lastName),
      eventId: Value(eventId),
      email: Value(email),
    );
  }

  factory AttendeeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendeeData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      firstName: serializer.fromJson<String>(json['first_name']),
      middleName: serializer.fromJson<String?>(json['middle_name']),
      lastName: serializer.fromJson<String>(json['last_name']),
      eventId: serializer.fromJson<String>(json['event_id']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'first_name': serializer.toJson<String>(firstName),
      'middle_name': serializer.toJson<String?>(middleName),
      'last_name': serializer.toJson<String>(lastName),
      'event_id': serializer.toJson<String>(eventId),
      'email': serializer.toJson<String>(email),
    };
  }

  AttendeeData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    Value<String?> middleName = const Value.absent(),
    String? lastName,
    String? eventId,
    String? email,
  }) => AttendeeData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    firstName: firstName ?? this.firstName,
    middleName: middleName.present ? middleName.value : this.middleName,
    lastName: lastName ?? this.lastName,
    eventId: eventId ?? this.eventId,
    email: email ?? this.email,
  );
  AttendeeData copyWithCompanion(AttendeeTableCompanion data) {
    return AttendeeData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      email: data.email.present ? data.email.value : this.email,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendeeData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('eventId: $eventId, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    firstName,
    middleName,
    lastName,
    eventId,
    email,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendeeData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.eventId == this.eventId &&
          other.email == this.email);
}

class AttendeeTableCompanion extends UpdateCompanion<AttendeeData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> firstName;
  final Value<String?> middleName;
  final Value<String> lastName;
  final Value<String> eventId;
  final Value<String> email;
  final Value<int> rowid;
  const AttendeeTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.eventId = const Value.absent(),
    this.email = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendeeTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String firstName,
    this.middleName = const Value.absent(),
    required String lastName,
    required String eventId,
    required String email,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firstName = Value(firstName),
       lastName = Value(lastName),
       eventId = Value(eventId),
       email = Value(email);
  static Insertable<AttendeeData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? eventId,
    Expression<String>? email,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (eventId != null) 'event_id': eventId,
      if (email != null) 'email': email,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendeeTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? firstName,
    Value<String?>? middleName,
    Value<String>? lastName,
    Value<String>? eventId,
    Value<String>? email,
    Value<int>? rowid,
  }) {
    return AttendeeTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      eventId: eventId ?? this.eventId,
      email: email ?? this.email,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendeeTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('eventId: $eventId, ')
          ..write('email: $email, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TicketTableTable extends TicketTable
    with TableInfo<$TicketTableTable, TicketData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  static const VerificationMeta _attendeeIdMeta = const VerificationMeta(
    'attendeeId',
  );
  @override
  late final GeneratedColumn<String> attendeeId = GeneratedColumn<String>(
    'attendee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES attendee_table (id)',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES event_table (id)',
    ),
  );
  static const VerificationMeta _paymentCodeMeta = const VerificationMeta(
    'paymentCode',
  );
  @override
  late final GeneratedColumn<String> paymentCode = GeneratedColumn<String>(
    'payment_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    attendeeId,
    eventId,
    paymentCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ticket_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TicketData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('attendee_id')) {
      context.handle(
        _attendeeIdMeta,
        attendeeId.isAcceptableOrUnknown(data['attendee_id']!, _attendeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_attendeeIdMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('payment_code')) {
      context.handle(
        _paymentCodeMeta,
        paymentCode.isAcceptableOrUnknown(
          data['payment_code']!,
          _paymentCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TicketData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TicketData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      attendeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendee_id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      paymentCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_code'],
      )!,
    );
  }

  @override
  $TicketTableTable createAlias(String alias) {
    return $TicketTableTable(attachedDatabase, alias);
  }
}

class TicketData extends DataClass implements Insertable<TicketData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String attendeeId;
  final String eventId;
  final String paymentCode;
  const TicketData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.attendeeId,
    required this.eventId,
    required this.paymentCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['attendee_id'] = Variable<String>(attendeeId);
    map['event_id'] = Variable<String>(eventId);
    map['payment_code'] = Variable<String>(paymentCode);
    return map;
  }

  TicketTableCompanion toCompanion(bool nullToAbsent) {
    return TicketTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      attendeeId: Value(attendeeId),
      eventId: Value(eventId),
      paymentCode: Value(paymentCode),
    );
  }

  factory TicketData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TicketData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      attendeeId: serializer.fromJson<String>(json['attendee_id']),
      eventId: serializer.fromJson<String>(json['event_id']),
      paymentCode: serializer.fromJson<String>(json['payment_code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'attendee_id': serializer.toJson<String>(attendeeId),
      'event_id': serializer.toJson<String>(eventId),
      'payment_code': serializer.toJson<String>(paymentCode),
    };
  }

  TicketData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? attendeeId,
    String? eventId,
    String? paymentCode,
  }) => TicketData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    attendeeId: attendeeId ?? this.attendeeId,
    eventId: eventId ?? this.eventId,
    paymentCode: paymentCode ?? this.paymentCode,
  );
  TicketData copyWithCompanion(TicketTableCompanion data) {
    return TicketData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      attendeeId: data.attendeeId.present
          ? data.attendeeId.value
          : this.attendeeId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      paymentCode: data.paymentCode.present
          ? data.paymentCode.value
          : this.paymentCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TicketData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('attendeeId: $attendeeId, ')
          ..write('eventId: $eventId, ')
          ..write('paymentCode: $paymentCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, attendeeId, eventId, paymentCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TicketData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.attendeeId == this.attendeeId &&
          other.eventId == this.eventId &&
          other.paymentCode == this.paymentCode);
}

class TicketTableCompanion extends UpdateCompanion<TicketData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> attendeeId;
  final Value<String> eventId;
  final Value<String> paymentCode;
  final Value<int> rowid;
  const TicketTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.attendeeId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.paymentCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TicketTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String attendeeId,
    required String eventId,
    required String paymentCode,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       attendeeId = Value(attendeeId),
       eventId = Value(eventId),
       paymentCode = Value(paymentCode);
  static Insertable<TicketData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? attendeeId,
    Expression<String>? eventId,
    Expression<String>? paymentCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (attendeeId != null) 'attendee_id': attendeeId,
      if (eventId != null) 'event_id': eventId,
      if (paymentCode != null) 'payment_code': paymentCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TicketTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? attendeeId,
    Value<String>? eventId,
    Value<String>? paymentCode,
    Value<int>? rowid,
  }) {
    return TicketTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attendeeId: attendeeId ?? this.attendeeId,
      eventId: eventId ?? this.eventId,
      paymentCode: paymentCode ?? this.paymentCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (attendeeId.present) {
      map['attendee_id'] = Variable<String>(attendeeId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (paymentCode.present) {
      map['payment_code'] = Variable<String>(paymentCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('attendeeId: $attendeeId, ')
          ..write('eventId: $eventId, ')
          ..write('paymentCode: $paymentCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgendaEventTable extends AgendaEvent
    with TableInfo<$AgendaEventTable, AgendaEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgendaEventTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _htmlLinkMeta = const VerificationMeta(
    'htmlLink',
  );
  @override
  late final GeneratedColumn<String> htmlLink = GeneratedColumn<String>(
    'html_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calendarIdMeta = const VerificationMeta(
    'calendarId',
  );
  @override
  late final GeneratedColumn<String> calendarId = GeneratedColumn<String>(
    'calendar_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transparencyMeta = const VerificationMeta(
    'transparency',
  );
  @override
  late final GeneratedColumn<String> transparency = GeneratedColumn<String>(
    'transparency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  @override
  late final GeneratedColumn<DateTime> updated = GeneratedColumn<DateTime>(
    'updated',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  attendees = GeneratedColumn<String>(
    'attendees',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<dynamic>?>($AgendaEventTable.$converterattendeesn);
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  recurrence = GeneratedColumn<String>(
    'recurrence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<dynamic>?>($AgendaEventTable.$converterrecurrencen);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  reminders =
      GeneratedColumn<String>(
        'reminders',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Map<String, dynamic>?>(
        $AgendaEventTable.$converterremindersn,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    allDay,
    summary,
    description,
    location,
    htmlLink,
    calendarId,
    ownerId,
    timezone,
    status,
    transparency,
    etag,
    created,
    updated,
    startTime,
    endTime,
    attendees,
    recurrence,
    reminders,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agenda_event';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgendaEventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('html_link')) {
      context.handle(
        _htmlLinkMeta,
        htmlLink.isAcceptableOrUnknown(data['html_link']!, _htmlLinkMeta),
      );
    }
    if (data.containsKey('calendar_id')) {
      context.handle(
        _calendarIdMeta,
        calendarId.isAcceptableOrUnknown(data['calendar_id']!, _calendarIdMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('transparency')) {
      context.handle(
        _transparencyMeta,
        transparency.isAcceptableOrUnknown(
          data['transparency']!,
          _transparencyMeta,
        ),
      );
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgendaEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgendaEventData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      htmlLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}html_link'],
      ),
      calendarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calendar_id'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      transparency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transparency'],
      ),
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      ),
      updated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      attendees: $AgendaEventTable.$converterattendeesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}attendees'],
        ),
      ),
      recurrence: $AgendaEventTable.$converterrecurrencen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}recurrence'],
        ),
      ),
      reminders: $AgendaEventTable.$converterremindersn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminders'],
        ),
      ),
    );
  }

  @override
  $AgendaEventTable createAlias(String alias) {
    return $AgendaEventTable(attachedDatabase, alias);
  }

  static TypeConverter<List<dynamic>, String> $converterattendees =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterattendeesn =
      NullAwareTypeConverter.wrap($converterattendees);
  static TypeConverter<List<dynamic>, String> $converterrecurrence =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterrecurrencen =
      NullAwareTypeConverter.wrap($converterrecurrence);
  static TypeConverter<Map<String, dynamic>, String> $converterreminders =
      const JsonConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converterremindersn =
      NullAwareTypeConverter.wrap($converterreminders);
}

class AgendaEventData extends DataClass implements Insertable<AgendaEventData> {
  final String id;
  final bool allDay;
  final String? summary;
  final String? description;
  final String? location;
  final String? htmlLink;
  final String? calendarId;
  final String? ownerId;
  final String? timezone;
  final String? status;
  final String? transparency;
  final String? etag;
  final DateTime? created;
  final DateTime? updated;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<dynamic>? attendees;
  final List<dynamic>? recurrence;
  final Map<String, dynamic>? reminders;
  const AgendaEventData({
    required this.id,
    required this.allDay,
    this.summary,
    this.description,
    this.location,
    this.htmlLink,
    this.calendarId,
    this.ownerId,
    this.timezone,
    this.status,
    this.transparency,
    this.etag,
    this.created,
    this.updated,
    this.startTime,
    this.endTime,
    this.attendees,
    this.recurrence,
    this.reminders,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['all_day'] = Variable<bool>(allDay);
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || htmlLink != null) {
      map['html_link'] = Variable<String>(htmlLink);
    }
    if (!nullToAbsent || calendarId != null) {
      map['calendar_id'] = Variable<String>(calendarId);
    }
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || transparency != null) {
      map['transparency'] = Variable<String>(transparency);
    }
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<DateTime>(created);
    }
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime>(updated);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || attendees != null) {
      map['attendees'] = Variable<String>(
        $AgendaEventTable.$converterattendeesn.toSql(attendees),
      );
    }
    if (!nullToAbsent || recurrence != null) {
      map['recurrence'] = Variable<String>(
        $AgendaEventTable.$converterrecurrencen.toSql(recurrence),
      );
    }
    if (!nullToAbsent || reminders != null) {
      map['reminders'] = Variable<String>(
        $AgendaEventTable.$converterremindersn.toSql(reminders),
      );
    }
    return map;
  }

  AgendaEventCompanion toCompanion(bool nullToAbsent) {
    return AgendaEventCompanion(
      id: Value(id),
      allDay: Value(allDay),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      htmlLink: htmlLink == null && nullToAbsent
          ? const Value.absent()
          : Value(htmlLink),
      calendarId: calendarId == null && nullToAbsent
          ? const Value.absent()
          : Value(calendarId),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      transparency: transparency == null && nullToAbsent
          ? const Value.absent()
          : Value(transparency),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      attendees: attendees == null && nullToAbsent
          ? const Value.absent()
          : Value(attendees),
      recurrence: recurrence == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrence),
      reminders: reminders == null && nullToAbsent
          ? const Value.absent()
          : Value(reminders),
    );
  }

  factory AgendaEventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgendaEventData(
      id: serializer.fromJson<String>(json['id']),
      allDay: serializer.fromJson<bool>(json['all_day']),
      summary: serializer.fromJson<String?>(json['summary']),
      description: serializer.fromJson<String?>(json['description']),
      location: serializer.fromJson<String?>(json['location']),
      htmlLink: serializer.fromJson<String?>(json['html_link']),
      calendarId: serializer.fromJson<String?>(json['calendar_id']),
      ownerId: serializer.fromJson<String?>(json['owner_id']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      status: serializer.fromJson<String?>(json['status']),
      transparency: serializer.fromJson<String?>(json['transparency']),
      etag: serializer.fromJson<String?>(json['etag']),
      created: serializer.fromJson<DateTime?>(json['created']),
      updated: serializer.fromJson<DateTime?>(json['updated']),
      startTime: serializer.fromJson<DateTime?>(json['start_time']),
      endTime: serializer.fromJson<DateTime?>(json['end_time']),
      attendees: serializer.fromJson<List<dynamic>?>(json['attendees']),
      recurrence: serializer.fromJson<List<dynamic>?>(json['recurrence']),
      reminders: serializer.fromJson<Map<String, dynamic>?>(json['reminders']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'all_day': serializer.toJson<bool>(allDay),
      'summary': serializer.toJson<String?>(summary),
      'description': serializer.toJson<String?>(description),
      'location': serializer.toJson<String?>(location),
      'html_link': serializer.toJson<String?>(htmlLink),
      'calendar_id': serializer.toJson<String?>(calendarId),
      'owner_id': serializer.toJson<String?>(ownerId),
      'timezone': serializer.toJson<String?>(timezone),
      'status': serializer.toJson<String?>(status),
      'transparency': serializer.toJson<String?>(transparency),
      'etag': serializer.toJson<String?>(etag),
      'created': serializer.toJson<DateTime?>(created),
      'updated': serializer.toJson<DateTime?>(updated),
      'start_time': serializer.toJson<DateTime?>(startTime),
      'end_time': serializer.toJson<DateTime?>(endTime),
      'attendees': serializer.toJson<List<dynamic>?>(attendees),
      'recurrence': serializer.toJson<List<dynamic>?>(recurrence),
      'reminders': serializer.toJson<Map<String, dynamic>?>(reminders),
    };
  }

  AgendaEventData copyWith({
    String? id,
    bool? allDay,
    Value<String?> summary = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> htmlLink = const Value.absent(),
    Value<String?> calendarId = const Value.absent(),
    Value<String?> ownerId = const Value.absent(),
    Value<String?> timezone = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<String?> transparency = const Value.absent(),
    Value<String?> etag = const Value.absent(),
    Value<DateTime?> created = const Value.absent(),
    Value<DateTime?> updated = const Value.absent(),
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    Value<List<dynamic>?> attendees = const Value.absent(),
    Value<List<dynamic>?> recurrence = const Value.absent(),
    Value<Map<String, dynamic>?> reminders = const Value.absent(),
  }) => AgendaEventData(
    id: id ?? this.id,
    allDay: allDay ?? this.allDay,
    summary: summary.present ? summary.value : this.summary,
    description: description.present ? description.value : this.description,
    location: location.present ? location.value : this.location,
    htmlLink: htmlLink.present ? htmlLink.value : this.htmlLink,
    calendarId: calendarId.present ? calendarId.value : this.calendarId,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
    timezone: timezone.present ? timezone.value : this.timezone,
    status: status.present ? status.value : this.status,
    transparency: transparency.present ? transparency.value : this.transparency,
    etag: etag.present ? etag.value : this.etag,
    created: created.present ? created.value : this.created,
    updated: updated.present ? updated.value : this.updated,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    attendees: attendees.present ? attendees.value : this.attendees,
    recurrence: recurrence.present ? recurrence.value : this.recurrence,
    reminders: reminders.present ? reminders.value : this.reminders,
  );
  AgendaEventData copyWithCompanion(AgendaEventCompanion data) {
    return AgendaEventData(
      id: data.id.present ? data.id.value : this.id,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      summary: data.summary.present ? data.summary.value : this.summary,
      description: data.description.present
          ? data.description.value
          : this.description,
      location: data.location.present ? data.location.value : this.location,
      htmlLink: data.htmlLink.present ? data.htmlLink.value : this.htmlLink,
      calendarId: data.calendarId.present
          ? data.calendarId.value
          : this.calendarId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      status: data.status.present ? data.status.value : this.status,
      transparency: data.transparency.present
          ? data.transparency.value
          : this.transparency,
      etag: data.etag.present ? data.etag.value : this.etag,
      created: data.created.present ? data.created.value : this.created,
      updated: data.updated.present ? data.updated.value : this.updated,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      attendees: data.attendees.present ? data.attendees.value : this.attendees,
      recurrence: data.recurrence.present
          ? data.recurrence.value
          : this.recurrence,
      reminders: data.reminders.present ? data.reminders.value : this.reminders,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgendaEventData(')
          ..write('id: $id, ')
          ..write('allDay: $allDay, ')
          ..write('summary: $summary, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('htmlLink: $htmlLink, ')
          ..write('calendarId: $calendarId, ')
          ..write('ownerId: $ownerId, ')
          ..write('timezone: $timezone, ')
          ..write('status: $status, ')
          ..write('transparency: $transparency, ')
          ..write('etag: $etag, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('attendees: $attendees, ')
          ..write('recurrence: $recurrence, ')
          ..write('reminders: $reminders')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    allDay,
    summary,
    description,
    location,
    htmlLink,
    calendarId,
    ownerId,
    timezone,
    status,
    transparency,
    etag,
    created,
    updated,
    startTime,
    endTime,
    attendees,
    recurrence,
    reminders,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgendaEventData &&
          other.id == this.id &&
          other.allDay == this.allDay &&
          other.summary == this.summary &&
          other.description == this.description &&
          other.location == this.location &&
          other.htmlLink == this.htmlLink &&
          other.calendarId == this.calendarId &&
          other.ownerId == this.ownerId &&
          other.timezone == this.timezone &&
          other.status == this.status &&
          other.transparency == this.transparency &&
          other.etag == this.etag &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.attendees == this.attendees &&
          other.recurrence == this.recurrence &&
          other.reminders == this.reminders);
}

class AgendaEventCompanion extends UpdateCompanion<AgendaEventData> {
  final Value<String> id;
  final Value<bool> allDay;
  final Value<String?> summary;
  final Value<String?> description;
  final Value<String?> location;
  final Value<String?> htmlLink;
  final Value<String?> calendarId;
  final Value<String?> ownerId;
  final Value<String?> timezone;
  final Value<String?> status;
  final Value<String?> transparency;
  final Value<String?> etag;
  final Value<DateTime?> created;
  final Value<DateTime?> updated;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<List<dynamic>?> attendees;
  final Value<List<dynamic>?> recurrence;
  final Value<Map<String, dynamic>?> reminders;
  final Value<int> rowid;
  const AgendaEventCompanion({
    this.id = const Value.absent(),
    this.allDay = const Value.absent(),
    this.summary = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.htmlLink = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.timezone = const Value.absent(),
    this.status = const Value.absent(),
    this.transparency = const Value.absent(),
    this.etag = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.attendees = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.reminders = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgendaEventCompanion.insert({
    required String id,
    this.allDay = const Value.absent(),
    this.summary = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.htmlLink = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.timezone = const Value.absent(),
    this.status = const Value.absent(),
    this.transparency = const Value.absent(),
    this.etag = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.attendees = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.reminders = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AgendaEventData> custom({
    Expression<String>? id,
    Expression<bool>? allDay,
    Expression<String>? summary,
    Expression<String>? description,
    Expression<String>? location,
    Expression<String>? htmlLink,
    Expression<String>? calendarId,
    Expression<String>? ownerId,
    Expression<String>? timezone,
    Expression<String>? status,
    Expression<String>? transparency,
    Expression<String>? etag,
    Expression<DateTime>? created,
    Expression<DateTime>? updated,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? attendees,
    Expression<String>? recurrence,
    Expression<String>? reminders,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (allDay != null) 'all_day': allDay,
      if (summary != null) 'summary': summary,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (htmlLink != null) 'html_link': htmlLink,
      if (calendarId != null) 'calendar_id': calendarId,
      if (ownerId != null) 'owner_id': ownerId,
      if (timezone != null) 'timezone': timezone,
      if (status != null) 'status': status,
      if (transparency != null) 'transparency': transparency,
      if (etag != null) 'etag': etag,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (attendees != null) 'attendees': attendees,
      if (recurrence != null) 'recurrence': recurrence,
      if (reminders != null) 'reminders': reminders,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgendaEventCompanion copyWith({
    Value<String>? id,
    Value<bool>? allDay,
    Value<String?>? summary,
    Value<String?>? description,
    Value<String?>? location,
    Value<String?>? htmlLink,
    Value<String?>? calendarId,
    Value<String?>? ownerId,
    Value<String?>? timezone,
    Value<String?>? status,
    Value<String?>? transparency,
    Value<String?>? etag,
    Value<DateTime?>? created,
    Value<DateTime?>? updated,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
    Value<List<dynamic>?>? attendees,
    Value<List<dynamic>?>? recurrence,
    Value<Map<String, dynamic>?>? reminders,
    Value<int>? rowid,
  }) {
    return AgendaEventCompanion(
      id: id ?? this.id,
      allDay: allDay ?? this.allDay,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      location: location ?? this.location,
      htmlLink: htmlLink ?? this.htmlLink,
      calendarId: calendarId ?? this.calendarId,
      ownerId: ownerId ?? this.ownerId,
      timezone: timezone ?? this.timezone,
      status: status ?? this.status,
      transparency: transparency ?? this.transparency,
      etag: etag ?? this.etag,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendees: attendees ?? this.attendees,
      recurrence: recurrence ?? this.recurrence,
      reminders: reminders ?? this.reminders,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (htmlLink.present) {
      map['html_link'] = Variable<String>(htmlLink.value);
    }
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (transparency.present) {
      map['transparency'] = Variable<String>(transparency.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (attendees.present) {
      map['attendees'] = Variable<String>(
        $AgendaEventTable.$converterattendeesn.toSql(attendees.value),
      );
    }
    if (recurrence.present) {
      map['recurrence'] = Variable<String>(
        $AgendaEventTable.$converterrecurrencen.toSql(recurrence.value),
      );
    }
    if (reminders.present) {
      map['reminders'] = Variable<String>(
        $AgendaEventTable.$converterremindersn.toSql(reminders.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgendaEventCompanion(')
          ..write('id: $id, ')
          ..write('allDay: $allDay, ')
          ..write('summary: $summary, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('htmlLink: $htmlLink, ')
          ..write('calendarId: $calendarId, ')
          ..write('ownerId: $ownerId, ')
          ..write('timezone: $timezone, ')
          ..write('status: $status, ')
          ..write('transparency: $transparency, ')
          ..write('etag: $etag, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('attendees: $attendees, ')
          ..write('recurrence: $recurrence, ')
          ..write('reminders: $reminders, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationTableTable extends NotificationTable
    with TableInfo<$NotificationTableTable, NotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  data =
      GeneratedColumn<String>(
        'data',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Map<String, dynamic>?>(
        $NotificationTableTable.$converterdatan,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionUrlMeta = const VerificationMeta(
    'actionUrl',
  );
  @override
  late final GeneratedColumn<String> actionUrl = GeneratedColumn<String>(
    'action_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    body,
    imageUrl,
    data,
    createdAt,
    isRead,
    category,
    actionUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('action_url')) {
      context.handle(
        _actionUrlMeta,
        actionUrl.isAcceptableOrUnknown(data['action_url']!, _actionUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      data: $NotificationTableTable.$converterdatan.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      actionUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_url'],
      ),
    );
  }

  @override
  $NotificationTableTable createAlias(String alias) {
    return $NotificationTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterdata =
      const JsonConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converterdatan =
      NullAwareTypeConverter.wrap($converterdata);
}

class NotificationTableData extends DataClass
    implements Insertable<NotificationTableData> {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final bool isRead;
  final String? category;
  final String? actionUrl;
  const NotificationTableData({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    this.data,
    required this.createdAt,
    required this.isRead,
    this.category,
    this.actionUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String>(
        $NotificationTableTable.$converterdatan.toSql(data),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || actionUrl != null) {
      map['action_url'] = Variable<String>(actionUrl);
    }
    return map;
  }

  NotificationTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationTableCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      createdAt: Value(createdAt),
      isRead: Value(isRead),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      actionUrl: actionUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(actionUrl),
    );
  }

  factory NotificationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      data: serializer.fromJson<Map<String, dynamic>?>(json['data']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      category: serializer.fromJson<String?>(json['category']),
      actionUrl: serializer.fromJson<String?>(json['actionUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'data': serializer.toJson<Map<String, dynamic>?>(data),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isRead': serializer.toJson<bool>(isRead),
      'category': serializer.toJson<String?>(category),
      'actionUrl': serializer.toJson<String?>(actionUrl),
    };
  }

  NotificationTableData copyWith({
    String? id,
    String? title,
    String? body,
    Value<String?> imageUrl = const Value.absent(),
    Value<Map<String, dynamic>?> data = const Value.absent(),
    DateTime? createdAt,
    bool? isRead,
    Value<String?> category = const Value.absent(),
    Value<String?> actionUrl = const Value.absent(),
  }) => NotificationTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    data: data.present ? data.value : this.data,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    category: category.present ? category.value : this.category,
    actionUrl: actionUrl.present ? actionUrl.value : this.actionUrl,
  );
  NotificationTableData copyWithCompanion(NotificationTableCompanion data) {
    return NotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      data: data.data.present ? data.data.value : this.data,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      category: data.category.present ? data.category.value : this.category,
      actionUrl: data.actionUrl.present ? data.actionUrl.value : this.actionUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('isRead: $isRead, ')
          ..write('category: $category, ')
          ..write('actionUrl: $actionUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    body,
    imageUrl,
    data,
    createdAt,
    isRead,
    category,
    actionUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.imageUrl == this.imageUrl &&
          other.data == this.data &&
          other.createdAt == this.createdAt &&
          other.isRead == this.isRead &&
          other.category == this.category &&
          other.actionUrl == this.actionUrl);
}

class NotificationTableCompanion
    extends UpdateCompanion<NotificationTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> imageUrl;
  final Value<Map<String, dynamic>?> data;
  final Value<DateTime> createdAt;
  final Value<bool> isRead;
  final Value<String?> category;
  final Value<String?> actionUrl;
  final Value<int> rowid;
  const NotificationTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.data = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isRead = const Value.absent(),
    this.category = const Value.absent(),
    this.actionUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationTableCompanion.insert({
    required String id,
    required String title,
    required String body,
    this.imageUrl = const Value.absent(),
    this.data = const Value.absent(),
    required DateTime createdAt,
    this.isRead = const Value.absent(),
    this.category = const Value.absent(),
    this.actionUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<NotificationTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? imageUrl,
    Expression<String>? data,
    Expression<DateTime>? createdAt,
    Expression<bool>? isRead,
    Expression<String>? category,
    Expression<String>? actionUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (imageUrl != null) 'image_url': imageUrl,
      if (data != null) 'data': data,
      if (createdAt != null) 'created_at': createdAt,
      if (isRead != null) 'is_read': isRead,
      if (category != null) 'category': category,
      if (actionUrl != null) 'action_url': actionUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? imageUrl,
    Value<Map<String, dynamic>?>? data,
    Value<DateTime>? createdAt,
    Value<bool>? isRead,
    Value<String?>? category,
    Value<String?>? actionUrl,
    Value<int>? rowid,
  }) {
    return NotificationTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      category: category ?? this.category,
      actionUrl: actionUrl ?? this.actionUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $NotificationTableTable.$converterdatan.toSql(data.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (actionUrl.present) {
      map['action_url'] = Variable<String>(actionUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('isRead: $isRead, ')
          ..write('category: $category, ')
          ..write('actionUrl: $actionUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstitutionTable extends Institution
    with TableInfo<$InstitutionTable, InstitutionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstitutionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _institutionIdMeta = const VerificationMeta(
    'institutionId',
  );
  @override
  late final GeneratedColumn<int> institutionId = GeneratedColumn<int>(
    'institution_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> webPages =
      GeneratedColumn<String>(
        'web_pages',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<dynamic>?>($InstitutionTable.$converterwebPagesn);
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> domains =
      GeneratedColumn<String>(
        'domains',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<dynamic>?>($InstitutionTable.$converterdomainsn);
  static const VerificationMeta _alphaTwoCodeMeta = const VerificationMeta(
    'alphaTwoCode',
  );
  @override
  late final GeneratedColumn<String> alphaTwoCode = GeneratedColumn<String>(
    'alpha_two_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateProvinceMeta = const VerificationMeta(
    'stateProvince',
  );
  @override
  late final GeneratedColumn<String> stateProvince = GeneratedColumn<String>(
    'state_province',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    institutionId,
    name,
    webPages,
    domains,
    alphaTwoCode,
    country,
    stateProvince,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'institution';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstitutionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('institution_id')) {
      context.handle(
        _institutionIdMeta,
        institutionId.isAcceptableOrUnknown(
          data['institution_id']!,
          _institutionIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('alpha_two_code')) {
      context.handle(
        _alphaTwoCodeMeta,
        alphaTwoCode.isAcceptableOrUnknown(
          data['alpha_two_code']!,
          _alphaTwoCodeMeta,
        ),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('state_province')) {
      context.handle(
        _stateProvinceMeta,
        stateProvince.isAcceptableOrUnknown(
          data['state_province']!,
          _stateProvinceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {institutionId};
  @override
  InstitutionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstitutionData(
      institutionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institution_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      webPages: $InstitutionTable.$converterwebPagesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}web_pages'],
        ),
      ),
      domains: $InstitutionTable.$converterdomainsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}domains'],
        ),
      ),
      alphaTwoCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alpha_two_code'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      stateProvince: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_province'],
      ),
    );
  }

  @override
  $InstitutionTable createAlias(String alias) {
    return $InstitutionTable(attachedDatabase, alias);
  }

  static TypeConverter<List<dynamic>, String> $converterwebPages =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterwebPagesn =
      NullAwareTypeConverter.wrap($converterwebPages);
  static TypeConverter<List<dynamic>, String> $converterdomains =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterdomainsn =
      NullAwareTypeConverter.wrap($converterdomains);
}

class InstitutionData extends DataClass implements Insertable<InstitutionData> {
  final int institutionId;
  final String name;
  final List<dynamic>? webPages;
  final List<dynamic>? domains;
  final String? alphaTwoCode;
  final String? country;
  final String? stateProvince;
  const InstitutionData({
    required this.institutionId,
    required this.name,
    this.webPages,
    this.domains,
    this.alphaTwoCode,
    this.country,
    this.stateProvince,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['institution_id'] = Variable<int>(institutionId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || webPages != null) {
      map['web_pages'] = Variable<String>(
        $InstitutionTable.$converterwebPagesn.toSql(webPages),
      );
    }
    if (!nullToAbsent || domains != null) {
      map['domains'] = Variable<String>(
        $InstitutionTable.$converterdomainsn.toSql(domains),
      );
    }
    if (!nullToAbsent || alphaTwoCode != null) {
      map['alpha_two_code'] = Variable<String>(alphaTwoCode);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || stateProvince != null) {
      map['state_province'] = Variable<String>(stateProvince);
    }
    return map;
  }

  InstitutionCompanion toCompanion(bool nullToAbsent) {
    return InstitutionCompanion(
      institutionId: Value(institutionId),
      name: Value(name),
      webPages: webPages == null && nullToAbsent
          ? const Value.absent()
          : Value(webPages),
      domains: domains == null && nullToAbsent
          ? const Value.absent()
          : Value(domains),
      alphaTwoCode: alphaTwoCode == null && nullToAbsent
          ? const Value.absent()
          : Value(alphaTwoCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      stateProvince: stateProvince == null && nullToAbsent
          ? const Value.absent()
          : Value(stateProvince),
    );
  }

  factory InstitutionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstitutionData(
      institutionId: serializer.fromJson<int>(json['institution_id']),
      name: serializer.fromJson<String>(json['name']),
      webPages: serializer.fromJson<List<dynamic>?>(json['web_pages']),
      domains: serializer.fromJson<List<dynamic>?>(json['domains']),
      alphaTwoCode: serializer.fromJson<String?>(json['alpha_two_code']),
      country: serializer.fromJson<String?>(json['country']),
      stateProvince: serializer.fromJson<String?>(json['state_province']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'institution_id': serializer.toJson<int>(institutionId),
      'name': serializer.toJson<String>(name),
      'web_pages': serializer.toJson<List<dynamic>?>(webPages),
      'domains': serializer.toJson<List<dynamic>?>(domains),
      'alpha_two_code': serializer.toJson<String?>(alphaTwoCode),
      'country': serializer.toJson<String?>(country),
      'state_province': serializer.toJson<String?>(stateProvince),
    };
  }

  InstitutionData copyWith({
    int? institutionId,
    String? name,
    Value<List<dynamic>?> webPages = const Value.absent(),
    Value<List<dynamic>?> domains = const Value.absent(),
    Value<String?> alphaTwoCode = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> stateProvince = const Value.absent(),
  }) => InstitutionData(
    institutionId: institutionId ?? this.institutionId,
    name: name ?? this.name,
    webPages: webPages.present ? webPages.value : this.webPages,
    domains: domains.present ? domains.value : this.domains,
    alphaTwoCode: alphaTwoCode.present ? alphaTwoCode.value : this.alphaTwoCode,
    country: country.present ? country.value : this.country,
    stateProvince: stateProvince.present
        ? stateProvince.value
        : this.stateProvince,
  );
  InstitutionData copyWithCompanion(InstitutionCompanion data) {
    return InstitutionData(
      institutionId: data.institutionId.present
          ? data.institutionId.value
          : this.institutionId,
      name: data.name.present ? data.name.value : this.name,
      webPages: data.webPages.present ? data.webPages.value : this.webPages,
      domains: data.domains.present ? data.domains.value : this.domains,
      alphaTwoCode: data.alphaTwoCode.present
          ? data.alphaTwoCode.value
          : this.alphaTwoCode,
      country: data.country.present ? data.country.value : this.country,
      stateProvince: data.stateProvince.present
          ? data.stateProvince.value
          : this.stateProvince,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstitutionData(')
          ..write('institutionId: $institutionId, ')
          ..write('name: $name, ')
          ..write('webPages: $webPages, ')
          ..write('domains: $domains, ')
          ..write('alphaTwoCode: $alphaTwoCode, ')
          ..write('country: $country, ')
          ..write('stateProvince: $stateProvince')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    institutionId,
    name,
    webPages,
    domains,
    alphaTwoCode,
    country,
    stateProvince,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstitutionData &&
          other.institutionId == this.institutionId &&
          other.name == this.name &&
          other.webPages == this.webPages &&
          other.domains == this.domains &&
          other.alphaTwoCode == this.alphaTwoCode &&
          other.country == this.country &&
          other.stateProvince == this.stateProvince);
}

class InstitutionCompanion extends UpdateCompanion<InstitutionData> {
  final Value<int> institutionId;
  final Value<String> name;
  final Value<List<dynamic>?> webPages;
  final Value<List<dynamic>?> domains;
  final Value<String?> alphaTwoCode;
  final Value<String?> country;
  final Value<String?> stateProvince;
  const InstitutionCompanion({
    this.institutionId = const Value.absent(),
    this.name = const Value.absent(),
    this.webPages = const Value.absent(),
    this.domains = const Value.absent(),
    this.alphaTwoCode = const Value.absent(),
    this.country = const Value.absent(),
    this.stateProvince = const Value.absent(),
  });
  InstitutionCompanion.insert({
    this.institutionId = const Value.absent(),
    required String name,
    this.webPages = const Value.absent(),
    this.domains = const Value.absent(),
    this.alphaTwoCode = const Value.absent(),
    this.country = const Value.absent(),
    this.stateProvince = const Value.absent(),
  }) : name = Value(name);
  static Insertable<InstitutionData> custom({
    Expression<int>? institutionId,
    Expression<String>? name,
    Expression<String>? webPages,
    Expression<String>? domains,
    Expression<String>? alphaTwoCode,
    Expression<String>? country,
    Expression<String>? stateProvince,
  }) {
    return RawValuesInsertable({
      if (institutionId != null) 'institution_id': institutionId,
      if (name != null) 'name': name,
      if (webPages != null) 'web_pages': webPages,
      if (domains != null) 'domains': domains,
      if (alphaTwoCode != null) 'alpha_two_code': alphaTwoCode,
      if (country != null) 'country': country,
      if (stateProvince != null) 'state_province': stateProvince,
    });
  }

  InstitutionCompanion copyWith({
    Value<int>? institutionId,
    Value<String>? name,
    Value<List<dynamic>?>? webPages,
    Value<List<dynamic>?>? domains,
    Value<String?>? alphaTwoCode,
    Value<String?>? country,
    Value<String?>? stateProvince,
  }) {
    return InstitutionCompanion(
      institutionId: institutionId ?? this.institutionId,
      name: name ?? this.name,
      webPages: webPages ?? this.webPages,
      domains: domains ?? this.domains,
      alphaTwoCode: alphaTwoCode ?? this.alphaTwoCode,
      country: country ?? this.country,
      stateProvince: stateProvince ?? this.stateProvince,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (institutionId.present) {
      map['institution_id'] = Variable<int>(institutionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (webPages.present) {
      map['web_pages'] = Variable<String>(
        $InstitutionTable.$converterwebPagesn.toSql(webPages.value),
      );
    }
    if (domains.present) {
      map['domains'] = Variable<String>(
        $InstitutionTable.$converterdomainsn.toSql(domains.value),
      );
    }
    if (alphaTwoCode.present) {
      map['alpha_two_code'] = Variable<String>(alphaTwoCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (stateProvince.present) {
      map['state_province'] = Variable<String>(stateProvince.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstitutionCompanion(')
          ..write('institutionId: $institutionId, ')
          ..write('name: $name, ')
          ..write('webPages: $webPages, ')
          ..write('domains: $domains, ')
          ..write('alphaTwoCode: $alphaTwoCode, ')
          ..write('country: $country, ')
          ..write('stateProvince: $stateProvince')
          ..write(')'))
        .toString();
  }
}

class $MagnetStudentProfileTable extends MagnetStudentProfile
    with TableInfo<$MagnetStudentProfileTable, MagnetStudentProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MagnetStudentProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
    'user_i_d',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionIDMeta = const VerificationMeta(
    'institutionID',
  );
  @override
  late final GeneratedColumn<int> institutionID = GeneratedColumn<int>(
    'institution_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _admissionNumberMeta = const VerificationMeta(
    'admissionNumber',
  );
  @override
  late final GeneratedColumn<String> admissionNumber = GeneratedColumn<String>(
    'admission_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherNamesMeta = const VerificationMeta(
    'otherNames',
  );
  @override
  late final GeneratedColumn<String> otherNames = GeneratedColumn<String>(
    'other_names',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profilePictureUrlMeta = const VerificationMeta(
    'profilePictureUrl',
  );
  @override
  late final GeneratedColumn<String> profilePictureUrl =
      GeneratedColumn<String>(
        'profile_picture_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
    'school',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _campusMeta = const VerificationMeta('campus');
  @override
  late final GeneratedColumn<String> campus = GeneratedColumn<String>(
    'campus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enrollmentStatusMeta = const VerificationMeta(
    'enrollmentStatus',
  );
  @override
  late final GeneratedColumn<String> enrollmentStatus = GeneratedColumn<String>(
    'enrollment_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _programmeMeta = const VerificationMeta(
    'programme',
  );
  @override
  late final GeneratedColumn<String> programme = GeneratedColumn<String>(
    'programme',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _degreeMeta = const VerificationMeta('degree');
  @override
  late final GeneratedColumn<String> degree = GeneratedColumn<String>(
    'degree',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _academicYearMeta = const VerificationMeta(
    'academicYear',
  );
  @override
  late final GeneratedColumn<int> academicYear = GeneratedColumn<int>(
    'academic_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpaMeta = const VerificationMeta('gpa');
  @override
  late final GeneratedColumn<double> gpa = GeneratedColumn<double>(
    'gpa',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emergencyContactMeta = const VerificationMeta(
    'emergencyContact',
  );
  @override
  late final GeneratedColumn<String> emergencyContact = GeneratedColumn<String>(
    'emergency_contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentNameMeta = const VerificationMeta(
    'parentName',
  );
  @override
  late final GeneratedColumn<String> parentName = GeneratedColumn<String>(
    'parent_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfAdmissionMeta = const VerificationMeta(
    'dateOfAdmission',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfAdmission =
      GeneratedColumn<DateTime>(
        'date_of_admission',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _graduationDateMeta = const VerificationMeta(
    'graduationDate',
  );
  @override
  late final GeneratedColumn<DateTime> graduationDate =
      GeneratedColumn<DateTime>(
        'graduation_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _disabilityStatusMeta = const VerificationMeta(
    'disabilityStatus',
  );
  @override
  late final GeneratedColumn<String> disabilityStatus = GeneratedColumn<String>(
    'disability_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isInternationalStudentMeta =
      const VerificationMeta('isInternationalStudent');
  @override
  late final GeneratedColumn<bool> isInternationalStudent =
      GeneratedColumn<bool>(
        'is_international_student',
        aliasedName,
        true,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_international_student" IN (0, 1))',
        ),
      );
  @override
  List<GeneratedColumn> get $columns => [
    userID,
    institutionID,
    admissionNumber,
    firstName,
    otherNames,
    nationalId,
    gender,
    address,
    email,
    phoneNumber,
    profilePictureUrl,
    dateOfBirth,
    school,
    campus,
    enrollmentStatus,
    programme,
    degree,
    academicYear,
    gpa,
    emergencyContact,
    parentName,
    dateOfAdmission,
    graduationDate,
    disabilityStatus,
    isInternationalStudent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'magnet_student_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<MagnetStudentProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('institution_i_d')) {
      context.handle(
        _institutionIDMeta,
        institutionID.isAcceptableOrUnknown(
          data['institution_i_d']!,
          _institutionIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionIDMeta);
    }
    if (data.containsKey('admission_number')) {
      context.handle(
        _admissionNumberMeta,
        admissionNumber.isAcceptableOrUnknown(
          data['admission_number']!,
          _admissionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_admissionNumberMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('other_names')) {
      context.handle(
        _otherNamesMeta,
        otherNames.isAcceptableOrUnknown(data['other_names']!, _otherNamesMeta),
      );
    } else if (isInserting) {
      context.missing(_otherNamesMeta);
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('profile_picture_url')) {
      context.handle(
        _profilePictureUrlMeta,
        profilePictureUrl.isAcceptableOrUnknown(
          data['profile_picture_url']!,
          _profilePictureUrlMeta,
        ),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('school')) {
      context.handle(
        _schoolMeta,
        school.isAcceptableOrUnknown(data['school']!, _schoolMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolMeta);
    }
    if (data.containsKey('campus')) {
      context.handle(
        _campusMeta,
        campus.isAcceptableOrUnknown(data['campus']!, _campusMeta),
      );
    }
    if (data.containsKey('enrollment_status')) {
      context.handle(
        _enrollmentStatusMeta,
        enrollmentStatus.isAcceptableOrUnknown(
          data['enrollment_status']!,
          _enrollmentStatusMeta,
        ),
      );
    }
    if (data.containsKey('programme')) {
      context.handle(
        _programmeMeta,
        programme.isAcceptableOrUnknown(data['programme']!, _programmeMeta),
      );
    }
    if (data.containsKey('degree')) {
      context.handle(
        _degreeMeta,
        degree.isAcceptableOrUnknown(data['degree']!, _degreeMeta),
      );
    }
    if (data.containsKey('academic_year')) {
      context.handle(
        _academicYearMeta,
        academicYear.isAcceptableOrUnknown(
          data['academic_year']!,
          _academicYearMeta,
        ),
      );
    }
    if (data.containsKey('gpa')) {
      context.handle(
        _gpaMeta,
        gpa.isAcceptableOrUnknown(data['gpa']!, _gpaMeta),
      );
    }
    if (data.containsKey('emergency_contact')) {
      context.handle(
        _emergencyContactMeta,
        emergencyContact.isAcceptableOrUnknown(
          data['emergency_contact']!,
          _emergencyContactMeta,
        ),
      );
    }
    if (data.containsKey('parent_name')) {
      context.handle(
        _parentNameMeta,
        parentName.isAcceptableOrUnknown(data['parent_name']!, _parentNameMeta),
      );
    }
    if (data.containsKey('date_of_admission')) {
      context.handle(
        _dateOfAdmissionMeta,
        dateOfAdmission.isAcceptableOrUnknown(
          data['date_of_admission']!,
          _dateOfAdmissionMeta,
        ),
      );
    }
    if (data.containsKey('graduation_date')) {
      context.handle(
        _graduationDateMeta,
        graduationDate.isAcceptableOrUnknown(
          data['graduation_date']!,
          _graduationDateMeta,
        ),
      );
    }
    if (data.containsKey('disability_status')) {
      context.handle(
        _disabilityStatusMeta,
        disabilityStatus.isAcceptableOrUnknown(
          data['disability_status']!,
          _disabilityStatusMeta,
        ),
      );
    }
    if (data.containsKey('is_international_student')) {
      context.handle(
        _isInternationalStudentMeta,
        isInternationalStudent.isAcceptableOrUnknown(
          data['is_international_student']!,
          _isInternationalStudentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    admissionNumber,
    institutionID,
    userID,
  };
  @override
  MagnetStudentProfileData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MagnetStudentProfileData(
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_i_d'],
      )!,
      institutionID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institution_i_d'],
      )!,
      admissionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admission_number'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      otherNames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_names'],
      )!,
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      profilePictureUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_picture_url'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      school: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school'],
      )!,
      campus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campus'],
      ),
      enrollmentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enrollment_status'],
      ),
      programme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}programme'],
      ),
      degree: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}degree'],
      ),
      academicYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_year'],
      ),
      gpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gpa'],
      ),
      emergencyContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact'],
      ),
      parentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_name'],
      ),
      dateOfAdmission: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_admission'],
      ),
      graduationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}graduation_date'],
      ),
      disabilityStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}disability_status'],
      ),
      isInternationalStudent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_international_student'],
      ),
    );
  }

  @override
  $MagnetStudentProfileTable createAlias(String alias) {
    return $MagnetStudentProfileTable(attachedDatabase, alias);
  }
}

class MagnetStudentProfileData extends DataClass
    implements Insertable<MagnetStudentProfileData> {
  final String userID;
  final int institutionID;
  final String admissionNumber;
  final String firstName;
  final String otherNames;
  final String? nationalId;
  final String? gender;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final DateTime? dateOfBirth;
  final String school;
  final String? campus;
  final String? enrollmentStatus;
  final String? programme;
  final String? degree;
  final int? academicYear;
  final double? gpa;
  final String? emergencyContact;
  final String? parentName;
  final DateTime? dateOfAdmission;
  final DateTime? graduationDate;
  final String? disabilityStatus;
  final bool? isInternationalStudent;
  const MagnetStudentProfileData({
    required this.userID,
    required this.institutionID,
    required this.admissionNumber,
    required this.firstName,
    required this.otherNames,
    this.nationalId,
    this.gender,
    this.address,
    this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    this.dateOfBirth,
    required this.school,
    this.campus,
    this.enrollmentStatus,
    this.programme,
    this.degree,
    this.academicYear,
    this.gpa,
    this.emergencyContact,
    this.parentName,
    this.dateOfAdmission,
    this.graduationDate,
    this.disabilityStatus,
    this.isInternationalStudent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_i_d'] = Variable<String>(userID);
    map['institution_i_d'] = Variable<int>(institutionID);
    map['admission_number'] = Variable<String>(admissionNumber);
    map['first_name'] = Variable<String>(firstName);
    map['other_names'] = Variable<String>(otherNames);
    if (!nullToAbsent || nationalId != null) {
      map['national_id'] = Variable<String>(nationalId);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || profilePictureUrl != null) {
      map['profile_picture_url'] = Variable<String>(profilePictureUrl);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    map['school'] = Variable<String>(school);
    if (!nullToAbsent || campus != null) {
      map['campus'] = Variable<String>(campus);
    }
    if (!nullToAbsent || enrollmentStatus != null) {
      map['enrollment_status'] = Variable<String>(enrollmentStatus);
    }
    if (!nullToAbsent || programme != null) {
      map['programme'] = Variable<String>(programme);
    }
    if (!nullToAbsent || degree != null) {
      map['degree'] = Variable<String>(degree);
    }
    if (!nullToAbsent || academicYear != null) {
      map['academic_year'] = Variable<int>(academicYear);
    }
    if (!nullToAbsent || gpa != null) {
      map['gpa'] = Variable<double>(gpa);
    }
    if (!nullToAbsent || emergencyContact != null) {
      map['emergency_contact'] = Variable<String>(emergencyContact);
    }
    if (!nullToAbsent || parentName != null) {
      map['parent_name'] = Variable<String>(parentName);
    }
    if (!nullToAbsent || dateOfAdmission != null) {
      map['date_of_admission'] = Variable<DateTime>(dateOfAdmission);
    }
    if (!nullToAbsent || graduationDate != null) {
      map['graduation_date'] = Variable<DateTime>(graduationDate);
    }
    if (!nullToAbsent || disabilityStatus != null) {
      map['disability_status'] = Variable<String>(disabilityStatus);
    }
    if (!nullToAbsent || isInternationalStudent != null) {
      map['is_international_student'] = Variable<bool>(isInternationalStudent);
    }
    return map;
  }

  MagnetStudentProfileCompanion toCompanion(bool nullToAbsent) {
    return MagnetStudentProfileCompanion(
      userID: Value(userID),
      institutionID: Value(institutionID),
      admissionNumber: Value(admissionNumber),
      firstName: Value(firstName),
      otherNames: Value(otherNames),
      nationalId: nationalId == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalId),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      profilePictureUrl: profilePictureUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePictureUrl),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      school: Value(school),
      campus: campus == null && nullToAbsent
          ? const Value.absent()
          : Value(campus),
      enrollmentStatus: enrollmentStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(enrollmentStatus),
      programme: programme == null && nullToAbsent
          ? const Value.absent()
          : Value(programme),
      degree: degree == null && nullToAbsent
          ? const Value.absent()
          : Value(degree),
      academicYear: academicYear == null && nullToAbsent
          ? const Value.absent()
          : Value(academicYear),
      gpa: gpa == null && nullToAbsent ? const Value.absent() : Value(gpa),
      emergencyContact: emergencyContact == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContact),
      parentName: parentName == null && nullToAbsent
          ? const Value.absent()
          : Value(parentName),
      dateOfAdmission: dateOfAdmission == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfAdmission),
      graduationDate: graduationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(graduationDate),
      disabilityStatus: disabilityStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(disabilityStatus),
      isInternationalStudent: isInternationalStudent == null && nullToAbsent
          ? const Value.absent()
          : Value(isInternationalStudent),
    );
  }

  factory MagnetStudentProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MagnetStudentProfileData(
      userID: serializer.fromJson<String>(json['user_id']),
      institutionID: serializer.fromJson<int>(json['institution_id']),
      admissionNumber: serializer.fromJson<String>(json['admission_number']),
      firstName: serializer.fromJson<String>(json['first_name']),
      otherNames: serializer.fromJson<String>(json['other_names']),
      nationalId: serializer.fromJson<String?>(json['national_id']),
      gender: serializer.fromJson<String?>(json['gender']),
      address: serializer.fromJson<String?>(json['address']),
      email: serializer.fromJson<String?>(json['email']),
      phoneNumber: serializer.fromJson<String?>(json['phone_number']),
      profilePictureUrl: serializer.fromJson<String?>(
        json['profile_picture_url'],
      ),
      dateOfBirth: serializer.fromJson<DateTime?>(json['date_of_birth']),
      school: serializer.fromJson<String>(json['school']),
      campus: serializer.fromJson<String?>(json['campus']),
      enrollmentStatus: serializer.fromJson<String?>(json['enrollment_status']),
      programme: serializer.fromJson<String?>(json['programme']),
      degree: serializer.fromJson<String?>(json['degree']),
      academicYear: serializer.fromJson<int?>(json['academicYear']),
      gpa: serializer.fromJson<double?>(json['gpa']),
      emergencyContact: serializer.fromJson<String?>(json['emergency_contact']),
      parentName: serializer.fromJson<String?>(json['parent_name']),
      dateOfAdmission: serializer.fromJson<DateTime?>(
        json['date_of_admission'],
      ),
      graduationDate: serializer.fromJson<DateTime?>(json['graduation_date']),
      disabilityStatus: serializer.fromJson<String?>(json['disability_status']),
      isInternationalStudent: serializer.fromJson<bool?>(
        json['is_international_student'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<String>(userID),
      'institution_id': serializer.toJson<int>(institutionID),
      'admission_number': serializer.toJson<String>(admissionNumber),
      'first_name': serializer.toJson<String>(firstName),
      'other_names': serializer.toJson<String>(otherNames),
      'national_id': serializer.toJson<String?>(nationalId),
      'gender': serializer.toJson<String?>(gender),
      'address': serializer.toJson<String?>(address),
      'email': serializer.toJson<String?>(email),
      'phone_number': serializer.toJson<String?>(phoneNumber),
      'profile_picture_url': serializer.toJson<String?>(profilePictureUrl),
      'date_of_birth': serializer.toJson<DateTime?>(dateOfBirth),
      'school': serializer.toJson<String>(school),
      'campus': serializer.toJson<String?>(campus),
      'enrollment_status': serializer.toJson<String?>(enrollmentStatus),
      'programme': serializer.toJson<String?>(programme),
      'degree': serializer.toJson<String?>(degree),
      'academicYear': serializer.toJson<int?>(academicYear),
      'gpa': serializer.toJson<double?>(gpa),
      'emergency_contact': serializer.toJson<String?>(emergencyContact),
      'parent_name': serializer.toJson<String?>(parentName),
      'date_of_admission': serializer.toJson<DateTime?>(dateOfAdmission),
      'graduation_date': serializer.toJson<DateTime?>(graduationDate),
      'disability_status': serializer.toJson<String?>(disabilityStatus),
      'is_international_student': serializer.toJson<bool?>(
        isInternationalStudent,
      ),
    };
  }

  MagnetStudentProfileData copyWith({
    String? userID,
    int? institutionID,
    String? admissionNumber,
    String? firstName,
    String? otherNames,
    Value<String?> nationalId = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> profilePictureUrl = const Value.absent(),
    Value<DateTime?> dateOfBirth = const Value.absent(),
    String? school,
    Value<String?> campus = const Value.absent(),
    Value<String?> enrollmentStatus = const Value.absent(),
    Value<String?> programme = const Value.absent(),
    Value<String?> degree = const Value.absent(),
    Value<int?> academicYear = const Value.absent(),
    Value<double?> gpa = const Value.absent(),
    Value<String?> emergencyContact = const Value.absent(),
    Value<String?> parentName = const Value.absent(),
    Value<DateTime?> dateOfAdmission = const Value.absent(),
    Value<DateTime?> graduationDate = const Value.absent(),
    Value<String?> disabilityStatus = const Value.absent(),
    Value<bool?> isInternationalStudent = const Value.absent(),
  }) => MagnetStudentProfileData(
    userID: userID ?? this.userID,
    institutionID: institutionID ?? this.institutionID,
    admissionNumber: admissionNumber ?? this.admissionNumber,
    firstName: firstName ?? this.firstName,
    otherNames: otherNames ?? this.otherNames,
    nationalId: nationalId.present ? nationalId.value : this.nationalId,
    gender: gender.present ? gender.value : this.gender,
    address: address.present ? address.value : this.address,
    email: email.present ? email.value : this.email,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    profilePictureUrl: profilePictureUrl.present
        ? profilePictureUrl.value
        : this.profilePictureUrl,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    school: school ?? this.school,
    campus: campus.present ? campus.value : this.campus,
    enrollmentStatus: enrollmentStatus.present
        ? enrollmentStatus.value
        : this.enrollmentStatus,
    programme: programme.present ? programme.value : this.programme,
    degree: degree.present ? degree.value : this.degree,
    academicYear: academicYear.present ? academicYear.value : this.academicYear,
    gpa: gpa.present ? gpa.value : this.gpa,
    emergencyContact: emergencyContact.present
        ? emergencyContact.value
        : this.emergencyContact,
    parentName: parentName.present ? parentName.value : this.parentName,
    dateOfAdmission: dateOfAdmission.present
        ? dateOfAdmission.value
        : this.dateOfAdmission,
    graduationDate: graduationDate.present
        ? graduationDate.value
        : this.graduationDate,
    disabilityStatus: disabilityStatus.present
        ? disabilityStatus.value
        : this.disabilityStatus,
    isInternationalStudent: isInternationalStudent.present
        ? isInternationalStudent.value
        : this.isInternationalStudent,
  );
  MagnetStudentProfileData copyWithCompanion(
    MagnetStudentProfileCompanion data,
  ) {
    return MagnetStudentProfileData(
      userID: data.userID.present ? data.userID.value : this.userID,
      institutionID: data.institutionID.present
          ? data.institutionID.value
          : this.institutionID,
      admissionNumber: data.admissionNumber.present
          ? data.admissionNumber.value
          : this.admissionNumber,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      otherNames: data.otherNames.present
          ? data.otherNames.value
          : this.otherNames,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      gender: data.gender.present ? data.gender.value : this.gender,
      address: data.address.present ? data.address.value : this.address,
      email: data.email.present ? data.email.value : this.email,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      profilePictureUrl: data.profilePictureUrl.present
          ? data.profilePictureUrl.value
          : this.profilePictureUrl,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      school: data.school.present ? data.school.value : this.school,
      campus: data.campus.present ? data.campus.value : this.campus,
      enrollmentStatus: data.enrollmentStatus.present
          ? data.enrollmentStatus.value
          : this.enrollmentStatus,
      programme: data.programme.present ? data.programme.value : this.programme,
      degree: data.degree.present ? data.degree.value : this.degree,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      gpa: data.gpa.present ? data.gpa.value : this.gpa,
      emergencyContact: data.emergencyContact.present
          ? data.emergencyContact.value
          : this.emergencyContact,
      parentName: data.parentName.present
          ? data.parentName.value
          : this.parentName,
      dateOfAdmission: data.dateOfAdmission.present
          ? data.dateOfAdmission.value
          : this.dateOfAdmission,
      graduationDate: data.graduationDate.present
          ? data.graduationDate.value
          : this.graduationDate,
      disabilityStatus: data.disabilityStatus.present
          ? data.disabilityStatus.value
          : this.disabilityStatus,
      isInternationalStudent: data.isInternationalStudent.present
          ? data.isInternationalStudent.value
          : this.isInternationalStudent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MagnetStudentProfileData(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('admissionNumber: $admissionNumber, ')
          ..write('firstName: $firstName, ')
          ..write('otherNames: $otherNames, ')
          ..write('nationalId: $nationalId, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('profilePictureUrl: $profilePictureUrl, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('school: $school, ')
          ..write('campus: $campus, ')
          ..write('enrollmentStatus: $enrollmentStatus, ')
          ..write('programme: $programme, ')
          ..write('degree: $degree, ')
          ..write('academicYear: $academicYear, ')
          ..write('gpa: $gpa, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('parentName: $parentName, ')
          ..write('dateOfAdmission: $dateOfAdmission, ')
          ..write('graduationDate: $graduationDate, ')
          ..write('disabilityStatus: $disabilityStatus, ')
          ..write('isInternationalStudent: $isInternationalStudent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    userID,
    institutionID,
    admissionNumber,
    firstName,
    otherNames,
    nationalId,
    gender,
    address,
    email,
    phoneNumber,
    profilePictureUrl,
    dateOfBirth,
    school,
    campus,
    enrollmentStatus,
    programme,
    degree,
    academicYear,
    gpa,
    emergencyContact,
    parentName,
    dateOfAdmission,
    graduationDate,
    disabilityStatus,
    isInternationalStudent,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MagnetStudentProfileData &&
          other.userID == this.userID &&
          other.institutionID == this.institutionID &&
          other.admissionNumber == this.admissionNumber &&
          other.firstName == this.firstName &&
          other.otherNames == this.otherNames &&
          other.nationalId == this.nationalId &&
          other.gender == this.gender &&
          other.address == this.address &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.profilePictureUrl == this.profilePictureUrl &&
          other.dateOfBirth == this.dateOfBirth &&
          other.school == this.school &&
          other.campus == this.campus &&
          other.enrollmentStatus == this.enrollmentStatus &&
          other.programme == this.programme &&
          other.degree == this.degree &&
          other.academicYear == this.academicYear &&
          other.gpa == this.gpa &&
          other.emergencyContact == this.emergencyContact &&
          other.parentName == this.parentName &&
          other.dateOfAdmission == this.dateOfAdmission &&
          other.graduationDate == this.graduationDate &&
          other.disabilityStatus == this.disabilityStatus &&
          other.isInternationalStudent == this.isInternationalStudent);
}

class MagnetStudentProfileCompanion
    extends UpdateCompanion<MagnetStudentProfileData> {
  final Value<String> userID;
  final Value<int> institutionID;
  final Value<String> admissionNumber;
  final Value<String> firstName;
  final Value<String> otherNames;
  final Value<String?> nationalId;
  final Value<String?> gender;
  final Value<String?> address;
  final Value<String?> email;
  final Value<String?> phoneNumber;
  final Value<String?> profilePictureUrl;
  final Value<DateTime?> dateOfBirth;
  final Value<String> school;
  final Value<String?> campus;
  final Value<String?> enrollmentStatus;
  final Value<String?> programme;
  final Value<String?> degree;
  final Value<int?> academicYear;
  final Value<double?> gpa;
  final Value<String?> emergencyContact;
  final Value<String?> parentName;
  final Value<DateTime?> dateOfAdmission;
  final Value<DateTime?> graduationDate;
  final Value<String?> disabilityStatus;
  final Value<bool?> isInternationalStudent;
  final Value<int> rowid;
  const MagnetStudentProfileCompanion({
    this.userID = const Value.absent(),
    this.institutionID = const Value.absent(),
    this.admissionNumber = const Value.absent(),
    this.firstName = const Value.absent(),
    this.otherNames = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.profilePictureUrl = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.school = const Value.absent(),
    this.campus = const Value.absent(),
    this.enrollmentStatus = const Value.absent(),
    this.programme = const Value.absent(),
    this.degree = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.gpa = const Value.absent(),
    this.emergencyContact = const Value.absent(),
    this.parentName = const Value.absent(),
    this.dateOfAdmission = const Value.absent(),
    this.graduationDate = const Value.absent(),
    this.disabilityStatus = const Value.absent(),
    this.isInternationalStudent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MagnetStudentProfileCompanion.insert({
    required String userID,
    required int institutionID,
    required String admissionNumber,
    required String firstName,
    required String otherNames,
    this.nationalId = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.profilePictureUrl = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    required String school,
    this.campus = const Value.absent(),
    this.enrollmentStatus = const Value.absent(),
    this.programme = const Value.absent(),
    this.degree = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.gpa = const Value.absent(),
    this.emergencyContact = const Value.absent(),
    this.parentName = const Value.absent(),
    this.dateOfAdmission = const Value.absent(),
    this.graduationDate = const Value.absent(),
    this.disabilityStatus = const Value.absent(),
    this.isInternationalStudent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userID = Value(userID),
       institutionID = Value(institutionID),
       admissionNumber = Value(admissionNumber),
       firstName = Value(firstName),
       otherNames = Value(otherNames),
       school = Value(school);
  static Insertable<MagnetStudentProfileData> custom({
    Expression<String>? userID,
    Expression<int>? institutionID,
    Expression<String>? admissionNumber,
    Expression<String>? firstName,
    Expression<String>? otherNames,
    Expression<String>? nationalId,
    Expression<String>? gender,
    Expression<String>? address,
    Expression<String>? email,
    Expression<String>? phoneNumber,
    Expression<String>? profilePictureUrl,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? school,
    Expression<String>? campus,
    Expression<String>? enrollmentStatus,
    Expression<String>? programme,
    Expression<String>? degree,
    Expression<int>? academicYear,
    Expression<double>? gpa,
    Expression<String>? emergencyContact,
    Expression<String>? parentName,
    Expression<DateTime>? dateOfAdmission,
    Expression<DateTime>? graduationDate,
    Expression<String>? disabilityStatus,
    Expression<bool>? isInternationalStudent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userID != null) 'user_i_d': userID,
      if (institutionID != null) 'institution_i_d': institutionID,
      if (admissionNumber != null) 'admission_number': admissionNumber,
      if (firstName != null) 'first_name': firstName,
      if (otherNames != null) 'other_names': otherNames,
      if (nationalId != null) 'national_id': nationalId,
      if (gender != null) 'gender': gender,
      if (address != null) 'address': address,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (profilePictureUrl != null) 'profile_picture_url': profilePictureUrl,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (school != null) 'school': school,
      if (campus != null) 'campus': campus,
      if (enrollmentStatus != null) 'enrollment_status': enrollmentStatus,
      if (programme != null) 'programme': programme,
      if (degree != null) 'degree': degree,
      if (academicYear != null) 'academic_year': academicYear,
      if (gpa != null) 'gpa': gpa,
      if (emergencyContact != null) 'emergency_contact': emergencyContact,
      if (parentName != null) 'parent_name': parentName,
      if (dateOfAdmission != null) 'date_of_admission': dateOfAdmission,
      if (graduationDate != null) 'graduation_date': graduationDate,
      if (disabilityStatus != null) 'disability_status': disabilityStatus,
      if (isInternationalStudent != null)
        'is_international_student': isInternationalStudent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MagnetStudentProfileCompanion copyWith({
    Value<String>? userID,
    Value<int>? institutionID,
    Value<String>? admissionNumber,
    Value<String>? firstName,
    Value<String>? otherNames,
    Value<String?>? nationalId,
    Value<String?>? gender,
    Value<String?>? address,
    Value<String?>? email,
    Value<String?>? phoneNumber,
    Value<String?>? profilePictureUrl,
    Value<DateTime?>? dateOfBirth,
    Value<String>? school,
    Value<String?>? campus,
    Value<String?>? enrollmentStatus,
    Value<String?>? programme,
    Value<String?>? degree,
    Value<int?>? academicYear,
    Value<double?>? gpa,
    Value<String?>? emergencyContact,
    Value<String?>? parentName,
    Value<DateTime?>? dateOfAdmission,
    Value<DateTime?>? graduationDate,
    Value<String?>? disabilityStatus,
    Value<bool?>? isInternationalStudent,
    Value<int>? rowid,
  }) {
    return MagnetStudentProfileCompanion(
      userID: userID ?? this.userID,
      institutionID: institutionID ?? this.institutionID,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      firstName: firstName ?? this.firstName,
      otherNames: otherNames ?? this.otherNames,
      nationalId: nationalId ?? this.nationalId,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      school: school ?? this.school,
      campus: campus ?? this.campus,
      enrollmentStatus: enrollmentStatus ?? this.enrollmentStatus,
      programme: programme ?? this.programme,
      degree: degree ?? this.degree,
      academicYear: academicYear ?? this.academicYear,
      gpa: gpa ?? this.gpa,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      parentName: parentName ?? this.parentName,
      dateOfAdmission: dateOfAdmission ?? this.dateOfAdmission,
      graduationDate: graduationDate ?? this.graduationDate,
      disabilityStatus: disabilityStatus ?? this.disabilityStatus,
      isInternationalStudent:
          isInternationalStudent ?? this.isInternationalStudent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userID.present) {
      map['user_i_d'] = Variable<String>(userID.value);
    }
    if (institutionID.present) {
      map['institution_i_d'] = Variable<int>(institutionID.value);
    }
    if (admissionNumber.present) {
      map['admission_number'] = Variable<String>(admissionNumber.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (otherNames.present) {
      map['other_names'] = Variable<String>(otherNames.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (profilePictureUrl.present) {
      map['profile_picture_url'] = Variable<String>(profilePictureUrl.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (enrollmentStatus.present) {
      map['enrollment_status'] = Variable<String>(enrollmentStatus.value);
    }
    if (programme.present) {
      map['programme'] = Variable<String>(programme.value);
    }
    if (degree.present) {
      map['degree'] = Variable<String>(degree.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<int>(academicYear.value);
    }
    if (gpa.present) {
      map['gpa'] = Variable<double>(gpa.value);
    }
    if (emergencyContact.present) {
      map['emergency_contact'] = Variable<String>(emergencyContact.value);
    }
    if (parentName.present) {
      map['parent_name'] = Variable<String>(parentName.value);
    }
    if (dateOfAdmission.present) {
      map['date_of_admission'] = Variable<DateTime>(dateOfAdmission.value);
    }
    if (graduationDate.present) {
      map['graduation_date'] = Variable<DateTime>(graduationDate.value);
    }
    if (disabilityStatus.present) {
      map['disability_status'] = Variable<String>(disabilityStatus.value);
    }
    if (isInternationalStudent.present) {
      map['is_international_student'] = Variable<bool>(
        isInternationalStudent.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MagnetStudentProfileCompanion(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('admissionNumber: $admissionNumber, ')
          ..write('firstName: $firstName, ')
          ..write('otherNames: $otherNames, ')
          ..write('nationalId: $nationalId, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('profilePictureUrl: $profilePictureUrl, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('school: $school, ')
          ..write('campus: $campus, ')
          ..write('enrollmentStatus: $enrollmentStatus, ')
          ..write('programme: $programme, ')
          ..write('degree: $degree, ')
          ..write('academicYear: $academicYear, ')
          ..write('gpa: $gpa, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('parentName: $parentName, ')
          ..write('dateOfAdmission: $dateOfAdmission, ')
          ..write('graduationDate: $graduationDate, ')
          ..write('disabilityStatus: $disabilityStatus, ')
          ..write('isInternationalStudent: $isInternationalStudent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MagnetCredentialsTable extends MagnetCredentials
    with TableInfo<$MagnetCredentialsTable, MagnetCredential> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MagnetCredentialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
    'user_i_d',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionIDMeta = const VerificationMeta(
    'institutionID',
  );
  @override
  late final GeneratedColumn<int> institutionID = GeneratedColumn<int>(
    'institution_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String> extra = GeneratedColumn<String>(
    'extra',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userID,
    institutionID,
    username,
    password,
    extra,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'magnet_credentials';
  @override
  VerificationContext validateIntegrity(
    Insertable<MagnetCredential> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('institution_i_d')) {
      context.handle(
        _institutionIDMeta,
        institutionID.isAcceptableOrUnknown(
          data['institution_i_d']!,
          _institutionIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionIDMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('extra')) {
      context.handle(
        _extraMeta,
        extra.isAcceptableOrUnknown(data['extra']!, _extraMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username, institutionID, userID};
  @override
  MagnetCredential map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MagnetCredential(
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_i_d'],
      )!,
      institutionID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institution_i_d'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      extra: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extra'],
      ),
    );
  }

  @override
  $MagnetCredentialsTable createAlias(String alias) {
    return $MagnetCredentialsTable(attachedDatabase, alias);
  }
}

class MagnetCredential extends DataClass
    implements Insertable<MagnetCredential> {
  final String userID;
  final int institutionID;
  final String username;
  final String password;

  /// Store the extra Map`<String, dynamic>` as a JSON string
  final String? extra;
  const MagnetCredential({
    required this.userID,
    required this.institutionID,
    required this.username,
    required this.password,
    this.extra,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_i_d'] = Variable<String>(userID);
    map['institution_i_d'] = Variable<int>(institutionID);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || extra != null) {
      map['extra'] = Variable<String>(extra);
    }
    return map;
  }

  MagnetCredentialsCompanion toCompanion(bool nullToAbsent) {
    return MagnetCredentialsCompanion(
      userID: Value(userID),
      institutionID: Value(institutionID),
      username: Value(username),
      password: Value(password),
      extra: extra == null && nullToAbsent
          ? const Value.absent()
          : Value(extra),
    );
  }

  factory MagnetCredential.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MagnetCredential(
      userID: serializer.fromJson<String>(json['user_id']),
      institutionID: serializer.fromJson<int>(json['institution_id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      extra: serializer.fromJson<String?>(json['extra']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<String>(userID),
      'institution_id': serializer.toJson<int>(institutionID),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'extra': serializer.toJson<String?>(extra),
    };
  }

  MagnetCredential copyWith({
    String? userID,
    int? institutionID,
    String? username,
    String? password,
    Value<String?> extra = const Value.absent(),
  }) => MagnetCredential(
    userID: userID ?? this.userID,
    institutionID: institutionID ?? this.institutionID,
    username: username ?? this.username,
    password: password ?? this.password,
    extra: extra.present ? extra.value : this.extra,
  );
  MagnetCredential copyWithCompanion(MagnetCredentialsCompanion data) {
    return MagnetCredential(
      userID: data.userID.present ? data.userID.value : this.userID,
      institutionID: data.institutionID.present
          ? data.institutionID.value
          : this.institutionID,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      extra: data.extra.present ? data.extra.value : this.extra,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MagnetCredential(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('extra: $extra')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userID, institutionID, username, password, extra);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MagnetCredential &&
          other.userID == this.userID &&
          other.institutionID == this.institutionID &&
          other.username == this.username &&
          other.password == this.password &&
          other.extra == this.extra);
}

class MagnetCredentialsCompanion extends UpdateCompanion<MagnetCredential> {
  final Value<String> userID;
  final Value<int> institutionID;
  final Value<String> username;
  final Value<String> password;
  final Value<String?> extra;
  final Value<int> rowid;
  const MagnetCredentialsCompanion({
    this.userID = const Value.absent(),
    this.institutionID = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.extra = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MagnetCredentialsCompanion.insert({
    required String userID,
    required int institutionID,
    required String username,
    required String password,
    this.extra = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userID = Value(userID),
       institutionID = Value(institutionID),
       username = Value(username),
       password = Value(password);
  static Insertable<MagnetCredential> custom({
    Expression<String>? userID,
    Expression<int>? institutionID,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? extra,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userID != null) 'user_i_d': userID,
      if (institutionID != null) 'institution_i_d': institutionID,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (extra != null) 'extra': extra,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MagnetCredentialsCompanion copyWith({
    Value<String>? userID,
    Value<int>? institutionID,
    Value<String>? username,
    Value<String>? password,
    Value<String?>? extra,
    Value<int>? rowid,
  }) {
    return MagnetCredentialsCompanion(
      userID: userID ?? this.userID,
      institutionID: institutionID ?? this.institutionID,
      username: username ?? this.username,
      password: password ?? this.password,
      extra: extra ?? this.extra,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userID.present) {
      map['user_i_d'] = Variable<String>(userID.value);
    }
    if (institutionID.present) {
      map['institution_i_d'] = Variable<int>(institutionID.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String>(extra.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MagnetCredentialsCompanion(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('extra: $extra, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MagnetCourseInfoTable extends MagnetCourseInfo
    with TableInfo<$MagnetCourseInfoTable, MagnetCourseInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MagnetCourseInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionIDMeta = const VerificationMeta(
    'institutionID',
  );
  @override
  late final GeneratedColumn<int> institutionID = GeneratedColumn<int>(
    'institution_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseCodeMeta = const VerificationMeta(
    'courseCode',
  );
  @override
  late final GeneratedColumn<String> courseCode = GeneratedColumn<String>(
    'course_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseTitleMeta = const VerificationMeta(
    'courseTitle',
  );
  @override
  late final GeneratedColumn<String> courseTitle = GeneratedColumn<String>(
    'course_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseDescriptionMeta = const VerificationMeta(
    'courseDescription',
  );
  @override
  late final GeneratedColumn<String> courseDescription =
      GeneratedColumn<String>(
        'course_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _creditsMeta = const VerificationMeta(
    'credits',
  );
  @override
  late final GeneratedColumn<int> credits = GeneratedColumn<int>(
    'credits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructorMeta = const VerificationMeta(
    'instructor',
  );
  @override
  late final GeneratedColumn<String> instructor = GeneratedColumn<String>(
    'instructor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _semesterMeta = const VerificationMeta(
    'semester',
  );
  @override
  late final GeneratedColumn<String> semester = GeneratedColumn<String>(
    'semester',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduleMeta = const VerificationMeta(
    'schedule',
  );
  @override
  late final GeneratedColumn<DateTime> schedule = GeneratedColumn<DateTime>(
    'schedule',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationInSecondsMeta = const VerificationMeta(
    'durationInSeconds',
  );
  @override
  late final GeneratedColumn<int> durationInSeconds = GeneratedColumn<int>(
    'duration_in_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prerequisitesMeta = const VerificationMeta(
    'prerequisites',
  );
  @override
  late final GeneratedColumn<String> prerequisites = GeneratedColumn<String>(
    'prerequisites',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseTypeMeta = const VerificationMeta(
    'courseType',
  );
  @override
  late final GeneratedColumn<String> courseType = GeneratedColumn<String>(
    'course_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseLevelMeta = const VerificationMeta(
    'courseLevel',
  );
  @override
  late final GeneratedColumn<String> courseLevel = GeneratedColumn<String>(
    'course_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enrollmentLimitMeta = const VerificationMeta(
    'enrollmentLimit',
  );
  @override
  late final GeneratedColumn<int> enrollmentLimit = GeneratedColumn<int>(
    'enrollment_limit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentEnrollmentMeta = const VerificationMeta(
    'currentEnrollment',
  );
  @override
  late final GeneratedColumn<int> currentEnrollment = GeneratedColumn<int>(
    'current_enrollment',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseMaterialsMeta = const VerificationMeta(
    'courseMaterials',
  );
  @override
  late final GeneratedColumn<String> courseMaterials = GeneratedColumn<String>(
    'course_materials',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userID,
    institutionID,
    courseCode,
    courseTitle,
    courseDescription,
    credits,
    instructor,
    semester,
    schedule,
    durationInSeconds,
    prerequisites,
    courseType,
    courseLevel,
    location,
    enrollmentLimit,
    currentEnrollment,
    courseMaterials,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<MagnetCourseInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_id']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('institution_id')) {
      context.handle(
        _institutionIDMeta,
        institutionID.isAcceptableOrUnknown(
          data['institution_id']!,
          _institutionIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionIDMeta);
    }
    if (data.containsKey('course_code')) {
      context.handle(
        _courseCodeMeta,
        courseCode.isAcceptableOrUnknown(data['course_code']!, _courseCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_courseCodeMeta);
    }
    if (data.containsKey('course_title')) {
      context.handle(
        _courseTitleMeta,
        courseTitle.isAcceptableOrUnknown(
          data['course_title']!,
          _courseTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseTitleMeta);
    }
    if (data.containsKey('course_description')) {
      context.handle(
        _courseDescriptionMeta,
        courseDescription.isAcceptableOrUnknown(
          data['course_description']!,
          _courseDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('credits')) {
      context.handle(
        _creditsMeta,
        credits.isAcceptableOrUnknown(data['credits']!, _creditsMeta),
      );
    } else if (isInserting) {
      context.missing(_creditsMeta);
    }
    if (data.containsKey('instructor')) {
      context.handle(
        _instructorMeta,
        instructor.isAcceptableOrUnknown(data['instructor']!, _instructorMeta),
      );
    }
    if (data.containsKey('semester')) {
      context.handle(
        _semesterMeta,
        semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta),
      );
    }
    if (data.containsKey('schedule')) {
      context.handle(
        _scheduleMeta,
        schedule.isAcceptableOrUnknown(data['schedule']!, _scheduleMeta),
      );
    }
    if (data.containsKey('duration_in_seconds')) {
      context.handle(
        _durationInSecondsMeta,
        durationInSeconds.isAcceptableOrUnknown(
          data['duration_in_seconds']!,
          _durationInSecondsMeta,
        ),
      );
    }
    if (data.containsKey('prerequisites')) {
      context.handle(
        _prerequisitesMeta,
        prerequisites.isAcceptableOrUnknown(
          data['prerequisites']!,
          _prerequisitesMeta,
        ),
      );
    }
    if (data.containsKey('course_type')) {
      context.handle(
        _courseTypeMeta,
        courseType.isAcceptableOrUnknown(data['course_type']!, _courseTypeMeta),
      );
    }
    if (data.containsKey('course_level')) {
      context.handle(
        _courseLevelMeta,
        courseLevel.isAcceptableOrUnknown(
          data['course_level']!,
          _courseLevelMeta,
        ),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('enrollment_limit')) {
      context.handle(
        _enrollmentLimitMeta,
        enrollmentLimit.isAcceptableOrUnknown(
          data['enrollment_limit']!,
          _enrollmentLimitMeta,
        ),
      );
    }
    if (data.containsKey('current_enrollment')) {
      context.handle(
        _currentEnrollmentMeta,
        currentEnrollment.isAcceptableOrUnknown(
          data['current_enrollment']!,
          _currentEnrollmentMeta,
        ),
      );
    }
    if (data.containsKey('course_materials')) {
      context.handle(
        _courseMaterialsMeta,
        courseMaterials.isAcceptableOrUnknown(
          data['course_materials']!,
          _courseMaterialsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userID, institutionID, courseCode};
  @override
  MagnetCourseInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MagnetCourseInfoData(
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      institutionID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institution_id'],
      )!,
      courseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_code'],
      )!,
      courseTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_title'],
      )!,
      courseDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_description'],
      ),
      credits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credits'],
      )!,
      instructor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructor'],
      ),
      semester: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}semester'],
      ),
      schedule: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}schedule'],
      ),
      durationInSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_in_seconds'],
      ),
      prerequisites: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prerequisites'],
      ),
      courseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_type'],
      ),
      courseLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_level'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      enrollmentLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enrollment_limit'],
      ),
      currentEnrollment: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_enrollment'],
      ),
      courseMaterials: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_materials'],
      ),
    );
  }

  @override
  $MagnetCourseInfoTable createAlias(String alias) {
    return $MagnetCourseInfoTable(attachedDatabase, alias);
  }
}

class MagnetCourseInfoData extends DataClass
    implements Insertable<MagnetCourseInfoData> {
  final String userID;
  final int institutionID;
  final String courseCode;
  final String courseTitle;
  final String? courseDescription;
  final int credits;
  final String? instructor;
  final String? semester;
  final DateTime? schedule;
  final int? durationInSeconds;
  final String? prerequisites;
  final String? courseType;
  final String? courseLevel;
  final String? location;
  final int? enrollmentLimit;
  final int? currentEnrollment;
  final String? courseMaterials;
  const MagnetCourseInfoData({
    required this.userID,
    required this.institutionID,
    required this.courseCode,
    required this.courseTitle,
    this.courseDescription,
    required this.credits,
    this.instructor,
    this.semester,
    this.schedule,
    this.durationInSeconds,
    this.prerequisites,
    this.courseType,
    this.courseLevel,
    this.location,
    this.enrollmentLimit,
    this.currentEnrollment,
    this.courseMaterials,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userID);
    map['institution_id'] = Variable<int>(institutionID);
    map['course_code'] = Variable<String>(courseCode);
    map['course_title'] = Variable<String>(courseTitle);
    if (!nullToAbsent || courseDescription != null) {
      map['course_description'] = Variable<String>(courseDescription);
    }
    map['credits'] = Variable<int>(credits);
    if (!nullToAbsent || instructor != null) {
      map['instructor'] = Variable<String>(instructor);
    }
    if (!nullToAbsent || semester != null) {
      map['semester'] = Variable<String>(semester);
    }
    if (!nullToAbsent || schedule != null) {
      map['schedule'] = Variable<DateTime>(schedule);
    }
    if (!nullToAbsent || durationInSeconds != null) {
      map['duration_in_seconds'] = Variable<int>(durationInSeconds);
    }
    if (!nullToAbsent || prerequisites != null) {
      map['prerequisites'] = Variable<String>(prerequisites);
    }
    if (!nullToAbsent || courseType != null) {
      map['course_type'] = Variable<String>(courseType);
    }
    if (!nullToAbsent || courseLevel != null) {
      map['course_level'] = Variable<String>(courseLevel);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || enrollmentLimit != null) {
      map['enrollment_limit'] = Variable<int>(enrollmentLimit);
    }
    if (!nullToAbsent || currentEnrollment != null) {
      map['current_enrollment'] = Variable<int>(currentEnrollment);
    }
    if (!nullToAbsent || courseMaterials != null) {
      map['course_materials'] = Variable<String>(courseMaterials);
    }
    return map;
  }

  MagnetCourseInfoCompanion toCompanion(bool nullToAbsent) {
    return MagnetCourseInfoCompanion(
      userID: Value(userID),
      institutionID: Value(institutionID),
      courseCode: Value(courseCode),
      courseTitle: Value(courseTitle),
      courseDescription: courseDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(courseDescription),
      credits: Value(credits),
      instructor: instructor == null && nullToAbsent
          ? const Value.absent()
          : Value(instructor),
      semester: semester == null && nullToAbsent
          ? const Value.absent()
          : Value(semester),
      schedule: schedule == null && nullToAbsent
          ? const Value.absent()
          : Value(schedule),
      durationInSeconds: durationInSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationInSeconds),
      prerequisites: prerequisites == null && nullToAbsent
          ? const Value.absent()
          : Value(prerequisites),
      courseType: courseType == null && nullToAbsent
          ? const Value.absent()
          : Value(courseType),
      courseLevel: courseLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(courseLevel),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      enrollmentLimit: enrollmentLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(enrollmentLimit),
      currentEnrollment: currentEnrollment == null && nullToAbsent
          ? const Value.absent()
          : Value(currentEnrollment),
      courseMaterials: courseMaterials == null && nullToAbsent
          ? const Value.absent()
          : Value(courseMaterials),
    );
  }

  factory MagnetCourseInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MagnetCourseInfoData(
      userID: serializer.fromJson<String>(json['userID']),
      institutionID: serializer.fromJson<int>(json['institutionID']),
      courseCode: serializer.fromJson<String>(json['courseCode']),
      courseTitle: serializer.fromJson<String>(json['courseTitle']),
      courseDescription: serializer.fromJson<String?>(
        json['courseDescription'],
      ),
      credits: serializer.fromJson<int>(json['credits']),
      instructor: serializer.fromJson<String?>(json['instructor']),
      semester: serializer.fromJson<String?>(json['semester']),
      schedule: serializer.fromJson<DateTime?>(json['schedule']),
      durationInSeconds: serializer.fromJson<int?>(json['durationInSeconds']),
      prerequisites: serializer.fromJson<String?>(json['prerequisites']),
      courseType: serializer.fromJson<String?>(json['courseType']),
      courseLevel: serializer.fromJson<String?>(json['courseLevel']),
      location: serializer.fromJson<String?>(json['location']),
      enrollmentLimit: serializer.fromJson<int?>(json['enrollmentLimit']),
      currentEnrollment: serializer.fromJson<int?>(json['currentEnrollment']),
      courseMaterials: serializer.fromJson<String?>(json['courseMaterials']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userID': serializer.toJson<String>(userID),
      'institutionID': serializer.toJson<int>(institutionID),
      'courseCode': serializer.toJson<String>(courseCode),
      'courseTitle': serializer.toJson<String>(courseTitle),
      'courseDescription': serializer.toJson<String?>(courseDescription),
      'credits': serializer.toJson<int>(credits),
      'instructor': serializer.toJson<String?>(instructor),
      'semester': serializer.toJson<String?>(semester),
      'schedule': serializer.toJson<DateTime?>(schedule),
      'durationInSeconds': serializer.toJson<int?>(durationInSeconds),
      'prerequisites': serializer.toJson<String?>(prerequisites),
      'courseType': serializer.toJson<String?>(courseType),
      'courseLevel': serializer.toJson<String?>(courseLevel),
      'location': serializer.toJson<String?>(location),
      'enrollmentLimit': serializer.toJson<int?>(enrollmentLimit),
      'currentEnrollment': serializer.toJson<int?>(currentEnrollment),
      'courseMaterials': serializer.toJson<String?>(courseMaterials),
    };
  }

  MagnetCourseInfoData copyWith({
    String? userID,
    int? institutionID,
    String? courseCode,
    String? courseTitle,
    Value<String?> courseDescription = const Value.absent(),
    int? credits,
    Value<String?> instructor = const Value.absent(),
    Value<String?> semester = const Value.absent(),
    Value<DateTime?> schedule = const Value.absent(),
    Value<int?> durationInSeconds = const Value.absent(),
    Value<String?> prerequisites = const Value.absent(),
    Value<String?> courseType = const Value.absent(),
    Value<String?> courseLevel = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<int?> enrollmentLimit = const Value.absent(),
    Value<int?> currentEnrollment = const Value.absent(),
    Value<String?> courseMaterials = const Value.absent(),
  }) => MagnetCourseInfoData(
    userID: userID ?? this.userID,
    institutionID: institutionID ?? this.institutionID,
    courseCode: courseCode ?? this.courseCode,
    courseTitle: courseTitle ?? this.courseTitle,
    courseDescription: courseDescription.present
        ? courseDescription.value
        : this.courseDescription,
    credits: credits ?? this.credits,
    instructor: instructor.present ? instructor.value : this.instructor,
    semester: semester.present ? semester.value : this.semester,
    schedule: schedule.present ? schedule.value : this.schedule,
    durationInSeconds: durationInSeconds.present
        ? durationInSeconds.value
        : this.durationInSeconds,
    prerequisites: prerequisites.present
        ? prerequisites.value
        : this.prerequisites,
    courseType: courseType.present ? courseType.value : this.courseType,
    courseLevel: courseLevel.present ? courseLevel.value : this.courseLevel,
    location: location.present ? location.value : this.location,
    enrollmentLimit: enrollmentLimit.present
        ? enrollmentLimit.value
        : this.enrollmentLimit,
    currentEnrollment: currentEnrollment.present
        ? currentEnrollment.value
        : this.currentEnrollment,
    courseMaterials: courseMaterials.present
        ? courseMaterials.value
        : this.courseMaterials,
  );
  MagnetCourseInfoData copyWithCompanion(MagnetCourseInfoCompanion data) {
    return MagnetCourseInfoData(
      userID: data.userID.present ? data.userID.value : this.userID,
      institutionID: data.institutionID.present
          ? data.institutionID.value
          : this.institutionID,
      courseCode: data.courseCode.present
          ? data.courseCode.value
          : this.courseCode,
      courseTitle: data.courseTitle.present
          ? data.courseTitle.value
          : this.courseTitle,
      courseDescription: data.courseDescription.present
          ? data.courseDescription.value
          : this.courseDescription,
      credits: data.credits.present ? data.credits.value : this.credits,
      instructor: data.instructor.present
          ? data.instructor.value
          : this.instructor,
      semester: data.semester.present ? data.semester.value : this.semester,
      schedule: data.schedule.present ? data.schedule.value : this.schedule,
      durationInSeconds: data.durationInSeconds.present
          ? data.durationInSeconds.value
          : this.durationInSeconds,
      prerequisites: data.prerequisites.present
          ? data.prerequisites.value
          : this.prerequisites,
      courseType: data.courseType.present
          ? data.courseType.value
          : this.courseType,
      courseLevel: data.courseLevel.present
          ? data.courseLevel.value
          : this.courseLevel,
      location: data.location.present ? data.location.value : this.location,
      enrollmentLimit: data.enrollmentLimit.present
          ? data.enrollmentLimit.value
          : this.enrollmentLimit,
      currentEnrollment: data.currentEnrollment.present
          ? data.currentEnrollment.value
          : this.currentEnrollment,
      courseMaterials: data.courseMaterials.present
          ? data.courseMaterials.value
          : this.courseMaterials,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MagnetCourseInfoData(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('courseCode: $courseCode, ')
          ..write('courseTitle: $courseTitle, ')
          ..write('courseDescription: $courseDescription, ')
          ..write('credits: $credits, ')
          ..write('instructor: $instructor, ')
          ..write('semester: $semester, ')
          ..write('schedule: $schedule, ')
          ..write('durationInSeconds: $durationInSeconds, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('courseType: $courseType, ')
          ..write('courseLevel: $courseLevel, ')
          ..write('location: $location, ')
          ..write('enrollmentLimit: $enrollmentLimit, ')
          ..write('currentEnrollment: $currentEnrollment, ')
          ..write('courseMaterials: $courseMaterials')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userID,
    institutionID,
    courseCode,
    courseTitle,
    courseDescription,
    credits,
    instructor,
    semester,
    schedule,
    durationInSeconds,
    prerequisites,
    courseType,
    courseLevel,
    location,
    enrollmentLimit,
    currentEnrollment,
    courseMaterials,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MagnetCourseInfoData &&
          other.userID == this.userID &&
          other.institutionID == this.institutionID &&
          other.courseCode == this.courseCode &&
          other.courseTitle == this.courseTitle &&
          other.courseDescription == this.courseDescription &&
          other.credits == this.credits &&
          other.instructor == this.instructor &&
          other.semester == this.semester &&
          other.schedule == this.schedule &&
          other.durationInSeconds == this.durationInSeconds &&
          other.prerequisites == this.prerequisites &&
          other.courseType == this.courseType &&
          other.courseLevel == this.courseLevel &&
          other.location == this.location &&
          other.enrollmentLimit == this.enrollmentLimit &&
          other.currentEnrollment == this.currentEnrollment &&
          other.courseMaterials == this.courseMaterials);
}

class MagnetCourseInfoCompanion extends UpdateCompanion<MagnetCourseInfoData> {
  final Value<String> userID;
  final Value<int> institutionID;
  final Value<String> courseCode;
  final Value<String> courseTitle;
  final Value<String?> courseDescription;
  final Value<int> credits;
  final Value<String?> instructor;
  final Value<String?> semester;
  final Value<DateTime?> schedule;
  final Value<int?> durationInSeconds;
  final Value<String?> prerequisites;
  final Value<String?> courseType;
  final Value<String?> courseLevel;
  final Value<String?> location;
  final Value<int?> enrollmentLimit;
  final Value<int?> currentEnrollment;
  final Value<String?> courseMaterials;
  final Value<int> rowid;
  const MagnetCourseInfoCompanion({
    this.userID = const Value.absent(),
    this.institutionID = const Value.absent(),
    this.courseCode = const Value.absent(),
    this.courseTitle = const Value.absent(),
    this.courseDescription = const Value.absent(),
    this.credits = const Value.absent(),
    this.instructor = const Value.absent(),
    this.semester = const Value.absent(),
    this.schedule = const Value.absent(),
    this.durationInSeconds = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.courseType = const Value.absent(),
    this.courseLevel = const Value.absent(),
    this.location = const Value.absent(),
    this.enrollmentLimit = const Value.absent(),
    this.currentEnrollment = const Value.absent(),
    this.courseMaterials = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MagnetCourseInfoCompanion.insert({
    required String userID,
    required int institutionID,
    required String courseCode,
    required String courseTitle,
    this.courseDescription = const Value.absent(),
    required int credits,
    this.instructor = const Value.absent(),
    this.semester = const Value.absent(),
    this.schedule = const Value.absent(),
    this.durationInSeconds = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.courseType = const Value.absent(),
    this.courseLevel = const Value.absent(),
    this.location = const Value.absent(),
    this.enrollmentLimit = const Value.absent(),
    this.currentEnrollment = const Value.absent(),
    this.courseMaterials = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userID = Value(userID),
       institutionID = Value(institutionID),
       courseCode = Value(courseCode),
       courseTitle = Value(courseTitle),
       credits = Value(credits);
  static Insertable<MagnetCourseInfoData> custom({
    Expression<String>? userID,
    Expression<int>? institutionID,
    Expression<String>? courseCode,
    Expression<String>? courseTitle,
    Expression<String>? courseDescription,
    Expression<int>? credits,
    Expression<String>? instructor,
    Expression<String>? semester,
    Expression<DateTime>? schedule,
    Expression<int>? durationInSeconds,
    Expression<String>? prerequisites,
    Expression<String>? courseType,
    Expression<String>? courseLevel,
    Expression<String>? location,
    Expression<int>? enrollmentLimit,
    Expression<int>? currentEnrollment,
    Expression<String>? courseMaterials,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userID != null) 'user_id': userID,
      if (institutionID != null) 'institution_id': institutionID,
      if (courseCode != null) 'course_code': courseCode,
      if (courseTitle != null) 'course_title': courseTitle,
      if (courseDescription != null) 'course_description': courseDescription,
      if (credits != null) 'credits': credits,
      if (instructor != null) 'instructor': instructor,
      if (semester != null) 'semester': semester,
      if (schedule != null) 'schedule': schedule,
      if (durationInSeconds != null) 'duration_in_seconds': durationInSeconds,
      if (prerequisites != null) 'prerequisites': prerequisites,
      if (courseType != null) 'course_type': courseType,
      if (courseLevel != null) 'course_level': courseLevel,
      if (location != null) 'location': location,
      if (enrollmentLimit != null) 'enrollment_limit': enrollmentLimit,
      if (currentEnrollment != null) 'current_enrollment': currentEnrollment,
      if (courseMaterials != null) 'course_materials': courseMaterials,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MagnetCourseInfoCompanion copyWith({
    Value<String>? userID,
    Value<int>? institutionID,
    Value<String>? courseCode,
    Value<String>? courseTitle,
    Value<String?>? courseDescription,
    Value<int>? credits,
    Value<String?>? instructor,
    Value<String?>? semester,
    Value<DateTime?>? schedule,
    Value<int?>? durationInSeconds,
    Value<String?>? prerequisites,
    Value<String?>? courseType,
    Value<String?>? courseLevel,
    Value<String?>? location,
    Value<int?>? enrollmentLimit,
    Value<int?>? currentEnrollment,
    Value<String?>? courseMaterials,
    Value<int>? rowid,
  }) {
    return MagnetCourseInfoCompanion(
      userID: userID ?? this.userID,
      institutionID: institutionID ?? this.institutionID,
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      courseDescription: courseDescription ?? this.courseDescription,
      credits: credits ?? this.credits,
      instructor: instructor ?? this.instructor,
      semester: semester ?? this.semester,
      schedule: schedule ?? this.schedule,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      prerequisites: prerequisites ?? this.prerequisites,
      courseType: courseType ?? this.courseType,
      courseLevel: courseLevel ?? this.courseLevel,
      location: location ?? this.location,
      enrollmentLimit: enrollmentLimit ?? this.enrollmentLimit,
      currentEnrollment: currentEnrollment ?? this.currentEnrollment,
      courseMaterials: courseMaterials ?? this.courseMaterials,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userID.present) {
      map['user_id'] = Variable<String>(userID.value);
    }
    if (institutionID.present) {
      map['institution_id'] = Variable<int>(institutionID.value);
    }
    if (courseCode.present) {
      map['course_code'] = Variable<String>(courseCode.value);
    }
    if (courseTitle.present) {
      map['course_title'] = Variable<String>(courseTitle.value);
    }
    if (courseDescription.present) {
      map['course_description'] = Variable<String>(courseDescription.value);
    }
    if (credits.present) {
      map['credits'] = Variable<int>(credits.value);
    }
    if (instructor.present) {
      map['instructor'] = Variable<String>(instructor.value);
    }
    if (semester.present) {
      map['semester'] = Variable<String>(semester.value);
    }
    if (schedule.present) {
      map['schedule'] = Variable<DateTime>(schedule.value);
    }
    if (durationInSeconds.present) {
      map['duration_in_seconds'] = Variable<int>(durationInSeconds.value);
    }
    if (prerequisites.present) {
      map['prerequisites'] = Variable<String>(prerequisites.value);
    }
    if (courseType.present) {
      map['course_type'] = Variable<String>(courseType.value);
    }
    if (courseLevel.present) {
      map['course_level'] = Variable<String>(courseLevel.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (enrollmentLimit.present) {
      map['enrollment_limit'] = Variable<int>(enrollmentLimit.value);
    }
    if (currentEnrollment.present) {
      map['current_enrollment'] = Variable<int>(currentEnrollment.value);
    }
    if (courseMaterials.present) {
      map['course_materials'] = Variable<String>(courseMaterials.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MagnetCourseInfoCompanion(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('courseCode: $courseCode, ')
          ..write('courseTitle: $courseTitle, ')
          ..write('courseDescription: $courseDescription, ')
          ..write('credits: $credits, ')
          ..write('instructor: $instructor, ')
          ..write('semester: $semester, ')
          ..write('schedule: $schedule, ')
          ..write('durationInSeconds: $durationInSeconds, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('courseType: $courseType, ')
          ..write('courseLevel: $courseLevel, ')
          ..write('location: $location, ')
          ..write('enrollmentLimit: $enrollmentLimit, ')
          ..write('currentEnrollment: $currentEnrollment, ')
          ..write('courseMaterials: $courseMaterials, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MagnetFinancialTransactionTable extends MagnetFinancialTransaction
    with
        TableInfo<
          $MagnetFinancialTransactionTable,
          MagnetFinancialTransactionData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MagnetFinancialTransactionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionIDMeta = const VerificationMeta(
    'institutionID',
  );
  @override
  late final GeneratedColumn<int> institutionID = GeneratedColumn<int>(
    'institution_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceAfterTransactionMeta =
      const VerificationMeta('balanceAfterTransaction');
  @override
  late final GeneratedColumn<double> balanceAfterTransaction =
      GeneratedColumn<double>(
        'balance_after_transaction',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userID,
    institutionID,
    transactionId,
    amount,
    date,
    type,
    paymentMethod,
    studentId,
    balanceAfterTransaction,
    status,
    currency,
    description,
    referenceNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'magnet_financial_transaction';
  @override
  VerificationContext validateIntegrity(
    Insertable<MagnetFinancialTransactionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_id']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('institution_id')) {
      context.handle(
        _institutionIDMeta,
        institutionID.isAcceptableOrUnknown(
          data['institution_id']!,
          _institutionIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionIDMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('balance_after_transaction')) {
      context.handle(
        _balanceAfterTransactionMeta,
        balanceAfterTransaction.isAcceptableOrUnknown(
          data['balance_after_transaction']!,
          _balanceAfterTransactionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceAfterTransactionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    userID,
    institutionID,
    transactionId,
  };
  @override
  MagnetFinancialTransactionData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MagnetFinancialTransactionData(
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      institutionID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institution_id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      balanceAfterTransaction: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance_after_transaction'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      ),
    );
  }

  @override
  $MagnetFinancialTransactionTable createAlias(String alias) {
    return $MagnetFinancialTransactionTable(attachedDatabase, alias);
  }
}

class MagnetFinancialTransactionData extends DataClass
    implements Insertable<MagnetFinancialTransactionData> {
  final String userID;
  final int institutionID;
  final String transactionId;
  final double amount;
  final DateTime date;
  final String type;
  final String paymentMethod;
  final String studentId;
  final double balanceAfterTransaction;
  final String status;
  final String currency;
  final String? description;
  final String? referenceNumber;
  const MagnetFinancialTransactionData({
    required this.userID,
    required this.institutionID,
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.type,
    required this.paymentMethod,
    required this.studentId,
    required this.balanceAfterTransaction,
    required this.status,
    required this.currency,
    this.description,
    this.referenceNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userID);
    map['institution_id'] = Variable<int>(institutionID);
    map['transaction_id'] = Variable<String>(transactionId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['type'] = Variable<String>(type);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['student_id'] = Variable<String>(studentId);
    map['balance_after_transaction'] = Variable<double>(
      balanceAfterTransaction,
    );
    map['status'] = Variable<String>(status);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    return map;
  }

  MagnetFinancialTransactionCompanion toCompanion(bool nullToAbsent) {
    return MagnetFinancialTransactionCompanion(
      userID: Value(userID),
      institutionID: Value(institutionID),
      transactionId: Value(transactionId),
      amount: Value(amount),
      date: Value(date),
      type: Value(type),
      paymentMethod: Value(paymentMethod),
      studentId: Value(studentId),
      balanceAfterTransaction: Value(balanceAfterTransaction),
      status: Value(status),
      currency: Value(currency),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
    );
  }

  factory MagnetFinancialTransactionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MagnetFinancialTransactionData(
      userID: serializer.fromJson<String>(json['userID']),
      institutionID: serializer.fromJson<int>(json['institutionID']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      studentId: serializer.fromJson<String>(json['studentId']),
      balanceAfterTransaction: serializer.fromJson<double>(
        json['balanceAfterTransaction'],
      ),
      status: serializer.fromJson<String>(json['status']),
      currency: serializer.fromJson<String>(json['currency']),
      description: serializer.fromJson<String?>(json['description']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userID': serializer.toJson<String>(userID),
      'institutionID': serializer.toJson<int>(institutionID),
      'transactionId': serializer.toJson<String>(transactionId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'type': serializer.toJson<String>(type),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'studentId': serializer.toJson<String>(studentId),
      'balanceAfterTransaction': serializer.toJson<double>(
        balanceAfterTransaction,
      ),
      'status': serializer.toJson<String>(status),
      'currency': serializer.toJson<String>(currency),
      'description': serializer.toJson<String?>(description),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
    };
  }

  MagnetFinancialTransactionData copyWith({
    String? userID,
    int? institutionID,
    String? transactionId,
    double? amount,
    DateTime? date,
    String? type,
    String? paymentMethod,
    String? studentId,
    double? balanceAfterTransaction,
    String? status,
    String? currency,
    Value<String?> description = const Value.absent(),
    Value<String?> referenceNumber = const Value.absent(),
  }) => MagnetFinancialTransactionData(
    userID: userID ?? this.userID,
    institutionID: institutionID ?? this.institutionID,
    transactionId: transactionId ?? this.transactionId,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    type: type ?? this.type,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    studentId: studentId ?? this.studentId,
    balanceAfterTransaction:
        balanceAfterTransaction ?? this.balanceAfterTransaction,
    status: status ?? this.status,
    currency: currency ?? this.currency,
    description: description.present ? description.value : this.description,
    referenceNumber: referenceNumber.present
        ? referenceNumber.value
        : this.referenceNumber,
  );
  MagnetFinancialTransactionData copyWithCompanion(
    MagnetFinancialTransactionCompanion data,
  ) {
    return MagnetFinancialTransactionData(
      userID: data.userID.present ? data.userID.value : this.userID,
      institutionID: data.institutionID.present
          ? data.institutionID.value
          : this.institutionID,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      balanceAfterTransaction: data.balanceAfterTransaction.present
          ? data.balanceAfterTransaction.value
          : this.balanceAfterTransaction,
      status: data.status.present ? data.status.value : this.status,
      currency: data.currency.present ? data.currency.value : this.currency,
      description: data.description.present
          ? data.description.value
          : this.description,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MagnetFinancialTransactionData(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('studentId: $studentId, ')
          ..write('balanceAfterTransaction: $balanceAfterTransaction, ')
          ..write('status: $status, ')
          ..write('currency: $currency, ')
          ..write('description: $description, ')
          ..write('referenceNumber: $referenceNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userID,
    institutionID,
    transactionId,
    amount,
    date,
    type,
    paymentMethod,
    studentId,
    balanceAfterTransaction,
    status,
    currency,
    description,
    referenceNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MagnetFinancialTransactionData &&
          other.userID == this.userID &&
          other.institutionID == this.institutionID &&
          other.transactionId == this.transactionId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.type == this.type &&
          other.paymentMethod == this.paymentMethod &&
          other.studentId == this.studentId &&
          other.balanceAfterTransaction == this.balanceAfterTransaction &&
          other.status == this.status &&
          other.currency == this.currency &&
          other.description == this.description &&
          other.referenceNumber == this.referenceNumber);
}

class MagnetFinancialTransactionCompanion
    extends UpdateCompanion<MagnetFinancialTransactionData> {
  final Value<String> userID;
  final Value<int> institutionID;
  final Value<String> transactionId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> type;
  final Value<String> paymentMethod;
  final Value<String> studentId;
  final Value<double> balanceAfterTransaction;
  final Value<String> status;
  final Value<String> currency;
  final Value<String?> description;
  final Value<String?> referenceNumber;
  final Value<int> rowid;
  const MagnetFinancialTransactionCompanion({
    this.userID = const Value.absent(),
    this.institutionID = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.studentId = const Value.absent(),
    this.balanceAfterTransaction = const Value.absent(),
    this.status = const Value.absent(),
    this.currency = const Value.absent(),
    this.description = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MagnetFinancialTransactionCompanion.insert({
    required String userID,
    required int institutionID,
    required String transactionId,
    required double amount,
    required DateTime date,
    required String type,
    required String paymentMethod,
    required String studentId,
    required double balanceAfterTransaction,
    required String status,
    required String currency,
    this.description = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userID = Value(userID),
       institutionID = Value(institutionID),
       transactionId = Value(transactionId),
       amount = Value(amount),
       date = Value(date),
       type = Value(type),
       paymentMethod = Value(paymentMethod),
       studentId = Value(studentId),
       balanceAfterTransaction = Value(balanceAfterTransaction),
       status = Value(status),
       currency = Value(currency);
  static Insertable<MagnetFinancialTransactionData> custom({
    Expression<String>? userID,
    Expression<int>? institutionID,
    Expression<String>? transactionId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? type,
    Expression<String>? paymentMethod,
    Expression<String>? studentId,
    Expression<double>? balanceAfterTransaction,
    Expression<String>? status,
    Expression<String>? currency,
    Expression<String>? description,
    Expression<String>? referenceNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userID != null) 'user_id': userID,
      if (institutionID != null) 'institution_id': institutionID,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (studentId != null) 'student_id': studentId,
      if (balanceAfterTransaction != null)
        'balance_after_transaction': balanceAfterTransaction,
      if (status != null) 'status': status,
      if (currency != null) 'currency': currency,
      if (description != null) 'description': description,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MagnetFinancialTransactionCompanion copyWith({
    Value<String>? userID,
    Value<int>? institutionID,
    Value<String>? transactionId,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String>? type,
    Value<String>? paymentMethod,
    Value<String>? studentId,
    Value<double>? balanceAfterTransaction,
    Value<String>? status,
    Value<String>? currency,
    Value<String?>? description,
    Value<String?>? referenceNumber,
    Value<int>? rowid,
  }) {
    return MagnetFinancialTransactionCompanion(
      userID: userID ?? this.userID,
      institutionID: institutionID ?? this.institutionID,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      studentId: studentId ?? this.studentId,
      balanceAfterTransaction:
          balanceAfterTransaction ?? this.balanceAfterTransaction,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userID.present) {
      map['user_id'] = Variable<String>(userID.value);
    }
    if (institutionID.present) {
      map['institution_id'] = Variable<int>(institutionID.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (balanceAfterTransaction.present) {
      map['balance_after_transaction'] = Variable<double>(
        balanceAfterTransaction.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MagnetFinancialTransactionCompanion(')
          ..write('userID: $userID, ')
          ..write('institutionID: $institutionID, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('studentId: $studentId, ')
          ..write('balanceAfterTransaction: $balanceAfterTransaction, ')
          ..write('status: $status, ')
          ..write('currency: $currency, ')
          ..write('description: $description, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityTableTable extends CommunityTable
    with TableInfo<$CommunityTableTable, CommunityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creatorIdMeta = const VerificationMeta(
    'creatorId',
  );
  @override
  late final GeneratedColumn<String> creatorId = GeneratedColumn<String>(
    'creator_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creatorNameMeta = const VerificationMeta(
    'creatorName',
  );
  @override
  late final GeneratedColumn<String> creatorName = GeneratedColumn<String>(
    'creator_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  moderators = GeneratedColumn<String>(
    'moderators',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<dynamic>?>($CommunityTableTable.$convertermoderatorsn);
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  moderatorNames =
      GeneratedColumn<String>(
        'moderator_names',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<dynamic>?>(
        $CommunityTableTable.$convertermoderatorNamesn,
      );
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> members =
      GeneratedColumn<String>(
        'members',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<dynamic>?>($CommunityTableTable.$convertermembersn);
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  memberNames = GeneratedColumn<String>(
    'member_names',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<dynamic>?>($CommunityTableTable.$convertermemberNamesn);
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  bannedUsers = GeneratedColumn<String>(
    'banned_users',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<dynamic>?>($CommunityTableTable.$converterbannedUsersn);
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  bannedUserNames =
      GeneratedColumn<String>(
        'banned_user_names',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<dynamic>?>(
        $CommunityTableTable.$converterbannedUserNamesn,
      );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String> rules =
      GeneratedColumn<String>(
        'rules',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<dynamic>?>($CommunityTableTable.$converterrulesn);
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bannerUrlMeta = const VerificationMeta(
    'bannerUrl',
  );
  @override
  late final GeneratedColumn<String> bannerUrl = GeneratedColumn<String>(
    'banner_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _canModerateMeta = const VerificationMeta(
    'canModerate',
  );
  @override
  late final GeneratedColumn<bool> canModerate = GeneratedColumn<bool>(
    'can_moderate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_moderate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _canPostMeta = const VerificationMeta(
    'canPost',
  );
  @override
  late final GeneratedColumn<bool> canPost = GeneratedColumn<bool>(
    'can_post',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_post" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isBannedMeta = const VerificationMeta(
    'isBanned',
  );
  @override
  late final GeneratedColumn<bool> isBanned = GeneratedColumn<bool>(
    'is_banned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_banned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _memberCountMeta = const VerificationMeta(
    'memberCount',
  );
  @override
  late final GeneratedColumn<int> memberCount = GeneratedColumn<int>(
    'member_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    creatorId,
    creatorName,
    moderators,
    moderatorNames,
    members,
    memberNames,
    bannedUsers,
    bannedUserNames,
    isPrivate,
    rules,
    logoUrl,
    bannerUrl,
    createdAt,
    updatedAt,
    canModerate,
    canPost,
    isBanned,
    memberCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('creator_id')) {
      context.handle(
        _creatorIdMeta,
        creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta),
      );
    }
    if (data.containsKey('creator_name')) {
      context.handle(
        _creatorNameMeta,
        creatorName.isAcceptableOrUnknown(
          data['creator_name']!,
          _creatorNameMeta,
        ),
      );
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('banner_url')) {
      context.handle(
        _bannerUrlMeta,
        bannerUrl.isAcceptableOrUnknown(data['banner_url']!, _bannerUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('can_moderate')) {
      context.handle(
        _canModerateMeta,
        canModerate.isAcceptableOrUnknown(
          data['can_moderate']!,
          _canModerateMeta,
        ),
      );
    }
    if (data.containsKey('can_post')) {
      context.handle(
        _canPostMeta,
        canPost.isAcceptableOrUnknown(data['can_post']!, _canPostMeta),
      );
    }
    if (data.containsKey('is_banned')) {
      context.handle(
        _isBannedMeta,
        isBanned.isAcceptableOrUnknown(data['is_banned']!, _isBannedMeta),
      );
    }
    if (data.containsKey('member_count')) {
      context.handle(
        _memberCountMeta,
        memberCount.isAcceptableOrUnknown(
          data['member_count']!,
          _memberCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      creatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creator_id'],
      ),
      creatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creator_name'],
      ),
      moderators: $CommunityTableTable.$convertermoderatorsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}moderators'],
        ),
      ),
      moderatorNames: $CommunityTableTable.$convertermoderatorNamesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}moderator_names'],
        ),
      ),
      members: $CommunityTableTable.$convertermembersn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}members'],
        ),
      ),
      memberNames: $CommunityTableTable.$convertermemberNamesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}member_names'],
        ),
      ),
      bannedUsers: $CommunityTableTable.$converterbannedUsersn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}banned_users'],
        ),
      ),
      bannedUserNames: $CommunityTableTable.$converterbannedUserNamesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}banned_user_names'],
        ),
      ),
      isPrivate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_private'],
      )!,
      rules: $CommunityTableTable.$converterrulesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rules'],
        ),
      ),
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      bannerUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      canModerate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_moderate'],
      )!,
      canPost: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_post'],
      )!,
      isBanned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_banned'],
      )!,
      memberCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_count'],
      )!,
    );
  }

  @override
  $CommunityTableTable createAlias(String alias) {
    return $CommunityTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<dynamic>, String> $convertermoderators =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $convertermoderatorsn =
      NullAwareTypeConverter.wrap($convertermoderators);
  static TypeConverter<List<dynamic>, String> $convertermoderatorNames =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $convertermoderatorNamesn =
      NullAwareTypeConverter.wrap($convertermoderatorNames);
  static TypeConverter<List<dynamic>, String> $convertermembers =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $convertermembersn =
      NullAwareTypeConverter.wrap($convertermembers);
  static TypeConverter<List<dynamic>, String> $convertermemberNames =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $convertermemberNamesn =
      NullAwareTypeConverter.wrap($convertermemberNames);
  static TypeConverter<List<dynamic>, String> $converterbannedUsers =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterbannedUsersn =
      NullAwareTypeConverter.wrap($converterbannedUsers);
  static TypeConverter<List<dynamic>, String> $converterbannedUserNames =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterbannedUserNamesn =
      NullAwareTypeConverter.wrap($converterbannedUserNames);
  static TypeConverter<List<dynamic>, String> $converterrules =
      const JsonListConverter();
  static TypeConverter<List<dynamic>?, String?> $converterrulesn =
      NullAwareTypeConverter.wrap($converterrules);
}

class CommunityData extends DataClass implements Insertable<CommunityData> {
  final int id;
  final String name;
  final String? description;
  final String? creatorId;
  final String? creatorName;

  /// Moderators (IDs)
  final List<dynamic>? moderators;

  /// Moderator names
  final List<dynamic>? moderatorNames;

  /// Members (IDs)
  final List<dynamic>? members;

  /// Member names
  final List<dynamic>? memberNames;

  /// Banned users (IDs)
  final List<dynamic>? bannedUsers;

  /// Banned user names
  final List<dynamic>? bannedUserNames;
  final bool isPrivate;
  final List<dynamic>? rules;
  final String? logoUrl;
  final String? bannerUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool canModerate;
  final bool canPost;
  final bool isBanned;
  final int memberCount;
  const CommunityData({
    required this.id,
    required this.name,
    this.description,
    this.creatorId,
    this.creatorName,
    this.moderators,
    this.moderatorNames,
    this.members,
    this.memberNames,
    this.bannedUsers,
    this.bannedUserNames,
    required this.isPrivate,
    this.rules,
    this.logoUrl,
    this.bannerUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.canModerate,
    required this.canPost,
    required this.isBanned,
    required this.memberCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || creatorId != null) {
      map['creator_id'] = Variable<String>(creatorId);
    }
    if (!nullToAbsent || creatorName != null) {
      map['creator_name'] = Variable<String>(creatorName);
    }
    if (!nullToAbsent || moderators != null) {
      map['moderators'] = Variable<String>(
        $CommunityTableTable.$convertermoderatorsn.toSql(moderators),
      );
    }
    if (!nullToAbsent || moderatorNames != null) {
      map['moderator_names'] = Variable<String>(
        $CommunityTableTable.$convertermoderatorNamesn.toSql(moderatorNames),
      );
    }
    if (!nullToAbsent || members != null) {
      map['members'] = Variable<String>(
        $CommunityTableTable.$convertermembersn.toSql(members),
      );
    }
    if (!nullToAbsent || memberNames != null) {
      map['member_names'] = Variable<String>(
        $CommunityTableTable.$convertermemberNamesn.toSql(memberNames),
      );
    }
    if (!nullToAbsent || bannedUsers != null) {
      map['banned_users'] = Variable<String>(
        $CommunityTableTable.$converterbannedUsersn.toSql(bannedUsers),
      );
    }
    if (!nullToAbsent || bannedUserNames != null) {
      map['banned_user_names'] = Variable<String>(
        $CommunityTableTable.$converterbannedUserNamesn.toSql(bannedUserNames),
      );
    }
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || rules != null) {
      map['rules'] = Variable<String>(
        $CommunityTableTable.$converterrulesn.toSql(rules),
      );
    }
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || bannerUrl != null) {
      map['banner_url'] = Variable<String>(bannerUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['can_moderate'] = Variable<bool>(canModerate);
    map['can_post'] = Variable<bool>(canPost);
    map['is_banned'] = Variable<bool>(isBanned);
    map['member_count'] = Variable<int>(memberCount);
    return map;
  }

  CommunityTableCompanion toCompanion(bool nullToAbsent) {
    return CommunityTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      creatorId: creatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(creatorId),
      creatorName: creatorName == null && nullToAbsent
          ? const Value.absent()
          : Value(creatorName),
      moderators: moderators == null && nullToAbsent
          ? const Value.absent()
          : Value(moderators),
      moderatorNames: moderatorNames == null && nullToAbsent
          ? const Value.absent()
          : Value(moderatorNames),
      members: members == null && nullToAbsent
          ? const Value.absent()
          : Value(members),
      memberNames: memberNames == null && nullToAbsent
          ? const Value.absent()
          : Value(memberNames),
      bannedUsers: bannedUsers == null && nullToAbsent
          ? const Value.absent()
          : Value(bannedUsers),
      bannedUserNames: bannedUserNames == null && nullToAbsent
          ? const Value.absent()
          : Value(bannedUserNames),
      isPrivate: Value(isPrivate),
      rules: rules == null && nullToAbsent
          ? const Value.absent()
          : Value(rules),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      bannerUrl: bannerUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(bannerUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      canModerate: Value(canModerate),
      canPost: Value(canPost),
      isBanned: Value(isBanned),
      memberCount: Value(memberCount),
    );
  }

  factory CommunityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      creatorId: serializer.fromJson<String?>(json['creator_id']),
      creatorName: serializer.fromJson<String?>(json['creator_name']),
      moderators: serializer.fromJson<List<dynamic>?>(json['moderators']),
      moderatorNames: serializer.fromJson<List<dynamic>?>(
        json['moderator_names'],
      ),
      members: serializer.fromJson<List<dynamic>?>(json['members']),
      memberNames: serializer.fromJson<List<dynamic>?>(json['member_names']),
      bannedUsers: serializer.fromJson<List<dynamic>?>(json['banned_users']),
      bannedUserNames: serializer.fromJson<List<dynamic>?>(
        json['banned_user_names'],
      ),
      isPrivate: serializer.fromJson<bool>(json['is_private']),
      rules: serializer.fromJson<List<dynamic>?>(json['rules']),
      logoUrl: serializer.fromJson<String?>(json['logo_url']),
      bannerUrl: serializer.fromJson<String?>(json['banner_url']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      canModerate: serializer.fromJson<bool>(json['can_moderate']),
      canPost: serializer.fromJson<bool>(json['can_post']),
      isBanned: serializer.fromJson<bool>(json['is_banned']),
      memberCount: serializer.fromJson<int>(json['member_count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'creator_id': serializer.toJson<String?>(creatorId),
      'creator_name': serializer.toJson<String?>(creatorName),
      'moderators': serializer.toJson<List<dynamic>?>(moderators),
      'moderator_names': serializer.toJson<List<dynamic>?>(moderatorNames),
      'members': serializer.toJson<List<dynamic>?>(members),
      'member_names': serializer.toJson<List<dynamic>?>(memberNames),
      'banned_users': serializer.toJson<List<dynamic>?>(bannedUsers),
      'banned_user_names': serializer.toJson<List<dynamic>?>(bannedUserNames),
      'is_private': serializer.toJson<bool>(isPrivate),
      'rules': serializer.toJson<List<dynamic>?>(rules),
      'logo_url': serializer.toJson<String?>(logoUrl),
      'banner_url': serializer.toJson<String?>(bannerUrl),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'can_moderate': serializer.toJson<bool>(canModerate),
      'can_post': serializer.toJson<bool>(canPost),
      'is_banned': serializer.toJson<bool>(isBanned),
      'member_count': serializer.toJson<int>(memberCount),
    };
  }

  CommunityData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> creatorId = const Value.absent(),
    Value<String?> creatorName = const Value.absent(),
    Value<List<dynamic>?> moderators = const Value.absent(),
    Value<List<dynamic>?> moderatorNames = const Value.absent(),
    Value<List<dynamic>?> members = const Value.absent(),
    Value<List<dynamic>?> memberNames = const Value.absent(),
    Value<List<dynamic>?> bannedUsers = const Value.absent(),
    Value<List<dynamic>?> bannedUserNames = const Value.absent(),
    bool? isPrivate,
    Value<List<dynamic>?> rules = const Value.absent(),
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> bannerUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? canModerate,
    bool? canPost,
    bool? isBanned,
    int? memberCount,
  }) => CommunityData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    creatorId: creatorId.present ? creatorId.value : this.creatorId,
    creatorName: creatorName.present ? creatorName.value : this.creatorName,
    moderators: moderators.present ? moderators.value : this.moderators,
    moderatorNames: moderatorNames.present
        ? moderatorNames.value
        : this.moderatorNames,
    members: members.present ? members.value : this.members,
    memberNames: memberNames.present ? memberNames.value : this.memberNames,
    bannedUsers: bannedUsers.present ? bannedUsers.value : this.bannedUsers,
    bannedUserNames: bannedUserNames.present
        ? bannedUserNames.value
        : this.bannedUserNames,
    isPrivate: isPrivate ?? this.isPrivate,
    rules: rules.present ? rules.value : this.rules,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    bannerUrl: bannerUrl.present ? bannerUrl.value : this.bannerUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    canModerate: canModerate ?? this.canModerate,
    canPost: canPost ?? this.canPost,
    isBanned: isBanned ?? this.isBanned,
    memberCount: memberCount ?? this.memberCount,
  );
  CommunityData copyWithCompanion(CommunityTableCompanion data) {
    return CommunityData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      creatorId: data.creatorId.present ? data.creatorId.value : this.creatorId,
      creatorName: data.creatorName.present
          ? data.creatorName.value
          : this.creatorName,
      moderators: data.moderators.present
          ? data.moderators.value
          : this.moderators,
      moderatorNames: data.moderatorNames.present
          ? data.moderatorNames.value
          : this.moderatorNames,
      members: data.members.present ? data.members.value : this.members,
      memberNames: data.memberNames.present
          ? data.memberNames.value
          : this.memberNames,
      bannedUsers: data.bannedUsers.present
          ? data.bannedUsers.value
          : this.bannedUsers,
      bannedUserNames: data.bannedUserNames.present
          ? data.bannedUserNames.value
          : this.bannedUserNames,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      rules: data.rules.present ? data.rules.value : this.rules,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      bannerUrl: data.bannerUrl.present ? data.bannerUrl.value : this.bannerUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      canModerate: data.canModerate.present
          ? data.canModerate.value
          : this.canModerate,
      canPost: data.canPost.present ? data.canPost.value : this.canPost,
      isBanned: data.isBanned.present ? data.isBanned.value : this.isBanned,
      memberCount: data.memberCount.present
          ? data.memberCount.value
          : this.memberCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('creatorId: $creatorId, ')
          ..write('creatorName: $creatorName, ')
          ..write('moderators: $moderators, ')
          ..write('moderatorNames: $moderatorNames, ')
          ..write('members: $members, ')
          ..write('memberNames: $memberNames, ')
          ..write('bannedUsers: $bannedUsers, ')
          ..write('bannedUserNames: $bannedUserNames, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('rules: $rules, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('canModerate: $canModerate, ')
          ..write('canPost: $canPost, ')
          ..write('isBanned: $isBanned, ')
          ..write('memberCount: $memberCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    description,
    creatorId,
    creatorName,
    moderators,
    moderatorNames,
    members,
    memberNames,
    bannedUsers,
    bannedUserNames,
    isPrivate,
    rules,
    logoUrl,
    bannerUrl,
    createdAt,
    updatedAt,
    canModerate,
    canPost,
    isBanned,
    memberCount,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.creatorId == this.creatorId &&
          other.creatorName == this.creatorName &&
          other.moderators == this.moderators &&
          other.moderatorNames == this.moderatorNames &&
          other.members == this.members &&
          other.memberNames == this.memberNames &&
          other.bannedUsers == this.bannedUsers &&
          other.bannedUserNames == this.bannedUserNames &&
          other.isPrivate == this.isPrivate &&
          other.rules == this.rules &&
          other.logoUrl == this.logoUrl &&
          other.bannerUrl == this.bannerUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.canModerate == this.canModerate &&
          other.canPost == this.canPost &&
          other.isBanned == this.isBanned &&
          other.memberCount == this.memberCount);
}

class CommunityTableCompanion extends UpdateCompanion<CommunityData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> creatorId;
  final Value<String?> creatorName;
  final Value<List<dynamic>?> moderators;
  final Value<List<dynamic>?> moderatorNames;
  final Value<List<dynamic>?> members;
  final Value<List<dynamic>?> memberNames;
  final Value<List<dynamic>?> bannedUsers;
  final Value<List<dynamic>?> bannedUserNames;
  final Value<bool> isPrivate;
  final Value<List<dynamic>?> rules;
  final Value<String?> logoUrl;
  final Value<String?> bannerUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> canModerate;
  final Value<bool> canPost;
  final Value<bool> isBanned;
  final Value<int> memberCount;
  const CommunityTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorName = const Value.absent(),
    this.moderators = const Value.absent(),
    this.moderatorNames = const Value.absent(),
    this.members = const Value.absent(),
    this.memberNames = const Value.absent(),
    this.bannedUsers = const Value.absent(),
    this.bannedUserNames = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.rules = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.canModerate = const Value.absent(),
    this.canPost = const Value.absent(),
    this.isBanned = const Value.absent(),
    this.memberCount = const Value.absent(),
  });
  CommunityTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.creatorName = const Value.absent(),
    this.moderators = const Value.absent(),
    this.moderatorNames = const Value.absent(),
    this.members = const Value.absent(),
    this.memberNames = const Value.absent(),
    this.bannedUsers = const Value.absent(),
    this.bannedUserNames = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.rules = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.canModerate = const Value.absent(),
    this.canPost = const Value.absent(),
    this.isBanned = const Value.absent(),
    this.memberCount = const Value.absent(),
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CommunityData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? creatorId,
    Expression<String>? creatorName,
    Expression<String>? moderators,
    Expression<String>? moderatorNames,
    Expression<String>? members,
    Expression<String>? memberNames,
    Expression<String>? bannedUsers,
    Expression<String>? bannedUserNames,
    Expression<bool>? isPrivate,
    Expression<String>? rules,
    Expression<String>? logoUrl,
    Expression<String>? bannerUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? canModerate,
    Expression<bool>? canPost,
    Expression<bool>? isBanned,
    Expression<int>? memberCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (creatorId != null) 'creator_id': creatorId,
      if (creatorName != null) 'creator_name': creatorName,
      if (moderators != null) 'moderators': moderators,
      if (moderatorNames != null) 'moderator_names': moderatorNames,
      if (members != null) 'members': members,
      if (memberNames != null) 'member_names': memberNames,
      if (bannedUsers != null) 'banned_users': bannedUsers,
      if (bannedUserNames != null) 'banned_user_names': bannedUserNames,
      if (isPrivate != null) 'is_private': isPrivate,
      if (rules != null) 'rules': rules,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (bannerUrl != null) 'banner_url': bannerUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (canModerate != null) 'can_moderate': canModerate,
      if (canPost != null) 'can_post': canPost,
      if (isBanned != null) 'is_banned': isBanned,
      if (memberCount != null) 'member_count': memberCount,
    });
  }

  CommunityTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? creatorId,
    Value<String?>? creatorName,
    Value<List<dynamic>?>? moderators,
    Value<List<dynamic>?>? moderatorNames,
    Value<List<dynamic>?>? members,
    Value<List<dynamic>?>? memberNames,
    Value<List<dynamic>?>? bannedUsers,
    Value<List<dynamic>?>? bannedUserNames,
    Value<bool>? isPrivate,
    Value<List<dynamic>?>? rules,
    Value<String?>? logoUrl,
    Value<String?>? bannerUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? canModerate,
    Value<bool>? canPost,
    Value<bool>? isBanned,
    Value<int>? memberCount,
  }) {
    return CommunityTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      moderators: moderators ?? this.moderators,
      moderatorNames: moderatorNames ?? this.moderatorNames,
      members: members ?? this.members,
      memberNames: memberNames ?? this.memberNames,
      bannedUsers: bannedUsers ?? this.bannedUsers,
      bannedUserNames: bannedUserNames ?? this.bannedUserNames,
      isPrivate: isPrivate ?? this.isPrivate,
      rules: rules ?? this.rules,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      canModerate: canModerate ?? this.canModerate,
      canPost: canPost ?? this.canPost,
      isBanned: isBanned ?? this.isBanned,
      memberCount: memberCount ?? this.memberCount,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<String>(creatorId.value);
    }
    if (creatorName.present) {
      map['creator_name'] = Variable<String>(creatorName.value);
    }
    if (moderators.present) {
      map['moderators'] = Variable<String>(
        $CommunityTableTable.$convertermoderatorsn.toSql(moderators.value),
      );
    }
    if (moderatorNames.present) {
      map['moderator_names'] = Variable<String>(
        $CommunityTableTable.$convertermoderatorNamesn.toSql(
          moderatorNames.value,
        ),
      );
    }
    if (members.present) {
      map['members'] = Variable<String>(
        $CommunityTableTable.$convertermembersn.toSql(members.value),
      );
    }
    if (memberNames.present) {
      map['member_names'] = Variable<String>(
        $CommunityTableTable.$convertermemberNamesn.toSql(memberNames.value),
      );
    }
    if (bannedUsers.present) {
      map['banned_users'] = Variable<String>(
        $CommunityTableTable.$converterbannedUsersn.toSql(bannedUsers.value),
      );
    }
    if (bannedUserNames.present) {
      map['banned_user_names'] = Variable<String>(
        $CommunityTableTable.$converterbannedUserNamesn.toSql(
          bannedUserNames.value,
        ),
      );
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (rules.present) {
      map['rules'] = Variable<String>(
        $CommunityTableTable.$converterrulesn.toSql(rules.value),
      );
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (bannerUrl.present) {
      map['banner_url'] = Variable<String>(bannerUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (canModerate.present) {
      map['can_moderate'] = Variable<bool>(canModerate.value);
    }
    if (canPost.present) {
      map['can_post'] = Variable<bool>(canPost.value);
    }
    if (isBanned.present) {
      map['is_banned'] = Variable<bool>(isBanned.value);
    }
    if (memberCount.present) {
      map['member_count'] = Variable<int>(memberCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('creatorId: $creatorId, ')
          ..write('creatorName: $creatorName, ')
          ..write('moderators: $moderators, ')
          ..write('moderatorNames: $moderatorNames, ')
          ..write('members: $members, ')
          ..write('memberNames: $memberNames, ')
          ..write('bannedUsers: $bannedUsers, ')
          ..write('bannedUserNames: $bannedUserNames, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('rules: $rules, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('canModerate: $canModerate, ')
          ..write('canPost: $canPost, ')
          ..write('isBanned: $isBanned, ')
          ..write('memberCount: $memberCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  $AppDataBaseManager get managers => $AppDataBaseManager(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  late final $TokenTable token = $TokenTable(this);
  late final $ChirpUserTableTable chirpUserTable = $ChirpUserTableTable(this);
  late final $MessageTableTable messageTable = $MessageTableTable(this);
  late final $ConversationTableTable conversationTable =
      $ConversationTableTable(this);
  late final $GroupTableTable groupTable = $GroupTableTable(this);
  late final $PostTableTable postTable = $PostTableTable(this);
  late final $AttachmentTableTable attachmentTable = $AttachmentTableTable(
    this,
  );
  late final $PostReplyTableTable postReplyTable = $PostReplyTableTable(this);
  late final $TodoTable todo = $TodoTable(this);
  late final $EventTableTable eventTable = $EventTableTable(this);
  late final $AttendeeTableTable attendeeTable = $AttendeeTableTable(this);
  late final $TicketTableTable ticketTable = $TicketTableTable(this);
  late final $AgendaEventTable agendaEvent = $AgendaEventTable(this);
  late final $NotificationTableTable notificationTable =
      $NotificationTableTable(this);
  late final $InstitutionTable institution = $InstitutionTable(this);
  late final $MagnetStudentProfileTable magnetStudentProfile =
      $MagnetStudentProfileTable(this);
  late final $MagnetCredentialsTable magnetCredentials =
      $MagnetCredentialsTable(this);
  late final $MagnetCourseInfoTable magnetCourseInfo = $MagnetCourseInfoTable(
    this,
  );
  late final $MagnetFinancialTransactionTable magnetFinancialTransaction =
      $MagnetFinancialTransactionTable(this);
  late final $CommunityTableTable communityTable = $CommunityTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfile,
    token,
    chirpUserTable,
    messageTable,
    conversationTable,
    groupTable,
    postTable,
    attachmentTable,
    postReplyTable,
    todo,
    eventTable,
    attendeeTable,
    ticketTable,
    agendaEvent,
    notificationTable,
    institution,
    magnetStudentProfile,
    magnetCredentials,
    magnetCourseInfo,
    magnetFinancialTransaction,
    communityTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'post_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attachment_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'post_reply_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('post_reply_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'post_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('post_reply_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserProfileTableCreateCompanionBuilder =
    UserProfileCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      Value<String?> username,
      required String email,
      Value<bool> termsAccepted,
      Value<bool> onboarded,
      Value<String?> nationalID,
      Value<String?> avatarUrl,
      Value<String?> bio,
      Value<String?> phone,
      Value<int> vibePoints,
      Value<int> rowid,
    });
typedef $$UserProfileTableUpdateCompanionBuilder =
    UserProfileCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String?> username,
      Value<String> email,
      Value<bool> termsAccepted,
      Value<bool> onboarded,
      Value<String?> nationalID,
      Value<String?> avatarUrl,
      Value<String?> bio,
      Value<String?> phone,
      Value<int> vibePoints,
      Value<int> rowid,
    });

class $$UserProfileTableFilterComposer
    extends Composer<_$AppDataBase, $UserProfileTable> {
  $$UserProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get termsAccepted => $composableBuilder(
    column: $table.termsAccepted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalID => $composableBuilder(
    column: $table.nationalID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vibePoints => $composableBuilder(
    column: $table.vibePoints,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableOrderingComposer
    extends Composer<_$AppDataBase, $UserProfileTable> {
  $$UserProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get termsAccepted => $composableBuilder(
    column: $table.termsAccepted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalID => $composableBuilder(
    column: $table.nationalID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vibePoints => $composableBuilder(
    column: $table.vibePoints,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableAnnotationComposer
    extends Composer<_$AppDataBase, $UserProfileTable> {
  $$UserProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get termsAccepted => $composableBuilder(
    column: $table.termsAccepted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboarded =>
      $composableBuilder(column: $table.onboarded, builder: (column) => column);

  GeneratedColumn<String> get nationalID => $composableBuilder(
    column: $table.nationalID,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get vibePoints => $composableBuilder(
    column: $table.vibePoints,
    builder: (column) => column,
  );
}

class $$UserProfileTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $UserProfileTable,
          UserProfileData,
          $$UserProfileTableFilterComposer,
          $$UserProfileTableOrderingComposer,
          $$UserProfileTableAnnotationComposer,
          $$UserProfileTableCreateCompanionBuilder,
          $$UserProfileTableUpdateCompanionBuilder,
          (
            UserProfileData,
            BaseReferences<_$AppDataBase, $UserProfileTable, UserProfileData>,
          ),
          UserProfileData,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableManager(_$AppDataBase db, $UserProfileTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<bool> termsAccepted = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
                Value<String?> nationalID = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int> vibePoints = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfileCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                username: username,
                email: email,
                termsAccepted: termsAccepted,
                onboarded: onboarded,
                nationalID: nationalID,
                avatarUrl: avatarUrl,
                bio: bio,
                phone: phone,
                vibePoints: vibePoints,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                Value<String?> username = const Value.absent(),
                required String email,
                Value<bool> termsAccepted = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
                Value<String?> nationalID = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int> vibePoints = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfileCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                username: username,
                email: email,
                termsAccepted: termsAccepted,
                onboarded: onboarded,
                nationalID: nationalID,
                avatarUrl: avatarUrl,
                bio: bio,
                phone: phone,
                vibePoints: vibePoints,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $UserProfileTable,
      UserProfileData,
      $$UserProfileTableFilterComposer,
      $$UserProfileTableOrderingComposer,
      $$UserProfileTableAnnotationComposer,
      $$UserProfileTableCreateCompanionBuilder,
      $$UserProfileTableUpdateCompanionBuilder,
      (
        UserProfileData,
        BaseReferences<_$AppDataBase, $UserProfileTable, UserProfileData>,
      ),
      UserProfileData,
      PrefetchHooks Function()
    >;
typedef $$TokenTableCreateCompanionBuilder =
    TokenCompanion Function({
      Value<int> id,
      required String accessToken,
      required String refreshToken,
      required String provider,
      Value<DateTime?> expiresAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TokenTableUpdateCompanionBuilder =
    TokenCompanion Function({
      Value<int> id,
      Value<String> accessToken,
      Value<String> refreshToken,
      Value<String> provider,
      Value<DateTime?> expiresAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$TokenTableFilterComposer extends Composer<_$AppDataBase, $TokenTable> {
  $$TokenTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TokenTableOrderingComposer
    extends Composer<_$AppDataBase, $TokenTable> {
  $$TokenTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TokenTableAnnotationComposer
    extends Composer<_$AppDataBase, $TokenTable> {
  $$TokenTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TokenTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $TokenTable,
          TokenData,
          $$TokenTableFilterComposer,
          $$TokenTableOrderingComposer,
          $$TokenTableAnnotationComposer,
          $$TokenTableCreateCompanionBuilder,
          $$TokenTableUpdateCompanionBuilder,
          (TokenData, BaseReferences<_$AppDataBase, $TokenTable, TokenData>),
          TokenData,
          PrefetchHooks Function()
        > {
  $$TokenTableTableManager(_$AppDataBase db, $TokenTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TokenTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TokenTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TokenTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> accessToken = const Value.absent(),
                Value<String> refreshToken = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TokenCompanion(
                id: id,
                accessToken: accessToken,
                refreshToken: refreshToken,
                provider: provider,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String accessToken,
                required String refreshToken,
                required String provider,
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TokenCompanion.insert(
                id: id,
                accessToken: accessToken,
                refreshToken: refreshToken,
                provider: provider,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TokenTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $TokenTable,
      TokenData,
      $$TokenTableFilterComposer,
      $$TokenTableOrderingComposer,
      $$TokenTableAnnotationComposer,
      $$TokenTableCreateCompanionBuilder,
      $$TokenTableUpdateCompanionBuilder,
      (TokenData, BaseReferences<_$AppDataBase, $TokenTable, TokenData>),
      TokenData,
      PrefetchHooks Function()
    >;
typedef $$ChirpUserTableTableCreateCompanionBuilder =
    ChirpUserTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      required String email,
      Value<int> vibepoints,
      Value<String?> avatarUrl,
      Value<int> rowid,
    });
typedef $$ChirpUserTableTableUpdateCompanionBuilder =
    ChirpUserTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String> email,
      Value<int> vibepoints,
      Value<String?> avatarUrl,
      Value<int> rowid,
    });

final class $$ChirpUserTableTableReferences
    extends BaseReferences<_$AppDataBase, $ChirpUserTableTable, ChirpUserData> {
  $$ChirpUserTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ConversationTableTable, List<ConversationData>>
  _conversationTableRefsTable(_$AppDataBase db) =>
      MultiTypedResultKey.fromTable(
        db.conversationTable,
        aliasName: $_aliasNameGenerator(
          db.chirpUserTable.id,
          db.conversationTable.userId,
        ),
      );

  $$ConversationTableTableProcessedTableManager get conversationTableRefs {
    final manager = $$ConversationTableTableTableManager(
      $_db,
      $_db.conversationTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _conversationTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChirpUserTableTableFilterComposer
    extends Composer<_$AppDataBase, $ChirpUserTableTable> {
  $$ChirpUserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vibepoints => $composableBuilder(
    column: $table.vibepoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> conversationTableRefs(
    Expression<bool> Function($$ConversationTableTableFilterComposer f) f,
  ) {
    final $$ConversationTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.conversationTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationTableTableFilterComposer(
            $db: $db,
            $table: $db.conversationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChirpUserTableTableOrderingComposer
    extends Composer<_$AppDataBase, $ChirpUserTableTable> {
  $$ChirpUserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vibepoints => $composableBuilder(
    column: $table.vibepoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChirpUserTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $ChirpUserTableTable> {
  $$ChirpUserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<int> get vibepoints => $composableBuilder(
    column: $table.vibepoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  Expression<T> conversationTableRefs<T extends Object>(
    Expression<T> Function($$ConversationTableTableAnnotationComposer a) f,
  ) {
    final $$ConversationTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.conversationTable,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ConversationTableTableAnnotationComposer(
                $db: $db,
                $table: $db.conversationTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChirpUserTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $ChirpUserTableTable,
          ChirpUserData,
          $$ChirpUserTableTableFilterComposer,
          $$ChirpUserTableTableOrderingComposer,
          $$ChirpUserTableTableAnnotationComposer,
          $$ChirpUserTableTableCreateCompanionBuilder,
          $$ChirpUserTableTableUpdateCompanionBuilder,
          (ChirpUserData, $$ChirpUserTableTableReferences),
          ChirpUserData,
          PrefetchHooks Function({bool conversationTableRefs})
        > {
  $$ChirpUserTableTableTableManager(
    _$AppDataBase db,
    $ChirpUserTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChirpUserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChirpUserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChirpUserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<int> vibepoints = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChirpUserTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                email: email,
                vibepoints: vibepoints,
                avatarUrl: avatarUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                required String email,
                Value<int> vibepoints = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChirpUserTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                email: email,
                vibepoints: vibepoints,
                avatarUrl: avatarUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChirpUserTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({conversationTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (conversationTableRefs) db.conversationTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (conversationTableRefs)
                    await $_getPrefetchedData<
                      ChirpUserData,
                      $ChirpUserTableTable,
                      ConversationData
                    >(
                      currentTable: table,
                      referencedTable: $$ChirpUserTableTableReferences
                          ._conversationTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChirpUserTableTableReferences(
                            db,
                            table,
                            p0,
                          ).conversationTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChirpUserTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $ChirpUserTableTable,
      ChirpUserData,
      $$ChirpUserTableTableFilterComposer,
      $$ChirpUserTableTableOrderingComposer,
      $$ChirpUserTableTableAnnotationComposer,
      $$ChirpUserTableTableCreateCompanionBuilder,
      $$ChirpUserTableTableUpdateCompanionBuilder,
      (ChirpUserData, $$ChirpUserTableTableReferences),
      ChirpUserData,
      PrefetchHooks Function({bool conversationTableRefs})
    >;
typedef $$MessageTableTableCreateCompanionBuilder =
    MessageTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String content,
      required String senderId,
      required String recipientId,
      required DateTime sentAt,
      Value<bool> isRead,
      Value<String?> imageUrl,
      Value<int> rowid,
    });
typedef $$MessageTableTableUpdateCompanionBuilder =
    MessageTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> content,
      Value<String> senderId,
      Value<String> recipientId,
      Value<DateTime> sentAt,
      Value<bool> isRead,
      Value<String?> imageUrl,
      Value<int> rowid,
    });

final class $$MessageTableTableReferences
    extends BaseReferences<_$AppDataBase, $MessageTableTable, MessageData> {
  $$MessageTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChirpUserTableTable _senderIdTable(_$AppDataBase db) =>
      db.chirpUserTable.createAlias(
        $_aliasNameGenerator(db.messageTable.senderId, db.chirpUserTable.id),
      );

  $$ChirpUserTableTableProcessedTableManager get senderId {
    final $_column = $_itemColumn<String>('sender_id')!;

    final manager = $$ChirpUserTableTableTableManager(
      $_db,
      $_db.chirpUserTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_senderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChirpUserTableTable _recipientIdTable(_$AppDataBase db) =>
      db.chirpUserTable.createAlias(
        $_aliasNameGenerator(db.messageTable.recipientId, db.chirpUserTable.id),
      );

  $$ChirpUserTableTableProcessedTableManager get recipientId {
    final $_column = $_itemColumn<String>('recipient_id')!;

    final manager = $$ChirpUserTableTableTableManager(
      $_db,
      $_db.chirpUserTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ConversationTableTable, List<ConversationData>>
  _conversationTableRefsTable(_$AppDataBase db) =>
      MultiTypedResultKey.fromTable(
        db.conversationTable,
        aliasName: $_aliasNameGenerator(
          db.messageTable.id,
          db.conversationTable.lastMessageId,
        ),
      );

  $$ConversationTableTableProcessedTableManager get conversationTableRefs {
    final manager = $$ConversationTableTableTableManager(
      $_db,
      $_db.conversationTable,
    ).filter((f) => f.lastMessageId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _conversationTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MessageTableTableFilterComposer
    extends Composer<_$AppDataBase, $MessageTableTable> {
  $$MessageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$ChirpUserTableTableFilterComposer get senderId {
    final $$ChirpUserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableFilterComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChirpUserTableTableFilterComposer get recipientId {
    final $$ChirpUserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableFilterComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> conversationTableRefs(
    Expression<bool> Function($$ConversationTableTableFilterComposer f) f,
  ) {
    final $$ConversationTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.conversationTable,
      getReferencedColumn: (t) => t.lastMessageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationTableTableFilterComposer(
            $db: $db,
            $table: $db.conversationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MessageTableTableOrderingComposer
    extends Composer<_$AppDataBase, $MessageTableTable> {
  $$MessageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChirpUserTableTableOrderingComposer get senderId {
    final $$ChirpUserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableOrderingComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChirpUserTableTableOrderingComposer get recipientId {
    final $$ChirpUserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableOrderingComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessageTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $MessageTableTable> {
  $$MessageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  $$ChirpUserTableTableAnnotationComposer get senderId {
    final $$ChirpUserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChirpUserTableTableAnnotationComposer get recipientId {
    final $$ChirpUserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> conversationTableRefs<T extends Object>(
    Expression<T> Function($$ConversationTableTableAnnotationComposer a) f,
  ) {
    final $$ConversationTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.conversationTable,
          getReferencedColumn: (t) => t.lastMessageId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ConversationTableTableAnnotationComposer(
                $db: $db,
                $table: $db.conversationTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MessageTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $MessageTableTable,
          MessageData,
          $$MessageTableTableFilterComposer,
          $$MessageTableTableOrderingComposer,
          $$MessageTableTableAnnotationComposer,
          $$MessageTableTableCreateCompanionBuilder,
          $$MessageTableTableUpdateCompanionBuilder,
          (MessageData, $$MessageTableTableReferences),
          MessageData,
          PrefetchHooks Function({
            bool senderId,
            bool recipientId,
            bool conversationTableRefs,
          })
        > {
  $$MessageTableTableTableManager(_$AppDataBase db, $MessageTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> recipientId = const Value.absent(),
                Value<DateTime> sentAt = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                content: content,
                senderId: senderId,
                recipientId: recipientId,
                sentAt: sentAt,
                isRead: isRead,
                imageUrl: imageUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String content,
                required String senderId,
                required String recipientId,
                required DateTime sentAt,
                Value<bool> isRead = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                content: content,
                senderId: senderId,
                recipientId: recipientId,
                sentAt: sentAt,
                isRead: isRead,
                imageUrl: imageUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MessageTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                senderId = false,
                recipientId = false,
                conversationTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (conversationTableRefs) db.conversationTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (senderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.senderId,
                                    referencedTable:
                                        $$MessageTableTableReferences
                                            ._senderIdTable(db),
                                    referencedColumn:
                                        $$MessageTableTableReferences
                                            ._senderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (recipientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.recipientId,
                                    referencedTable:
                                        $$MessageTableTableReferences
                                            ._recipientIdTable(db),
                                    referencedColumn:
                                        $$MessageTableTableReferences
                                            ._recipientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (conversationTableRefs)
                        await $_getPrefetchedData<
                          MessageData,
                          $MessageTableTable,
                          ConversationData
                        >(
                          currentTable: table,
                          referencedTable: $$MessageTableTableReferences
                              ._conversationTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MessageTableTableReferences(
                                db,
                                table,
                                p0,
                              ).conversationTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lastMessageId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MessageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $MessageTableTable,
      MessageData,
      $$MessageTableTableFilterComposer,
      $$MessageTableTableOrderingComposer,
      $$MessageTableTableAnnotationComposer,
      $$MessageTableTableCreateCompanionBuilder,
      $$MessageTableTableUpdateCompanionBuilder,
      (MessageData, $$MessageTableTableReferences),
      MessageData,
      PrefetchHooks Function({
        bool senderId,
        bool recipientId,
        bool conversationTableRefs,
      })
    >;
typedef $$ConversationTableTableCreateCompanionBuilder =
    ConversationTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String userId,
      Value<String?> lastMessageId,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<int> rowid,
    });
typedef $$ConversationTableTableUpdateCompanionBuilder =
    ConversationTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> userId,
      Value<String?> lastMessageId,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<int> rowid,
    });

final class $$ConversationTableTableReferences
    extends
        BaseReferences<
          _$AppDataBase,
          $ConversationTableTable,
          ConversationData
        > {
  $$ConversationTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChirpUserTableTable _userIdTable(_$AppDataBase db) =>
      db.chirpUserTable.createAlias(
        $_aliasNameGenerator(db.conversationTable.userId, db.chirpUserTable.id),
      );

  $$ChirpUserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ChirpUserTableTableTableManager(
      $_db,
      $_db.chirpUserTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MessageTableTable _lastMessageIdTable(_$AppDataBase db) =>
      db.messageTable.createAlias(
        $_aliasNameGenerator(
          db.conversationTable.lastMessageId,
          db.messageTable.id,
        ),
      );

  $$MessageTableTableProcessedTableManager? get lastMessageId {
    final $_column = $_itemColumn<String>('last_message_id');
    if ($_column == null) return null;
    final manager = $$MessageTableTableTableManager(
      $_db,
      $_db.messageTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lastMessageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConversationTableTableFilterComposer
    extends Composer<_$AppDataBase, $ConversationTableTable> {
  $$ConversationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  $$ChirpUserTableTableFilterComposer get userId {
    final $$ChirpUserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableFilterComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MessageTableTableFilterComposer get lastMessageId {
    final $$MessageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lastMessageId,
      referencedTable: $db.messageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageTableTableFilterComposer(
            $db: $db,
            $table: $db.messageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConversationTableTableOrderingComposer
    extends Composer<_$AppDataBase, $ConversationTableTable> {
  $$ConversationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChirpUserTableTableOrderingComposer get userId {
    final $$ChirpUserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableOrderingComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MessageTableTableOrderingComposer get lastMessageId {
    final $$MessageTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lastMessageId,
      referencedTable: $db.messageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageTableTableOrderingComposer(
            $db: $db,
            $table: $db.messageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConversationTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $ConversationTableTable> {
  $$ConversationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  $$ChirpUserTableTableAnnotationComposer get userId {
    final $$ChirpUserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.chirpUserTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChirpUserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chirpUserTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MessageTableTableAnnotationComposer get lastMessageId {
    final $$MessageTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lastMessageId,
      referencedTable: $db.messageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageTableTableAnnotationComposer(
            $db: $db,
            $table: $db.messageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConversationTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $ConversationTableTable,
          ConversationData,
          $$ConversationTableTableFilterComposer,
          $$ConversationTableTableOrderingComposer,
          $$ConversationTableTableAnnotationComposer,
          $$ConversationTableTableCreateCompanionBuilder,
          $$ConversationTableTableUpdateCompanionBuilder,
          (ConversationData, $$ConversationTableTableReferences),
          ConversationData,
          PrefetchHooks Function({bool userId, bool lastMessageId})
        > {
  $$ConversationTableTableTableManager(
    _$AppDataBase db,
    $ConversationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userId: userId,
                lastMessageId: lastMessageId,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String userId,
                Value<String?> lastMessageId = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userId: userId,
                lastMessageId: lastMessageId,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConversationTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, lastMessageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$ConversationTableTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$ConversationTableTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (lastMessageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lastMessageId,
                                referencedTable:
                                    $$ConversationTableTableReferences
                                        ._lastMessageIdTable(db),
                                referencedColumn:
                                    $$ConversationTableTableReferences
                                        ._lastMessageIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConversationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $ConversationTableTable,
      ConversationData,
      $$ConversationTableTableFilterComposer,
      $$ConversationTableTableOrderingComposer,
      $$ConversationTableTableAnnotationComposer,
      $$ConversationTableTableCreateCompanionBuilder,
      $$ConversationTableTableUpdateCompanionBuilder,
      (ConversationData, $$ConversationTableTableReferences),
      ConversationData,
      PrefetchHooks Function({bool userId, bool lastMessageId})
    >;
typedef $$GroupTableTableCreateCompanionBuilder =
    GroupTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      required String description,
      required String creatorId,
      required String creatorName,
      required String admins,
      required String adminNames,
      required String moderators,
      required String moderatorNames,
      required String members,
      required String memberNames,
      required String bannedUsers,
      required String bannedUserNames,
      required bool isPrivate,
      required String rules,
      Value<String?> logo,
      Value<String?> banner,
      Value<String?> logoUrl,
      Value<String?> bannerUrl,
      Value<String?> userRole,
      required bool canPost,
      required bool canModerate,
      required bool canAdmin,
      Value<int> rowid,
    });
typedef $$GroupTableTableUpdateCompanionBuilder =
    GroupTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String> description,
      Value<String> creatorId,
      Value<String> creatorName,
      Value<String> admins,
      Value<String> adminNames,
      Value<String> moderators,
      Value<String> moderatorNames,
      Value<String> members,
      Value<String> memberNames,
      Value<String> bannedUsers,
      Value<String> bannedUserNames,
      Value<bool> isPrivate,
      Value<String> rules,
      Value<String?> logo,
      Value<String?> banner,
      Value<String?> logoUrl,
      Value<String?> bannerUrl,
      Value<String?> userRole,
      Value<bool> canPost,
      Value<bool> canModerate,
      Value<bool> canAdmin,
      Value<int> rowid,
    });

final class $$GroupTableTableReferences
    extends BaseReferences<_$AppDataBase, $GroupTableTable, GroupEntity> {
  $$GroupTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PostTableTable, List<PostEntity>>
  _postTableRefsTable(_$AppDataBase db) => MultiTypedResultKey.fromTable(
    db.postTable,
    aliasName: $_aliasNameGenerator(db.groupTable.id, db.postTable.groupId),
  );

  $$PostTableTableProcessedTableManager get postTableRefs {
    final manager = $$PostTableTableTableManager(
      $_db,
      $_db.postTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_postTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupTableTableFilterComposer
    extends Composer<_$AppDataBase, $GroupTableTable> {
  $$GroupTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creatorId => $composableBuilder(
    column: $table.creatorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creatorName => $composableBuilder(
    column: $table.creatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get admins => $composableBuilder(
    column: $table.admins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adminNames => $composableBuilder(
    column: $table.adminNames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moderators => $composableBuilder(
    column: $table.moderators,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moderatorNames => $composableBuilder(
    column: $table.moderatorNames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get members => $composableBuilder(
    column: $table.members,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberNames => $composableBuilder(
    column: $table.memberNames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannedUsers => $composableBuilder(
    column: $table.bannedUsers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannedUserNames => $composableBuilder(
    column: $table.bannedUserNames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rules => $composableBuilder(
    column: $table.rules,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logo => $composableBuilder(
    column: $table.logo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get banner => $composableBuilder(
    column: $table.banner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userRole => $composableBuilder(
    column: $table.userRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canPost => $composableBuilder(
    column: $table.canPost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canModerate => $composableBuilder(
    column: $table.canModerate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canAdmin => $composableBuilder(
    column: $table.canAdmin,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> postTableRefs(
    Expression<bool> Function($$PostTableTableFilterComposer f) f,
  ) {
    final $$PostTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableFilterComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupTableTableOrderingComposer
    extends Composer<_$AppDataBase, $GroupTableTable> {
  $$GroupTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creatorId => $composableBuilder(
    column: $table.creatorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creatorName => $composableBuilder(
    column: $table.creatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get admins => $composableBuilder(
    column: $table.admins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adminNames => $composableBuilder(
    column: $table.adminNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moderators => $composableBuilder(
    column: $table.moderators,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moderatorNames => $composableBuilder(
    column: $table.moderatorNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get members => $composableBuilder(
    column: $table.members,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberNames => $composableBuilder(
    column: $table.memberNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannedUsers => $composableBuilder(
    column: $table.bannedUsers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannedUserNames => $composableBuilder(
    column: $table.bannedUserNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rules => $composableBuilder(
    column: $table.rules,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logo => $composableBuilder(
    column: $table.logo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get banner => $composableBuilder(
    column: $table.banner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userRole => $composableBuilder(
    column: $table.userRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canPost => $composableBuilder(
    column: $table.canPost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canModerate => $composableBuilder(
    column: $table.canModerate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canAdmin => $composableBuilder(
    column: $table.canAdmin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $GroupTableTable> {
  $$GroupTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creatorId =>
      $composableBuilder(column: $table.creatorId, builder: (column) => column);

  GeneratedColumn<String> get creatorName => $composableBuilder(
    column: $table.creatorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get admins =>
      $composableBuilder(column: $table.admins, builder: (column) => column);

  GeneratedColumn<String> get adminNames => $composableBuilder(
    column: $table.adminNames,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moderators => $composableBuilder(
    column: $table.moderators,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moderatorNames => $composableBuilder(
    column: $table.moderatorNames,
    builder: (column) => column,
  );

  GeneratedColumn<String> get members =>
      $composableBuilder(column: $table.members, builder: (column) => column);

  GeneratedColumn<String> get memberNames => $composableBuilder(
    column: $table.memberNames,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bannedUsers => $composableBuilder(
    column: $table.bannedUsers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bannedUserNames => $composableBuilder(
    column: $table.bannedUserNames,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get rules =>
      $composableBuilder(column: $table.rules, builder: (column) => column);

  GeneratedColumn<String> get logo =>
      $composableBuilder(column: $table.logo, builder: (column) => column);

  GeneratedColumn<String> get banner =>
      $composableBuilder(column: $table.banner, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get bannerUrl =>
      $composableBuilder(column: $table.bannerUrl, builder: (column) => column);

  GeneratedColumn<String> get userRole =>
      $composableBuilder(column: $table.userRole, builder: (column) => column);

  GeneratedColumn<bool> get canPost =>
      $composableBuilder(column: $table.canPost, builder: (column) => column);

  GeneratedColumn<bool> get canModerate => $composableBuilder(
    column: $table.canModerate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canAdmin =>
      $composableBuilder(column: $table.canAdmin, builder: (column) => column);

  Expression<T> postTableRefs<T extends Object>(
    Expression<T> Function($$PostTableTableAnnotationComposer a) f,
  ) {
    final $$PostTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableAnnotationComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $GroupTableTable,
          GroupEntity,
          $$GroupTableTableFilterComposer,
          $$GroupTableTableOrderingComposer,
          $$GroupTableTableAnnotationComposer,
          $$GroupTableTableCreateCompanionBuilder,
          $$GroupTableTableUpdateCompanionBuilder,
          (GroupEntity, $$GroupTableTableReferences),
          GroupEntity,
          PrefetchHooks Function({bool postTableRefs})
        > {
  $$GroupTableTableTableManager(_$AppDataBase db, $GroupTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> creatorId = const Value.absent(),
                Value<String> creatorName = const Value.absent(),
                Value<String> admins = const Value.absent(),
                Value<String> adminNames = const Value.absent(),
                Value<String> moderators = const Value.absent(),
                Value<String> moderatorNames = const Value.absent(),
                Value<String> members = const Value.absent(),
                Value<String> memberNames = const Value.absent(),
                Value<String> bannedUsers = const Value.absent(),
                Value<String> bannedUserNames = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<String> rules = const Value.absent(),
                Value<String?> logo = const Value.absent(),
                Value<String?> banner = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                Value<String?> userRole = const Value.absent(),
                Value<bool> canPost = const Value.absent(),
                Value<bool> canModerate = const Value.absent(),
                Value<bool> canAdmin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                description: description,
                creatorId: creatorId,
                creatorName: creatorName,
                admins: admins,
                adminNames: adminNames,
                moderators: moderators,
                moderatorNames: moderatorNames,
                members: members,
                memberNames: memberNames,
                bannedUsers: bannedUsers,
                bannedUserNames: bannedUserNames,
                isPrivate: isPrivate,
                rules: rules,
                logo: logo,
                banner: banner,
                logoUrl: logoUrl,
                bannerUrl: bannerUrl,
                userRole: userRole,
                canPost: canPost,
                canModerate: canModerate,
                canAdmin: canAdmin,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                required String description,
                required String creatorId,
                required String creatorName,
                required String admins,
                required String adminNames,
                required String moderators,
                required String moderatorNames,
                required String members,
                required String memberNames,
                required String bannedUsers,
                required String bannedUserNames,
                required bool isPrivate,
                required String rules,
                Value<String?> logo = const Value.absent(),
                Value<String?> banner = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                Value<String?> userRole = const Value.absent(),
                required bool canPost,
                required bool canModerate,
                required bool canAdmin,
                Value<int> rowid = const Value.absent(),
              }) => GroupTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                description: description,
                creatorId: creatorId,
                creatorName: creatorName,
                admins: admins,
                adminNames: adminNames,
                moderators: moderators,
                moderatorNames: moderatorNames,
                members: members,
                memberNames: memberNames,
                bannedUsers: bannedUsers,
                bannedUserNames: bannedUserNames,
                isPrivate: isPrivate,
                rules: rules,
                logo: logo,
                banner: banner,
                logoUrl: logoUrl,
                bannerUrl: bannerUrl,
                userRole: userRole,
                canPost: canPost,
                canModerate: canModerate,
                canAdmin: canAdmin,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({postTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (postTableRefs) db.postTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (postTableRefs)
                    await $_getPrefetchedData<
                      GroupEntity,
                      $GroupTableTable,
                      PostEntity
                    >(
                      currentTable: table,
                      referencedTable: $$GroupTableTableReferences
                          ._postTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GroupTableTableReferences(
                            db,
                            table,
                            p0,
                          ).postTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GroupTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $GroupTableTable,
      GroupEntity,
      $$GroupTableTableFilterComposer,
      $$GroupTableTableOrderingComposer,
      $$GroupTableTableAnnotationComposer,
      $$GroupTableTableCreateCompanionBuilder,
      $$GroupTableTableUpdateCompanionBuilder,
      (GroupEntity, $$GroupTableTableReferences),
      GroupEntity,
      PrefetchHooks Function({bool postTableRefs})
    >;
typedef $$PostTableTableCreateCompanionBuilder =
    PostTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String groupId,
      required String userId,
      required String userName,
      required String email,
      Value<String?> avatarUrl,
      required String content,
      required int likeCount,
      required int commentCount,
      Value<bool> isLiked,
      Value<int> rowid,
    });
typedef $$PostTableTableUpdateCompanionBuilder =
    PostTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> groupId,
      Value<String> userId,
      Value<String> userName,
      Value<String> email,
      Value<String?> avatarUrl,
      Value<String> content,
      Value<int> likeCount,
      Value<int> commentCount,
      Value<bool> isLiked,
      Value<int> rowid,
    });

final class $$PostTableTableReferences
    extends BaseReferences<_$AppDataBase, $PostTableTable, PostEntity> {
  $$PostTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupTableTable _groupIdTable(_$AppDataBase db) =>
      db.groupTable.createAlias(
        $_aliasNameGenerator(db.postTable.groupId, db.groupTable.id),
      );

  $$GroupTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$GroupTableTableTableManager(
      $_db,
      $_db.groupTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AttachmentTableTable, List<AttachmentEntity>>
  _attachmentTableRefsTable(_$AppDataBase db) => MultiTypedResultKey.fromTable(
    db.attachmentTable,
    aliasName: $_aliasNameGenerator(db.postTable.id, db.attachmentTable.postId),
  );

  $$AttachmentTableTableProcessedTableManager get attachmentTableRefs {
    final manager = $$AttachmentTableTableTableManager(
      $_db,
      $_db.attachmentTable,
    ).filter((f) => f.postId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attachmentTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PostReplyTableTable, List<PostReplyEntity>>
  _postReplyTableRefsTable(_$AppDataBase db) => MultiTypedResultKey.fromTable(
    db.postReplyTable,
    aliasName: $_aliasNameGenerator(db.postTable.id, db.postReplyTable.postId),
  );

  $$PostReplyTableTableProcessedTableManager get postReplyTableRefs {
    final manager = $$PostReplyTableTableTableManager(
      $_db,
      $_db.postReplyTable,
    ).filter((f) => f.postId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_postReplyTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PostTableTableFilterComposer
    extends Composer<_$AppDataBase, $PostTableTable> {
  $$PostTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get commentCount => $composableBuilder(
    column: $table.commentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupTableTableFilterComposer get groupId {
    final $$GroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableFilterComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> attachmentTableRefs(
    Expression<bool> Function($$AttachmentTableTableFilterComposer f) f,
  ) {
    final $$AttachmentTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachmentTable,
      getReferencedColumn: (t) => t.postId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentTableTableFilterComposer(
            $db: $db,
            $table: $db.attachmentTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> postReplyTableRefs(
    Expression<bool> Function($$PostReplyTableTableFilterComposer f) f,
  ) {
    final $$PostReplyTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postReplyTable,
      getReferencedColumn: (t) => t.postId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostReplyTableTableFilterComposer(
            $db: $db,
            $table: $db.postReplyTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PostTableTableOrderingComposer
    extends Composer<_$AppDataBase, $PostTableTable> {
  $$PostTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get commentCount => $composableBuilder(
    column: $table.commentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupTableTableOrderingComposer get groupId {
    final $$GroupTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PostTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $PostTableTable> {
  $$PostTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

  GeneratedColumn<int> get commentCount => $composableBuilder(
    column: $table.commentCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);

  $$GroupTableTableAnnotationComposer get groupId {
    final $$GroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> attachmentTableRefs<T extends Object>(
    Expression<T> Function($$AttachmentTableTableAnnotationComposer a) f,
  ) {
    final $$AttachmentTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachmentTable,
      getReferencedColumn: (t) => t.postId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentTableTableAnnotationComposer(
            $db: $db,
            $table: $db.attachmentTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> postReplyTableRefs<T extends Object>(
    Expression<T> Function($$PostReplyTableTableAnnotationComposer a) f,
  ) {
    final $$PostReplyTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postReplyTable,
      getReferencedColumn: (t) => t.postId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostReplyTableTableAnnotationComposer(
            $db: $db,
            $table: $db.postReplyTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PostTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $PostTableTable,
          PostEntity,
          $$PostTableTableFilterComposer,
          $$PostTableTableOrderingComposer,
          $$PostTableTableAnnotationComposer,
          $$PostTableTableCreateCompanionBuilder,
          $$PostTableTableUpdateCompanionBuilder,
          (PostEntity, $$PostTableTableReferences),
          PostEntity,
          PrefetchHooks Function({
            bool groupId,
            bool attachmentTableRefs,
            bool postReplyTableRefs,
          })
        > {
  $$PostTableTableTableManager(_$AppDataBase db, $PostTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> likeCount = const Value.absent(),
                Value<int> commentCount = const Value.absent(),
                Value<bool> isLiked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                groupId: groupId,
                userId: userId,
                userName: userName,
                email: email,
                avatarUrl: avatarUrl,
                content: content,
                likeCount: likeCount,
                commentCount: commentCount,
                isLiked: isLiked,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String groupId,
                required String userId,
                required String userName,
                required String email,
                Value<String?> avatarUrl = const Value.absent(),
                required String content,
                required int likeCount,
                required int commentCount,
                Value<bool> isLiked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                groupId: groupId,
                userId: userId,
                userName: userName,
                email: email,
                avatarUrl: avatarUrl,
                content: content,
                likeCount: likeCount,
                commentCount: commentCount,
                isLiked: isLiked,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PostTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                groupId = false,
                attachmentTableRefs = false,
                postReplyTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attachmentTableRefs) db.attachmentTable,
                    if (postReplyTableRefs) db.postReplyTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable: $$PostTableTableReferences
                                        ._groupIdTable(db),
                                    referencedColumn: $$PostTableTableReferences
                                        ._groupIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attachmentTableRefs)
                        await $_getPrefetchedData<
                          PostEntity,
                          $PostTableTable,
                          AttachmentEntity
                        >(
                          currentTable: table,
                          referencedTable: $$PostTableTableReferences
                              ._attachmentTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PostTableTableReferences(
                                db,
                                table,
                                p0,
                              ).attachmentTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.postId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (postReplyTableRefs)
                        await $_getPrefetchedData<
                          PostEntity,
                          $PostTableTable,
                          PostReplyEntity
                        >(
                          currentTable: table,
                          referencedTable: $$PostTableTableReferences
                              ._postReplyTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PostTableTableReferences(
                                db,
                                table,
                                p0,
                              ).postReplyTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.postId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PostTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $PostTableTable,
      PostEntity,
      $$PostTableTableFilterComposer,
      $$PostTableTableOrderingComposer,
      $$PostTableTableAnnotationComposer,
      $$PostTableTableCreateCompanionBuilder,
      $$PostTableTableUpdateCompanionBuilder,
      (PostEntity, $$PostTableTableReferences),
      PostEntity,
      PrefetchHooks Function({
        bool groupId,
        bool attachmentTableRefs,
        bool postReplyTableRefs,
      })
    >;
typedef $$AttachmentTableTableCreateCompanionBuilder =
    AttachmentTableCompanion Function({
      required String id,
      required DateTime createdAt,
      Value<DateTime> updatedAt,
      required String postId,
      required String attachmentType,
      required String file,
      required String name,
      required double size,
      Value<int> rowid,
    });
typedef $$AttachmentTableTableUpdateCompanionBuilder =
    AttachmentTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> postId,
      Value<String> attachmentType,
      Value<String> file,
      Value<String> name,
      Value<double> size,
      Value<int> rowid,
    });

final class $$AttachmentTableTableReferences
    extends
        BaseReferences<_$AppDataBase, $AttachmentTableTable, AttachmentEntity> {
  $$AttachmentTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PostTableTable _postIdTable(_$AppDataBase db) =>
      db.postTable.createAlias(
        $_aliasNameGenerator(db.attachmentTable.postId, db.postTable.id),
      );

  $$PostTableTableProcessedTableManager get postId {
    final $_column = $_itemColumn<String>('post_id')!;

    final manager = $$PostTableTableTableManager(
      $_db,
      $_db.postTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_postIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttachmentTableTableFilterComposer
    extends Composer<_$AppDataBase, $AttachmentTableTable> {
  $$AttachmentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentType => $composableBuilder(
    column: $table.attachmentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get file => $composableBuilder(
    column: $table.file,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  $$PostTableTableFilterComposer get postId {
    final $$PostTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.postId,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableFilterComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentTableTableOrderingComposer
    extends Composer<_$AppDataBase, $AttachmentTableTable> {
  $$AttachmentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentType => $composableBuilder(
    column: $table.attachmentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get file => $composableBuilder(
    column: $table.file,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  $$PostTableTableOrderingComposer get postId {
    final $$PostTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.postId,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableOrderingComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $AttachmentTableTable> {
  $$AttachmentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get attachmentType => $composableBuilder(
    column: $table.attachmentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get file =>
      $composableBuilder(column: $table.file, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  $$PostTableTableAnnotationComposer get postId {
    final $$PostTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.postId,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableAnnotationComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $AttachmentTableTable,
          AttachmentEntity,
          $$AttachmentTableTableFilterComposer,
          $$AttachmentTableTableOrderingComposer,
          $$AttachmentTableTableAnnotationComposer,
          $$AttachmentTableTableCreateCompanionBuilder,
          $$AttachmentTableTableUpdateCompanionBuilder,
          (AttachmentEntity, $$AttachmentTableTableReferences),
          AttachmentEntity,
          PrefetchHooks Function({bool postId})
        > {
  $$AttachmentTableTableTableManager(
    _$AppDataBase db,
    $AttachmentTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> postId = const Value.absent(),
                Value<String> attachmentType = const Value.absent(),
                Value<String> file = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> size = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                postId: postId,
                attachmentType: attachmentType,
                file: file,
                name: name,
                size: size,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                Value<DateTime> updatedAt = const Value.absent(),
                required String postId,
                required String attachmentType,
                required String file,
                required String name,
                required double size,
                Value<int> rowid = const Value.absent(),
              }) => AttachmentTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                postId: postId,
                attachmentType: attachmentType,
                file: file,
                name: name,
                size: size,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttachmentTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({postId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (postId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.postId,
                                referencedTable:
                                    $$AttachmentTableTableReferences
                                        ._postIdTable(db),
                                referencedColumn:
                                    $$AttachmentTableTableReferences
                                        ._postIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttachmentTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $AttachmentTableTable,
      AttachmentEntity,
      $$AttachmentTableTableFilterComposer,
      $$AttachmentTableTableOrderingComposer,
      $$AttachmentTableTableAnnotationComposer,
      $$AttachmentTableTableCreateCompanionBuilder,
      $$AttachmentTableTableUpdateCompanionBuilder,
      (AttachmentEntity, $$AttachmentTableTableReferences),
      AttachmentEntity,
      PrefetchHooks Function({bool postId})
    >;
typedef $$PostReplyTableTableCreateCompanionBuilder =
    PostReplyTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> parentId,
      required String postId,
      required String userId,
      required String userName,
      Value<String?> userAvatar,
      required String content,
      required int depth,
      Value<int> rowid,
    });
typedef $$PostReplyTableTableUpdateCompanionBuilder =
    PostReplyTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> parentId,
      Value<String> postId,
      Value<String> userId,
      Value<String> userName,
      Value<String?> userAvatar,
      Value<String> content,
      Value<int> depth,
      Value<int> rowid,
    });

final class $$PostReplyTableTableReferences
    extends
        BaseReferences<_$AppDataBase, $PostReplyTableTable, PostReplyEntity> {
  $$PostReplyTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PostReplyTableTable _parentIdTable(_$AppDataBase db) =>
      db.postReplyTable.createAlias(
        $_aliasNameGenerator(db.postReplyTable.parentId, db.postReplyTable.id),
      );

  $$PostReplyTableTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$PostReplyTableTableTableManager(
      $_db,
      $_db.postReplyTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PostTableTable _postIdTable(_$AppDataBase db) =>
      db.postTable.createAlias(
        $_aliasNameGenerator(db.postReplyTable.postId, db.postTable.id),
      );

  $$PostTableTableProcessedTableManager get postId {
    final $_column = $_itemColumn<String>('post_id')!;

    final manager = $$PostTableTableTableManager(
      $_db,
      $_db.postTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_postIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PostReplyTableTableFilterComposer
    extends Composer<_$AppDataBase, $PostReplyTableTable> {
  $$PostReplyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userAvatar => $composableBuilder(
    column: $table.userAvatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );

  $$PostReplyTableTableFilterComposer get parentId {
    final $$PostReplyTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.postReplyTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostReplyTableTableFilterComposer(
            $db: $db,
            $table: $db.postReplyTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PostTableTableFilterComposer get postId {
    final $$PostTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.postId,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableFilterComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PostReplyTableTableOrderingComposer
    extends Composer<_$AppDataBase, $PostReplyTableTable> {
  $$PostReplyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userAvatar => $composableBuilder(
    column: $table.userAvatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );

  $$PostReplyTableTableOrderingComposer get parentId {
    final $$PostReplyTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.postReplyTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostReplyTableTableOrderingComposer(
            $db: $db,
            $table: $db.postReplyTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PostTableTableOrderingComposer get postId {
    final $$PostTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.postId,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableOrderingComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PostReplyTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $PostReplyTableTable> {
  $$PostReplyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get userAvatar => $composableBuilder(
    column: $table.userAvatar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  $$PostReplyTableTableAnnotationComposer get parentId {
    final $$PostReplyTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.postReplyTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostReplyTableTableAnnotationComposer(
            $db: $db,
            $table: $db.postReplyTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PostTableTableAnnotationComposer get postId {
    final $$PostTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.postId,
      referencedTable: $db.postTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostTableTableAnnotationComposer(
            $db: $db,
            $table: $db.postTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PostReplyTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $PostReplyTableTable,
          PostReplyEntity,
          $$PostReplyTableTableFilterComposer,
          $$PostReplyTableTableOrderingComposer,
          $$PostReplyTableTableAnnotationComposer,
          $$PostReplyTableTableCreateCompanionBuilder,
          $$PostReplyTableTableUpdateCompanionBuilder,
          (PostReplyEntity, $$PostReplyTableTableReferences),
          PostReplyEntity,
          PrefetchHooks Function({bool parentId, bool postId})
        > {
  $$PostReplyTableTableTableManager(
    _$AppDataBase db,
    $PostReplyTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostReplyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostReplyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostReplyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> postId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String?> userAvatar = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostReplyTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                parentId: parentId,
                postId: postId,
                userId: userId,
                userName: userName,
                userAvatar: userAvatar,
                content: content,
                depth: depth,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                required String postId,
                required String userId,
                required String userName,
                Value<String?> userAvatar = const Value.absent(),
                required String content,
                required int depth,
                Value<int> rowid = const Value.absent(),
              }) => PostReplyTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                parentId: parentId,
                postId: postId,
                userId: userId,
                userName: userName,
                userAvatar: userAvatar,
                content: content,
                depth: depth,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PostReplyTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parentId = false, postId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentId,
                                referencedTable: $$PostReplyTableTableReferences
                                    ._parentIdTable(db),
                                referencedColumn:
                                    $$PostReplyTableTableReferences
                                        ._parentIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (postId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.postId,
                                referencedTable: $$PostReplyTableTableReferences
                                    ._postIdTable(db),
                                referencedColumn:
                                    $$PostReplyTableTableReferences
                                        ._postIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PostReplyTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $PostReplyTableTable,
      PostReplyEntity,
      $$PostReplyTableTableFilterComposer,
      $$PostReplyTableTableOrderingComposer,
      $$PostReplyTableTableAnnotationComposer,
      $$PostReplyTableTableCreateCompanionBuilder,
      $$PostReplyTableTableUpdateCompanionBuilder,
      (PostReplyEntity, $$PostReplyTableTableReferences),
      PostReplyEntity,
      PrefetchHooks Function({bool parentId, bool postId})
    >;
typedef $$TodoTableCreateCompanionBuilder =
    TodoCompanion Function({
      Value<DateTime?> completed,
      Value<bool> deleted,
      Value<DateTime?> due,
      required String etag,
      Value<bool> hidden,
      required String id,
      required String kind,
      Value<String?> notes,
      required String owner,
      Value<String?> parent,
      required String position,
      required String selfLink,
      required String status,
      required String title,
      Value<DateTime?> updated,
      required String webViewLink,
      Value<int> rowid,
    });
typedef $$TodoTableUpdateCompanionBuilder =
    TodoCompanion Function({
      Value<DateTime?> completed,
      Value<bool> deleted,
      Value<DateTime?> due,
      Value<String> etag,
      Value<bool> hidden,
      Value<String> id,
      Value<String> kind,
      Value<String?> notes,
      Value<String> owner,
      Value<String?> parent,
      Value<String> position,
      Value<String> selfLink,
      Value<String> status,
      Value<String> title,
      Value<DateTime?> updated,
      Value<String> webViewLink,
      Value<int> rowid,
    });

class $$TodoTableFilterComposer extends Composer<_$AppDataBase, $TodoTable> {
  $$TodoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parent => $composableBuilder(
    column: $table.parent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selfLink => $composableBuilder(
    column: $table.selfLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get webViewLink => $composableBuilder(
    column: $table.webViewLink,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodoTableOrderingComposer extends Composer<_$AppDataBase, $TodoTable> {
  $$TodoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parent => $composableBuilder(
    column: $table.parent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selfLink => $composableBuilder(
    column: $table.selfLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get webViewLink => $composableBuilder(
    column: $table.webViewLink,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodoTableAnnotationComposer
    extends Composer<_$AppDataBase, $TodoTable> {
  $$TodoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  GeneratedColumn<bool> get hidden =>
      $composableBuilder(column: $table.hidden, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumn<String> get parent =>
      $composableBuilder(column: $table.parent, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get selfLink =>
      $composableBuilder(column: $table.selfLink, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);

  GeneratedColumn<String> get webViewLink => $composableBuilder(
    column: $table.webViewLink,
    builder: (column) => column,
  );
}

class $$TodoTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $TodoTable,
          TodoData,
          $$TodoTableFilterComposer,
          $$TodoTableOrderingComposer,
          $$TodoTableAnnotationComposer,
          $$TodoTableCreateCompanionBuilder,
          $$TodoTableUpdateCompanionBuilder,
          (TodoData, BaseReferences<_$AppDataBase, $TodoTable, TodoData>),
          TodoData,
          PrefetchHooks Function()
        > {
  $$TodoTableTableManager(_$AppDataBase db, $TodoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> completed = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                Value<String> etag = const Value.absent(),
                Value<bool> hidden = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> owner = const Value.absent(),
                Value<String?> parent = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String> selfLink = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> updated = const Value.absent(),
                Value<String> webViewLink = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodoCompanion(
                completed: completed,
                deleted: deleted,
                due: due,
                etag: etag,
                hidden: hidden,
                id: id,
                kind: kind,
                notes: notes,
                owner: owner,
                parent: parent,
                position: position,
                selfLink: selfLink,
                status: status,
                title: title,
                updated: updated,
                webViewLink: webViewLink,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime?> completed = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                required String etag,
                Value<bool> hidden = const Value.absent(),
                required String id,
                required String kind,
                Value<String?> notes = const Value.absent(),
                required String owner,
                Value<String?> parent = const Value.absent(),
                required String position,
                required String selfLink,
                required String status,
                required String title,
                Value<DateTime?> updated = const Value.absent(),
                required String webViewLink,
                Value<int> rowid = const Value.absent(),
              }) => TodoCompanion.insert(
                completed: completed,
                deleted: deleted,
                due: due,
                etag: etag,
                hidden: hidden,
                id: id,
                kind: kind,
                notes: notes,
                owner: owner,
                parent: parent,
                position: position,
                selfLink: selfLink,
                status: status,
                title: title,
                updated: updated,
                webViewLink: webViewLink,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $TodoTable,
      TodoData,
      $$TodoTableFilterComposer,
      $$TodoTableOrderingComposer,
      $$TodoTableAnnotationComposer,
      $$TodoTableCreateCompanionBuilder,
      $$TodoTableUpdateCompanionBuilder,
      (TodoData, BaseReferences<_$AppDataBase, $TodoTable, TodoData>),
      TodoData,
      PrefetchHooks Function()
    >;
typedef $$EventTableTableCreateCompanionBuilder =
    EventTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      required String description,
      required String url,
      required String location,
      required String time,
      required String date,
      required String organizer,
      required String imageUrl,
      required int numberOfAttendees,
      required String organizerId,
      required String genre,
      Value<String?> poster,
      Value<String?> banner,
      Value<int> rowid,
    });
typedef $$EventTableTableUpdateCompanionBuilder =
    EventTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String> description,
      Value<String> url,
      Value<String> location,
      Value<String> time,
      Value<String> date,
      Value<String> organizer,
      Value<String> imageUrl,
      Value<int> numberOfAttendees,
      Value<String> organizerId,
      Value<String> genre,
      Value<String?> poster,
      Value<String?> banner,
      Value<int> rowid,
    });

final class $$EventTableTableReferences
    extends BaseReferences<_$AppDataBase, $EventTableTable, EventData> {
  $$EventTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AttendeeTableTable, List<AttendeeData>>
  _attendeeTableRefsTable(_$AppDataBase db) => MultiTypedResultKey.fromTable(
    db.attendeeTable,
    aliasName: $_aliasNameGenerator(db.eventTable.id, db.attendeeTable.eventId),
  );

  $$AttendeeTableTableProcessedTableManager get attendeeTableRefs {
    final manager = $$AttendeeTableTableTableManager(
      $_db,
      $_db.attendeeTable,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_attendeeTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TicketTableTable, List<TicketData>>
  _ticketTableRefsTable(_$AppDataBase db) => MultiTypedResultKey.fromTable(
    db.ticketTable,
    aliasName: $_aliasNameGenerator(db.eventTable.id, db.ticketTable.eventId),
  );

  $$TicketTableTableProcessedTableManager get ticketTableRefs {
    final manager = $$TicketTableTableTableManager(
      $_db,
      $_db.ticketTable,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventTableTableFilterComposer
    extends Composer<_$AppDataBase, $EventTableTable> {
  $$EventTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizer => $composableBuilder(
    column: $table.organizer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfAttendees => $composableBuilder(
    column: $table.numberOfAttendees,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizerId => $composableBuilder(
    column: $table.organizerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poster => $composableBuilder(
    column: $table.poster,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get banner => $composableBuilder(
    column: $table.banner,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> attendeeTableRefs(
    Expression<bool> Function($$AttendeeTableTableFilterComposer f) f,
  ) {
    final $$AttendeeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendeeTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendeeTableTableFilterComposer(
            $db: $db,
            $table: $db.attendeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ticketTableRefs(
    Expression<bool> Function($$TicketTableTableFilterComposer f) f,
  ) {
    final $$TicketTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketTableTableFilterComposer(
            $db: $db,
            $table: $db.ticketTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventTableTableOrderingComposer
    extends Composer<_$AppDataBase, $EventTableTable> {
  $$EventTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizer => $composableBuilder(
    column: $table.organizer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfAttendees => $composableBuilder(
    column: $table.numberOfAttendees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizerId => $composableBuilder(
    column: $table.organizerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poster => $composableBuilder(
    column: $table.poster,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get banner => $composableBuilder(
    column: $table.banner,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $EventTableTable> {
  $$EventTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get organizer =>
      $composableBuilder(column: $table.organizer, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get numberOfAttendees => $composableBuilder(
    column: $table.numberOfAttendees,
    builder: (column) => column,
  );

  GeneratedColumn<String> get organizerId => $composableBuilder(
    column: $table.organizerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<String> get poster =>
      $composableBuilder(column: $table.poster, builder: (column) => column);

  GeneratedColumn<String> get banner =>
      $composableBuilder(column: $table.banner, builder: (column) => column);

  Expression<T> attendeeTableRefs<T extends Object>(
    Expression<T> Function($$AttendeeTableTableAnnotationComposer a) f,
  ) {
    final $$AttendeeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendeeTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendeeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.attendeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ticketTableRefs<T extends Object>(
    Expression<T> Function($$TicketTableTableAnnotationComposer a) f,
  ) {
    final $$TicketTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ticketTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $EventTableTable,
          EventData,
          $$EventTableTableFilterComposer,
          $$EventTableTableOrderingComposer,
          $$EventTableTableAnnotationComposer,
          $$EventTableTableCreateCompanionBuilder,
          $$EventTableTableUpdateCompanionBuilder,
          (EventData, $$EventTableTableReferences),
          EventData,
          PrefetchHooks Function({bool attendeeTableRefs, bool ticketTableRefs})
        > {
  $$EventTableTableTableManager(_$AppDataBase db, $EventTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> organizer = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> numberOfAttendees = const Value.absent(),
                Value<String> organizerId = const Value.absent(),
                Value<String> genre = const Value.absent(),
                Value<String?> poster = const Value.absent(),
                Value<String?> banner = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                description: description,
                url: url,
                location: location,
                time: time,
                date: date,
                organizer: organizer,
                imageUrl: imageUrl,
                numberOfAttendees: numberOfAttendees,
                organizerId: organizerId,
                genre: genre,
                poster: poster,
                banner: banner,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                required String description,
                required String url,
                required String location,
                required String time,
                required String date,
                required String organizer,
                required String imageUrl,
                required int numberOfAttendees,
                required String organizerId,
                required String genre,
                Value<String?> poster = const Value.absent(),
                Value<String?> banner = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                description: description,
                url: url,
                location: location,
                time: time,
                date: date,
                organizer: organizer,
                imageUrl: imageUrl,
                numberOfAttendees: numberOfAttendees,
                organizerId: organizerId,
                genre: genre,
                poster: poster,
                banner: banner,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attendeeTableRefs = false, ticketTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attendeeTableRefs) db.attendeeTable,
                    if (ticketTableRefs) db.ticketTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attendeeTableRefs)
                        await $_getPrefetchedData<
                          EventData,
                          $EventTableTable,
                          AttendeeData
                        >(
                          currentTable: table,
                          referencedTable: $$EventTableTableReferences
                              ._attendeeTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventTableTableReferences(
                                db,
                                table,
                                p0,
                              ).attendeeTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ticketTableRefs)
                        await $_getPrefetchedData<
                          EventData,
                          $EventTableTable,
                          TicketData
                        >(
                          currentTable: table,
                          referencedTable: $$EventTableTableReferences
                              ._ticketTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventTableTableReferences(
                                db,
                                table,
                                p0,
                              ).ticketTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $EventTableTable,
      EventData,
      $$EventTableTableFilterComposer,
      $$EventTableTableOrderingComposer,
      $$EventTableTableAnnotationComposer,
      $$EventTableTableCreateCompanionBuilder,
      $$EventTableTableUpdateCompanionBuilder,
      (EventData, $$EventTableTableReferences),
      EventData,
      PrefetchHooks Function({bool attendeeTableRefs, bool ticketTableRefs})
    >;
typedef $$AttendeeTableTableCreateCompanionBuilder =
    AttendeeTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String firstName,
      Value<String?> middleName,
      required String lastName,
      required String eventId,
      required String email,
      Value<int> rowid,
    });
typedef $$AttendeeTableTableUpdateCompanionBuilder =
    AttendeeTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> firstName,
      Value<String?> middleName,
      Value<String> lastName,
      Value<String> eventId,
      Value<String> email,
      Value<int> rowid,
    });

final class $$AttendeeTableTableReferences
    extends BaseReferences<_$AppDataBase, $AttendeeTableTable, AttendeeData> {
  $$AttendeeTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventTableTable _eventIdTable(_$AppDataBase db) =>
      db.eventTable.createAlias(
        $_aliasNameGenerator(db.attendeeTable.eventId, db.eventTable.id),
      );

  $$EventTableTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventTableTableTableManager(
      $_db,
      $_db.eventTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TicketTableTable, List<TicketData>>
  _ticketTableRefsTable(_$AppDataBase db) => MultiTypedResultKey.fromTable(
    db.ticketTable,
    aliasName: $_aliasNameGenerator(
      db.attendeeTable.id,
      db.ticketTable.attendeeId,
    ),
  );

  $$TicketTableTableProcessedTableManager get ticketTableRefs {
    final manager = $$TicketTableTableTableManager(
      $_db,
      $_db.ticketTable,
    ).filter((f) => f.attendeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AttendeeTableTableFilterComposer
    extends Composer<_$AppDataBase, $AttendeeTableTable> {
  $$AttendeeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  $$EventTableTableFilterComposer get eventId {
    final $$EventTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.eventTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableTableFilterComposer(
            $db: $db,
            $table: $db.eventTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ticketTableRefs(
    Expression<bool> Function($$TicketTableTableFilterComposer f) f,
  ) {
    final $$TicketTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketTable,
      getReferencedColumn: (t) => t.attendeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketTableTableFilterComposer(
            $db: $db,
            $table: $db.ticketTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttendeeTableTableOrderingComposer
    extends Composer<_$AppDataBase, $AttendeeTableTable> {
  $$AttendeeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventTableTableOrderingComposer get eventId {
    final $$EventTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.eventTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableTableOrderingComposer(
            $db: $db,
            $table: $db.eventTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendeeTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $AttendeeTableTable> {
  $$AttendeeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  $$EventTableTableAnnotationComposer get eventId {
    final $$EventTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.eventTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableTableAnnotationComposer(
            $db: $db,
            $table: $db.eventTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ticketTableRefs<T extends Object>(
    Expression<T> Function($$TicketTableTableAnnotationComposer a) f,
  ) {
    final $$TicketTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketTable,
      getReferencedColumn: (t) => t.attendeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ticketTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttendeeTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $AttendeeTableTable,
          AttendeeData,
          $$AttendeeTableTableFilterComposer,
          $$AttendeeTableTableOrderingComposer,
          $$AttendeeTableTableAnnotationComposer,
          $$AttendeeTableTableCreateCompanionBuilder,
          $$AttendeeTableTableUpdateCompanionBuilder,
          (AttendeeData, $$AttendeeTableTableReferences),
          AttendeeData,
          PrefetchHooks Function({bool eventId, bool ticketTableRefs})
        > {
  $$AttendeeTableTableTableManager(_$AppDataBase db, $AttendeeTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendeeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendeeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendeeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String?> middleName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendeeTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                eventId: eventId,
                email: email,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String firstName,
                Value<String?> middleName = const Value.absent(),
                required String lastName,
                required String eventId,
                required String email,
                Value<int> rowid = const Value.absent(),
              }) => AttendeeTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                eventId: eventId,
                email: email,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttendeeTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, ticketTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ticketTableRefs) db.ticketTable],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$AttendeeTableTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$AttendeeTableTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ticketTableRefs)
                    await $_getPrefetchedData<
                      AttendeeData,
                      $AttendeeTableTable,
                      TicketData
                    >(
                      currentTable: table,
                      referencedTable: $$AttendeeTableTableReferences
                          ._ticketTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AttendeeTableTableReferences(
                            db,
                            table,
                            p0,
                          ).ticketTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.attendeeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AttendeeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $AttendeeTableTable,
      AttendeeData,
      $$AttendeeTableTableFilterComposer,
      $$AttendeeTableTableOrderingComposer,
      $$AttendeeTableTableAnnotationComposer,
      $$AttendeeTableTableCreateCompanionBuilder,
      $$AttendeeTableTableUpdateCompanionBuilder,
      (AttendeeData, $$AttendeeTableTableReferences),
      AttendeeData,
      PrefetchHooks Function({bool eventId, bool ticketTableRefs})
    >;
typedef $$TicketTableTableCreateCompanionBuilder =
    TicketTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String attendeeId,
      required String eventId,
      required String paymentCode,
      Value<int> rowid,
    });
typedef $$TicketTableTableUpdateCompanionBuilder =
    TicketTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> attendeeId,
      Value<String> eventId,
      Value<String> paymentCode,
      Value<int> rowid,
    });

final class $$TicketTableTableReferences
    extends BaseReferences<_$AppDataBase, $TicketTableTable, TicketData> {
  $$TicketTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AttendeeTableTable _attendeeIdTable(_$AppDataBase db) =>
      db.attendeeTable.createAlias(
        $_aliasNameGenerator(db.ticketTable.attendeeId, db.attendeeTable.id),
      );

  $$AttendeeTableTableProcessedTableManager get attendeeId {
    final $_column = $_itemColumn<String>('attendee_id')!;

    final manager = $$AttendeeTableTableTableManager(
      $_db,
      $_db.attendeeTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attendeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventTableTable _eventIdTable(_$AppDataBase db) =>
      db.eventTable.createAlias(
        $_aliasNameGenerator(db.ticketTable.eventId, db.eventTable.id),
      );

  $$EventTableTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventTableTableTableManager(
      $_db,
      $_db.eventTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TicketTableTableFilterComposer
    extends Composer<_$AppDataBase, $TicketTableTable> {
  $$TicketTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentCode => $composableBuilder(
    column: $table.paymentCode,
    builder: (column) => ColumnFilters(column),
  );

  $$AttendeeTableTableFilterComposer get attendeeId {
    final $$AttendeeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendeeId,
      referencedTable: $db.attendeeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendeeTableTableFilterComposer(
            $db: $db,
            $table: $db.attendeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventTableTableFilterComposer get eventId {
    final $$EventTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.eventTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableTableFilterComposer(
            $db: $db,
            $table: $db.eventTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TicketTableTableOrderingComposer
    extends Composer<_$AppDataBase, $TicketTableTable> {
  $$TicketTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentCode => $composableBuilder(
    column: $table.paymentCode,
    builder: (column) => ColumnOrderings(column),
  );

  $$AttendeeTableTableOrderingComposer get attendeeId {
    final $$AttendeeTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendeeId,
      referencedTable: $db.attendeeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendeeTableTableOrderingComposer(
            $db: $db,
            $table: $db.attendeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventTableTableOrderingComposer get eventId {
    final $$EventTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.eventTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableTableOrderingComposer(
            $db: $db,
            $table: $db.eventTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TicketTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $TicketTableTable> {
  $$TicketTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get paymentCode => $composableBuilder(
    column: $table.paymentCode,
    builder: (column) => column,
  );

  $$AttendeeTableTableAnnotationComposer get attendeeId {
    final $$AttendeeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendeeId,
      referencedTable: $db.attendeeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendeeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.attendeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventTableTableAnnotationComposer get eventId {
    final $$EventTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.eventTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableTableAnnotationComposer(
            $db: $db,
            $table: $db.eventTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TicketTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $TicketTableTable,
          TicketData,
          $$TicketTableTableFilterComposer,
          $$TicketTableTableOrderingComposer,
          $$TicketTableTableAnnotationComposer,
          $$TicketTableTableCreateCompanionBuilder,
          $$TicketTableTableUpdateCompanionBuilder,
          (TicketData, $$TicketTableTableReferences),
          TicketData,
          PrefetchHooks Function({bool attendeeId, bool eventId})
        > {
  $$TicketTableTableTableManager(_$AppDataBase db, $TicketTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TicketTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TicketTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TicketTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> attendeeId = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> paymentCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TicketTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                attendeeId: attendeeId,
                eventId: eventId,
                paymentCode: paymentCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String attendeeId,
                required String eventId,
                required String paymentCode,
                Value<int> rowid = const Value.absent(),
              }) => TicketTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                attendeeId: attendeeId,
                eventId: eventId,
                paymentCode: paymentCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TicketTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({attendeeId = false, eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (attendeeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.attendeeId,
                                referencedTable: $$TicketTableTableReferences
                                    ._attendeeIdTable(db),
                                referencedColumn: $$TicketTableTableReferences
                                    ._attendeeIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$TicketTableTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$TicketTableTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TicketTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $TicketTableTable,
      TicketData,
      $$TicketTableTableFilterComposer,
      $$TicketTableTableOrderingComposer,
      $$TicketTableTableAnnotationComposer,
      $$TicketTableTableCreateCompanionBuilder,
      $$TicketTableTableUpdateCompanionBuilder,
      (TicketData, $$TicketTableTableReferences),
      TicketData,
      PrefetchHooks Function({bool attendeeId, bool eventId})
    >;
typedef $$AgendaEventTableCreateCompanionBuilder =
    AgendaEventCompanion Function({
      required String id,
      Value<bool> allDay,
      Value<String?> summary,
      Value<String?> description,
      Value<String?> location,
      Value<String?> htmlLink,
      Value<String?> calendarId,
      Value<String?> ownerId,
      Value<String?> timezone,
      Value<String?> status,
      Value<String?> transparency,
      Value<String?> etag,
      Value<DateTime?> created,
      Value<DateTime?> updated,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<List<dynamic>?> attendees,
      Value<List<dynamic>?> recurrence,
      Value<Map<String, dynamic>?> reminders,
      Value<int> rowid,
    });
typedef $$AgendaEventTableUpdateCompanionBuilder =
    AgendaEventCompanion Function({
      Value<String> id,
      Value<bool> allDay,
      Value<String?> summary,
      Value<String?> description,
      Value<String?> location,
      Value<String?> htmlLink,
      Value<String?> calendarId,
      Value<String?> ownerId,
      Value<String?> timezone,
      Value<String?> status,
      Value<String?> transparency,
      Value<String?> etag,
      Value<DateTime?> created,
      Value<DateTime?> updated,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<List<dynamic>?> attendees,
      Value<List<dynamic>?> recurrence,
      Value<Map<String, dynamic>?> reminders,
      Value<int> rowid,
    });

class $$AgendaEventTableFilterComposer
    extends Composer<_$AppDataBase, $AgendaEventTable> {
  $$AgendaEventTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get htmlLink => $composableBuilder(
    column: $table.htmlLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transparency => $composableBuilder(
    column: $table.transparency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get attendees => $composableBuilder(
    column: $table.attendees,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get reminders => $composableBuilder(
    column: $table.reminders,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$AgendaEventTableOrderingComposer
    extends Composer<_$AppDataBase, $AgendaEventTable> {
  $$AgendaEventTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get htmlLink => $composableBuilder(
    column: $table.htmlLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transparency => $composableBuilder(
    column: $table.transparency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attendees => $composableBuilder(
    column: $table.attendees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminders => $composableBuilder(
    column: $table.reminders,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AgendaEventTableAnnotationComposer
    extends Composer<_$AppDataBase, $AgendaEventTable> {
  $$AgendaEventTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get htmlLink =>
      $composableBuilder(column: $table.htmlLink, builder: (column) => column);

  GeneratedColumn<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get transparency => $composableBuilder(
    column: $table.transparency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get attendees =>
      $composableBuilder(column: $table.attendees, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get recurrence =>
      $composableBuilder(
        column: $table.recurrence,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  get reminders =>
      $composableBuilder(column: $table.reminders, builder: (column) => column);
}

class $$AgendaEventTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $AgendaEventTable,
          AgendaEventData,
          $$AgendaEventTableFilterComposer,
          $$AgendaEventTableOrderingComposer,
          $$AgendaEventTableAnnotationComposer,
          $$AgendaEventTableCreateCompanionBuilder,
          $$AgendaEventTableUpdateCompanionBuilder,
          (
            AgendaEventData,
            BaseReferences<_$AppDataBase, $AgendaEventTable, AgendaEventData>,
          ),
          AgendaEventData,
          PrefetchHooks Function()
        > {
  $$AgendaEventTableTableManager(_$AppDataBase db, $AgendaEventTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgendaEventTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgendaEventTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgendaEventTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> htmlLink = const Value.absent(),
                Value<String?> calendarId = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> transparency = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<DateTime?> created = const Value.absent(),
                Value<DateTime?> updated = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<List<dynamic>?> attendees = const Value.absent(),
                Value<List<dynamic>?> recurrence = const Value.absent(),
                Value<Map<String, dynamic>?> reminders = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgendaEventCompanion(
                id: id,
                allDay: allDay,
                summary: summary,
                description: description,
                location: location,
                htmlLink: htmlLink,
                calendarId: calendarId,
                ownerId: ownerId,
                timezone: timezone,
                status: status,
                transparency: transparency,
                etag: etag,
                created: created,
                updated: updated,
                startTime: startTime,
                endTime: endTime,
                attendees: attendees,
                recurrence: recurrence,
                reminders: reminders,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<bool> allDay = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> htmlLink = const Value.absent(),
                Value<String?> calendarId = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> transparency = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<DateTime?> created = const Value.absent(),
                Value<DateTime?> updated = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<List<dynamic>?> attendees = const Value.absent(),
                Value<List<dynamic>?> recurrence = const Value.absent(),
                Value<Map<String, dynamic>?> reminders = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgendaEventCompanion.insert(
                id: id,
                allDay: allDay,
                summary: summary,
                description: description,
                location: location,
                htmlLink: htmlLink,
                calendarId: calendarId,
                ownerId: ownerId,
                timezone: timezone,
                status: status,
                transparency: transparency,
                etag: etag,
                created: created,
                updated: updated,
                startTime: startTime,
                endTime: endTime,
                attendees: attendees,
                recurrence: recurrence,
                reminders: reminders,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AgendaEventTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $AgendaEventTable,
      AgendaEventData,
      $$AgendaEventTableFilterComposer,
      $$AgendaEventTableOrderingComposer,
      $$AgendaEventTableAnnotationComposer,
      $$AgendaEventTableCreateCompanionBuilder,
      $$AgendaEventTableUpdateCompanionBuilder,
      (
        AgendaEventData,
        BaseReferences<_$AppDataBase, $AgendaEventTable, AgendaEventData>,
      ),
      AgendaEventData,
      PrefetchHooks Function()
    >;
typedef $$NotificationTableTableCreateCompanionBuilder =
    NotificationTableCompanion Function({
      required String id,
      required String title,
      required String body,
      Value<String?> imageUrl,
      Value<Map<String, dynamic>?> data,
      required DateTime createdAt,
      Value<bool> isRead,
      Value<String?> category,
      Value<String?> actionUrl,
      Value<int> rowid,
    });
typedef $$NotificationTableTableUpdateCompanionBuilder =
    NotificationTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> body,
      Value<String?> imageUrl,
      Value<Map<String, dynamic>?> data,
      Value<DateTime> createdAt,
      Value<bool> isRead,
      Value<String?> category,
      Value<String?> actionUrl,
      Value<int> rowid,
    });

class $$NotificationTableTableFilterComposer
    extends Composer<_$AppDataBase, $NotificationTableTable> {
  $$NotificationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionUrl => $composableBuilder(
    column: $table.actionUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationTableTableOrderingComposer
    extends Composer<_$AppDataBase, $NotificationTableTable> {
  $$NotificationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionUrl => $composableBuilder(
    column: $table.actionUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $NotificationTableTable> {
  $$NotificationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get actionUrl =>
      $composableBuilder(column: $table.actionUrl, builder: (column) => column);
}

class $$NotificationTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $NotificationTableTable,
          NotificationTableData,
          $$NotificationTableTableFilterComposer,
          $$NotificationTableTableOrderingComposer,
          $$NotificationTableTableAnnotationComposer,
          $$NotificationTableTableCreateCompanionBuilder,
          $$NotificationTableTableUpdateCompanionBuilder,
          (
            NotificationTableData,
            BaseReferences<
              _$AppDataBase,
              $NotificationTableTable,
              NotificationTableData
            >,
          ),
          NotificationTableData,
          PrefetchHooks Function()
        > {
  $$NotificationTableTableTableManager(
    _$AppDataBase db,
    $NotificationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<Map<String, dynamic>?> data = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> actionUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationTableCompanion(
                id: id,
                title: title,
                body: body,
                imageUrl: imageUrl,
                data: data,
                createdAt: createdAt,
                isRead: isRead,
                category: category,
                actionUrl: actionUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String body,
                Value<String?> imageUrl = const Value.absent(),
                Value<Map<String, dynamic>?> data = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isRead = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> actionUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationTableCompanion.insert(
                id: id,
                title: title,
                body: body,
                imageUrl: imageUrl,
                data: data,
                createdAt: createdAt,
                isRead: isRead,
                category: category,
                actionUrl: actionUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $NotificationTableTable,
      NotificationTableData,
      $$NotificationTableTableFilterComposer,
      $$NotificationTableTableOrderingComposer,
      $$NotificationTableTableAnnotationComposer,
      $$NotificationTableTableCreateCompanionBuilder,
      $$NotificationTableTableUpdateCompanionBuilder,
      (
        NotificationTableData,
        BaseReferences<
          _$AppDataBase,
          $NotificationTableTable,
          NotificationTableData
        >,
      ),
      NotificationTableData,
      PrefetchHooks Function()
    >;
typedef $$InstitutionTableCreateCompanionBuilder =
    InstitutionCompanion Function({
      Value<int> institutionId,
      required String name,
      Value<List<dynamic>?> webPages,
      Value<List<dynamic>?> domains,
      Value<String?> alphaTwoCode,
      Value<String?> country,
      Value<String?> stateProvince,
    });
typedef $$InstitutionTableUpdateCompanionBuilder =
    InstitutionCompanion Function({
      Value<int> institutionId,
      Value<String> name,
      Value<List<dynamic>?> webPages,
      Value<List<dynamic>?> domains,
      Value<String?> alphaTwoCode,
      Value<String?> country,
      Value<String?> stateProvince,
    });

class $$InstitutionTableFilterComposer
    extends Composer<_$AppDataBase, $InstitutionTable> {
  $$InstitutionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get institutionId => $composableBuilder(
    column: $table.institutionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get webPages => $composableBuilder(
    column: $table.webPages,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get domains => $composableBuilder(
    column: $table.domains,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get alphaTwoCode => $composableBuilder(
    column: $table.alphaTwoCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InstitutionTableOrderingComposer
    extends Composer<_$AppDataBase, $InstitutionTable> {
  $$InstitutionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get institutionId => $composableBuilder(
    column: $table.institutionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get webPages => $composableBuilder(
    column: $table.webPages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domains => $composableBuilder(
    column: $table.domains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alphaTwoCode => $composableBuilder(
    column: $table.alphaTwoCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstitutionTableAnnotationComposer
    extends Composer<_$AppDataBase, $InstitutionTable> {
  $$InstitutionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get institutionId => $composableBuilder(
    column: $table.institutionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get webPages =>
      $composableBuilder(column: $table.webPages, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get domains =>
      $composableBuilder(column: $table.domains, builder: (column) => column);

  GeneratedColumn<String> get alphaTwoCode => $composableBuilder(
    column: $table.alphaTwoCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => column,
  );
}

class $$InstitutionTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $InstitutionTable,
          InstitutionData,
          $$InstitutionTableFilterComposer,
          $$InstitutionTableOrderingComposer,
          $$InstitutionTableAnnotationComposer,
          $$InstitutionTableCreateCompanionBuilder,
          $$InstitutionTableUpdateCompanionBuilder,
          (
            InstitutionData,
            BaseReferences<_$AppDataBase, $InstitutionTable, InstitutionData>,
          ),
          InstitutionData,
          PrefetchHooks Function()
        > {
  $$InstitutionTableTableManager(_$AppDataBase db, $InstitutionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstitutionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstitutionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstitutionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> institutionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<List<dynamic>?> webPages = const Value.absent(),
                Value<List<dynamic>?> domains = const Value.absent(),
                Value<String?> alphaTwoCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> stateProvince = const Value.absent(),
              }) => InstitutionCompanion(
                institutionId: institutionId,
                name: name,
                webPages: webPages,
                domains: domains,
                alphaTwoCode: alphaTwoCode,
                country: country,
                stateProvince: stateProvince,
              ),
          createCompanionCallback:
              ({
                Value<int> institutionId = const Value.absent(),
                required String name,
                Value<List<dynamic>?> webPages = const Value.absent(),
                Value<List<dynamic>?> domains = const Value.absent(),
                Value<String?> alphaTwoCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> stateProvince = const Value.absent(),
              }) => InstitutionCompanion.insert(
                institutionId: institutionId,
                name: name,
                webPages: webPages,
                domains: domains,
                alphaTwoCode: alphaTwoCode,
                country: country,
                stateProvince: stateProvince,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InstitutionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $InstitutionTable,
      InstitutionData,
      $$InstitutionTableFilterComposer,
      $$InstitutionTableOrderingComposer,
      $$InstitutionTableAnnotationComposer,
      $$InstitutionTableCreateCompanionBuilder,
      $$InstitutionTableUpdateCompanionBuilder,
      (
        InstitutionData,
        BaseReferences<_$AppDataBase, $InstitutionTable, InstitutionData>,
      ),
      InstitutionData,
      PrefetchHooks Function()
    >;
typedef $$MagnetStudentProfileTableCreateCompanionBuilder =
    MagnetStudentProfileCompanion Function({
      required String userID,
      required int institutionID,
      required String admissionNumber,
      required String firstName,
      required String otherNames,
      Value<String?> nationalId,
      Value<String?> gender,
      Value<String?> address,
      Value<String?> email,
      Value<String?> phoneNumber,
      Value<String?> profilePictureUrl,
      Value<DateTime?> dateOfBirth,
      required String school,
      Value<String?> campus,
      Value<String?> enrollmentStatus,
      Value<String?> programme,
      Value<String?> degree,
      Value<int?> academicYear,
      Value<double?> gpa,
      Value<String?> emergencyContact,
      Value<String?> parentName,
      Value<DateTime?> dateOfAdmission,
      Value<DateTime?> graduationDate,
      Value<String?> disabilityStatus,
      Value<bool?> isInternationalStudent,
      Value<int> rowid,
    });
typedef $$MagnetStudentProfileTableUpdateCompanionBuilder =
    MagnetStudentProfileCompanion Function({
      Value<String> userID,
      Value<int> institutionID,
      Value<String> admissionNumber,
      Value<String> firstName,
      Value<String> otherNames,
      Value<String?> nationalId,
      Value<String?> gender,
      Value<String?> address,
      Value<String?> email,
      Value<String?> phoneNumber,
      Value<String?> profilePictureUrl,
      Value<DateTime?> dateOfBirth,
      Value<String> school,
      Value<String?> campus,
      Value<String?> enrollmentStatus,
      Value<String?> programme,
      Value<String?> degree,
      Value<int?> academicYear,
      Value<double?> gpa,
      Value<String?> emergencyContact,
      Value<String?> parentName,
      Value<DateTime?> dateOfAdmission,
      Value<DateTime?> graduationDate,
      Value<String?> disabilityStatus,
      Value<bool?> isInternationalStudent,
      Value<int> rowid,
    });

class $$MagnetStudentProfileTableFilterComposer
    extends Composer<_$AppDataBase, $MagnetStudentProfileTable> {
  $$MagnetStudentProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get admissionNumber => $composableBuilder(
    column: $table.admissionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherNames => $composableBuilder(
    column: $table.otherNames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profilePictureUrl => $composableBuilder(
    column: $table.profilePictureUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campus => $composableBuilder(
    column: $table.campus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrollmentStatus => $composableBuilder(
    column: $table.enrollmentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programme => $composableBuilder(
    column: $table.programme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get degree => $composableBuilder(
    column: $table.degree,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpa => $composableBuilder(
    column: $table.gpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentName => $composableBuilder(
    column: $table.parentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfAdmission => $composableBuilder(
    column: $table.dateOfAdmission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get graduationDate => $composableBuilder(
    column: $table.graduationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get disabilityStatus => $composableBuilder(
    column: $table.disabilityStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInternationalStudent => $composableBuilder(
    column: $table.isInternationalStudent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MagnetStudentProfileTableOrderingComposer
    extends Composer<_$AppDataBase, $MagnetStudentProfileTable> {
  $$MagnetStudentProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get admissionNumber => $composableBuilder(
    column: $table.admissionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherNames => $composableBuilder(
    column: $table.otherNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profilePictureUrl => $composableBuilder(
    column: $table.profilePictureUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campus => $composableBuilder(
    column: $table.campus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrollmentStatus => $composableBuilder(
    column: $table.enrollmentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programme => $composableBuilder(
    column: $table.programme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get degree => $composableBuilder(
    column: $table.degree,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpa => $composableBuilder(
    column: $table.gpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentName => $composableBuilder(
    column: $table.parentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfAdmission => $composableBuilder(
    column: $table.dateOfAdmission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get graduationDate => $composableBuilder(
    column: $table.graduationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get disabilityStatus => $composableBuilder(
    column: $table.disabilityStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInternationalStudent => $composableBuilder(
    column: $table.isInternationalStudent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MagnetStudentProfileTableAnnotationComposer
    extends Composer<_$AppDataBase, $MagnetStudentProfileTable> {
  $$MagnetStudentProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userID =>
      $composableBuilder(column: $table.userID, builder: (column) => column);

  GeneratedColumn<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => column,
  );

  GeneratedColumn<String> get admissionNumber => $composableBuilder(
    column: $table.admissionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get otherNames => $composableBuilder(
    column: $table.otherNames,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profilePictureUrl => $composableBuilder(
    column: $table.profilePictureUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);

  GeneratedColumn<String> get enrollmentStatus => $composableBuilder(
    column: $table.enrollmentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get programme =>
      $composableBuilder(column: $table.programme, builder: (column) => column);

  GeneratedColumn<String> get degree =>
      $composableBuilder(column: $table.degree, builder: (column) => column);

  GeneratedColumn<int> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gpa =>
      $composableBuilder(column: $table.gpa, builder: (column) => column);

  GeneratedColumn<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentName => $composableBuilder(
    column: $table.parentName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateOfAdmission => $composableBuilder(
    column: $table.dateOfAdmission,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get graduationDate => $composableBuilder(
    column: $table.graduationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get disabilityStatus => $composableBuilder(
    column: $table.disabilityStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isInternationalStudent => $composableBuilder(
    column: $table.isInternationalStudent,
    builder: (column) => column,
  );
}

class $$MagnetStudentProfileTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $MagnetStudentProfileTable,
          MagnetStudentProfileData,
          $$MagnetStudentProfileTableFilterComposer,
          $$MagnetStudentProfileTableOrderingComposer,
          $$MagnetStudentProfileTableAnnotationComposer,
          $$MagnetStudentProfileTableCreateCompanionBuilder,
          $$MagnetStudentProfileTableUpdateCompanionBuilder,
          (
            MagnetStudentProfileData,
            BaseReferences<
              _$AppDataBase,
              $MagnetStudentProfileTable,
              MagnetStudentProfileData
            >,
          ),
          MagnetStudentProfileData,
          PrefetchHooks Function()
        > {
  $$MagnetStudentProfileTableTableManager(
    _$AppDataBase db,
    $MagnetStudentProfileTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MagnetStudentProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MagnetStudentProfileTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MagnetStudentProfileTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userID = const Value.absent(),
                Value<int> institutionID = const Value.absent(),
                Value<String> admissionNumber = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> otherNames = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> profilePictureUrl = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String> school = const Value.absent(),
                Value<String?> campus = const Value.absent(),
                Value<String?> enrollmentStatus = const Value.absent(),
                Value<String?> programme = const Value.absent(),
                Value<String?> degree = const Value.absent(),
                Value<int?> academicYear = const Value.absent(),
                Value<double?> gpa = const Value.absent(),
                Value<String?> emergencyContact = const Value.absent(),
                Value<String?> parentName = const Value.absent(),
                Value<DateTime?> dateOfAdmission = const Value.absent(),
                Value<DateTime?> graduationDate = const Value.absent(),
                Value<String?> disabilityStatus = const Value.absent(),
                Value<bool?> isInternationalStudent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetStudentProfileCompanion(
                userID: userID,
                institutionID: institutionID,
                admissionNumber: admissionNumber,
                firstName: firstName,
                otherNames: otherNames,
                nationalId: nationalId,
                gender: gender,
                address: address,
                email: email,
                phoneNumber: phoneNumber,
                profilePictureUrl: profilePictureUrl,
                dateOfBirth: dateOfBirth,
                school: school,
                campus: campus,
                enrollmentStatus: enrollmentStatus,
                programme: programme,
                degree: degree,
                academicYear: academicYear,
                gpa: gpa,
                emergencyContact: emergencyContact,
                parentName: parentName,
                dateOfAdmission: dateOfAdmission,
                graduationDate: graduationDate,
                disabilityStatus: disabilityStatus,
                isInternationalStudent: isInternationalStudent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userID,
                required int institutionID,
                required String admissionNumber,
                required String firstName,
                required String otherNames,
                Value<String?> nationalId = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> profilePictureUrl = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                required String school,
                Value<String?> campus = const Value.absent(),
                Value<String?> enrollmentStatus = const Value.absent(),
                Value<String?> programme = const Value.absent(),
                Value<String?> degree = const Value.absent(),
                Value<int?> academicYear = const Value.absent(),
                Value<double?> gpa = const Value.absent(),
                Value<String?> emergencyContact = const Value.absent(),
                Value<String?> parentName = const Value.absent(),
                Value<DateTime?> dateOfAdmission = const Value.absent(),
                Value<DateTime?> graduationDate = const Value.absent(),
                Value<String?> disabilityStatus = const Value.absent(),
                Value<bool?> isInternationalStudent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetStudentProfileCompanion.insert(
                userID: userID,
                institutionID: institutionID,
                admissionNumber: admissionNumber,
                firstName: firstName,
                otherNames: otherNames,
                nationalId: nationalId,
                gender: gender,
                address: address,
                email: email,
                phoneNumber: phoneNumber,
                profilePictureUrl: profilePictureUrl,
                dateOfBirth: dateOfBirth,
                school: school,
                campus: campus,
                enrollmentStatus: enrollmentStatus,
                programme: programme,
                degree: degree,
                academicYear: academicYear,
                gpa: gpa,
                emergencyContact: emergencyContact,
                parentName: parentName,
                dateOfAdmission: dateOfAdmission,
                graduationDate: graduationDate,
                disabilityStatus: disabilityStatus,
                isInternationalStudent: isInternationalStudent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MagnetStudentProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $MagnetStudentProfileTable,
      MagnetStudentProfileData,
      $$MagnetStudentProfileTableFilterComposer,
      $$MagnetStudentProfileTableOrderingComposer,
      $$MagnetStudentProfileTableAnnotationComposer,
      $$MagnetStudentProfileTableCreateCompanionBuilder,
      $$MagnetStudentProfileTableUpdateCompanionBuilder,
      (
        MagnetStudentProfileData,
        BaseReferences<
          _$AppDataBase,
          $MagnetStudentProfileTable,
          MagnetStudentProfileData
        >,
      ),
      MagnetStudentProfileData,
      PrefetchHooks Function()
    >;
typedef $$MagnetCredentialsTableCreateCompanionBuilder =
    MagnetCredentialsCompanion Function({
      required String userID,
      required int institutionID,
      required String username,
      required String password,
      Value<String?> extra,
      Value<int> rowid,
    });
typedef $$MagnetCredentialsTableUpdateCompanionBuilder =
    MagnetCredentialsCompanion Function({
      Value<String> userID,
      Value<int> institutionID,
      Value<String> username,
      Value<String> password,
      Value<String?> extra,
      Value<int> rowid,
    });

class $$MagnetCredentialsTableFilterComposer
    extends Composer<_$AppDataBase, $MagnetCredentialsTable> {
  $$MagnetCredentialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extra => $composableBuilder(
    column: $table.extra,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MagnetCredentialsTableOrderingComposer
    extends Composer<_$AppDataBase, $MagnetCredentialsTable> {
  $$MagnetCredentialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extra => $composableBuilder(
    column: $table.extra,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MagnetCredentialsTableAnnotationComposer
    extends Composer<_$AppDataBase, $MagnetCredentialsTable> {
  $$MagnetCredentialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userID =>
      $composableBuilder(column: $table.userID, builder: (column) => column);

  GeneratedColumn<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => column,
  );

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get extra =>
      $composableBuilder(column: $table.extra, builder: (column) => column);
}

class $$MagnetCredentialsTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $MagnetCredentialsTable,
          MagnetCredential,
          $$MagnetCredentialsTableFilterComposer,
          $$MagnetCredentialsTableOrderingComposer,
          $$MagnetCredentialsTableAnnotationComposer,
          $$MagnetCredentialsTableCreateCompanionBuilder,
          $$MagnetCredentialsTableUpdateCompanionBuilder,
          (
            MagnetCredential,
            BaseReferences<
              _$AppDataBase,
              $MagnetCredentialsTable,
              MagnetCredential
            >,
          ),
          MagnetCredential,
          PrefetchHooks Function()
        > {
  $$MagnetCredentialsTableTableManager(
    _$AppDataBase db,
    $MagnetCredentialsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MagnetCredentialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MagnetCredentialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MagnetCredentialsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userID = const Value.absent(),
                Value<int> institutionID = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String?> extra = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetCredentialsCompanion(
                userID: userID,
                institutionID: institutionID,
                username: username,
                password: password,
                extra: extra,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userID,
                required int institutionID,
                required String username,
                required String password,
                Value<String?> extra = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetCredentialsCompanion.insert(
                userID: userID,
                institutionID: institutionID,
                username: username,
                password: password,
                extra: extra,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MagnetCredentialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $MagnetCredentialsTable,
      MagnetCredential,
      $$MagnetCredentialsTableFilterComposer,
      $$MagnetCredentialsTableOrderingComposer,
      $$MagnetCredentialsTableAnnotationComposer,
      $$MagnetCredentialsTableCreateCompanionBuilder,
      $$MagnetCredentialsTableUpdateCompanionBuilder,
      (
        MagnetCredential,
        BaseReferences<
          _$AppDataBase,
          $MagnetCredentialsTable,
          MagnetCredential
        >,
      ),
      MagnetCredential,
      PrefetchHooks Function()
    >;
typedef $$MagnetCourseInfoTableCreateCompanionBuilder =
    MagnetCourseInfoCompanion Function({
      required String userID,
      required int institutionID,
      required String courseCode,
      required String courseTitle,
      Value<String?> courseDescription,
      required int credits,
      Value<String?> instructor,
      Value<String?> semester,
      Value<DateTime?> schedule,
      Value<int?> durationInSeconds,
      Value<String?> prerequisites,
      Value<String?> courseType,
      Value<String?> courseLevel,
      Value<String?> location,
      Value<int?> enrollmentLimit,
      Value<int?> currentEnrollment,
      Value<String?> courseMaterials,
      Value<int> rowid,
    });
typedef $$MagnetCourseInfoTableUpdateCompanionBuilder =
    MagnetCourseInfoCompanion Function({
      Value<String> userID,
      Value<int> institutionID,
      Value<String> courseCode,
      Value<String> courseTitle,
      Value<String?> courseDescription,
      Value<int> credits,
      Value<String?> instructor,
      Value<String?> semester,
      Value<DateTime?> schedule,
      Value<int?> durationInSeconds,
      Value<String?> prerequisites,
      Value<String?> courseType,
      Value<String?> courseLevel,
      Value<String?> location,
      Value<int?> enrollmentLimit,
      Value<int?> currentEnrollment,
      Value<String?> courseMaterials,
      Value<int> rowid,
    });

class $$MagnetCourseInfoTableFilterComposer
    extends Composer<_$AppDataBase, $MagnetCourseInfoTable> {
  $$MagnetCourseInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseCode => $composableBuilder(
    column: $table.courseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseTitle => $composableBuilder(
    column: $table.courseTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseDescription => $composableBuilder(
    column: $table.courseDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get credits => $composableBuilder(
    column: $table.credits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructor => $composableBuilder(
    column: $table.instructor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get semester => $composableBuilder(
    column: $table.semester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get schedule => $composableBuilder(
    column: $table.schedule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationInSeconds => $composableBuilder(
    column: $table.durationInSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prerequisites => $composableBuilder(
    column: $table.prerequisites,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseType => $composableBuilder(
    column: $table.courseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseLevel => $composableBuilder(
    column: $table.courseLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enrollmentLimit => $composableBuilder(
    column: $table.enrollmentLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentEnrollment => $composableBuilder(
    column: $table.currentEnrollment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseMaterials => $composableBuilder(
    column: $table.courseMaterials,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MagnetCourseInfoTableOrderingComposer
    extends Composer<_$AppDataBase, $MagnetCourseInfoTable> {
  $$MagnetCourseInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseCode => $composableBuilder(
    column: $table.courseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseTitle => $composableBuilder(
    column: $table.courseTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseDescription => $composableBuilder(
    column: $table.courseDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get credits => $composableBuilder(
    column: $table.credits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructor => $composableBuilder(
    column: $table.instructor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get semester => $composableBuilder(
    column: $table.semester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get schedule => $composableBuilder(
    column: $table.schedule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationInSeconds => $composableBuilder(
    column: $table.durationInSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prerequisites => $composableBuilder(
    column: $table.prerequisites,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseType => $composableBuilder(
    column: $table.courseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseLevel => $composableBuilder(
    column: $table.courseLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enrollmentLimit => $composableBuilder(
    column: $table.enrollmentLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentEnrollment => $composableBuilder(
    column: $table.currentEnrollment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseMaterials => $composableBuilder(
    column: $table.courseMaterials,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MagnetCourseInfoTableAnnotationComposer
    extends Composer<_$AppDataBase, $MagnetCourseInfoTable> {
  $$MagnetCourseInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userID =>
      $composableBuilder(column: $table.userID, builder: (column) => column);

  GeneratedColumn<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseCode => $composableBuilder(
    column: $table.courseCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseTitle => $composableBuilder(
    column: $table.courseTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseDescription => $composableBuilder(
    column: $table.courseDescription,
    builder: (column) => column,
  );

  GeneratedColumn<int> get credits =>
      $composableBuilder(column: $table.credits, builder: (column) => column);

  GeneratedColumn<String> get instructor => $composableBuilder(
    column: $table.instructor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get semester =>
      $composableBuilder(column: $table.semester, builder: (column) => column);

  GeneratedColumn<DateTime> get schedule =>
      $composableBuilder(column: $table.schedule, builder: (column) => column);

  GeneratedColumn<int> get durationInSeconds => $composableBuilder(
    column: $table.durationInSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prerequisites => $composableBuilder(
    column: $table.prerequisites,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseType => $composableBuilder(
    column: $table.courseType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseLevel => $composableBuilder(
    column: $table.courseLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get enrollmentLimit => $composableBuilder(
    column: $table.enrollmentLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentEnrollment => $composableBuilder(
    column: $table.currentEnrollment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseMaterials => $composableBuilder(
    column: $table.courseMaterials,
    builder: (column) => column,
  );
}

class $$MagnetCourseInfoTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $MagnetCourseInfoTable,
          MagnetCourseInfoData,
          $$MagnetCourseInfoTableFilterComposer,
          $$MagnetCourseInfoTableOrderingComposer,
          $$MagnetCourseInfoTableAnnotationComposer,
          $$MagnetCourseInfoTableCreateCompanionBuilder,
          $$MagnetCourseInfoTableUpdateCompanionBuilder,
          (
            MagnetCourseInfoData,
            BaseReferences<
              _$AppDataBase,
              $MagnetCourseInfoTable,
              MagnetCourseInfoData
            >,
          ),
          MagnetCourseInfoData,
          PrefetchHooks Function()
        > {
  $$MagnetCourseInfoTableTableManager(
    _$AppDataBase db,
    $MagnetCourseInfoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MagnetCourseInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MagnetCourseInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MagnetCourseInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userID = const Value.absent(),
                Value<int> institutionID = const Value.absent(),
                Value<String> courseCode = const Value.absent(),
                Value<String> courseTitle = const Value.absent(),
                Value<String?> courseDescription = const Value.absent(),
                Value<int> credits = const Value.absent(),
                Value<String?> instructor = const Value.absent(),
                Value<String?> semester = const Value.absent(),
                Value<DateTime?> schedule = const Value.absent(),
                Value<int?> durationInSeconds = const Value.absent(),
                Value<String?> prerequisites = const Value.absent(),
                Value<String?> courseType = const Value.absent(),
                Value<String?> courseLevel = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int?> enrollmentLimit = const Value.absent(),
                Value<int?> currentEnrollment = const Value.absent(),
                Value<String?> courseMaterials = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetCourseInfoCompanion(
                userID: userID,
                institutionID: institutionID,
                courseCode: courseCode,
                courseTitle: courseTitle,
                courseDescription: courseDescription,
                credits: credits,
                instructor: instructor,
                semester: semester,
                schedule: schedule,
                durationInSeconds: durationInSeconds,
                prerequisites: prerequisites,
                courseType: courseType,
                courseLevel: courseLevel,
                location: location,
                enrollmentLimit: enrollmentLimit,
                currentEnrollment: currentEnrollment,
                courseMaterials: courseMaterials,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userID,
                required int institutionID,
                required String courseCode,
                required String courseTitle,
                Value<String?> courseDescription = const Value.absent(),
                required int credits,
                Value<String?> instructor = const Value.absent(),
                Value<String?> semester = const Value.absent(),
                Value<DateTime?> schedule = const Value.absent(),
                Value<int?> durationInSeconds = const Value.absent(),
                Value<String?> prerequisites = const Value.absent(),
                Value<String?> courseType = const Value.absent(),
                Value<String?> courseLevel = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int?> enrollmentLimit = const Value.absent(),
                Value<int?> currentEnrollment = const Value.absent(),
                Value<String?> courseMaterials = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetCourseInfoCompanion.insert(
                userID: userID,
                institutionID: institutionID,
                courseCode: courseCode,
                courseTitle: courseTitle,
                courseDescription: courseDescription,
                credits: credits,
                instructor: instructor,
                semester: semester,
                schedule: schedule,
                durationInSeconds: durationInSeconds,
                prerequisites: prerequisites,
                courseType: courseType,
                courseLevel: courseLevel,
                location: location,
                enrollmentLimit: enrollmentLimit,
                currentEnrollment: currentEnrollment,
                courseMaterials: courseMaterials,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MagnetCourseInfoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $MagnetCourseInfoTable,
      MagnetCourseInfoData,
      $$MagnetCourseInfoTableFilterComposer,
      $$MagnetCourseInfoTableOrderingComposer,
      $$MagnetCourseInfoTableAnnotationComposer,
      $$MagnetCourseInfoTableCreateCompanionBuilder,
      $$MagnetCourseInfoTableUpdateCompanionBuilder,
      (
        MagnetCourseInfoData,
        BaseReferences<
          _$AppDataBase,
          $MagnetCourseInfoTable,
          MagnetCourseInfoData
        >,
      ),
      MagnetCourseInfoData,
      PrefetchHooks Function()
    >;
typedef $$MagnetFinancialTransactionTableCreateCompanionBuilder =
    MagnetFinancialTransactionCompanion Function({
      required String userID,
      required int institutionID,
      required String transactionId,
      required double amount,
      required DateTime date,
      required String type,
      required String paymentMethod,
      required String studentId,
      required double balanceAfterTransaction,
      required String status,
      required String currency,
      Value<String?> description,
      Value<String?> referenceNumber,
      Value<int> rowid,
    });
typedef $$MagnetFinancialTransactionTableUpdateCompanionBuilder =
    MagnetFinancialTransactionCompanion Function({
      Value<String> userID,
      Value<int> institutionID,
      Value<String> transactionId,
      Value<double> amount,
      Value<DateTime> date,
      Value<String> type,
      Value<String> paymentMethod,
      Value<String> studentId,
      Value<double> balanceAfterTransaction,
      Value<String> status,
      Value<String> currency,
      Value<String?> description,
      Value<String?> referenceNumber,
      Value<int> rowid,
    });

class $$MagnetFinancialTransactionTableFilterComposer
    extends Composer<_$AppDataBase, $MagnetFinancialTransactionTable> {
  $$MagnetFinancialTransactionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balanceAfterTransaction => $composableBuilder(
    column: $table.balanceAfterTransaction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MagnetFinancialTransactionTableOrderingComposer
    extends Composer<_$AppDataBase, $MagnetFinancialTransactionTable> {
  $$MagnetFinancialTransactionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userID => $composableBuilder(
    column: $table.userID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balanceAfterTransaction => $composableBuilder(
    column: $table.balanceAfterTransaction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MagnetFinancialTransactionTableAnnotationComposer
    extends Composer<_$AppDataBase, $MagnetFinancialTransactionTable> {
  $$MagnetFinancialTransactionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userID =>
      $composableBuilder(column: $table.userID, builder: (column) => column);

  GeneratedColumn<int> get institutionID => $composableBuilder(
    column: $table.institutionID,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<double> get balanceAfterTransaction => $composableBuilder(
    column: $table.balanceAfterTransaction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );
}

class $$MagnetFinancialTransactionTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $MagnetFinancialTransactionTable,
          MagnetFinancialTransactionData,
          $$MagnetFinancialTransactionTableFilterComposer,
          $$MagnetFinancialTransactionTableOrderingComposer,
          $$MagnetFinancialTransactionTableAnnotationComposer,
          $$MagnetFinancialTransactionTableCreateCompanionBuilder,
          $$MagnetFinancialTransactionTableUpdateCompanionBuilder,
          (
            MagnetFinancialTransactionData,
            BaseReferences<
              _$AppDataBase,
              $MagnetFinancialTransactionTable,
              MagnetFinancialTransactionData
            >,
          ),
          MagnetFinancialTransactionData,
          PrefetchHooks Function()
        > {
  $$MagnetFinancialTransactionTableTableManager(
    _$AppDataBase db,
    $MagnetFinancialTransactionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MagnetFinancialTransactionTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MagnetFinancialTransactionTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MagnetFinancialTransactionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userID = const Value.absent(),
                Value<int> institutionID = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<double> balanceAfterTransaction = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetFinancialTransactionCompanion(
                userID: userID,
                institutionID: institutionID,
                transactionId: transactionId,
                amount: amount,
                date: date,
                type: type,
                paymentMethod: paymentMethod,
                studentId: studentId,
                balanceAfterTransaction: balanceAfterTransaction,
                status: status,
                currency: currency,
                description: description,
                referenceNumber: referenceNumber,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userID,
                required int institutionID,
                required String transactionId,
                required double amount,
                required DateTime date,
                required String type,
                required String paymentMethod,
                required String studentId,
                required double balanceAfterTransaction,
                required String status,
                required String currency,
                Value<String?> description = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MagnetFinancialTransactionCompanion.insert(
                userID: userID,
                institutionID: institutionID,
                transactionId: transactionId,
                amount: amount,
                date: date,
                type: type,
                paymentMethod: paymentMethod,
                studentId: studentId,
                balanceAfterTransaction: balanceAfterTransaction,
                status: status,
                currency: currency,
                description: description,
                referenceNumber: referenceNumber,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MagnetFinancialTransactionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $MagnetFinancialTransactionTable,
      MagnetFinancialTransactionData,
      $$MagnetFinancialTransactionTableFilterComposer,
      $$MagnetFinancialTransactionTableOrderingComposer,
      $$MagnetFinancialTransactionTableAnnotationComposer,
      $$MagnetFinancialTransactionTableCreateCompanionBuilder,
      $$MagnetFinancialTransactionTableUpdateCompanionBuilder,
      (
        MagnetFinancialTransactionData,
        BaseReferences<
          _$AppDataBase,
          $MagnetFinancialTransactionTable,
          MagnetFinancialTransactionData
        >,
      ),
      MagnetFinancialTransactionData,
      PrefetchHooks Function()
    >;
typedef $$CommunityTableTableCreateCompanionBuilder =
    CommunityTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> creatorId,
      Value<String?> creatorName,
      Value<List<dynamic>?> moderators,
      Value<List<dynamic>?> moderatorNames,
      Value<List<dynamic>?> members,
      Value<List<dynamic>?> memberNames,
      Value<List<dynamic>?> bannedUsers,
      Value<List<dynamic>?> bannedUserNames,
      Value<bool> isPrivate,
      Value<List<dynamic>?> rules,
      Value<String?> logoUrl,
      Value<String?> bannerUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> canModerate,
      Value<bool> canPost,
      Value<bool> isBanned,
      Value<int> memberCount,
    });
typedef $$CommunityTableTableUpdateCompanionBuilder =
    CommunityTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> creatorId,
      Value<String?> creatorName,
      Value<List<dynamic>?> moderators,
      Value<List<dynamic>?> moderatorNames,
      Value<List<dynamic>?> members,
      Value<List<dynamic>?> memberNames,
      Value<List<dynamic>?> bannedUsers,
      Value<List<dynamic>?> bannedUserNames,
      Value<bool> isPrivate,
      Value<List<dynamic>?> rules,
      Value<String?> logoUrl,
      Value<String?> bannerUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> canModerate,
      Value<bool> canPost,
      Value<bool> isBanned,
      Value<int> memberCount,
    });

class $$CommunityTableTableFilterComposer
    extends Composer<_$AppDataBase, $CommunityTableTable> {
  $$CommunityTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creatorId => $composableBuilder(
    column: $table.creatorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creatorName => $composableBuilder(
    column: $table.creatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get moderators => $composableBuilder(
    column: $table.moderators,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get moderatorNames => $composableBuilder(
    column: $table.moderatorNames,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get members => $composableBuilder(
    column: $table.members,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get memberNames => $composableBuilder(
    column: $table.memberNames,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get bannedUsers => $composableBuilder(
    column: $table.bannedUsers,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get bannedUserNames => $composableBuilder(
    column: $table.bannedUserNames,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get rules => $composableBuilder(
    column: $table.rules,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canModerate => $composableBuilder(
    column: $table.canModerate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canPost => $composableBuilder(
    column: $table.canPost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBanned => $composableBuilder(
    column: $table.isBanned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityTableTableOrderingComposer
    extends Composer<_$AppDataBase, $CommunityTableTable> {
  $$CommunityTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creatorId => $composableBuilder(
    column: $table.creatorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creatorName => $composableBuilder(
    column: $table.creatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moderators => $composableBuilder(
    column: $table.moderators,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moderatorNames => $composableBuilder(
    column: $table.moderatorNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get members => $composableBuilder(
    column: $table.members,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberNames => $composableBuilder(
    column: $table.memberNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannedUsers => $composableBuilder(
    column: $table.bannedUsers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannedUserNames => $composableBuilder(
    column: $table.bannedUserNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rules => $composableBuilder(
    column: $table.rules,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canModerate => $composableBuilder(
    column: $table.canModerate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canPost => $composableBuilder(
    column: $table.canPost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBanned => $composableBuilder(
    column: $table.isBanned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityTableTableAnnotationComposer
    extends Composer<_$AppDataBase, $CommunityTableTable> {
  $$CommunityTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creatorId =>
      $composableBuilder(column: $table.creatorId, builder: (column) => column);

  GeneratedColumn<String> get creatorName => $composableBuilder(
    column: $table.creatorName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get moderators =>
      $composableBuilder(
        column: $table.moderators,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get moderatorNames =>
      $composableBuilder(
        column: $table.moderatorNames,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get members =>
      $composableBuilder(column: $table.members, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get memberNames =>
      $composableBuilder(
        column: $table.memberNames,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get bannedUsers =>
      $composableBuilder(
        column: $table.bannedUsers,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  get bannedUserNames => $composableBuilder(
    column: $table.bannedUserNames,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get rules =>
      $composableBuilder(column: $table.rules, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get bannerUrl =>
      $composableBuilder(column: $table.bannerUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get canModerate => $composableBuilder(
    column: $table.canModerate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canPost =>
      $composableBuilder(column: $table.canPost, builder: (column) => column);

  GeneratedColumn<bool> get isBanned =>
      $composableBuilder(column: $table.isBanned, builder: (column) => column);

  GeneratedColumn<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => column,
  );
}

class $$CommunityTableTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $CommunityTableTable,
          CommunityData,
          $$CommunityTableTableFilterComposer,
          $$CommunityTableTableOrderingComposer,
          $$CommunityTableTableAnnotationComposer,
          $$CommunityTableTableCreateCompanionBuilder,
          $$CommunityTableTableUpdateCompanionBuilder,
          (
            CommunityData,
            BaseReferences<_$AppDataBase, $CommunityTableTable, CommunityData>,
          ),
          CommunityData,
          PrefetchHooks Function()
        > {
  $$CommunityTableTableTableManager(
    _$AppDataBase db,
    $CommunityTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> creatorId = const Value.absent(),
                Value<String?> creatorName = const Value.absent(),
                Value<List<dynamic>?> moderators = const Value.absent(),
                Value<List<dynamic>?> moderatorNames = const Value.absent(),
                Value<List<dynamic>?> members = const Value.absent(),
                Value<List<dynamic>?> memberNames = const Value.absent(),
                Value<List<dynamic>?> bannedUsers = const Value.absent(),
                Value<List<dynamic>?> bannedUserNames = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<List<dynamic>?> rules = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> canModerate = const Value.absent(),
                Value<bool> canPost = const Value.absent(),
                Value<bool> isBanned = const Value.absent(),
                Value<int> memberCount = const Value.absent(),
              }) => CommunityTableCompanion(
                id: id,
                name: name,
                description: description,
                creatorId: creatorId,
                creatorName: creatorName,
                moderators: moderators,
                moderatorNames: moderatorNames,
                members: members,
                memberNames: memberNames,
                bannedUsers: bannedUsers,
                bannedUserNames: bannedUserNames,
                isPrivate: isPrivate,
                rules: rules,
                logoUrl: logoUrl,
                bannerUrl: bannerUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                canModerate: canModerate,
                canPost: canPost,
                isBanned: isBanned,
                memberCount: memberCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> creatorId = const Value.absent(),
                Value<String?> creatorName = const Value.absent(),
                Value<List<dynamic>?> moderators = const Value.absent(),
                Value<List<dynamic>?> moderatorNames = const Value.absent(),
                Value<List<dynamic>?> members = const Value.absent(),
                Value<List<dynamic>?> memberNames = const Value.absent(),
                Value<List<dynamic>?> bannedUsers = const Value.absent(),
                Value<List<dynamic>?> bannedUserNames = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<List<dynamic>?> rules = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> canModerate = const Value.absent(),
                Value<bool> canPost = const Value.absent(),
                Value<bool> isBanned = const Value.absent(),
                Value<int> memberCount = const Value.absent(),
              }) => CommunityTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                creatorId: creatorId,
                creatorName: creatorName,
                moderators: moderators,
                moderatorNames: moderatorNames,
                members: members,
                memberNames: memberNames,
                bannedUsers: bannedUsers,
                bannedUserNames: bannedUserNames,
                isPrivate: isPrivate,
                rules: rules,
                logoUrl: logoUrl,
                bannerUrl: bannerUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                canModerate: canModerate,
                canPost: canPost,
                isBanned: isBanned,
                memberCount: memberCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $CommunityTableTable,
      CommunityData,
      $$CommunityTableTableFilterComposer,
      $$CommunityTableTableOrderingComposer,
      $$CommunityTableTableAnnotationComposer,
      $$CommunityTableTableCreateCompanionBuilder,
      $$CommunityTableTableUpdateCompanionBuilder,
      (
        CommunityData,
        BaseReferences<_$AppDataBase, $CommunityTableTable, CommunityData>,
      ),
      CommunityData,
      PrefetchHooks Function()
    >;

class $AppDataBaseManager {
  final _$AppDataBase _db;
  $AppDataBaseManager(this._db);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db, _db.userProfile);
  $$TokenTableTableManager get token =>
      $$TokenTableTableManager(_db, _db.token);
  $$ChirpUserTableTableTableManager get chirpUserTable =>
      $$ChirpUserTableTableTableManager(_db, _db.chirpUserTable);
  $$MessageTableTableTableManager get messageTable =>
      $$MessageTableTableTableManager(_db, _db.messageTable);
  $$ConversationTableTableTableManager get conversationTable =>
      $$ConversationTableTableTableManager(_db, _db.conversationTable);
  $$GroupTableTableTableManager get groupTable =>
      $$GroupTableTableTableManager(_db, _db.groupTable);
  $$PostTableTableTableManager get postTable =>
      $$PostTableTableTableManager(_db, _db.postTable);
  $$AttachmentTableTableTableManager get attachmentTable =>
      $$AttachmentTableTableTableManager(_db, _db.attachmentTable);
  $$PostReplyTableTableTableManager get postReplyTable =>
      $$PostReplyTableTableTableManager(_db, _db.postReplyTable);
  $$TodoTableTableManager get todo => $$TodoTableTableManager(_db, _db.todo);
  $$EventTableTableTableManager get eventTable =>
      $$EventTableTableTableManager(_db, _db.eventTable);
  $$AttendeeTableTableTableManager get attendeeTable =>
      $$AttendeeTableTableTableManager(_db, _db.attendeeTable);
  $$TicketTableTableTableManager get ticketTable =>
      $$TicketTableTableTableManager(_db, _db.ticketTable);
  $$AgendaEventTableTableManager get agendaEvent =>
      $$AgendaEventTableTableManager(_db, _db.agendaEvent);
  $$NotificationTableTableTableManager get notificationTable =>
      $$NotificationTableTableTableManager(_db, _db.notificationTable);
  $$InstitutionTableTableManager get institution =>
      $$InstitutionTableTableManager(_db, _db.institution);
  $$MagnetStudentProfileTableTableManager get magnetStudentProfile =>
      $$MagnetStudentProfileTableTableManager(_db, _db.magnetStudentProfile);
  $$MagnetCredentialsTableTableManager get magnetCredentials =>
      $$MagnetCredentialsTableTableManager(_db, _db.magnetCredentials);
  $$MagnetCourseInfoTableTableManager get magnetCourseInfo =>
      $$MagnetCourseInfoTableTableManager(_db, _db.magnetCourseInfo);
  $$MagnetFinancialTransactionTableTableManager
  get magnetFinancialTransaction =>
      $$MagnetFinancialTransactionTableTableManager(
        _db,
        _db.magnetFinancialTransaction,
      );
  $$CommunityTableTableTableManager get communityTable =>
      $$CommunityTableTableTableManager(_db, _db.communityTable);
}
