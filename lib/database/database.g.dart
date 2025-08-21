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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    userId,
    content,
    likeCount,
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
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      likeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}like_count'],
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
  final String userId;
  final String content;
  final int likeCount;
  const PostEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.content,
    required this.likeCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['user_id'] = Variable<String>(userId);
    map['content'] = Variable<String>(content);
    map['like_count'] = Variable<int>(likeCount);
    return map;
  }

  PostTableCompanion toCompanion(bool nullToAbsent) {
    return PostTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      userId: Value(userId),
      content: Value(content),
      likeCount: Value(likeCount),
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
      userId: serializer.fromJson<String>(json['user_id']),
      content: serializer.fromJson<String>(json['content']),
      likeCount: serializer.fromJson<int>(json['like_count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'user_id': serializer.toJson<String>(userId),
      'content': serializer.toJson<String>(content),
      'like_count': serializer.toJson<int>(likeCount),
    };
  }

  PostEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    String? content,
    int? likeCount,
  }) => PostEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    userId: userId ?? this.userId,
    content: content ?? this.content,
    likeCount: likeCount ?? this.likeCount,
  );
  PostEntity copyWithCompanion(PostTableCompanion data) {
    return PostEntity(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      content: data.content.present ? data.content.value : this.content,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostEntity(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('likeCount: $likeCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, userId, content, likeCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.userId == this.userId &&
          other.content == this.content &&
          other.likeCount == this.likeCount);
}

class PostTableCompanion extends UpdateCompanion<PostEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> userId;
  final Value<String> content;
  final Value<int> likeCount;
  final Value<int> rowid;
  const PostTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.content = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String userId,
    required String content,
    required int likeCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       content = Value(content),
       likeCount = Value(likeCount);
  static Insertable<PostEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<String>? content,
    Expression<int>? likeCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (content != null) 'content': content,
      if (likeCount != null) 'like_count': likeCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? userId,
    Value<String>? content,
    Value<int>? likeCount,
    Value<int>? rowid,
  }) {
    return PostTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
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
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
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
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('likeCount: $likeCount, ')
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    postId,
    attachmentType,
    file,
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
  const AttachmentEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.postId,
    required this.attachmentType,
    required this.file,
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
      file: serializer.fromJson<String>(json['file']),
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
      'file': serializer.toJson<String>(file),
    };
  }

  AttachmentEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? postId,
    String? attachmentType,
    String? file,
  }) => AttachmentEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    postId: postId ?? this.postId,
    attachmentType: attachmentType ?? this.attachmentType,
    file: file ?? this.file,
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
          ..write('file: $file')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, postId, attachmentType, file);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.postId == this.postId &&
          other.attachmentType == this.attachmentType &&
          other.file == this.file);
}

class AttachmentTableCompanion extends UpdateCompanion<AttachmentEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> postId;
  final Value<String> attachmentType;
  final Value<String> file;
  final Value<int> rowid;
  const AttachmentTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.postId = const Value.absent(),
    this.attachmentType = const Value.absent(),
    this.file = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String postId,
    required String attachmentType,
    required String file,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       postId = Value(postId),
       attachmentType = Value(attachmentType),
       file = Value(file);
  static Insertable<AttachmentEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? postId,
    Expression<String>? attachmentType,
    Expression<String>? file,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (postId != null) 'post_id': postId,
      if (attachmentType != null) 'attachment_type': attachmentType,
      if (file != null) 'file': file,
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
    Value<int>? rowid,
  }) {
    return AttachmentTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postId: postId ?? this.postId,
      attachmentType: attachmentType ?? this.attachmentType,
      file: file ?? this.file,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    postId,
    userId,
    content,
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
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
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
      postId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}post_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
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
  final String postId;
  final String userId;
  final String content;
  const PostReplyEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.postId,
    required this.userId,
    required this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['post_id'] = Variable<String>(postId);
    map['user_id'] = Variable<String>(userId);
    map['content'] = Variable<String>(content);
    return map;
  }

  PostReplyTableCompanion toCompanion(bool nullToAbsent) {
    return PostReplyTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      postId: Value(postId),
      userId: Value(userId),
      content: Value(content),
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
      postId: serializer.fromJson<String>(json['post_id']),
      userId: serializer.fromJson<String>(json['user_id']),
      content: serializer.fromJson<String>(json['content']),
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
      'user_id': serializer.toJson<String>(userId),
      'content': serializer.toJson<String>(content),
    };
  }

  PostReplyEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? postId,
    String? userId,
    String? content,
  }) => PostReplyEntity(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    postId: postId ?? this.postId,
    userId: userId ?? this.userId,
    content: content ?? this.content,
  );
  PostReplyEntity copyWithCompanion(PostReplyTableCompanion data) {
    return PostReplyEntity(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      postId: data.postId.present ? data.postId.value : this.postId,
      userId: data.userId.present ? data.userId.value : this.userId,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostReplyEntity(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, postId, userId, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostReplyEntity &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.postId == this.postId &&
          other.userId == this.userId &&
          other.content == this.content);
}

class PostReplyTableCompanion extends UpdateCompanion<PostReplyEntity> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> postId;
  final Value<String> userId;
  final Value<String> content;
  final Value<int> rowid;
  const PostReplyTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.postId = const Value.absent(),
    this.userId = const Value.absent(),
    this.content = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostReplyTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String postId,
    required String userId,
    required String content,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       postId = Value(postId),
       userId = Value(userId),
       content = Value(content);
  static Insertable<PostReplyEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? postId,
    Expression<String>? userId,
    Expression<String>? content,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (postId != null) 'post_id': postId,
      if (userId != null) 'user_id': userId,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostReplyTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? postId,
    Value<String>? userId,
    Value<String>? content,
    Value<int>? rowid,
  }) {
    return PostReplyTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
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
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
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
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
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
      imageUrl: serializer.fromJson<String>(json['image_url']),
      numberOfAttendees: serializer.fromJson<int>(json['number_of_attendees']),
      organizerId: serializer.fromJson<String>(json['organizer_id']),
      genre: serializer.fromJson<String>(json['genre']),
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
      'image_url': serializer.toJson<String>(imageUrl),
      'number_of_attendees': serializer.toJson<int>(numberOfAttendees),
      'organizer_id': serializer.toJson<String>(organizerId),
      'genre': serializer.toJson<String>(genre),
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
          ..write('genre: $genre')
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
          other.genre == this.genre);
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    firstName,
    middleName,
    lastName,
    eventId,
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
  const AttendeeData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.eventId,
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
  }) => AttendeeData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    firstName: firstName ?? this.firstName,
    middleName: middleName.present ? middleName.value : this.middleName,
    lastName: lastName ?? this.lastName,
    eventId: eventId ?? this.eventId,
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
          ..write('eventId: $eventId')
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
          other.eventId == this.eventId);
}

