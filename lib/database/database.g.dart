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
  Set<GeneratedColumn> get $primaryKey => const {};
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

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  $AppDataBaseManager get managers => $AppDataBaseManager(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  late final $TokenTable token = $TokenTable(this);
  late final $TodoTable todo = $TodoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfile,
    token,
    todo,
  ];
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

class $AppDataBaseManager {
  final _$AppDataBase _db;
  $AppDataBaseManager(this._db);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db, _db.userProfile);
  $$TokenTableTableManager get token =>
      $$TokenTableTableManager(_db, _db.token);
  $$TodoTableTableManager get todo => $$TodoTableTableManager(_db, _db.todo);
}