class AttendeeTableCompanion extends UpdateCompanion<AttendeeData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> firstName;
  final Value<String?> middleName;
  final Value<String> lastName;
  final Value<String> eventId;
  final Value<int> rowid;
  const AttendeeTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.eventId = const Value.absent(),
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
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firstName = Value(firstName),
       lastName = Value(lastName),
       eventId = Value(eventId);
  static Insertable<AttendeeData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? eventId,
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

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  $AppDataBaseManager get managers => $AppDataBaseManager(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  late final $TokenTable token = $TokenTable(this);
  late final $ChirpUserTableTable chirpUserTable = $ChirpUserTableTable(this);
  late final $MessageTableTable messageTable = $MessageTableTable(this);
  late final $ConversationTableTable conversationTable =
      $ConversationTableTable(this);
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
    postTable,
    attachmentTable,
    postReplyTable,
    todo,
    eventTable,
    attendeeTable,
    ticketTable,
    agendaEvent,
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
typedef $$PostTableTableCreateCompanionBuilder =
    PostTableCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String userId,
      required String content,
      required int likeCount,
      Value<int> rowid,
    });
typedef $$PostTableTableUpdateCompanionBuilder =
    PostTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> userId,
      Value<String> content,
      Value<int> likeCount,
      Value<int> rowid,
    });

final class $$PostTableTableReferences
    extends BaseReferences<_$AppDataBase, $PostTableTable, PostEntity> {
  $$PostTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

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

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnFilters(column),
  );

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

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

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
                Value<String> userId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> likeCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userId: userId,
                content: content,
                likeCount: likeCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String userId,
                required String content,
                required int likeCount,
                Value<int> rowid = const Value.absent(),
              }) => PostTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                userId: userId,
                content: content,
                likeCount: likeCount,
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
              ({attachmentTableRefs = false, postReplyTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attachmentTableRefs) db.attachmentTable,
                    if (postReplyTableRefs) db.postReplyTable,
                  ],
                  addJoins: null,
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
                Value<int> rowid = const Value.absent(),
              }) => AttachmentTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                postId: postId,
                attachmentType: attachmentType,
                file: file,
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
                Value<int> rowid = const Value.absent(),
              }) => AttachmentTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                postId: postId,
                attachmentType: attachmentType,
                file: file,
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
      required String postId,
      required String userId,
      required String content,
      Value<int> rowid,
    });
typedef $$PostReplyTableTableUpdateCompanionBuilder =
    PostReplyTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> postId,
      Value<String> userId,
      Value<String> content,
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

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
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

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
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

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

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
          PrefetchHooks Function({bool postId})
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
                Value<String> postId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostReplyTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                postId: postId,
                userId: userId,
                content: content,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String postId,
                required String userId,
                required String content,
                Value<int> rowid = const Value.absent(),
              }) => PostReplyTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                postId: postId,
                userId: userId,
                content: content,
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
      PrefetchHooks Function({bool postId})
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
                Value<int> rowid = const Value.absent(),
              }) => AttendeeTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                eventId: eventId,
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
                Value<int> rowid = const Value.absent(),
              }) => AttendeeTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                eventId: eventId,
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
}
