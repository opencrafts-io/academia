// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_v2.dart';

// ignore_for_file: type=lint
class $PlansTable extends Plans with TableInfo<$PlansTable, Plan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _billingIntervalDaysMeta =
      const VerificationMeta('billingIntervalDays');
  @override
  late final GeneratedColumn<int> billingIntervalDays = GeneratedColumn<int>(
    'billing_interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
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
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _visibleMeta = const VerificationMeta(
    'visible',
  );
  @override
  late final GeneratedColumn<bool> visible = GeneratedColumn<bool>(
    'visible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("visible" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    active,
    billingIntervalDays,
    code,
    createdAt,
    createdBy,
    currency,
    description,
    name,
    price,
    updatedAt,
    visible,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    if (data.containsKey('billing_interval_days')) {
      context.handle(
        _billingIntervalDaysMeta,
        billingIntervalDays.isAcceptableOrUnknown(
          data['billing_interval_days']!,
          _billingIntervalDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingIntervalDaysMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('visible')) {
      context.handle(
        _visibleMeta,
        visible.isAcceptableOrUnknown(data['visible']!, _visibleMeta),
      );
    } else if (isInserting) {
      context.missing(_visibleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      billingIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_interval_days'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      visible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}visible'],
      )!,
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class Plan extends DataClass implements Insertable<Plan> {
  final int id;
  final bool active;
  final int billingIntervalDays;
  final String code;
  final DateTime createdAt;
  final String createdBy;
  final String currency;
  final String description;
  final String name;
  final double price;
  final DateTime updatedAt;
  final bool visible;
  const Plan({
    required this.id,
    required this.active,
    required this.billingIntervalDays,
    required this.code,
    required this.createdAt,
    required this.createdBy,
    required this.currency,
    required this.description,
    required this.name,
    required this.price,
    required this.updatedAt,
    required this.visible,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['active'] = Variable<bool>(active);
    map['billing_interval_days'] = Variable<int>(billingIntervalDays);
    map['code'] = Variable<String>(code);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['created_by'] = Variable<String>(createdBy);
    map['currency'] = Variable<String>(currency);
    map['description'] = Variable<String>(description);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['visible'] = Variable<bool>(visible);
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      active: Value(active),
      billingIntervalDays: Value(billingIntervalDays),
      code: Value(code),
      createdAt: Value(createdAt),
      createdBy: Value(createdBy),
      currency: Value(currency),
      description: Value(description),
      name: Value(name),
      price: Value(price),
      updatedAt: Value(updatedAt),
      visible: Value(visible),
    );
  }

  factory Plan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plan(
      id: serializer.fromJson<int>(json['id']),
      active: serializer.fromJson<bool>(json['active']),
      billingIntervalDays: serializer.fromJson<int>(
        json['billingIntervalDays'],
      ),
      code: serializer.fromJson<String>(json['code']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      currency: serializer.fromJson<String>(json['currency']),
      description: serializer.fromJson<String>(json['description']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      visible: serializer.fromJson<bool>(json['visible']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'active': serializer.toJson<bool>(active),
      'billingIntervalDays': serializer.toJson<int>(billingIntervalDays),
      'code': serializer.toJson<String>(code),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'currency': serializer.toJson<String>(currency),
      'description': serializer.toJson<String>(description),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'visible': serializer.toJson<bool>(visible),
    };
  }

  Plan copyWith({
    int? id,
    bool? active,
    int? billingIntervalDays,
    String? code,
    DateTime? createdAt,
    String? createdBy,
    String? currency,
    String? description,
    String? name,
    double? price,
    DateTime? updatedAt,
    bool? visible,
  }) => Plan(
    id: id ?? this.id,
    active: active ?? this.active,
    billingIntervalDays: billingIntervalDays ?? this.billingIntervalDays,
    code: code ?? this.code,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    currency: currency ?? this.currency,
    description: description ?? this.description,
    name: name ?? this.name,
    price: price ?? this.price,
    updatedAt: updatedAt ?? this.updatedAt,
    visible: visible ?? this.visible,
  );
  Plan copyWithCompanion(PlansCompanion data) {
    return Plan(
      id: data.id.present ? data.id.value : this.id,
      active: data.active.present ? data.active.value : this.active,
      billingIntervalDays: data.billingIntervalDays.present
          ? data.billingIntervalDays.value
          : this.billingIntervalDays,
      code: data.code.present ? data.code.value : this.code,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      currency: data.currency.present ? data.currency.value : this.currency,
      description: data.description.present
          ? data.description.value
          : this.description,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      visible: data.visible.present ? data.visible.value : this.visible,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plan(')
          ..write('id: $id, ')
          ..write('active: $active, ')
          ..write('billingIntervalDays: $billingIntervalDays, ')
          ..write('code: $code, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('currency: $currency, ')
          ..write('description: $description, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('visible: $visible')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    active,
    billingIntervalDays,
    code,
    createdAt,
    createdBy,
    currency,
    description,
    name,
    price,
    updatedAt,
    visible,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plan &&
          other.id == this.id &&
          other.active == this.active &&
          other.billingIntervalDays == this.billingIntervalDays &&
          other.code == this.code &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.currency == this.currency &&
          other.description == this.description &&
          other.name == this.name &&
          other.price == this.price &&
          other.updatedAt == this.updatedAt &&
          other.visible == this.visible);
}

class PlansCompanion extends UpdateCompanion<Plan> {
  final Value<int> id;
  final Value<bool> active;
  final Value<int> billingIntervalDays;
  final Value<String> code;
  final Value<DateTime> createdAt;
  final Value<String> createdBy;
  final Value<String> currency;
  final Value<String> description;
  final Value<String> name;
  final Value<double> price;
  final Value<DateTime> updatedAt;
  final Value<bool> visible;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.active = const Value.absent(),
    this.billingIntervalDays = const Value.absent(),
    this.code = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.currency = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.visible = const Value.absent(),
  });
  PlansCompanion.insert({
    this.id = const Value.absent(),
    required bool active,
    required int billingIntervalDays,
    required String code,
    this.createdAt = const Value.absent(),
    required String createdBy,
    required String currency,
    required String description,
    required String name,
    required double price,
    this.updatedAt = const Value.absent(),
    required bool visible,
  }) : active = Value(active),
       billingIntervalDays = Value(billingIntervalDays),
       code = Value(code),
       createdBy = Value(createdBy),
       currency = Value(currency),
       description = Value(description),
       name = Value(name),
       price = Value(price),
       visible = Value(visible);
  static Insertable<Plan> custom({
    Expression<int>? id,
    Expression<bool>? active,
    Expression<int>? billingIntervalDays,
    Expression<String>? code,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<String>? currency,
    Expression<String>? description,
    Expression<String>? name,
    Expression<double>? price,
    Expression<DateTime>? updatedAt,
    Expression<bool>? visible,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (active != null) 'active': active,
      if (billingIntervalDays != null)
        'billing_interval_days': billingIntervalDays,
      if (code != null) 'code': code,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (currency != null) 'currency': currency,
      if (description != null) 'description': description,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (visible != null) 'visible': visible,
    });
  }

  PlansCompanion copyWith({
    Value<int>? id,
    Value<bool>? active,
    Value<int>? billingIntervalDays,
    Value<String>? code,
    Value<DateTime>? createdAt,
    Value<String>? createdBy,
    Value<String>? currency,
    Value<String>? description,
    Value<String>? name,
    Value<double>? price,
    Value<DateTime>? updatedAt,
    Value<bool>? visible,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      active: active ?? this.active,
      billingIntervalDays: billingIntervalDays ?? this.billingIntervalDays,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      name: name ?? this.name,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      visible: visible ?? this.visible,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (billingIntervalDays.present) {
      map['billing_interval_days'] = Variable<int>(billingIntervalDays.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (visible.present) {
      map['visible'] = Variable<bool>(visible.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('active: $active, ')
          ..write('billingIntervalDays: $billingIntervalDays, ')
          ..write('code: $code, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('currency: $currency, ')
          ..write('description: $description, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('visible: $visible')
          ..write(')'))
        .toString();
  }
}

class $BillingOrdersTable extends BillingOrders
    with TableInfo<$BillingOrdersTable, BillingOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<int> tax = GeneratedColumn<int>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelledAtMeta = const VerificationMeta(
    'cancelledAt',
  );
  @override
  late final GeneratedColumn<DateTime> cancelledAt = GeneratedColumn<DateTime>(
    'cancelled_at',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currency,
    discount,
    expiresAt,
    metadata,
    paidAt,
    status,
    subtotal,
    tax,
    total,
    userId,
    cancelledAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('cancelled_at')) {
      context.handle(
        _cancelledAtMeta,
        cancelledAt.isAcceptableOrUnknown(
          data['cancelled_at']!,
          _cancelledAtMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillingOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      cancelledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cancelled_at'],
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
  $BillingOrdersTable createAlias(String alias) {
    return $BillingOrdersTable(attachedDatabase, alias);
  }
}

class BillingOrder extends DataClass implements Insertable<BillingOrder> {
  final String id;
  final String currency;
  final int discount;
  final DateTime? expiresAt;
  final String metadata;
  final DateTime? paidAt;
  final String status;
  final int subtotal;
  final int tax;
  final int total;
  final String? userId;
  final DateTime? cancelledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BillingOrder({
    required this.id,
    required this.currency,
    required this.discount,
    this.expiresAt,
    required this.metadata,
    this.paidAt,
    required this.status,
    required this.subtotal,
    required this.tax,
    required this.total,
    this.userId,
    this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['currency'] = Variable<String>(currency);
    map['discount'] = Variable<int>(discount);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['metadata'] = Variable<String>(metadata);
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    map['status'] = Variable<String>(status);
    map['subtotal'] = Variable<int>(subtotal);
    map['tax'] = Variable<int>(tax);
    map['total'] = Variable<int>(total);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || cancelledAt != null) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillingOrdersCompanion toCompanion(bool nullToAbsent) {
    return BillingOrdersCompanion(
      id: Value(id),
      currency: Value(currency),
      discount: Value(discount),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      metadata: Value(metadata),
      paidAt: paidAt == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAt),
      status: Value(status),
      subtotal: Value(subtotal),
      tax: Value(tax),
      total: Value(total),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      cancelledAt: cancelledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelledAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillingOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingOrder(
      id: serializer.fromJson<String>(json['id']),
      currency: serializer.fromJson<String>(json['currency']),
      discount: serializer.fromJson<int>(json['discount']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      metadata: serializer.fromJson<String>(json['metadata']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      status: serializer.fromJson<String>(json['status']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      tax: serializer.fromJson<int>(json['tax']),
      total: serializer.fromJson<int>(json['total']),
      userId: serializer.fromJson<String?>(json['userId']),
      cancelledAt: serializer.fromJson<DateTime?>(json['cancelledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'currency': serializer.toJson<String>(currency),
      'discount': serializer.toJson<int>(discount),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'metadata': serializer.toJson<String>(metadata),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'status': serializer.toJson<String>(status),
      'subtotal': serializer.toJson<int>(subtotal),
      'tax': serializer.toJson<int>(tax),
      'total': serializer.toJson<int>(total),
      'userId': serializer.toJson<String?>(userId),
      'cancelledAt': serializer.toJson<DateTime?>(cancelledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillingOrder copyWith({
    String? id,
    String? currency,
    int? discount,
    Value<DateTime?> expiresAt = const Value.absent(),
    String? metadata,
    Value<DateTime?> paidAt = const Value.absent(),
    String? status,
    int? subtotal,
    int? tax,
    int? total,
    Value<String?> userId = const Value.absent(),
    Value<DateTime?> cancelledAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BillingOrder(
    id: id ?? this.id,
    currency: currency ?? this.currency,
    discount: discount ?? this.discount,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    metadata: metadata ?? this.metadata,
    paidAt: paidAt.present ? paidAt.value : this.paidAt,
    status: status ?? this.status,
    subtotal: subtotal ?? this.subtotal,
    tax: tax ?? this.tax,
    total: total ?? this.total,
    userId: userId.present ? userId.value : this.userId,
    cancelledAt: cancelledAt.present ? cancelledAt.value : this.cancelledAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillingOrder copyWithCompanion(BillingOrdersCompanion data) {
    return BillingOrder(
      id: data.id.present ? data.id.value : this.id,
      currency: data.currency.present ? data.currency.value : this.currency,
      discount: data.discount.present ? data.discount.value : this.discount,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      status: data.status.present ? data.status.value : this.status,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      tax: data.tax.present ? data.tax.value : this.tax,
      total: data.total.present ? data.total.value : this.total,
      userId: data.userId.present ? data.userId.value : this.userId,
      cancelledAt: data.cancelledAt.present
          ? data.cancelledAt.value
          : this.cancelledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingOrder(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('discount: $discount, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('metadata: $metadata, ')
          ..write('paidAt: $paidAt, ')
          ..write('status: $status, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('total: $total, ')
          ..write('userId: $userId, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currency,
    discount,
    expiresAt,
    metadata,
    paidAt,
    status,
    subtotal,
    tax,
    total,
    userId,
    cancelledAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingOrder &&
          other.id == this.id &&
          other.currency == this.currency &&
          other.discount == this.discount &&
          other.expiresAt == this.expiresAt &&
          other.metadata == this.metadata &&
          other.paidAt == this.paidAt &&
          other.status == this.status &&
          other.subtotal == this.subtotal &&
          other.tax == this.tax &&
          other.total == this.total &&
          other.userId == this.userId &&
          other.cancelledAt == this.cancelledAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillingOrdersCompanion extends UpdateCompanion<BillingOrder> {
  final Value<String> id;
  final Value<String> currency;
  final Value<int> discount;
  final Value<DateTime?> expiresAt;
  final Value<String> metadata;
  final Value<DateTime?> paidAt;
  final Value<String> status;
  final Value<int> subtotal;
  final Value<int> tax;
  final Value<int> total;
  final Value<String?> userId;
  final Value<DateTime?> cancelledAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BillingOrdersCompanion({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.discount = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.metadata = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.status = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.tax = const Value.absent(),
    this.total = const Value.absent(),
    this.userId = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillingOrdersCompanion.insert({
    required String id,
    required String currency,
    required int discount,
    this.expiresAt = const Value.absent(),
    required String metadata,
    this.paidAt = const Value.absent(),
    required String status,
    required int subtotal,
    required int tax,
    required int total,
    this.userId = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       currency = Value(currency),
       discount = Value(discount),
       metadata = Value(metadata),
       status = Value(status),
       subtotal = Value(subtotal),
       tax = Value(tax),
       total = Value(total),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BillingOrder> custom({
    Expression<String>? id,
    Expression<String>? currency,
    Expression<int>? discount,
    Expression<DateTime>? expiresAt,
    Expression<String>? metadata,
    Expression<DateTime>? paidAt,
    Expression<String>? status,
    Expression<int>? subtotal,
    Expression<int>? tax,
    Expression<int>? total,
    Expression<String>? userId,
    Expression<DateTime>? cancelledAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currency != null) 'currency': currency,
      if (discount != null) 'discount': discount,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (metadata != null) 'metadata': metadata,
      if (paidAt != null) 'paid_at': paidAt,
      if (status != null) 'status': status,
      if (subtotal != null) 'subtotal': subtotal,
      if (tax != null) 'tax': tax,
      if (total != null) 'total': total,
      if (userId != null) 'user_id': userId,
      if (cancelledAt != null) 'cancelled_at': cancelledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillingOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? currency,
    Value<int>? discount,
    Value<DateTime?>? expiresAt,
    Value<String>? metadata,
    Value<DateTime?>? paidAt,
    Value<String>? status,
    Value<int>? subtotal,
    Value<int>? tax,
    Value<int>? total,
    Value<String?>? userId,
    Value<DateTime?>? cancelledAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BillingOrdersCompanion(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      discount: discount ?? this.discount,
      expiresAt: expiresAt ?? this.expiresAt,
      metadata: metadata ?? this.metadata,
      paidAt: paidAt ?? this.paidAt,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      userId: userId ?? this.userId,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (discount.present) {
      map['discount'] = Variable<int>(discount.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (tax.present) {
      map['tax'] = Variable<int>(tax.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (cancelledAt.present) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingOrdersCompanion(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('discount: $discount, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('metadata: $metadata, ')
          ..write('paidAt: $paidAt, ')
          ..write('status: $status, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('total: $total, ')
          ..write('userId: $userId, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillingOrderItemsTable extends BillingOrderItems
    with TableInfo<$BillingOrderItemsTable, BillingOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<int> unitPrice = GeneratedColumn<int>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<int> tax = GeneratedColumn<int>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedByMeta = const VerificationMeta(
    'addedBy',
  );
  @override
  late final GeneratedColumn<String> addedBy = GeneratedColumn<String>(
    'added_by',
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    planId,
    quantity,
    unitPrice,
    discount,
    tax,
    addedBy,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('added_by')) {
      context.handle(
        _addedByMeta,
        addedBy.isAcceptableOrUnknown(data['added_by']!, _addedByMeta),
      );
    } else if (isInserting) {
      context.missing(_addedByMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillingOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax'],
      )!,
      addedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}added_by'],
      )!,
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
  $BillingOrderItemsTable createAlias(String alias) {
    return $BillingOrderItemsTable(attachedDatabase, alias);
  }
}

class BillingOrderItem extends DataClass
    implements Insertable<BillingOrderItem> {
  final String id;
  final String orderId;
  final int planId;
  final int quantity;
  final int unitPrice;
  final int discount;
  final int tax;
  final String addedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BillingOrderItem({
    required this.id,
    required this.orderId,
    required this.planId,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.tax,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    map['plan_id'] = Variable<int>(planId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<int>(unitPrice);
    map['discount'] = Variable<int>(discount);
    map['tax'] = Variable<int>(tax);
    map['added_by'] = Variable<String>(addedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillingOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return BillingOrderItemsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      planId: Value(planId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      discount: Value(discount),
      tax: Value(tax),
      addedBy: Value(addedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillingOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingOrderItem(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      planId: serializer.fromJson<int>(json['planId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<int>(json['unitPrice']),
      discount: serializer.fromJson<int>(json['discount']),
      tax: serializer.fromJson<int>(json['tax']),
      addedBy: serializer.fromJson<String>(json['addedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'planId': serializer.toJson<int>(planId),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<int>(unitPrice),
      'discount': serializer.toJson<int>(discount),
      'tax': serializer.toJson<int>(tax),
      'addedBy': serializer.toJson<String>(addedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillingOrderItem copyWith({
    String? id,
    String? orderId,
    int? planId,
    int? quantity,
    int? unitPrice,
    int? discount,
    int? tax,
    String? addedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BillingOrderItem(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    planId: planId ?? this.planId,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    discount: discount ?? this.discount,
    tax: tax ?? this.tax,
    addedBy: addedBy ?? this.addedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillingOrderItem copyWithCompanion(BillingOrderItemsCompanion data) {
    return BillingOrderItem(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      planId: data.planId.present ? data.planId.value : this.planId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      discount: data.discount.present ? data.discount.value : this.discount,
      tax: data.tax.present ? data.tax.value : this.tax,
      addedBy: data.addedBy.present ? data.addedBy.value : this.addedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingOrderItem(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('planId: $planId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('addedBy: $addedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    planId,
    quantity,
    unitPrice,
    discount,
    tax,
    addedBy,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingOrderItem &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.planId == this.planId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.addedBy == this.addedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillingOrderItemsCompanion extends UpdateCompanion<BillingOrderItem> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<int> planId;
  final Value<int> quantity;
  final Value<int> unitPrice;
  final Value<int> discount;
  final Value<int> tax;
  final Value<String> addedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BillingOrderItemsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.planId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.addedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillingOrderItemsCompanion.insert({
    required String id,
    required String orderId,
    required int planId,
    required int quantity,
    required int unitPrice,
    required int discount,
    required int tax,
    required String addedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       orderId = Value(orderId),
       planId = Value(planId),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       discount = Value(discount),
       tax = Value(tax),
       addedBy = Value(addedBy),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BillingOrderItem> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<int>? planId,
    Expression<int>? quantity,
    Expression<int>? unitPrice,
    Expression<int>? discount,
    Expression<int>? tax,
    Expression<String>? addedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (planId != null) 'plan_id': planId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (addedBy != null) 'added_by': addedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillingOrderItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? orderId,
    Value<int>? planId,
    Value<int>? quantity,
    Value<int>? unitPrice,
    Value<int>? discount,
    Value<int>? tax,
    Value<String>? addedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BillingOrderItemsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      planId: planId ?? this.planId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      addedBy: addedBy ?? this.addedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<int>(unitPrice.value);
    }
    if (discount.present) {
      map['discount'] = Variable<int>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<int>(tax.value);
    }
    if (addedBy.present) {
      map['added_by'] = Variable<String>(addedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('planId: $planId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('addedBy: $addedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillingSubscriptionsTable extends BillingSubscriptions
    with TableInfo<$BillingSubscriptionsTable, BillingSubscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingSubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _planCodeMeta = const VerificationMeta(
    'planCode',
  );
  @override
  late final GeneratedColumn<String> planCode = GeneratedColumn<String>(
    'plan_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planNameMeta = const VerificationMeta(
    'planName',
  );
  @override
  late final GeneratedColumn<String> planName = GeneratedColumn<String>(
    'plan_name',
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
  static const VerificationMeta _cancelAtPeriodEndMeta = const VerificationMeta(
    'cancelAtPeriodEnd',
  );
  @override
  late final GeneratedColumn<bool> cancelAtPeriodEnd = GeneratedColumn<bool>(
    'cancel_at_period_end',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cancel_at_period_end" IN (0, 1))',
    ),
  );
  static const VerificationMeta _cancelledAtMeta = const VerificationMeta(
    'cancelledAt',
  );
  @override
  late final GeneratedColumn<DateTime> cancelledAt = GeneratedColumn<DateTime>(
    'cancelled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPeriodEndMeta = const VerificationMeta(
    'currentPeriodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> currentPeriodEnd =
      GeneratedColumn<DateTime>(
        'current_period_end',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _currentPeriodStartMeta =
      const VerificationMeta('currentPeriodStart');
  @override
  late final GeneratedColumn<DateTime> currentPeriodStart =
      GeneratedColumn<DateTime>(
        'current_period_start',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planCode,
    planId,
    planName,
    status,
    cancelAtPeriodEnd,
    cancelledAt,
    currentPeriodEnd,
    currentPeriodStart,
    startedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingSubscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_code')) {
      context.handle(
        _planCodeMeta,
        planCode.isAcceptableOrUnknown(data['plan_code']!, _planCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_planCodeMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('plan_name')) {
      context.handle(
        _planNameMeta,
        planName.isAcceptableOrUnknown(data['plan_name']!, _planNameMeta),
      );
    } else if (isInserting) {
      context.missing(_planNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('cancel_at_period_end')) {
      context.handle(
        _cancelAtPeriodEndMeta,
        cancelAtPeriodEnd.isAcceptableOrUnknown(
          data['cancel_at_period_end']!,
          _cancelAtPeriodEndMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cancelAtPeriodEndMeta);
    }
    if (data.containsKey('cancelled_at')) {
      context.handle(
        _cancelledAtMeta,
        cancelledAt.isAcceptableOrUnknown(
          data['cancelled_at']!,
          _cancelledAtMeta,
        ),
      );
    }
    if (data.containsKey('current_period_end')) {
      context.handle(
        _currentPeriodEndMeta,
        currentPeriodEnd.isAcceptableOrUnknown(
          data['current_period_end']!,
          _currentPeriodEndMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPeriodEndMeta);
    }
    if (data.containsKey('current_period_start')) {
      context.handle(
        _currentPeriodStartMeta,
        currentPeriodStart.isAcceptableOrUnknown(
          data['current_period_start']!,
          _currentPeriodStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPeriodStartMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillingSubscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingSubscription(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_code'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      planName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      cancelAtPeriodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cancel_at_period_end'],
      )!,
      cancelledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cancelled_at'],
      ),
      currentPeriodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_period_end'],
      )!,
      currentPeriodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_period_start'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
    );
  }

  @override
  $BillingSubscriptionsTable createAlias(String alias) {
    return $BillingSubscriptionsTable(attachedDatabase, alias);
  }
}

class BillingSubscription extends DataClass
    implements Insertable<BillingSubscription> {
  final int id;
  final String planCode;
  final int planId;
  final String planName;
  final String status;
  final bool cancelAtPeriodEnd;
  final DateTime? cancelledAt;
  final DateTime currentPeriodEnd;
  final DateTime currentPeriodStart;
  final DateTime startedAt;
  const BillingSubscription({
    required this.id,
    required this.planCode,
    required this.planId,
    required this.planName,
    required this.status,
    required this.cancelAtPeriodEnd,
    this.cancelledAt,
    required this.currentPeriodEnd,
    required this.currentPeriodStart,
    required this.startedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_code'] = Variable<String>(planCode);
    map['plan_id'] = Variable<int>(planId);
    map['plan_name'] = Variable<String>(planName);
    map['status'] = Variable<String>(status);
    map['cancel_at_period_end'] = Variable<bool>(cancelAtPeriodEnd);
    if (!nullToAbsent || cancelledAt != null) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt);
    }
    map['current_period_end'] = Variable<DateTime>(currentPeriodEnd);
    map['current_period_start'] = Variable<DateTime>(currentPeriodStart);
    map['started_at'] = Variable<DateTime>(startedAt);
    return map;
  }

  BillingSubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return BillingSubscriptionsCompanion(
      id: Value(id),
      planCode: Value(planCode),
      planId: Value(planId),
      planName: Value(planName),
      status: Value(status),
      cancelAtPeriodEnd: Value(cancelAtPeriodEnd),
      cancelledAt: cancelledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelledAt),
      currentPeriodEnd: Value(currentPeriodEnd),
      currentPeriodStart: Value(currentPeriodStart),
      startedAt: Value(startedAt),
    );
  }

  factory BillingSubscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingSubscription(
      id: serializer.fromJson<int>(json['id']),
      planCode: serializer.fromJson<String>(json['planCode']),
      planId: serializer.fromJson<int>(json['planId']),
      planName: serializer.fromJson<String>(json['planName']),
      status: serializer.fromJson<String>(json['status']),
      cancelAtPeriodEnd: serializer.fromJson<bool>(json['cancelAtPeriodEnd']),
      cancelledAt: serializer.fromJson<DateTime?>(json['cancelledAt']),
      currentPeriodEnd: serializer.fromJson<DateTime>(json['currentPeriodEnd']),
      currentPeriodStart: serializer.fromJson<DateTime>(
        json['currentPeriodStart'],
      ),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planCode': serializer.toJson<String>(planCode),
      'planId': serializer.toJson<int>(planId),
      'planName': serializer.toJson<String>(planName),
      'status': serializer.toJson<String>(status),
      'cancelAtPeriodEnd': serializer.toJson<bool>(cancelAtPeriodEnd),
      'cancelledAt': serializer.toJson<DateTime?>(cancelledAt),
      'currentPeriodEnd': serializer.toJson<DateTime>(currentPeriodEnd),
      'currentPeriodStart': serializer.toJson<DateTime>(currentPeriodStart),
      'startedAt': serializer.toJson<DateTime>(startedAt),
    };
  }

  BillingSubscription copyWith({
    int? id,
    String? planCode,
    int? planId,
    String? planName,
    String? status,
    bool? cancelAtPeriodEnd,
    Value<DateTime?> cancelledAt = const Value.absent(),
    DateTime? currentPeriodEnd,
    DateTime? currentPeriodStart,
    DateTime? startedAt,
  }) => BillingSubscription(
    id: id ?? this.id,
    planCode: planCode ?? this.planCode,
    planId: planId ?? this.planId,
    planName: planName ?? this.planName,
    status: status ?? this.status,
    cancelAtPeriodEnd: cancelAtPeriodEnd ?? this.cancelAtPeriodEnd,
    cancelledAt: cancelledAt.present ? cancelledAt.value : this.cancelledAt,
    currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
    currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
    startedAt: startedAt ?? this.startedAt,
  );
  BillingSubscription copyWithCompanion(BillingSubscriptionsCompanion data) {
    return BillingSubscription(
      id: data.id.present ? data.id.value : this.id,
      planCode: data.planCode.present ? data.planCode.value : this.planCode,
      planId: data.planId.present ? data.planId.value : this.planId,
      planName: data.planName.present ? data.planName.value : this.planName,
      status: data.status.present ? data.status.value : this.status,
      cancelAtPeriodEnd: data.cancelAtPeriodEnd.present
          ? data.cancelAtPeriodEnd.value
          : this.cancelAtPeriodEnd,
      cancelledAt: data.cancelledAt.present
          ? data.cancelledAt.value
          : this.cancelledAt,
      currentPeriodEnd: data.currentPeriodEnd.present
          ? data.currentPeriodEnd.value
          : this.currentPeriodEnd,
      currentPeriodStart: data.currentPeriodStart.present
          ? data.currentPeriodStart.value
          : this.currentPeriodStart,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingSubscription(')
          ..write('id: $id, ')
          ..write('planCode: $planCode, ')
          ..write('planId: $planId, ')
          ..write('planName: $planName, ')
          ..write('status: $status, ')
          ..write('cancelAtPeriodEnd: $cancelAtPeriodEnd, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('currentPeriodEnd: $currentPeriodEnd, ')
          ..write('currentPeriodStart: $currentPeriodStart, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planCode,
    planId,
    planName,
    status,
    cancelAtPeriodEnd,
    cancelledAt,
    currentPeriodEnd,
    currentPeriodStart,
    startedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingSubscription &&
          other.id == this.id &&
          other.planCode == this.planCode &&
          other.planId == this.planId &&
          other.planName == this.planName &&
          other.status == this.status &&
          other.cancelAtPeriodEnd == this.cancelAtPeriodEnd &&
          other.cancelledAt == this.cancelledAt &&
          other.currentPeriodEnd == this.currentPeriodEnd &&
          other.currentPeriodStart == this.currentPeriodStart &&
          other.startedAt == this.startedAt);
}

class BillingSubscriptionsCompanion
    extends UpdateCompanion<BillingSubscription> {
  final Value<int> id;
  final Value<String> planCode;
  final Value<int> planId;
  final Value<String> planName;
  final Value<String> status;
  final Value<bool> cancelAtPeriodEnd;
  final Value<DateTime?> cancelledAt;
  final Value<DateTime> currentPeriodEnd;
  final Value<DateTime> currentPeriodStart;
  final Value<DateTime> startedAt;
  const BillingSubscriptionsCompanion({
    this.id = const Value.absent(),
    this.planCode = const Value.absent(),
    this.planId = const Value.absent(),
    this.planName = const Value.absent(),
    this.status = const Value.absent(),
    this.cancelAtPeriodEnd = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    this.currentPeriodEnd = const Value.absent(),
    this.currentPeriodStart = const Value.absent(),
    this.startedAt = const Value.absent(),
  });
  BillingSubscriptionsCompanion.insert({
    this.id = const Value.absent(),
    required String planCode,
    required int planId,
    required String planName,
    required String status,
    required bool cancelAtPeriodEnd,
    this.cancelledAt = const Value.absent(),
    required DateTime currentPeriodEnd,
    required DateTime currentPeriodStart,
    required DateTime startedAt,
  }) : planCode = Value(planCode),
       planId = Value(planId),
       planName = Value(planName),
       status = Value(status),
       cancelAtPeriodEnd = Value(cancelAtPeriodEnd),
       currentPeriodEnd = Value(currentPeriodEnd),
       currentPeriodStart = Value(currentPeriodStart),
       startedAt = Value(startedAt);
  static Insertable<BillingSubscription> custom({
    Expression<int>? id,
    Expression<String>? planCode,
    Expression<int>? planId,
    Expression<String>? planName,
    Expression<String>? status,
    Expression<bool>? cancelAtPeriodEnd,
    Expression<DateTime>? cancelledAt,
    Expression<DateTime>? currentPeriodEnd,
    Expression<DateTime>? currentPeriodStart,
    Expression<DateTime>? startedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planCode != null) 'plan_code': planCode,
      if (planId != null) 'plan_id': planId,
      if (planName != null) 'plan_name': planName,
      if (status != null) 'status': status,
      if (cancelAtPeriodEnd != null) 'cancel_at_period_end': cancelAtPeriodEnd,
      if (cancelledAt != null) 'cancelled_at': cancelledAt,
      if (currentPeriodEnd != null) 'current_period_end': currentPeriodEnd,
      if (currentPeriodStart != null)
        'current_period_start': currentPeriodStart,
      if (startedAt != null) 'started_at': startedAt,
    });
  }

  BillingSubscriptionsCompanion copyWith({
    Value<int>? id,
    Value<String>? planCode,
    Value<int>? planId,
    Value<String>? planName,
    Value<String>? status,
    Value<bool>? cancelAtPeriodEnd,
    Value<DateTime?>? cancelledAt,
    Value<DateTime>? currentPeriodEnd,
    Value<DateTime>? currentPeriodStart,
    Value<DateTime>? startedAt,
  }) {
    return BillingSubscriptionsCompanion(
      id: id ?? this.id,
      planCode: planCode ?? this.planCode,
      planId: planId ?? this.planId,
      planName: planName ?? this.planName,
      status: status ?? this.status,
      cancelAtPeriodEnd: cancelAtPeriodEnd ?? this.cancelAtPeriodEnd,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
      currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planCode.present) {
      map['plan_code'] = Variable<String>(planCode.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (planName.present) {
      map['plan_name'] = Variable<String>(planName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (cancelAtPeriodEnd.present) {
      map['cancel_at_period_end'] = Variable<bool>(cancelAtPeriodEnd.value);
    }
    if (cancelledAt.present) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt.value);
    }
    if (currentPeriodEnd.present) {
      map['current_period_end'] = Variable<DateTime>(currentPeriodEnd.value);
    }
    if (currentPeriodStart.present) {
      map['current_period_start'] = Variable<DateTime>(
        currentPeriodStart.value,
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingSubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('planCode: $planCode, ')
          ..write('planId: $planId, ')
          ..write('planName: $planName, ')
          ..write('status: $status, ')
          ..write('cancelAtPeriodEnd: $cancelAtPeriodEnd, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('currentPeriodEnd: $currentPeriodEnd, ')
          ..write('currentPeriodStart: $currentPeriodStart, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }
}

class $BillingSubscriptionStatusesTable extends BillingSubscriptionStatuses
    with
        TableInfo<
          $BillingSubscriptionStatusesTable,
          BillingSubscriptionStatuse
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingSubscriptionStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<int> subscriptionId = GeneratedColumn<int>(
    'subscription_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [id, active, subscriptionId, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_subscription_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingSubscriptionStatuse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillingSubscriptionStatuse map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingSubscriptionStatuse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subscription_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BillingSubscriptionStatusesTable createAlias(String alias) {
    return $BillingSubscriptionStatusesTable(attachedDatabase, alias);
  }
}

class BillingSubscriptionStatuse extends DataClass
    implements Insertable<BillingSubscriptionStatuse> {
  final int id;
  final bool active;
  final int? subscriptionId;
  final DateTime updatedAt;
  const BillingSubscriptionStatuse({
    required this.id,
    required this.active,
    this.subscriptionId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || subscriptionId != null) {
      map['subscription_id'] = Variable<int>(subscriptionId);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillingSubscriptionStatusesCompanion toCompanion(bool nullToAbsent) {
    return BillingSubscriptionStatusesCompanion(
      id: Value(id),
      active: Value(active),
      subscriptionId: subscriptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionId),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillingSubscriptionStatuse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingSubscriptionStatuse(
      id: serializer.fromJson<int>(json['id']),
      active: serializer.fromJson<bool>(json['active']),
      subscriptionId: serializer.fromJson<int?>(json['subscriptionId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'active': serializer.toJson<bool>(active),
      'subscriptionId': serializer.toJson<int?>(subscriptionId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillingSubscriptionStatuse copyWith({
    int? id,
    bool? active,
    Value<int?> subscriptionId = const Value.absent(),
    DateTime? updatedAt,
  }) => BillingSubscriptionStatuse(
    id: id ?? this.id,
    active: active ?? this.active,
    subscriptionId: subscriptionId.present
        ? subscriptionId.value
        : this.subscriptionId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillingSubscriptionStatuse copyWithCompanion(
    BillingSubscriptionStatusesCompanion data,
  ) {
    return BillingSubscriptionStatuse(
      id: data.id.present ? data.id.value : this.id,
      active: data.active.present ? data.active.value : this.active,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingSubscriptionStatuse(')
          ..write('id: $id, ')
          ..write('active: $active, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, active, subscriptionId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingSubscriptionStatuse &&
          other.id == this.id &&
          other.active == this.active &&
          other.subscriptionId == this.subscriptionId &&
          other.updatedAt == this.updatedAt);
}

class BillingSubscriptionStatusesCompanion
    extends UpdateCompanion<BillingSubscriptionStatuse> {
  final Value<int> id;
  final Value<bool> active;
  final Value<int?> subscriptionId;
  final Value<DateTime> updatedAt;
  const BillingSubscriptionStatusesCompanion({
    this.id = const Value.absent(),
    this.active = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BillingSubscriptionStatusesCompanion.insert({
    this.id = const Value.absent(),
    required bool active,
    this.subscriptionId = const Value.absent(),
    required DateTime updatedAt,
  }) : active = Value(active),
       updatedAt = Value(updatedAt);
  static Insertable<BillingSubscriptionStatuse> custom({
    Expression<int>? id,
    Expression<bool>? active,
    Expression<int>? subscriptionId,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (active != null) 'active': active,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BillingSubscriptionStatusesCompanion copyWith({
    Value<int>? id,
    Value<bool>? active,
    Value<int?>? subscriptionId,
    Value<DateTime>? updatedAt,
  }) {
    return BillingSubscriptionStatusesCompanion(
      id: id ?? this.id,
      active: active ?? this.active,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<int>(subscriptionId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingSubscriptionStatusesCompanion(')
          ..write('id: $id, ')
          ..write('active: $active, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BillingEntitlementsTable extends BillingEntitlements
    with TableInfo<$BillingEntitlementsTable, BillingEntitlement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingEntitlementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _planCodeMeta = const VerificationMeta(
    'planCode',
  );
  @override
  late final GeneratedColumn<String> planCode = GeneratedColumn<String>(
    'plan_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
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
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    planCode,
    key,
    description,
    unit,
    value,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_entitlements';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingEntitlement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('plan_code')) {
      context.handle(
        _planCodeMeta,
        planCode.isAcceptableOrUnknown(data['plan_code']!, _planCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_planCodeMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
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
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {planCode, key};
  @override
  BillingEntitlement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingEntitlement(
      planCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_code'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
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
  $BillingEntitlementsTable createAlias(String alias) {
    return $BillingEntitlementsTable(attachedDatabase, alias);
  }
}

class BillingEntitlement extends DataClass
    implements Insertable<BillingEntitlement> {
  final String planCode;
  final String key;
  final String? description;
  final String unit;
  final int value;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BillingEntitlement({
    required this.planCode,
    required this.key,
    this.description,
    required this.unit,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['plan_code'] = Variable<String>(planCode);
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['unit'] = Variable<String>(unit);
    map['value'] = Variable<int>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BillingEntitlementsCompanion toCompanion(bool nullToAbsent) {
    return BillingEntitlementsCompanion(
      planCode: Value(planCode),
      key: Value(key),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      unit: Value(unit),
      value: Value(value),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BillingEntitlement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingEntitlement(
      planCode: serializer.fromJson<String>(json['planCode']),
      key: serializer.fromJson<String>(json['key']),
      description: serializer.fromJson<String?>(json['description']),
      unit: serializer.fromJson<String>(json['unit']),
      value: serializer.fromJson<int>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'planCode': serializer.toJson<String>(planCode),
      'key': serializer.toJson<String>(key),
      'description': serializer.toJson<String?>(description),
      'unit': serializer.toJson<String>(unit),
      'value': serializer.toJson<int>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BillingEntitlement copyWith({
    String? planCode,
    String? key,
    Value<String?> description = const Value.absent(),
    String? unit,
    int? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BillingEntitlement(
    planCode: planCode ?? this.planCode,
    key: key ?? this.key,
    description: description.present ? description.value : this.description,
    unit: unit ?? this.unit,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BillingEntitlement copyWithCompanion(BillingEntitlementsCompanion data) {
    return BillingEntitlement(
      planCode: data.planCode.present ? data.planCode.value : this.planCode,
      key: data.key.present ? data.key.value : this.key,
      description: data.description.present
          ? data.description.value
          : this.description,
      unit: data.unit.present ? data.unit.value : this.unit,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingEntitlement(')
          ..write('planCode: $planCode, ')
          ..write('key: $key, ')
          ..write('description: $description, ')
          ..write('unit: $unit, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    planCode,
    key,
    description,
    unit,
    value,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingEntitlement &&
          other.planCode == this.planCode &&
          other.key == this.key &&
          other.description == this.description &&
          other.unit == this.unit &&
          other.value == this.value &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillingEntitlementsCompanion extends UpdateCompanion<BillingEntitlement> {
  final Value<String> planCode;
  final Value<String> key;
  final Value<String?> description;
  final Value<String> unit;
  final Value<int> value;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BillingEntitlementsCompanion({
    this.planCode = const Value.absent(),
    this.key = const Value.absent(),
    this.description = const Value.absent(),
    this.unit = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillingEntitlementsCompanion.insert({
    required String planCode,
    required String key,
    this.description = const Value.absent(),
    required String unit,
    required int value,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : planCode = Value(planCode),
       key = Value(key),
       unit = Value(unit),
       value = Value(value),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BillingEntitlement> custom({
    Expression<String>? planCode,
    Expression<String>? key,
    Expression<String>? description,
    Expression<String>? unit,
    Expression<int>? value,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (planCode != null) 'plan_code': planCode,
      if (key != null) 'key': key,
      if (description != null) 'description': description,
      if (unit != null) 'unit': unit,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillingEntitlementsCompanion copyWith({
    Value<String>? planCode,
    Value<String>? key,
    Value<String?>? description,
    Value<String>? unit,
    Value<int>? value,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BillingEntitlementsCompanion(
      planCode: planCode ?? this.planCode,
      key: key ?? this.key,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (planCode.present) {
      map['plan_code'] = Variable<String>(planCode.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingEntitlementsCompanion(')
          ..write('planCode: $planCode, ')
          ..write('key: $key, ')
          ..write('description: $description, ')
          ..write('unit: $unit, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LockInRuleRecordsTable extends LockInRuleRecords
    with TableInfo<$LockInRuleRecordsTable, LockInRuleRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LockInRuleRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _appsJsonMeta = const VerificationMeta(
    'appsJson',
  );
  @override
  late final GeneratedColumn<String> appsJson = GeneratedColumn<String>(
    'apps_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysJsonMeta = const VerificationMeta(
    'weekdaysJson',
  );
  @override
  late final GeneratedColumn<String> weekdaysJson = GeneratedColumn<String>(
    'weekdays_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinutesMeta = const VerificationMeta(
    'startMinutes',
  );
  @override
  late final GeneratedColumn<int> startMinutes = GeneratedColumn<int>(
    'start_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinutesMeta = const VerificationMeta(
    'endMinutes',
  );
  @override
  late final GeneratedColumn<int> endMinutes = GeneratedColumn<int>(
    'end_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    appsJson,
    weekdaysJson,
    startMinutes,
    endMinutes,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lock_in_rule_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<LockInRuleRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('apps_json')) {
      context.handle(
        _appsJsonMeta,
        appsJson.isAcceptableOrUnknown(data['apps_json']!, _appsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_appsJsonMeta);
    }
    if (data.containsKey('weekdays_json')) {
      context.handle(
        _weekdaysJsonMeta,
        weekdaysJson.isAcceptableOrUnknown(
          data['weekdays_json']!,
          _weekdaysJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekdaysJsonMeta);
    }
    if (data.containsKey('start_minutes')) {
      context.handle(
        _startMinutesMeta,
        startMinutes.isAcceptableOrUnknown(
          data['start_minutes']!,
          _startMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinutesMeta);
    }
    if (data.containsKey('end_minutes')) {
      context.handle(
        _endMinutesMeta,
        endMinutes.isAcceptableOrUnknown(data['end_minutes']!, _endMinutesMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinutesMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    } else if (isInserting) {
      context.missing(_enabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LockInRuleRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LockInRuleRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      appsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apps_json'],
      )!,
      weekdaysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays_json'],
      )!,
      startMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minutes'],
      )!,
      endMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minutes'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $LockInRuleRecordsTable createAlias(String alias) {
    return $LockInRuleRecordsTable(attachedDatabase, alias);
  }
}

class LockInRuleRecord extends DataClass
    implements Insertable<LockInRuleRecord> {
  final String id;
  final String name;
  final String appsJson;
  final String weekdaysJson;
  final int startMinutes;
  final int endMinutes;
  final bool enabled;
  const LockInRuleRecord({
    required this.id,
    required this.name,
    required this.appsJson,
    required this.weekdaysJson,
    required this.startMinutes,
    required this.endMinutes,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['apps_json'] = Variable<String>(appsJson);
    map['weekdays_json'] = Variable<String>(weekdaysJson);
    map['start_minutes'] = Variable<int>(startMinutes);
    map['end_minutes'] = Variable<int>(endMinutes);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  LockInRuleRecordsCompanion toCompanion(bool nullToAbsent) {
    return LockInRuleRecordsCompanion(
      id: Value(id),
      name: Value(name),
      appsJson: Value(appsJson),
      weekdaysJson: Value(weekdaysJson),
      startMinutes: Value(startMinutes),
      endMinutes: Value(endMinutes),
      enabled: Value(enabled),
    );
  }

  factory LockInRuleRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LockInRuleRecord(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      appsJson: serializer.fromJson<String>(json['appsJson']),
      weekdaysJson: serializer.fromJson<String>(json['weekdaysJson']),
      startMinutes: serializer.fromJson<int>(json['startMinutes']),
      endMinutes: serializer.fromJson<int>(json['endMinutes']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'appsJson': serializer.toJson<String>(appsJson),
      'weekdaysJson': serializer.toJson<String>(weekdaysJson),
      'startMinutes': serializer.toJson<int>(startMinutes),
      'endMinutes': serializer.toJson<int>(endMinutes),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  LockInRuleRecord copyWith({
    String? id,
    String? name,
    String? appsJson,
    String? weekdaysJson,
    int? startMinutes,
    int? endMinutes,
    bool? enabled,
  }) => LockInRuleRecord(
    id: id ?? this.id,
    name: name ?? this.name,
    appsJson: appsJson ?? this.appsJson,
    weekdaysJson: weekdaysJson ?? this.weekdaysJson,
    startMinutes: startMinutes ?? this.startMinutes,
    endMinutes: endMinutes ?? this.endMinutes,
    enabled: enabled ?? this.enabled,
  );
  LockInRuleRecord copyWithCompanion(LockInRuleRecordsCompanion data) {
    return LockInRuleRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      appsJson: data.appsJson.present ? data.appsJson.value : this.appsJson,
      weekdaysJson: data.weekdaysJson.present
          ? data.weekdaysJson.value
          : this.weekdaysJson,
      startMinutes: data.startMinutes.present
          ? data.startMinutes.value
          : this.startMinutes,
      endMinutes: data.endMinutes.present
          ? data.endMinutes.value
          : this.endMinutes,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LockInRuleRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('appsJson: $appsJson, ')
          ..write('weekdaysJson: $weekdaysJson, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    appsJson,
    weekdaysJson,
    startMinutes,
    endMinutes,
    enabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LockInRuleRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.appsJson == this.appsJson &&
          other.weekdaysJson == this.weekdaysJson &&
          other.startMinutes == this.startMinutes &&
          other.endMinutes == this.endMinutes &&
          other.enabled == this.enabled);
}

class LockInRuleRecordsCompanion extends UpdateCompanion<LockInRuleRecord> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> appsJson;
  final Value<String> weekdaysJson;
  final Value<int> startMinutes;
  final Value<int> endMinutes;
  final Value<bool> enabled;
  final Value<int> rowid;
  const LockInRuleRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.appsJson = const Value.absent(),
    this.weekdaysJson = const Value.absent(),
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LockInRuleRecordsCompanion.insert({
    required String id,
    required String name,
    required String appsJson,
    required String weekdaysJson,
    required int startMinutes,
    required int endMinutes,
    required bool enabled,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       appsJson = Value(appsJson),
       weekdaysJson = Value(weekdaysJson),
       startMinutes = Value(startMinutes),
       endMinutes = Value(endMinutes),
       enabled = Value(enabled);
  static Insertable<LockInRuleRecord> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? appsJson,
    Expression<String>? weekdaysJson,
    Expression<int>? startMinutes,
    Expression<int>? endMinutes,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (appsJson != null) 'apps_json': appsJson,
      if (weekdaysJson != null) 'weekdays_json': weekdaysJson,
      if (startMinutes != null) 'start_minutes': startMinutes,
      if (endMinutes != null) 'end_minutes': endMinutes,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LockInRuleRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? appsJson,
    Value<String>? weekdaysJson,
    Value<int>? startMinutes,
    Value<int>? endMinutes,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return LockInRuleRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      appsJson: appsJson ?? this.appsJson,
      weekdaysJson: weekdaysJson ?? this.weekdaysJson,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (appsJson.present) {
      map['apps_json'] = Variable<String>(appsJson.value);
    }
    if (weekdaysJson.present) {
      map['weekdays_json'] = Variable<String>(weekdaysJson.value);
    }
    if (startMinutes.present) {
      map['start_minutes'] = Variable<int>(startMinutes.value);
    }
    if (endMinutes.present) {
      map['end_minutes'] = Variable<int>(endMinutes.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LockInRuleRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('appsJson: $appsJson, ')
          ..write('weekdaysJson: $weekdaysJson, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LockInAttemptsTable extends LockInAttempts
    with TableInfo<$LockInAttemptsTable, LockInAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LockInAttemptsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _appIdentifierMeta = const VerificationMeta(
    'appIdentifier',
  );
  @override
  late final GeneratedColumn<String> appIdentifier = GeneratedColumn<String>(
    'app_identifier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appNameMeta = const VerificationMeta(
    'appName',
  );
  @override
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
    'app_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
    'rule_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    appIdentifier,
    appName,
    ruleId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lock_in_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LockInAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('app_identifier')) {
      context.handle(
        _appIdentifierMeta,
        appIdentifier.isAcceptableOrUnknown(
          data['app_identifier']!,
          _appIdentifierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appIdentifierMeta);
    }
    if (data.containsKey('app_name')) {
      context.handle(
        _appNameMeta,
        appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta),
      );
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LockInAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LockInAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      appIdentifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_identifier'],
      )!,
      appName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_name'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $LockInAttemptsTable createAlias(String alias) {
    return $LockInAttemptsTable(attachedDatabase, alias);
  }
}

class LockInAttempt extends DataClass implements Insertable<LockInAttempt> {
  final int id;
  final String appIdentifier;
  final String appName;
  final String? ruleId;
  final DateTime occurredAt;
  const LockInAttempt({
    required this.id,
    required this.appIdentifier,
    required this.appName,
    this.ruleId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['app_identifier'] = Variable<String>(appIdentifier);
    map['app_name'] = Variable<String>(appName);
    if (!nullToAbsent || ruleId != null) {
      map['rule_id'] = Variable<String>(ruleId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  LockInAttemptsCompanion toCompanion(bool nullToAbsent) {
    return LockInAttemptsCompanion(
      id: Value(id),
      appIdentifier: Value(appIdentifier),
      appName: Value(appName),
      ruleId: ruleId == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleId),
      occurredAt: Value(occurredAt),
    );
  }

  factory LockInAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LockInAttempt(
      id: serializer.fromJson<int>(json['id']),
      appIdentifier: serializer.fromJson<String>(json['appIdentifier']),
      appName: serializer.fromJson<String>(json['appName']),
      ruleId: serializer.fromJson<String?>(json['ruleId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'appIdentifier': serializer.toJson<String>(appIdentifier),
      'appName': serializer.toJson<String>(appName),
      'ruleId': serializer.toJson<String?>(ruleId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  LockInAttempt copyWith({
    int? id,
    String? appIdentifier,
    String? appName,
    Value<String?> ruleId = const Value.absent(),
    DateTime? occurredAt,
  }) => LockInAttempt(
    id: id ?? this.id,
    appIdentifier: appIdentifier ?? this.appIdentifier,
    appName: appName ?? this.appName,
    ruleId: ruleId.present ? ruleId.value : this.ruleId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  LockInAttempt copyWithCompanion(LockInAttemptsCompanion data) {
    return LockInAttempt(
      id: data.id.present ? data.id.value : this.id,
      appIdentifier: data.appIdentifier.present
          ? data.appIdentifier.value
          : this.appIdentifier,
      appName: data.appName.present ? data.appName.value : this.appName,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LockInAttempt(')
          ..write('id: $id, ')
          ..write('appIdentifier: $appIdentifier, ')
          ..write('appName: $appName, ')
          ..write('ruleId: $ruleId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, appIdentifier, appName, ruleId, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LockInAttempt &&
          other.id == this.id &&
          other.appIdentifier == this.appIdentifier &&
          other.appName == this.appName &&
          other.ruleId == this.ruleId &&
          other.occurredAt == this.occurredAt);
}

class LockInAttemptsCompanion extends UpdateCompanion<LockInAttempt> {
  final Value<int> id;
  final Value<String> appIdentifier;
  final Value<String> appName;
  final Value<String?> ruleId;
  final Value<DateTime> occurredAt;
  const LockInAttemptsCompanion({
    this.id = const Value.absent(),
    this.appIdentifier = const Value.absent(),
    this.appName = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.occurredAt = const Value.absent(),
  });
  LockInAttemptsCompanion.insert({
    this.id = const Value.absent(),
    required String appIdentifier,
    required String appName,
    this.ruleId = const Value.absent(),
    required DateTime occurredAt,
  }) : appIdentifier = Value(appIdentifier),
       appName = Value(appName),
       occurredAt = Value(occurredAt);
  static Insertable<LockInAttempt> custom({
    Expression<int>? id,
    Expression<String>? appIdentifier,
    Expression<String>? appName,
    Expression<String>? ruleId,
    Expression<DateTime>? occurredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appIdentifier != null) 'app_identifier': appIdentifier,
      if (appName != null) 'app_name': appName,
      if (ruleId != null) 'rule_id': ruleId,
      if (occurredAt != null) 'occurred_at': occurredAt,
    });
  }

  LockInAttemptsCompanion copyWith({
    Value<int>? id,
    Value<String>? appIdentifier,
    Value<String>? appName,
    Value<String?>? ruleId,
    Value<DateTime>? occurredAt,
  }) {
    return LockInAttemptsCompanion(
      id: id ?? this.id,
      appIdentifier: appIdentifier ?? this.appIdentifier,
      appName: appName ?? this.appName,
      ruleId: ruleId ?? this.ruleId,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appIdentifier.present) {
      map['app_identifier'] = Variable<String>(appIdentifier.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LockInAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('appIdentifier: $appIdentifier, ')
          ..write('appName: $appName, ')
          ..write('ruleId: $ruleId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncErrorMeta = const VerificationMeta(
    'lastSyncError',
  );
  @override
  late final GeneratedColumn<String> lastSyncError = GeneratedColumn<String>(
    'last_sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _institutionIdMeta = const VerificationMeta(
    'institutionId',
  );
  @override
  late final GeneratedColumn<int> institutionId = GeneratedColumn<int>(
    'institution_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termLabelMeta = const VerificationMeta(
    'termLabel',
  );
  @override
  late final GeneratedColumn<String> termLabel = GeneratedColumn<String>(
    'term_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _academicYearMeta = const VerificationMeta(
    'academicYear',
  );
  @override
  late final GeneratedColumn<String> academicYear = GeneratedColumn<String>(
    'academic_year',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termStartDateMeta = const VerificationMeta(
    'termStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> termStartDate =
      GeneratedColumn<DateTime>(
        'term_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _termEndDateMeta = const VerificationMeta(
    'termEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> termEndDate = GeneratedColumn<DateTime>(
    'term_end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousCourseIdMeta = const VerificationMeta(
    'previousCourseId',
  );
  @override
  late final GeneratedColumn<String> previousCourseId = GeneratedColumn<String>(
    'previous_course_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
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
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    idempotencyKey,
    syncStatus,
    lastSyncError,
    institutionId,
    title,
    code,
    color,
    termLabel,
    academicYear,
    termStartDate,
    termEndDate,
    previousCourseId,
    archivedAt,
    createdAt,
    updatedAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Course> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_sync_error')) {
      context.handle(
        _lastSyncErrorMeta,
        lastSyncError.isAcceptableOrUnknown(
          data['last_sync_error']!,
          _lastSyncErrorMeta,
        ),
      );
    }
    if (data.containsKey('institution_id')) {
      context.handle(
        _institutionIdMeta,
        institutionId.isAcceptableOrUnknown(
          data['institution_id']!,
          _institutionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('term_label')) {
      context.handle(
        _termLabelMeta,
        termLabel.isAcceptableOrUnknown(data['term_label']!, _termLabelMeta),
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
    if (data.containsKey('term_start_date')) {
      context.handle(
        _termStartDateMeta,
        termStartDate.isAcceptableOrUnknown(
          data['term_start_date']!,
          _termStartDateMeta,
        ),
      );
    }
    if (data.containsKey('term_end_date')) {
      context.handle(
        _termEndDateMeta,
        termEndDate.isAcceptableOrUnknown(
          data['term_end_date']!,
          _termEndDateMeta,
        ),
      );
    }
    if (data.containsKey('previous_course_id')) {
      context.handle(
        _previousCourseIdMeta,
        previousCourseId.isAcceptableOrUnknown(
          data['previous_course_id']!,
          _previousCourseIdMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
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
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sync_error'],
      ),
      institutionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institution_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      termLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term_label'],
      ),
      academicYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_year'],
      ),
      termStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}term_start_date'],
      ),
      termEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}term_end_date'],
      ),
      previousCourseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_course_id'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final String id;
  final String? serverId;
  final String idempotencyKey;
  final String syncStatus;
  final String? lastSyncError;
  final int institutionId;
  final String title;
  final String? code;
  final String? color;
  final String? termLabel;
  final String? academicYear;
  final DateTime? termStartDate;
  final DateTime? termEndDate;
  final String? previousCourseId;
  final DateTime? archivedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime cachedAt;
  const Course({
    required this.id,
    this.serverId,
    required this.idempotencyKey,
    required this.syncStatus,
    this.lastSyncError,
    required this.institutionId,
    required this.title,
    this.code,
    this.color,
    this.termLabel,
    this.academicYear,
    this.termStartDate,
    this.termEndDate,
    this.previousCourseId,
    this.archivedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncError != null) {
      map['last_sync_error'] = Variable<String>(lastSyncError);
    }
    map['institution_id'] = Variable<int>(institutionId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || termLabel != null) {
      map['term_label'] = Variable<String>(termLabel);
    }
    if (!nullToAbsent || academicYear != null) {
      map['academic_year'] = Variable<String>(academicYear);
    }
    if (!nullToAbsent || termStartDate != null) {
      map['term_start_date'] = Variable<DateTime>(termStartDate);
    }
    if (!nullToAbsent || termEndDate != null) {
      map['term_end_date'] = Variable<DateTime>(termEndDate);
    }
    if (!nullToAbsent || previousCourseId != null) {
      map['previous_course_id'] = Variable<String>(previousCourseId);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      idempotencyKey: Value(idempotencyKey),
      syncStatus: Value(syncStatus),
      lastSyncError: lastSyncError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncError),
      institutionId: Value(institutionId),
      title: Value(title),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      termLabel: termLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(termLabel),
      academicYear: academicYear == null && nullToAbsent
          ? const Value.absent()
          : Value(academicYear),
      termStartDate: termStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(termStartDate),
      termEndDate: termEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(termEndDate),
      previousCourseId: previousCourseId == null && nullToAbsent
          ? const Value.absent()
          : Value(previousCourseId),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory Course.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncError: serializer.fromJson<String?>(json['lastSyncError']),
      institutionId: serializer.fromJson<int>(json['institutionId']),
      title: serializer.fromJson<String>(json['title']),
      code: serializer.fromJson<String?>(json['code']),
      color: serializer.fromJson<String?>(json['color']),
      termLabel: serializer.fromJson<String?>(json['termLabel']),
      academicYear: serializer.fromJson<String?>(json['academicYear']),
      termStartDate: serializer.fromJson<DateTime?>(json['termStartDate']),
      termEndDate: serializer.fromJson<DateTime?>(json['termEndDate']),
      previousCourseId: serializer.fromJson<String?>(json['previousCourseId']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncError': serializer.toJson<String?>(lastSyncError),
      'institutionId': serializer.toJson<int>(institutionId),
      'title': serializer.toJson<String>(title),
      'code': serializer.toJson<String?>(code),
      'color': serializer.toJson<String?>(color),
      'termLabel': serializer.toJson<String?>(termLabel),
      'academicYear': serializer.toJson<String?>(academicYear),
      'termStartDate': serializer.toJson<DateTime?>(termStartDate),
      'termEndDate': serializer.toJson<DateTime?>(termEndDate),
      'previousCourseId': serializer.toJson<String?>(previousCourseId),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Course copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    String? idempotencyKey,
    String? syncStatus,
    Value<String?> lastSyncError = const Value.absent(),
    int? institutionId,
    String? title,
    Value<String?> code = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> termLabel = const Value.absent(),
    Value<String?> academicYear = const Value.absent(),
    Value<DateTime?> termStartDate = const Value.absent(),
    Value<DateTime?> termEndDate = const Value.absent(),
    Value<String?> previousCourseId = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cachedAt,
  }) => Course(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncError: lastSyncError.present
        ? lastSyncError.value
        : this.lastSyncError,
    institutionId: institutionId ?? this.institutionId,
    title: title ?? this.title,
    code: code.present ? code.value : this.code,
    color: color.present ? color.value : this.color,
    termLabel: termLabel.present ? termLabel.value : this.termLabel,
    academicYear: academicYear.present ? academicYear.value : this.academicYear,
    termStartDate: termStartDate.present
        ? termStartDate.value
        : this.termStartDate,
    termEndDate: termEndDate.present ? termEndDate.value : this.termEndDate,
    previousCourseId: previousCourseId.present
        ? previousCourseId.value
        : this.previousCourseId,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  Course copyWithCompanion(CoursesCompanion data) {
    return Course(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncError: data.lastSyncError.present
          ? data.lastSyncError.value
          : this.lastSyncError,
      institutionId: data.institutionId.present
          ? data.institutionId.value
          : this.institutionId,
      title: data.title.present ? data.title.value : this.title,
      code: data.code.present ? data.code.value : this.code,
      color: data.color.present ? data.color.value : this.color,
      termLabel: data.termLabel.present ? data.termLabel.value : this.termLabel,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      termStartDate: data.termStartDate.present
          ? data.termStartDate.value
          : this.termStartDate,
      termEndDate: data.termEndDate.present
          ? data.termEndDate.value
          : this.termEndDate,
      previousCourseId: data.previousCourseId.present
          ? data.previousCourseId.value
          : this.previousCourseId,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('institutionId: $institutionId, ')
          ..write('title: $title, ')
          ..write('code: $code, ')
          ..write('color: $color, ')
          ..write('termLabel: $termLabel, ')
          ..write('academicYear: $academicYear, ')
          ..write('termStartDate: $termStartDate, ')
          ..write('termEndDate: $termEndDate, ')
          ..write('previousCourseId: $previousCourseId, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    idempotencyKey,
    syncStatus,
    lastSyncError,
    institutionId,
    title,
    code,
    color,
    termLabel,
    academicYear,
    termStartDate,
    termEndDate,
    previousCourseId,
    archivedAt,
    createdAt,
    updatedAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.idempotencyKey == this.idempotencyKey &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncError == this.lastSyncError &&
          other.institutionId == this.institutionId &&
          other.title == this.title &&
          other.code == this.code &&
          other.color == this.color &&
          other.termLabel == this.termLabel &&
          other.academicYear == this.academicYear &&
          other.termStartDate == this.termStartDate &&
          other.termEndDate == this.termEndDate &&
          other.previousCourseId == this.previousCourseId &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String> idempotencyKey;
  final Value<String> syncStatus;
  final Value<String?> lastSyncError;
  final Value<int> institutionId;
  final Value<String> title;
  final Value<String?> code;
  final Value<String?> color;
  final Value<String?> termLabel;
  final Value<String?> academicYear;
  final Value<DateTime?> termStartDate;
  final Value<DateTime?> termEndDate;
  final Value<String?> previousCourseId;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    this.institutionId = const Value.absent(),
    this.title = const Value.absent(),
    this.code = const Value.absent(),
    this.color = const Value.absent(),
    this.termLabel = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.termStartDate = const Value.absent(),
    this.termEndDate = const Value.absent(),
    this.previousCourseId = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursesCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    required int institutionId,
    required String title,
    this.code = const Value.absent(),
    this.color = const Value.absent(),
    this.termLabel = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.termStartDate = const Value.absent(),
    this.termEndDate = const Value.absent(),
    this.previousCourseId = const Value.absent(),
    this.archivedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       institutionId = Value(institutionId),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       cachedAt = Value(cachedAt);
  static Insertable<Course> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? idempotencyKey,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncError,
    Expression<int>? institutionId,
    Expression<String>? title,
    Expression<String>? code,
    Expression<String>? color,
    Expression<String>? termLabel,
    Expression<String>? academicYear,
    Expression<DateTime>? termStartDate,
    Expression<DateTime>? termEndDate,
    Expression<String>? previousCourseId,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncError != null) 'last_sync_error': lastSyncError,
      if (institutionId != null) 'institution_id': institutionId,
      if (title != null) 'title': title,
      if (code != null) 'code': code,
      if (color != null) 'color': color,
      if (termLabel != null) 'term_label': termLabel,
      if (academicYear != null) 'academic_year': academicYear,
      if (termStartDate != null) 'term_start_date': termStartDate,
      if (termEndDate != null) 'term_end_date': termEndDate,
      if (previousCourseId != null) 'previous_course_id': previousCourseId,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursesCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String>? idempotencyKey,
    Value<String>? syncStatus,
    Value<String?>? lastSyncError,
    Value<int>? institutionId,
    Value<String>? title,
    Value<String?>? code,
    Value<String?>? color,
    Value<String?>? termLabel,
    Value<String?>? academicYear,
    Value<DateTime?>? termStartDate,
    Value<DateTime?>? termEndDate,
    Value<String?>? previousCourseId,
    Value<DateTime?>? archivedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CoursesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncError: lastSyncError ?? this.lastSyncError,
      institutionId: institutionId ?? this.institutionId,
      title: title ?? this.title,
      code: code ?? this.code,
      color: color ?? this.color,
      termLabel: termLabel ?? this.termLabel,
      academicYear: academicYear ?? this.academicYear,
      termStartDate: termStartDate ?? this.termStartDate,
      termEndDate: termEndDate ?? this.termEndDate,
      previousCourseId: previousCourseId ?? this.previousCourseId,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncError.present) {
      map['last_sync_error'] = Variable<String>(lastSyncError.value);
    }
    if (institutionId.present) {
      map['institution_id'] = Variable<int>(institutionId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (termLabel.present) {
      map['term_label'] = Variable<String>(termLabel.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<String>(academicYear.value);
    }
    if (termStartDate.present) {
      map['term_start_date'] = Variable<DateTime>(termStartDate.value);
    }
    if (termEndDate.present) {
      map['term_end_date'] = Variable<DateTime>(termEndDate.value);
    }
    if (previousCourseId.present) {
      map['previous_course_id'] = Variable<String>(previousCourseId.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('institutionId: $institutionId, ')
          ..write('title: $title, ')
          ..write('code: $code, ')
          ..write('color: $color, ')
          ..write('termLabel: $termLabel, ')
          ..write('academicYear: $academicYear, ')
          ..write('termStartDate: $termStartDate, ')
          ..write('termEndDate: $termEndDate, ')
          ..write('previousCourseId: $previousCourseId, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LecturersTable extends Lecturers
    with TableInfo<$LecturersTable, Lecturer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LecturersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentCourseIdMeta = const VerificationMeta(
    'studentCourseId',
  );
  @override
  late final GeneratedColumn<String> studentCourseId = GeneratedColumn<String>(
    'student_course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id)',
    ),
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
  static const VerificationMeta _officeMeta = const VerificationMeta('office');
  @override
  late final GeneratedColumn<String> office = GeneratedColumn<String>(
    'office',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentCourseId,
    name,
    email,
    phone,
    office,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lecturers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Lecturer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('student_course_id')) {
      context.handle(
        _studentCourseIdMeta,
        studentCourseId.isAcceptableOrUnknown(
          data['student_course_id']!,
          _studentCourseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studentCourseIdMeta);
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
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('office')) {
      context.handle(
        _officeMeta,
        office.isAcceptableOrUnknown(data['office']!, _officeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lecturer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lecturer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studentCourseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_course_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      office: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}office'],
      ),
    );
  }

  @override
  $LecturersTable createAlias(String alias) {
    return $LecturersTable(attachedDatabase, alias);
  }
}

class Lecturer extends DataClass implements Insertable<Lecturer> {
  final String id;
  final String studentCourseId;
  final String name;
  final String? email;
  final String? phone;
  final String? office;
  const Lecturer({
    required this.id,
    required this.studentCourseId,
    required this.name,
    this.email,
    this.phone,
    this.office,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['student_course_id'] = Variable<String>(studentCourseId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || office != null) {
      map['office'] = Variable<String>(office);
    }
    return map;
  }

  LecturersCompanion toCompanion(bool nullToAbsent) {
    return LecturersCompanion(
      id: Value(id),
      studentCourseId: Value(studentCourseId),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      office: office == null && nullToAbsent
          ? const Value.absent()
          : Value(office),
    );
  }

  factory Lecturer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lecturer(
      id: serializer.fromJson<String>(json['id']),
      studentCourseId: serializer.fromJson<String>(json['studentCourseId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      office: serializer.fromJson<String?>(json['office']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studentCourseId': serializer.toJson<String>(studentCourseId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'office': serializer.toJson<String?>(office),
    };
  }

  Lecturer copyWith({
    String? id,
    String? studentCourseId,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> office = const Value.absent(),
  }) => Lecturer(
    id: id ?? this.id,
    studentCourseId: studentCourseId ?? this.studentCourseId,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    office: office.present ? office.value : this.office,
  );
  Lecturer copyWithCompanion(LecturersCompanion data) {
    return Lecturer(
      id: data.id.present ? data.id.value : this.id,
      studentCourseId: data.studentCourseId.present
          ? data.studentCourseId.value
          : this.studentCourseId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      office: data.office.present ? data.office.value : this.office,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lecturer(')
          ..write('id: $id, ')
          ..write('studentCourseId: $studentCourseId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('office: $office')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, studentCourseId, name, email, phone, office);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lecturer &&
          other.id == this.id &&
          other.studentCourseId == this.studentCourseId &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.office == this.office);
}

class LecturersCompanion extends UpdateCompanion<Lecturer> {
  final Value<String> id;
  final Value<String> studentCourseId;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> office;
  final Value<int> rowid;
  const LecturersCompanion({
    this.id = const Value.absent(),
    this.studentCourseId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.office = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LecturersCompanion.insert({
    required String id,
    required String studentCourseId,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.office = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studentCourseId = Value(studentCourseId),
       name = Value(name);
  static Insertable<Lecturer> custom({
    Expression<String>? id,
    Expression<String>? studentCourseId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? office,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentCourseId != null) 'student_course_id': studentCourseId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (office != null) 'office': office,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LecturersCompanion copyWith({
    Value<String>? id,
    Value<String>? studentCourseId,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? office,
    Value<int>? rowid,
  }) {
    return LecturersCompanion(
      id: id ?? this.id,
      studentCourseId: studentCourseId ?? this.studentCourseId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      office: office ?? this.office,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studentCourseId.present) {
      map['student_course_id'] = Variable<String>(studentCourseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (office.present) {
      map['office'] = Variable<String>(office.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LecturersCompanion(')
          ..write('id: $id, ')
          ..write('studentCourseId: $studentCourseId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('office: $office, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleEntriesTable extends ScheduleEntries
    with TableInfo<$ScheduleEntriesTable, ScheduleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncErrorMeta = const VerificationMeta(
    'lastSyncError',
  );
  @override
  late final GeneratedColumn<String> lastSyncError = GeneratedColumn<String>(
    'last_sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studentCourseIdMeta = const VerificationMeta(
    'studentCourseId',
  );
  @override
  late final GeneratedColumn<String> studentCourseId = GeneratedColumn<String>(
    'student_course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<String> dayOfWeek = GeneratedColumn<String>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
    'venue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _sectionMeta = const VerificationMeta(
    'section',
  );
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
    'section',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _specificDateMeta = const VerificationMeta(
    'specificDate',
  );
  @override
  late final GeneratedColumn<DateTime> specificDate = GeneratedColumn<DateTime>(
    'specific_date',
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
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    idempotencyKey,
    syncStatus,
    lastSyncError,
    studentCourseId,
    dayOfWeek,
    startTime,
    endTime,
    venue,
    campus,
    section,
    label,
    color,
    isRecurring,
    specificDate,
    createdAt,
    updatedAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_sync_error')) {
      context.handle(
        _lastSyncErrorMeta,
        lastSyncError.isAcceptableOrUnknown(
          data['last_sync_error']!,
          _lastSyncErrorMeta,
        ),
      );
    }
    if (data.containsKey('student_course_id')) {
      context.handle(
        _studentCourseIdMeta,
        studentCourseId.isAcceptableOrUnknown(
          data['student_course_id']!,
          _studentCourseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studentCourseIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
        _venueMeta,
        venue.isAcceptableOrUnknown(data['venue']!, _venueMeta),
      );
    }
    if (data.containsKey('campus')) {
      context.handle(
        _campusMeta,
        campus.isAcceptableOrUnknown(data['campus']!, _campusMeta),
      );
    }
    if (data.containsKey('section')) {
      context.handle(
        _sectionMeta,
        section.isAcceptableOrUnknown(data['section']!, _sectionMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    if (data.containsKey('specific_date')) {
      context.handle(
        _specificDateMeta,
        specificDate.isAcceptableOrUnknown(
          data['specific_date']!,
          _specificDateMeta,
        ),
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
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sync_error'],
      ),
      studentCourseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_course_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_of_week'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      )!,
      venue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue'],
      ),
      campus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campus'],
      ),
      section: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring'],
      )!,
      specificDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}specific_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $ScheduleEntriesTable createAlias(String alias) {
    return $ScheduleEntriesTable(attachedDatabase, alias);
  }
}

class ScheduleEntry extends DataClass implements Insertable<ScheduleEntry> {
  final String id;
  final String? serverId;
  final String idempotencyKey;
  final String syncStatus;
  final String? lastSyncError;
  final String studentCourseId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String? venue;
  final String? campus;
  final String? section;
  final String? label;
  final String? color;
  final bool isRecurring;
  final DateTime? specificDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime cachedAt;
  const ScheduleEntry({
    required this.id,
    this.serverId,
    required this.idempotencyKey,
    required this.syncStatus,
    this.lastSyncError,
    required this.studentCourseId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.venue,
    this.campus,
    this.section,
    this.label,
    this.color,
    required this.isRecurring,
    this.specificDate,
    required this.createdAt,
    required this.updatedAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncError != null) {
      map['last_sync_error'] = Variable<String>(lastSyncError);
    }
    map['student_course_id'] = Variable<String>(studentCourseId);
    map['day_of_week'] = Variable<String>(dayOfWeek);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    if (!nullToAbsent || venue != null) {
      map['venue'] = Variable<String>(venue);
    }
    if (!nullToAbsent || campus != null) {
      map['campus'] = Variable<String>(campus);
    }
    if (!nullToAbsent || section != null) {
      map['section'] = Variable<String>(section);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || specificDate != null) {
      map['specific_date'] = Variable<DateTime>(specificDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  ScheduleEntriesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleEntriesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      idempotencyKey: Value(idempotencyKey),
      syncStatus: Value(syncStatus),
      lastSyncError: lastSyncError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncError),
      studentCourseId: Value(studentCourseId),
      dayOfWeek: Value(dayOfWeek),
      startTime: Value(startTime),
      endTime: Value(endTime),
      venue: venue == null && nullToAbsent
          ? const Value.absent()
          : Value(venue),
      campus: campus == null && nullToAbsent
          ? const Value.absent()
          : Value(campus),
      section: section == null && nullToAbsent
          ? const Value.absent()
          : Value(section),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      isRecurring: Value(isRecurring),
      specificDate: specificDate == null && nullToAbsent
          ? const Value.absent()
          : Value(specificDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory ScheduleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleEntry(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncError: serializer.fromJson<String?>(json['lastSyncError']),
      studentCourseId: serializer.fromJson<String>(json['studentCourseId']),
      dayOfWeek: serializer.fromJson<String>(json['dayOfWeek']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      venue: serializer.fromJson<String?>(json['venue']),
      campus: serializer.fromJson<String?>(json['campus']),
      section: serializer.fromJson<String?>(json['section']),
      label: serializer.fromJson<String?>(json['label']),
      color: serializer.fromJson<String?>(json['color']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      specificDate: serializer.fromJson<DateTime?>(json['specificDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncError': serializer.toJson<String?>(lastSyncError),
      'studentCourseId': serializer.toJson<String>(studentCourseId),
      'dayOfWeek': serializer.toJson<String>(dayOfWeek),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'venue': serializer.toJson<String?>(venue),
      'campus': serializer.toJson<String?>(campus),
      'section': serializer.toJson<String?>(section),
      'label': serializer.toJson<String?>(label),
      'color': serializer.toJson<String?>(color),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'specificDate': serializer.toJson<DateTime?>(specificDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  ScheduleEntry copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    String? idempotencyKey,
    String? syncStatus,
    Value<String?> lastSyncError = const Value.absent(),
    String? studentCourseId,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    Value<String?> venue = const Value.absent(),
    Value<String?> campus = const Value.absent(),
    Value<String?> section = const Value.absent(),
    Value<String?> label = const Value.absent(),
    Value<String?> color = const Value.absent(),
    bool? isRecurring,
    Value<DateTime?> specificDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cachedAt,
  }) => ScheduleEntry(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncError: lastSyncError.present
        ? lastSyncError.value
        : this.lastSyncError,
    studentCourseId: studentCourseId ?? this.studentCourseId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    venue: venue.present ? venue.value : this.venue,
    campus: campus.present ? campus.value : this.campus,
    section: section.present ? section.value : this.section,
    label: label.present ? label.value : this.label,
    color: color.present ? color.value : this.color,
    isRecurring: isRecurring ?? this.isRecurring,
    specificDate: specificDate.present ? specificDate.value : this.specificDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  ScheduleEntry copyWithCompanion(ScheduleEntriesCompanion data) {
    return ScheduleEntry(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncError: data.lastSyncError.present
          ? data.lastSyncError.value
          : this.lastSyncError,
      studentCourseId: data.studentCourseId.present
          ? data.studentCourseId.value
          : this.studentCourseId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      venue: data.venue.present ? data.venue.value : this.venue,
      campus: data.campus.present ? data.campus.value : this.campus,
      section: data.section.present ? data.section.value : this.section,
      label: data.label.present ? data.label.value : this.label,
      color: data.color.present ? data.color.value : this.color,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
      specificDate: data.specificDate.present
          ? data.specificDate.value
          : this.specificDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleEntry(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('studentCourseId: $studentCourseId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('venue: $venue, ')
          ..write('campus: $campus, ')
          ..write('section: $section, ')
          ..write('label: $label, ')
          ..write('color: $color, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('specificDate: $specificDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    idempotencyKey,
    syncStatus,
    lastSyncError,
    studentCourseId,
    dayOfWeek,
    startTime,
    endTime,
    venue,
    campus,
    section,
    label,
    color,
    isRecurring,
    specificDate,
    createdAt,
    updatedAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleEntry &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.idempotencyKey == this.idempotencyKey &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncError == this.lastSyncError &&
          other.studentCourseId == this.studentCourseId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.venue == this.venue &&
          other.campus == this.campus &&
          other.section == this.section &&
          other.label == this.label &&
          other.color == this.color &&
          other.isRecurring == this.isRecurring &&
          other.specificDate == this.specificDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt);
}

class ScheduleEntriesCompanion extends UpdateCompanion<ScheduleEntry> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String> idempotencyKey;
  final Value<String> syncStatus;
  final Value<String?> lastSyncError;
  final Value<String> studentCourseId;
  final Value<String> dayOfWeek;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String?> venue;
  final Value<String?> campus;
  final Value<String?> section;
  final Value<String?> label;
  final Value<String?> color;
  final Value<bool> isRecurring;
  final Value<DateTime?> specificDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const ScheduleEntriesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    this.studentCourseId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.venue = const Value.absent(),
    this.campus = const Value.absent(),
    this.section = const Value.absent(),
    this.label = const Value.absent(),
    this.color = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.specificDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleEntriesCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    required String studentCourseId,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    this.venue = const Value.absent(),
    this.campus = const Value.absent(),
    this.section = const Value.absent(),
    this.label = const Value.absent(),
    this.color = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.specificDate = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studentCourseId = Value(studentCourseId),
       dayOfWeek = Value(dayOfWeek),
       startTime = Value(startTime),
       endTime = Value(endTime),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       cachedAt = Value(cachedAt);
  static Insertable<ScheduleEntry> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? idempotencyKey,
    Expression<String>? syncStatus,
    Expression<String>? lastSyncError,
    Expression<String>? studentCourseId,
    Expression<String>? dayOfWeek,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? venue,
    Expression<String>? campus,
    Expression<String>? section,
    Expression<String>? label,
    Expression<String>? color,
    Expression<bool>? isRecurring,
    Expression<DateTime>? specificDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncError != null) 'last_sync_error': lastSyncError,
      if (studentCourseId != null) 'student_course_id': studentCourseId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (venue != null) 'venue': venue,
      if (campus != null) 'campus': campus,
      if (section != null) 'section': section,
      if (label != null) 'label': label,
      if (color != null) 'color': color,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (specificDate != null) 'specific_date': specificDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleEntriesCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String>? idempotencyKey,
    Value<String>? syncStatus,
    Value<String?>? lastSyncError,
    Value<String>? studentCourseId,
    Value<String>? dayOfWeek,
    Value<String>? startTime,
    Value<String>? endTime,
    Value<String?>? venue,
    Value<String?>? campus,
    Value<String?>? section,
    Value<String?>? label,
    Value<String?>? color,
    Value<bool>? isRecurring,
    Value<DateTime?>? specificDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return ScheduleEntriesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncError: lastSyncError ?? this.lastSyncError,
      studentCourseId: studentCourseId ?? this.studentCourseId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      venue: venue ?? this.venue,
      campus: campus ?? this.campus,
      section: section ?? this.section,
      label: label ?? this.label,
      color: color ?? this.color,
      isRecurring: isRecurring ?? this.isRecurring,
      specificDate: specificDate ?? this.specificDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncError.present) {
      map['last_sync_error'] = Variable<String>(lastSyncError.value);
    }
    if (studentCourseId.present) {
      map['student_course_id'] = Variable<String>(studentCourseId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<String>(dayOfWeek.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (specificDate.present) {
      map['specific_date'] = Variable<DateTime>(specificDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('studentCourseId: $studentCourseId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('venue: $venue, ')
          ..write('campus: $campus, ')
          ..write('section: $section, ')
          ..write('label: $label, ')
          ..write('color: $color, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('specificDate: $specificDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TodoListsTable extends TodoLists
    with TableInfo<$TodoListsTable, TodoList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _taskCountMeta = const VerificationMeta(
    'taskCount',
  );
  @override
  late final GeneratedColumn<int> taskCount = GeneratedColumn<int>(
    'task_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPendingDeletionMeta = const VerificationMeta(
    'isPendingDeletion',
  );
  @override
  late final GeneratedColumn<bool> isPendingDeletion = GeneratedColumn<bool>(
    'is_pending_deletion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pending_deletion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    id,
    title,
    color,
    isDefault,
    syncStatus,
    taskCount,
    lastSyncedAt,
    createdAt,
    updatedAt,
    isPendingDeletion,
    isDirty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_lists';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoList> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('task_count')) {
      context.handle(
        _taskCountMeta,
        taskCount.isAcceptableOrUnknown(data['task_count']!, _taskCountMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
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
    if (data.containsKey('is_pending_deletion')) {
      context.handle(
        _isPendingDeletionMeta,
        isPendingDeletion.isAcceptableOrUnknown(
          data['is_pending_deletion']!,
          _isPendingDeletionMeta,
        ),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  TodoList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoList(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      taskCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_count'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isPendingDeletion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pending_deletion'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
    );
  }

  @override
  $TodoListsTable createAlias(String alias) {
    return $TodoListsTable(attachedDatabase, alias);
  }
}

class TodoList extends DataClass implements Insertable<TodoList> {
  final int localId;
  final String? id;
  final String title;
  final int? color;
  final bool isDefault;
  final String syncStatus;
  final int taskCount;
  final DateTime? lastSyncedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPendingDeletion;
  final bool isDirty;
  const TodoList({
    required this.localId,
    this.id,
    required this.title,
    this.color,
    required this.isDefault,
    required this.syncStatus,
    required this.taskCount,
    this.lastSyncedAt,
    this.createdAt,
    this.updatedAt,
    required this.isPendingDeletion,
    required this.isDirty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['sync_status'] = Variable<String>(syncStatus);
    map['task_count'] = Variable<int>(taskCount);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_pending_deletion'] = Variable<bool>(isPendingDeletion);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  TodoListsCompanion toCompanion(bool nullToAbsent) {
    return TodoListsCompanion(
      localId: Value(localId),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      isDefault: Value(isDefault),
      syncStatus: Value(syncStatus),
      taskCount: Value(taskCount),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isPendingDeletion: Value(isPendingDeletion),
      isDirty: Value(isDirty),
    );
  }

  factory TodoList.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoList(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<String?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<int?>(json['color']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      taskCount: serializer.fromJson<int>(json['taskCount']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isPendingDeletion: serializer.fromJson<bool>(json['isPendingDeletion']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<String?>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<int?>(color),
      'isDefault': serializer.toJson<bool>(isDefault),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'taskCount': serializer.toJson<int>(taskCount),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isPendingDeletion': serializer.toJson<bool>(isPendingDeletion),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  TodoList copyWith({
    int? localId,
    Value<String?> id = const Value.absent(),
    String? title,
    Value<int?> color = const Value.absent(),
    bool? isDefault,
    String? syncStatus,
    int? taskCount,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isPendingDeletion,
    bool? isDirty,
  }) => TodoList(
    localId: localId ?? this.localId,
    id: id.present ? id.value : this.id,
    title: title ?? this.title,
    color: color.present ? color.value : this.color,
    isDefault: isDefault ?? this.isDefault,
    syncStatus: syncStatus ?? this.syncStatus,
    taskCount: taskCount ?? this.taskCount,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isPendingDeletion: isPendingDeletion ?? this.isPendingDeletion,
    isDirty: isDirty ?? this.isDirty,
  );
  TodoList copyWithCompanion(TodoListsCompanion data) {
    return TodoList(
      localId: data.localId.present ? data.localId.value : this.localId,
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      color: data.color.present ? data.color.value : this.color,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      taskCount: data.taskCount.present ? data.taskCount.value : this.taskCount,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isPendingDeletion: data.isPendingDeletion.present
          ? data.isPendingDeletion.value
          : this.isPendingDeletion,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoList(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('isDefault: $isDefault, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('taskCount: $taskCount, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPendingDeletion: $isPendingDeletion, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    id,
    title,
    color,
    isDefault,
    syncStatus,
    taskCount,
    lastSyncedAt,
    createdAt,
    updatedAt,
    isPendingDeletion,
    isDirty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoList &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.isDefault == this.isDefault &&
          other.syncStatus == this.syncStatus &&
          other.taskCount == this.taskCount &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isPendingDeletion == this.isPendingDeletion &&
          other.isDirty == this.isDirty);
}

class TodoListsCompanion extends UpdateCompanion<TodoList> {
  final Value<int> localId;
  final Value<String?> id;
  final Value<String> title;
  final Value<int?> color;
  final Value<bool> isDefault;
  final Value<String> syncStatus;
  final Value<int> taskCount;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isPendingDeletion;
  final Value<bool> isDirty;
  const TodoListsCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.taskCount = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPendingDeletion = const Value.absent(),
    this.isDirty = const Value.absent(),
  });
  TodoListsCompanion.insert({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    required String title,
    this.color = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.taskCount = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPendingDeletion = const Value.absent(),
    this.isDirty = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TodoList> custom({
    Expression<int>? localId,
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? color,
    Expression<bool>? isDefault,
    Expression<String>? syncStatus,
    Expression<int>? taskCount,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isPendingDeletion,
    Expression<bool>? isDirty,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (isDefault != null) 'is_default': isDefault,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (taskCount != null) 'task_count': taskCount,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isPendingDeletion != null) 'is_pending_deletion': isPendingDeletion,
      if (isDirty != null) 'is_dirty': isDirty,
    });
  }

  TodoListsCompanion copyWith({
    Value<int>? localId,
    Value<String?>? id,
    Value<String>? title,
    Value<int?>? color,
    Value<bool>? isDefault,
    Value<String>? syncStatus,
    Value<int>? taskCount,
    Value<DateTime?>? lastSyncedAt,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<bool>? isPendingDeletion,
    Value<bool>? isDirty,
  }) {
    return TodoListsCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      syncStatus: syncStatus ?? this.syncStatus,
      taskCount: taskCount ?? this.taskCount,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPendingDeletion: isPendingDeletion ?? this.isPendingDeletion,
      isDirty: isDirty ?? this.isDirty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (taskCount.present) {
      map['task_count'] = Variable<int>(taskCount.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isPendingDeletion.present) {
      map['is_pending_deletion'] = Variable<bool>(isPendingDeletion.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoListsCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('isDefault: $isDefault, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('taskCount: $taskCount, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPendingDeletion: $isPendingDeletion, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }
}

class $TodoTagItemsTable extends TodoTagItems
    with TableInfo<$TodoTagItemsTable, TodoTagItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTagItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPendingDeletionMeta = const VerificationMeta(
    'isPendingDeletion',
  );
  @override
  late final GeneratedColumn<bool> isPendingDeletion = GeneratedColumn<bool>(
    'is_pending_deletion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pending_deletion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    id,
    name,
    color,
    syncStatus,
    createdAt,
    isPendingDeletion,
    isDirty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_tag_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoTagItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_pending_deletion')) {
      context.handle(
        _isPendingDeletionMeta,
        isPendingDeletion.isAcceptableOrUnknown(
          data['is_pending_deletion']!,
          _isPendingDeletionMeta,
        ),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  TodoTagItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoTagItem(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      isPendingDeletion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pending_deletion'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
    );
  }

  @override
  $TodoTagItemsTable createAlias(String alias) {
    return $TodoTagItemsTable(attachedDatabase, alias);
  }
}

class TodoTagItem extends DataClass implements Insertable<TodoTagItem> {
  final int localId;
  final String? id;
  final String name;
  final String? color;
  final String syncStatus;
  final DateTime? createdAt;
  final bool isPendingDeletion;
  final bool isDirty;
  const TodoTagItem({
    required this.localId,
    this.id,
    required this.name,
    this.color,
    required this.syncStatus,
    this.createdAt,
    required this.isPendingDeletion,
    required this.isDirty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['is_pending_deletion'] = Variable<bool>(isPendingDeletion);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  TodoTagItemsCompanion toCompanion(bool nullToAbsent) {
    return TodoTagItemsCompanion(
      localId: Value(localId),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      syncStatus: Value(syncStatus),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isPendingDeletion: Value(isPendingDeletion),
      isDirty: Value(isDirty),
    );
  }

  factory TodoTagItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTagItem(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      isPendingDeletion: serializer.fromJson<bool>(json['isPendingDeletion']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'isPendingDeletion': serializer.toJson<bool>(isPendingDeletion),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  TodoTagItem copyWith({
    int? localId,
    Value<String?> id = const Value.absent(),
    String? name,
    Value<String?> color = const Value.absent(),
    String? syncStatus,
    Value<DateTime?> createdAt = const Value.absent(),
    bool? isPendingDeletion,
    bool? isDirty,
  }) => TodoTagItem(
    localId: localId ?? this.localId,
    id: id.present ? id.value : this.id,
    name: name ?? this.name,
    color: color.present ? color.value : this.color,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    isPendingDeletion: isPendingDeletion ?? this.isPendingDeletion,
    isDirty: isDirty ?? this.isDirty,
  );
  TodoTagItem copyWithCompanion(TodoTagItemsCompanion data) {
    return TodoTagItem(
      localId: data.localId.present ? data.localId.value : this.localId,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isPendingDeletion: data.isPendingDeletion.present
          ? data.isPendingDeletion.value
          : this.isPendingDeletion,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoTagItem(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('isPendingDeletion: $isPendingDeletion, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    id,
    name,
    color,
    syncStatus,
    createdAt,
    isPendingDeletion,
    isDirty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTagItem &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.isPendingDeletion == this.isPendingDeletion &&
          other.isDirty == this.isDirty);
}

class TodoTagItemsCompanion extends UpdateCompanion<TodoTagItem> {
  final Value<int> localId;
  final Value<String?> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<String> syncStatus;
  final Value<DateTime?> createdAt;
  final Value<bool> isPendingDeletion;
  final Value<bool> isDirty;
  const TodoTagItemsCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isPendingDeletion = const Value.absent(),
    this.isDirty = const Value.absent(),
  });
  TodoTagItemsCompanion.insert({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isPendingDeletion = const Value.absent(),
    this.isDirty = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TodoTagItem> custom({
    Expression<int>? localId,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<bool>? isPendingDeletion,
    Expression<bool>? isDirty,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (isPendingDeletion != null) 'is_pending_deletion': isPendingDeletion,
      if (isDirty != null) 'is_dirty': isDirty,
    });
  }

  TodoTagItemsCompanion copyWith({
    Value<int>? localId,
    Value<String?>? id,
    Value<String>? name,
    Value<String?>? color,
    Value<String>? syncStatus,
    Value<DateTime?>? createdAt,
    Value<bool>? isPendingDeletion,
    Value<bool>? isDirty,
  }) {
    return TodoTagItemsCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      isPendingDeletion: isPendingDeletion ?? this.isPendingDeletion,
      isDirty: isDirty ?? this.isDirty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isPendingDeletion.present) {
      map['is_pending_deletion'] = Variable<bool>(isPendingDeletion.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTagItemsCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('isPendingDeletion: $isPendingDeletion, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }
}

class $TodoItemsTable extends TodoItems
    with TableInfo<$TodoItemsTable, TodoItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _taskListLocalIdMeta = const VerificationMeta(
    'taskListLocalId',
  );
  @override
  late final GeneratedColumn<int> taskListLocalId = GeneratedColumn<int>(
    'task_list_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES todo_lists (local_id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('needsAction'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
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
  static const VerificationMeta _subtaskCountMeta = const VerificationMeta(
    'subtaskCount',
  );
  @override
  late final GeneratedColumn<int> subtaskCount = GeneratedColumn<int>(
    'subtask_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPendingDeletionMeta = const VerificationMeta(
    'isPendingDeletion',
  );
  @override
  late final GeneratedColumn<bool> isPendingDeletion = GeneratedColumn<bool>(
    'is_pending_deletion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pending_deletion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _focusedSecondsMeta = const VerificationMeta(
    'focusedSeconds',
  );
  @override
  late final GeneratedColumn<int> focusedSeconds = GeneratedColumn<int>(
    'focused_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    id,
    taskListLocalId,
    title,
    notes,
    status,
    priority,
    due,
    completed,
    subtaskCount,
    position,
    hidden,
    syncStatus,
    lastSyncedAt,
    createdAt,
    updatedAt,
    isPendingDeletion,
    isDirty,
    focusedSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_list_local_id')) {
      context.handle(
        _taskListLocalIdMeta,
        taskListLocalId.isAcceptableOrUnknown(
          data['task_list_local_id']!,
          _taskListLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taskListLocalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('due')) {
      context.handle(
        _dueMeta,
        due.isAcceptableOrUnknown(data['due']!, _dueMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('subtask_count')) {
      context.handle(
        _subtaskCountMeta,
        subtaskCount.isAcceptableOrUnknown(
          data['subtask_count']!,
          _subtaskCountMeta,
        ),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('hidden')) {
      context.handle(
        _hiddenMeta,
        hidden.isAcceptableOrUnknown(data['hidden']!, _hiddenMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
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
    if (data.containsKey('is_pending_deletion')) {
      context.handle(
        _isPendingDeletionMeta,
        isPendingDeletion.isAcceptableOrUnknown(
          data['is_pending_deletion']!,
          _isPendingDeletionMeta,
        ),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    if (data.containsKey('focused_seconds')) {
      context.handle(
        _focusedSecondsMeta,
        focusedSeconds.isAcceptableOrUnknown(
          data['focused_seconds']!,
          _focusedSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  TodoItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItem(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      ),
      taskListLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_list_local_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      due: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed'],
      ),
      subtaskCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtask_count'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      hidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hidden'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isPendingDeletion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pending_deletion'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
      focusedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focused_seconds'],
      )!,
    );
  }

  @override
  $TodoItemsTable createAlias(String alias) {
    return $TodoItemsTable(attachedDatabase, alias);
  }
}

class TodoItem extends DataClass implements Insertable<TodoItem> {
  final int localId;
  final String? id;
  final int taskListLocalId;
  final String title;
  final String? notes;
  final String status;
  final String priority;
  final DateTime? due;
  final DateTime? completed;
  final int subtaskCount;
  final String? position;
  final bool hidden;
  final String syncStatus;
  final DateTime? lastSyncedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPendingDeletion;
  final bool isDirty;

  /// Cumulative seconds spent focusing on this task via linked Pomodoro
  /// sessions. Local-only — not part of the remote API.
  final int focusedSeconds;
  const TodoItem({
    required this.localId,
    this.id,
    required this.taskListLocalId,
    required this.title,
    this.notes,
    required this.status,
    required this.priority,
    this.due,
    this.completed,
    required this.subtaskCount,
    this.position,
    required this.hidden,
    required this.syncStatus,
    this.lastSyncedAt,
    this.createdAt,
    this.updatedAt,
    required this.isPendingDeletion,
    required this.isDirty,
    required this.focusedSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['task_list_local_id'] = Variable<int>(taskListLocalId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<DateTime>(due);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<DateTime>(completed);
    }
    map['subtask_count'] = Variable<int>(subtaskCount);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    map['hidden'] = Variable<bool>(hidden);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_pending_deletion'] = Variable<bool>(isPendingDeletion);
    map['is_dirty'] = Variable<bool>(isDirty);
    map['focused_seconds'] = Variable<int>(focusedSeconds);
    return map;
  }

  TodoItemsCompanion toCompanion(bool nullToAbsent) {
    return TodoItemsCompanion(
      localId: Value(localId),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      taskListLocalId: Value(taskListLocalId),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      priority: Value(priority),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      subtaskCount: Value(subtaskCount),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      hidden: Value(hidden),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isPendingDeletion: Value(isPendingDeletion),
      isDirty: Value(isDirty),
      focusedSeconds: Value(focusedSeconds),
    );
  }

  factory TodoItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItem(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<String?>(json['id']),
      taskListLocalId: serializer.fromJson<int>(json['taskListLocalId']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      due: serializer.fromJson<DateTime?>(json['due']),
      completed: serializer.fromJson<DateTime?>(json['completed']),
      subtaskCount: serializer.fromJson<int>(json['subtaskCount']),
      position: serializer.fromJson<String?>(json['position']),
      hidden: serializer.fromJson<bool>(json['hidden']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isPendingDeletion: serializer.fromJson<bool>(json['isPendingDeletion']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
      focusedSeconds: serializer.fromJson<int>(json['focusedSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<String?>(id),
      'taskListLocalId': serializer.toJson<int>(taskListLocalId),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'due': serializer.toJson<DateTime?>(due),
      'completed': serializer.toJson<DateTime?>(completed),
      'subtaskCount': serializer.toJson<int>(subtaskCount),
      'position': serializer.toJson<String?>(position),
      'hidden': serializer.toJson<bool>(hidden),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isPendingDeletion': serializer.toJson<bool>(isPendingDeletion),
      'isDirty': serializer.toJson<bool>(isDirty),
      'focusedSeconds': serializer.toJson<int>(focusedSeconds),
    };
  }

  TodoItem copyWith({
    int? localId,
    Value<String?> id = const Value.absent(),
    int? taskListLocalId,
    String? title,
    Value<String?> notes = const Value.absent(),
    String? status,
    String? priority,
    Value<DateTime?> due = const Value.absent(),
    Value<DateTime?> completed = const Value.absent(),
    int? subtaskCount,
    Value<String?> position = const Value.absent(),
    bool? hidden,
    String? syncStatus,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isPendingDeletion,
    bool? isDirty,
    int? focusedSeconds,
  }) => TodoItem(
    localId: localId ?? this.localId,
    id: id.present ? id.value : this.id,
    taskListLocalId: taskListLocalId ?? this.taskListLocalId,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    due: due.present ? due.value : this.due,
    completed: completed.present ? completed.value : this.completed,
    subtaskCount: subtaskCount ?? this.subtaskCount,
    position: position.present ? position.value : this.position,
    hidden: hidden ?? this.hidden,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isPendingDeletion: isPendingDeletion ?? this.isPendingDeletion,
    isDirty: isDirty ?? this.isDirty,
    focusedSeconds: focusedSeconds ?? this.focusedSeconds,
  );
  TodoItem copyWithCompanion(TodoItemsCompanion data) {
    return TodoItem(
      localId: data.localId.present ? data.localId.value : this.localId,
      id: data.id.present ? data.id.value : this.id,
      taskListLocalId: data.taskListLocalId.present
          ? data.taskListLocalId.value
          : this.taskListLocalId,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      due: data.due.present ? data.due.value : this.due,
      completed: data.completed.present ? data.completed.value : this.completed,
      subtaskCount: data.subtaskCount.present
          ? data.subtaskCount.value
          : this.subtaskCount,
      position: data.position.present ? data.position.value : this.position,
      hidden: data.hidden.present ? data.hidden.value : this.hidden,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isPendingDeletion: data.isPendingDeletion.present
          ? data.isPendingDeletion.value
          : this.isPendingDeletion,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
      focusedSeconds: data.focusedSeconds.present
          ? data.focusedSeconds.value
          : this.focusedSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoItem(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('taskListLocalId: $taskListLocalId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('due: $due, ')
          ..write('completed: $completed, ')
          ..write('subtaskCount: $subtaskCount, ')
          ..write('position: $position, ')
          ..write('hidden: $hidden, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPendingDeletion: $isPendingDeletion, ')
          ..write('isDirty: $isDirty, ')
          ..write('focusedSeconds: $focusedSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    id,
    taskListLocalId,
    title,
    notes,
    status,
    priority,
    due,
    completed,
    subtaskCount,
    position,
    hidden,
    syncStatus,
    lastSyncedAt,
    createdAt,
    updatedAt,
    isPendingDeletion,
    isDirty,
    focusedSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItem &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.taskListLocalId == this.taskListLocalId &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.due == this.due &&
          other.completed == this.completed &&
          other.subtaskCount == this.subtaskCount &&
          other.position == this.position &&
          other.hidden == this.hidden &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isPendingDeletion == this.isPendingDeletion &&
          other.isDirty == this.isDirty &&
          other.focusedSeconds == this.focusedSeconds);
}

class TodoItemsCompanion extends UpdateCompanion<TodoItem> {
  final Value<int> localId;
  final Value<String?> id;
  final Value<int> taskListLocalId;
  final Value<String> title;
  final Value<String?> notes;
  final Value<String> status;
  final Value<String> priority;
  final Value<DateTime?> due;
  final Value<DateTime?> completed;
  final Value<int> subtaskCount;
  final Value<String?> position;
  final Value<bool> hidden;
  final Value<String> syncStatus;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isPendingDeletion;
  final Value<bool> isDirty;
  final Value<int> focusedSeconds;
  const TodoItemsCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.taskListLocalId = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.due = const Value.absent(),
    this.completed = const Value.absent(),
    this.subtaskCount = const Value.absent(),
    this.position = const Value.absent(),
    this.hidden = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPendingDeletion = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.focusedSeconds = const Value.absent(),
  });
  TodoItemsCompanion.insert({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    required int taskListLocalId,
    required String title,
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.due = const Value.absent(),
    this.completed = const Value.absent(),
    this.subtaskCount = const Value.absent(),
    this.position = const Value.absent(),
    this.hidden = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPendingDeletion = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.focusedSeconds = const Value.absent(),
  }) : taskListLocalId = Value(taskListLocalId),
       title = Value(title);
  static Insertable<TodoItem> custom({
    Expression<int>? localId,
    Expression<String>? id,
    Expression<int>? taskListLocalId,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<DateTime>? due,
    Expression<DateTime>? completed,
    Expression<int>? subtaskCount,
    Expression<String>? position,
    Expression<bool>? hidden,
    Expression<String>? syncStatus,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isPendingDeletion,
    Expression<bool>? isDirty,
    Expression<int>? focusedSeconds,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (taskListLocalId != null) 'task_list_local_id': taskListLocalId,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (due != null) 'due': due,
      if (completed != null) 'completed': completed,
      if (subtaskCount != null) 'subtask_count': subtaskCount,
      if (position != null) 'position': position,
      if (hidden != null) 'hidden': hidden,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isPendingDeletion != null) 'is_pending_deletion': isPendingDeletion,
      if (isDirty != null) 'is_dirty': isDirty,
      if (focusedSeconds != null) 'focused_seconds': focusedSeconds,
    });
  }

  TodoItemsCompanion copyWith({
    Value<int>? localId,
    Value<String?>? id,
    Value<int>? taskListLocalId,
    Value<String>? title,
    Value<String?>? notes,
    Value<String>? status,
    Value<String>? priority,
    Value<DateTime?>? due,
    Value<DateTime?>? completed,
    Value<int>? subtaskCount,
    Value<String?>? position,
    Value<bool>? hidden,
    Value<String>? syncStatus,
    Value<DateTime?>? lastSyncedAt,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<bool>? isPendingDeletion,
    Value<bool>? isDirty,
    Value<int>? focusedSeconds,
  }) {
    return TodoItemsCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      taskListLocalId: taskListLocalId ?? this.taskListLocalId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      due: due ?? this.due,
      completed: completed ?? this.completed,
      subtaskCount: subtaskCount ?? this.subtaskCount,
      position: position ?? this.position,
      hidden: hidden ?? this.hidden,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPendingDeletion: isPendingDeletion ?? this.isPendingDeletion,
      isDirty: isDirty ?? this.isDirty,
      focusedSeconds: focusedSeconds ?? this.focusedSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskListLocalId.present) {
      map['task_list_local_id'] = Variable<int>(taskListLocalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (completed.present) {
      map['completed'] = Variable<DateTime>(completed.value);
    }
    if (subtaskCount.present) {
      map['subtask_count'] = Variable<int>(subtaskCount.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (hidden.present) {
      map['hidden'] = Variable<bool>(hidden.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isPendingDeletion.present) {
      map['is_pending_deletion'] = Variable<bool>(isPendingDeletion.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (focusedSeconds.present) {
      map['focused_seconds'] = Variable<int>(focusedSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('taskListLocalId: $taskListLocalId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('due: $due, ')
          ..write('completed: $completed, ')
          ..write('subtaskCount: $subtaskCount, ')
          ..write('position: $position, ')
          ..write('hidden: $hidden, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPendingDeletion: $isPendingDeletion, ')
          ..write('isDirty: $isDirty, ')
          ..write('focusedSeconds: $focusedSeconds')
          ..write(')'))
        .toString();
  }
}

class $TodoItemTagsTable extends TodoItemTags
    with TableInfo<$TodoItemTagsTable, TodoItemTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoItemTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _todoLocalIdMeta = const VerificationMeta(
    'todoLocalId',
  );
  @override
  late final GeneratedColumn<int> todoLocalId = GeneratedColumn<int>(
    'todo_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES todo_items (local_id)',
    ),
  );
  static const VerificationMeta _tagLocalIdMeta = const VerificationMeta(
    'tagLocalId',
  );
  @override
  late final GeneratedColumn<int> tagLocalId = GeneratedColumn<int>(
    'tag_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES todo_tag_items (local_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [todoLocalId, tagLocalId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_item_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoItemTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('todo_local_id')) {
      context.handle(
        _todoLocalIdMeta,
        todoLocalId.isAcceptableOrUnknown(
          data['todo_local_id']!,
          _todoLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_todoLocalIdMeta);
    }
    if (data.containsKey('tag_local_id')) {
      context.handle(
        _tagLocalIdMeta,
        tagLocalId.isAcceptableOrUnknown(
          data['tag_local_id']!,
          _tagLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tagLocalIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {todoLocalId, tagLocalId};
  @override
  TodoItemTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItemTag(
      todoLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}todo_local_id'],
      )!,
      tagLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_local_id'],
      )!,
    );
  }

  @override
  $TodoItemTagsTable createAlias(String alias) {
    return $TodoItemTagsTable(attachedDatabase, alias);
  }
}

class TodoItemTag extends DataClass implements Insertable<TodoItemTag> {
  final int todoLocalId;
  final int tagLocalId;
  const TodoItemTag({required this.todoLocalId, required this.tagLocalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['todo_local_id'] = Variable<int>(todoLocalId);
    map['tag_local_id'] = Variable<int>(tagLocalId);
    return map;
  }

  TodoItemTagsCompanion toCompanion(bool nullToAbsent) {
    return TodoItemTagsCompanion(
      todoLocalId: Value(todoLocalId),
      tagLocalId: Value(tagLocalId),
    );
  }

  factory TodoItemTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItemTag(
      todoLocalId: serializer.fromJson<int>(json['todoLocalId']),
      tagLocalId: serializer.fromJson<int>(json['tagLocalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'todoLocalId': serializer.toJson<int>(todoLocalId),
      'tagLocalId': serializer.toJson<int>(tagLocalId),
    };
  }

  TodoItemTag copyWith({int? todoLocalId, int? tagLocalId}) => TodoItemTag(
    todoLocalId: todoLocalId ?? this.todoLocalId,
    tagLocalId: tagLocalId ?? this.tagLocalId,
  );
  TodoItemTag copyWithCompanion(TodoItemTagsCompanion data) {
    return TodoItemTag(
      todoLocalId: data.todoLocalId.present
          ? data.todoLocalId.value
          : this.todoLocalId,
      tagLocalId: data.tagLocalId.present
          ? data.tagLocalId.value
          : this.tagLocalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemTag(')
          ..write('todoLocalId: $todoLocalId, ')
          ..write('tagLocalId: $tagLocalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(todoLocalId, tagLocalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItemTag &&
          other.todoLocalId == this.todoLocalId &&
          other.tagLocalId == this.tagLocalId);
}

class TodoItemTagsCompanion extends UpdateCompanion<TodoItemTag> {
  final Value<int> todoLocalId;
  final Value<int> tagLocalId;
  final Value<int> rowid;
  const TodoItemTagsCompanion({
    this.todoLocalId = const Value.absent(),
    this.tagLocalId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodoItemTagsCompanion.insert({
    required int todoLocalId,
    required int tagLocalId,
    this.rowid = const Value.absent(),
  }) : todoLocalId = Value(todoLocalId),
       tagLocalId = Value(tagLocalId);
  static Insertable<TodoItemTag> custom({
    Expression<int>? todoLocalId,
    Expression<int>? tagLocalId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (todoLocalId != null) 'todo_local_id': todoLocalId,
      if (tagLocalId != null) 'tag_local_id': tagLocalId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodoItemTagsCompanion copyWith({
    Value<int>? todoLocalId,
    Value<int>? tagLocalId,
    Value<int>? rowid,
  }) {
    return TodoItemTagsCompanion(
      todoLocalId: todoLocalId ?? this.todoLocalId,
      tagLocalId: tagLocalId ?? this.tagLocalId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (todoLocalId.present) {
      map['todo_local_id'] = Variable<int>(todoLocalId.value);
    }
    if (tagLocalId.present) {
      map['tag_local_id'] = Variable<int>(tagLocalId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemTagsCompanion(')
          ..write('todoLocalId: $todoLocalId, ')
          ..write('tagLocalId: $tagLocalId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyMaterialRecordsTable extends StudyMaterialRecords
    with TableInfo<$StudyMaterialRecordsTable, StudyMaterialRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyMaterialRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    noteId,
    metadataJson,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_material_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyMaterialRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metadataJsonMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {environment, accountId, noteId};
  @override
  StudyMaterialRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyMaterialRecord(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $StudyMaterialRecordsTable createAlias(String alias) {
    return $StudyMaterialRecordsTable(attachedDatabase, alias);
  }
}

class StudyMaterialRecord extends DataClass
    implements Insertable<StudyMaterialRecord> {
  final String environment;
  final String accountId;
  final int noteId;
  final String metadataJson;
  final DateTime cachedAt;
  const StudyMaterialRecord({
    required this.environment,
    required this.accountId,
    required this.noteId,
    required this.metadataJson,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['note_id'] = Variable<int>(noteId);
    map['metadata_json'] = Variable<String>(metadataJson);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  StudyMaterialRecordsCompanion toCompanion(bool nullToAbsent) {
    return StudyMaterialRecordsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      noteId: Value(noteId),
      metadataJson: Value(metadataJson),
      cachedAt: Value(cachedAt),
    );
  }

  factory StudyMaterialRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyMaterialRecord(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'noteId': serializer.toJson<int>(noteId),
      'metadataJson': serializer.toJson<String>(metadataJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  StudyMaterialRecord copyWith({
    String? environment,
    String? accountId,
    int? noteId,
    String? metadataJson,
    DateTime? cachedAt,
  }) => StudyMaterialRecord(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    noteId: noteId ?? this.noteId,
    metadataJson: metadataJson ?? this.metadataJson,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  StudyMaterialRecord copyWithCompanion(StudyMaterialRecordsCompanion data) {
    return StudyMaterialRecord(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyMaterialRecord(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(environment, accountId, noteId, metadataJson, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyMaterialRecord &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.noteId == this.noteId &&
          other.metadataJson == this.metadataJson &&
          other.cachedAt == this.cachedAt);
}

class StudyMaterialRecordsCompanion
    extends UpdateCompanion<StudyMaterialRecord> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<int> noteId;
  final Value<String> metadataJson;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const StudyMaterialRecordsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyMaterialRecordsCompanion.insert({
    required String environment,
    required String accountId,
    required int noteId,
    required String metadataJson,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       noteId = Value(noteId),
       metadataJson = Value(metadataJson),
       cachedAt = Value(cachedAt);
  static Insertable<StudyMaterialRecord> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<int>? noteId,
    Expression<String>? metadataJson,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (noteId != null) 'note_id': noteId,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyMaterialRecordsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<int>? noteId,
    Value<String>? metadataJson,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return StudyMaterialRecordsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      noteId: noteId ?? this.noteId,
      metadataJson: metadataJson ?? this.metadataJson,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyMaterialRecordsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyQuestionSetRecordsTable extends StudyQuestionSetRecords
    with TableInfo<$StudyQuestionSetRecordsTable, StudyQuestionSetRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyQuestionSetRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<int> setId = GeneratedColumn<int>(
    'set_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setJsonMeta = const VerificationMeta(
    'setJson',
  );
  @override
  late final GeneratedColumn<String> setJson = GeneratedColumn<String>(
    'set_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    noteId,
    setId,
    format,
    setJson,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_question_set_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyQuestionSetRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
      );
    } else if (isInserting) {
      context.missing(_setIdMeta);
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('set_json')) {
      context.handle(
        _setJsonMeta,
        setJson.isAcceptableOrUnknown(data['set_json']!, _setJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_setJsonMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    environment,
    accountId,
    noteId,
    setId,
    format,
  };
  @override
  StudyQuestionSetRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyQuestionSetRecord(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_id'],
      )!,
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      setJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_json'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $StudyQuestionSetRecordsTable createAlias(String alias) {
    return $StudyQuestionSetRecordsTable(attachedDatabase, alias);
  }
}

class StudyQuestionSetRecord extends DataClass
    implements Insertable<StudyQuestionSetRecord> {
  final String environment;
  final String accountId;
  final int noteId;
  final int setId;
  final String format;
  final String setJson;
  final DateTime cachedAt;
  const StudyQuestionSetRecord({
    required this.environment,
    required this.accountId,
    required this.noteId,
    required this.setId,
    required this.format,
    required this.setJson,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['note_id'] = Variable<int>(noteId);
    map['set_id'] = Variable<int>(setId);
    map['format'] = Variable<String>(format);
    map['set_json'] = Variable<String>(setJson);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  StudyQuestionSetRecordsCompanion toCompanion(bool nullToAbsent) {
    return StudyQuestionSetRecordsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      noteId: Value(noteId),
      setId: Value(setId),
      format: Value(format),
      setJson: Value(setJson),
      cachedAt: Value(cachedAt),
    );
  }

  factory StudyQuestionSetRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyQuestionSetRecord(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      setId: serializer.fromJson<int>(json['setId']),
      format: serializer.fromJson<String>(json['format']),
      setJson: serializer.fromJson<String>(json['setJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'noteId': serializer.toJson<int>(noteId),
      'setId': serializer.toJson<int>(setId),
      'format': serializer.toJson<String>(format),
      'setJson': serializer.toJson<String>(setJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  StudyQuestionSetRecord copyWith({
    String? environment,
    String? accountId,
    int? noteId,
    int? setId,
    String? format,
    String? setJson,
    DateTime? cachedAt,
  }) => StudyQuestionSetRecord(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    noteId: noteId ?? this.noteId,
    setId: setId ?? this.setId,
    format: format ?? this.format,
    setJson: setJson ?? this.setJson,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  StudyQuestionSetRecord copyWithCompanion(
    StudyQuestionSetRecordsCompanion data,
  ) {
    return StudyQuestionSetRecord(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      setId: data.setId.present ? data.setId.value : this.setId,
      format: data.format.present ? data.format.value : this.format,
      setJson: data.setJson.present ? data.setJson.value : this.setJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyQuestionSetRecord(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('setId: $setId, ')
          ..write('format: $format, ')
          ..write('setJson: $setJson, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environment,
    accountId,
    noteId,
    setId,
    format,
    setJson,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyQuestionSetRecord &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.noteId == this.noteId &&
          other.setId == this.setId &&
          other.format == this.format &&
          other.setJson == this.setJson &&
          other.cachedAt == this.cachedAt);
}

class StudyQuestionSetRecordsCompanion
    extends UpdateCompanion<StudyQuestionSetRecord> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<int> noteId;
  final Value<int> setId;
  final Value<String> format;
  final Value<String> setJson;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const StudyQuestionSetRecordsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.setId = const Value.absent(),
    this.format = const Value.absent(),
    this.setJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyQuestionSetRecordsCompanion.insert({
    required String environment,
    required String accountId,
    required int noteId,
    required int setId,
    required String format,
    required String setJson,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       noteId = Value(noteId),
       setId = Value(setId),
       format = Value(format),
       setJson = Value(setJson),
       cachedAt = Value(cachedAt);
  static Insertable<StudyQuestionSetRecord> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<int>? noteId,
    Expression<int>? setId,
    Expression<String>? format,
    Expression<String>? setJson,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (noteId != null) 'note_id': noteId,
      if (setId != null) 'set_id': setId,
      if (format != null) 'format': format,
      if (setJson != null) 'set_json': setJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyQuestionSetRecordsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<int>? noteId,
    Value<int>? setId,
    Value<String>? format,
    Value<String>? setJson,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return StudyQuestionSetRecordsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      noteId: noteId ?? this.noteId,
      setId: setId ?? this.setId,
      format: format ?? this.format,
      setJson: setJson ?? this.setJson,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<int>(setId.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (setJson.present) {
      map['set_json'] = Variable<String>(setJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyQuestionSetRecordsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('setId: $setId, ')
          ..write('format: $format, ')
          ..write('setJson: $setJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyGenerationJobRecordsTable extends StudyGenerationJobRecords
    with TableInfo<$StudyGenerationJobRecordsTable, StudyGenerationJobRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyGenerationJobRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requestedOutputsJsonMeta =
      const VerificationMeta('requestedOutputsJson');
  @override
  late final GeneratedColumn<String> requestedOutputsJson =
      GeneratedColumn<String>(
        'requested_outputs_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    noteId,
    jobId,
    requestedOutputsJson,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_generation_job_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyGenerationJobRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('requested_outputs_json')) {
      context.handle(
        _requestedOutputsJsonMeta,
        requestedOutputsJson.isAcceptableOrUnknown(
          data['requested_outputs_json']!,
          _requestedOutputsJsonMeta,
        ),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {environment, accountId, noteId};
  @override
  StudyGenerationJobRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyGenerationJobRecord(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}job_id'],
      )!,
      requestedOutputsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requested_outputs_json'],
      ),
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $StudyGenerationJobRecordsTable createAlias(String alias) {
    return $StudyGenerationJobRecordsTable(attachedDatabase, alias);
  }
}

class StudyGenerationJobRecord extends DataClass
    implements Insertable<StudyGenerationJobRecord> {
  final String environment;
  final String accountId;
  final int noteId;
  final int jobId;
  final String? requestedOutputsJson;
  final DateTime savedAt;
  const StudyGenerationJobRecord({
    required this.environment,
    required this.accountId,
    required this.noteId,
    required this.jobId,
    this.requestedOutputsJson,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['note_id'] = Variable<int>(noteId);
    map['job_id'] = Variable<int>(jobId);
    if (!nullToAbsent || requestedOutputsJson != null) {
      map['requested_outputs_json'] = Variable<String>(requestedOutputsJson);
    }
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  StudyGenerationJobRecordsCompanion toCompanion(bool nullToAbsent) {
    return StudyGenerationJobRecordsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      noteId: Value(noteId),
      jobId: Value(jobId),
      requestedOutputsJson: requestedOutputsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(requestedOutputsJson),
      savedAt: Value(savedAt),
    );
  }

  factory StudyGenerationJobRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyGenerationJobRecord(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      jobId: serializer.fromJson<int>(json['jobId']),
      requestedOutputsJson: serializer.fromJson<String?>(
        json['requestedOutputsJson'],
      ),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'noteId': serializer.toJson<int>(noteId),
      'jobId': serializer.toJson<int>(jobId),
      'requestedOutputsJson': serializer.toJson<String?>(requestedOutputsJson),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  StudyGenerationJobRecord copyWith({
    String? environment,
    String? accountId,
    int? noteId,
    int? jobId,
    Value<String?> requestedOutputsJson = const Value.absent(),
    DateTime? savedAt,
  }) => StudyGenerationJobRecord(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    noteId: noteId ?? this.noteId,
    jobId: jobId ?? this.jobId,
    requestedOutputsJson: requestedOutputsJson.present
        ? requestedOutputsJson.value
        : this.requestedOutputsJson,
    savedAt: savedAt ?? this.savedAt,
  );
  StudyGenerationJobRecord copyWithCompanion(
    StudyGenerationJobRecordsCompanion data,
  ) {
    return StudyGenerationJobRecord(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      requestedOutputsJson: data.requestedOutputsJson.present
          ? data.requestedOutputsJson.value
          : this.requestedOutputsJson,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyGenerationJobRecord(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('jobId: $jobId, ')
          ..write('requestedOutputsJson: $requestedOutputsJson, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environment,
    accountId,
    noteId,
    jobId,
    requestedOutputsJson,
    savedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyGenerationJobRecord &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.noteId == this.noteId &&
          other.jobId == this.jobId &&
          other.requestedOutputsJson == this.requestedOutputsJson &&
          other.savedAt == this.savedAt);
}

class StudyGenerationJobRecordsCompanion
    extends UpdateCompanion<StudyGenerationJobRecord> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<int> noteId;
  final Value<int> jobId;
  final Value<String?> requestedOutputsJson;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const StudyGenerationJobRecordsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.jobId = const Value.absent(),
    this.requestedOutputsJson = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyGenerationJobRecordsCompanion.insert({
    required String environment,
    required String accountId,
    required int noteId,
    required int jobId,
    this.requestedOutputsJson = const Value.absent(),
    required DateTime savedAt,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       noteId = Value(noteId),
       jobId = Value(jobId),
       savedAt = Value(savedAt);
  static Insertable<StudyGenerationJobRecord> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<int>? noteId,
    Expression<int>? jobId,
    Expression<String>? requestedOutputsJson,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (noteId != null) 'note_id': noteId,
      if (jobId != null) 'job_id': jobId,
      if (requestedOutputsJson != null)
        'requested_outputs_json': requestedOutputsJson,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyGenerationJobRecordsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<int>? noteId,
    Value<int>? jobId,
    Value<String?>? requestedOutputsJson,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return StudyGenerationJobRecordsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      noteId: noteId ?? this.noteId,
      jobId: jobId ?? this.jobId,
      requestedOutputsJson: requestedOutputsJson ?? this.requestedOutputsJson,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (requestedOutputsJson.present) {
      map['requested_outputs_json'] = Variable<String>(
        requestedOutputsJson.value,
      );
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyGenerationJobRecordsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('jobId: $jobId, ')
          ..write('requestedOutputsJson: $requestedOutputsJson, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyPodcastRecordsTable extends StudyPodcastRecords
    with TableInfo<$StudyPodcastRecordsTable, StudyPodcastRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPodcastRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeIdMeta = const VerificationMeta(
    'episodeId',
  );
  @override
  late final GeneratedColumn<int> episodeId = GeneratedColumn<int>(
    'episode_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    noteId,
    episodeId,
    generatedAt,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_podcast_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPodcastRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('episode_id')) {
      context.handle(
        _episodeIdMeta,
        episodeId.isAcceptableOrUnknown(data['episode_id']!, _episodeIdMeta),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metadataJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    environment,
    accountId,
    noteId,
    generatedAt,
  };
  @override
  StudyPodcastRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPodcastRecord(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      episodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}episode_id'],
      ),
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
    );
  }

  @override
  $StudyPodcastRecordsTable createAlias(String alias) {
    return $StudyPodcastRecordsTable(attachedDatabase, alias);
  }
}

class StudyPodcastRecord extends DataClass
    implements Insertable<StudyPodcastRecord> {
  final String environment;
  final String accountId;
  final int noteId;
  final int? episodeId;
  final DateTime generatedAt;
  final String metadataJson;
  const StudyPodcastRecord({
    required this.environment,
    required this.accountId,
    required this.noteId,
    this.episodeId,
    required this.generatedAt,
    required this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['note_id'] = Variable<int>(noteId);
    if (!nullToAbsent || episodeId != null) {
      map['episode_id'] = Variable<int>(episodeId);
    }
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['metadata_json'] = Variable<String>(metadataJson);
    return map;
  }

  StudyPodcastRecordsCompanion toCompanion(bool nullToAbsent) {
    return StudyPodcastRecordsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      noteId: Value(noteId),
      episodeId: episodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeId),
      generatedAt: Value(generatedAt),
      metadataJson: Value(metadataJson),
    );
  }

  factory StudyPodcastRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPodcastRecord(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      episodeId: serializer.fromJson<int?>(json['episodeId']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'noteId': serializer.toJson<int>(noteId),
      'episodeId': serializer.toJson<int?>(episodeId),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'metadataJson': serializer.toJson<String>(metadataJson),
    };
  }

  StudyPodcastRecord copyWith({
    String? environment,
    String? accountId,
    int? noteId,
    Value<int?> episodeId = const Value.absent(),
    DateTime? generatedAt,
    String? metadataJson,
  }) => StudyPodcastRecord(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    noteId: noteId ?? this.noteId,
    episodeId: episodeId.present ? episodeId.value : this.episodeId,
    generatedAt: generatedAt ?? this.generatedAt,
    metadataJson: metadataJson ?? this.metadataJson,
  );
  StudyPodcastRecord copyWithCompanion(StudyPodcastRecordsCompanion data) {
    return StudyPodcastRecord(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      episodeId: data.episodeId.present ? data.episodeId.value : this.episodeId,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPodcastRecord(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('episodeId: $episodeId, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environment,
    accountId,
    noteId,
    episodeId,
    generatedAt,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPodcastRecord &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.noteId == this.noteId &&
          other.episodeId == this.episodeId &&
          other.generatedAt == this.generatedAt &&
          other.metadataJson == this.metadataJson);
}

class StudyPodcastRecordsCompanion extends UpdateCompanion<StudyPodcastRecord> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<int> noteId;
  final Value<int?> episodeId;
  final Value<DateTime> generatedAt;
  final Value<String> metadataJson;
  final Value<int> rowid;
  const StudyPodcastRecordsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.episodeId = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyPodcastRecordsCompanion.insert({
    required String environment,
    required String accountId,
    required int noteId,
    this.episodeId = const Value.absent(),
    required DateTime generatedAt,
    required String metadataJson,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       noteId = Value(noteId),
       generatedAt = Value(generatedAt),
       metadataJson = Value(metadataJson);
  static Insertable<StudyPodcastRecord> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<int>? noteId,
    Expression<int>? episodeId,
    Expression<DateTime>? generatedAt,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (noteId != null) 'note_id': noteId,
      if (episodeId != null) 'episode_id': episodeId,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyPodcastRecordsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<int>? noteId,
    Value<int?>? episodeId,
    Value<DateTime>? generatedAt,
    Value<String>? metadataJson,
    Value<int>? rowid,
  }) {
    return StudyPodcastRecordsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      noteId: noteId ?? this.noteId,
      episodeId: episodeId ?? this.episodeId,
      generatedAt: generatedAt ?? this.generatedAt,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (episodeId.present) {
      map['episode_id'] = Variable<int>(episodeId.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyPodcastRecordsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('episodeId: $episodeId, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyPodcastDownloadsTable extends StudyPodcastDownloads
    with TableInfo<$StudyPodcastDownloadsTable, StudyPodcastDownload> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPodcastDownloadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeKeyMeta = const VerificationMeta(
    'episodeKey',
  );
  @override
  late final GeneratedColumn<String> episodeKey = GeneratedColumn<String>(
    'episode_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<double> durationSeconds = GeneratedColumn<double>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseLabelMeta = const VerificationMeta(
    'courseLabel',
  );
  @override
  late final GeneratedColumn<String> courseLabel = GeneratedColumn<String>(
    'course_label',
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
  static const VerificationMeta _downloadedAtMeta = const VerificationMeta(
    'downloadedAt',
  );
  @override
  late final GeneratedColumn<DateTime> downloadedAt = GeneratedColumn<DateTime>(
    'downloaded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    noteId,
    episodeKey,
    localPath,
    sizeBytes,
    durationSeconds,
    courseLabel,
    title,
    downloadedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_podcast_downloads';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPodcastDownload> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('episode_key')) {
      context.handle(
        _episodeKeyMeta,
        episodeKey.isAcceptableOrUnknown(data['episode_key']!, _episodeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_episodeKeyMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('course_label')) {
      context.handle(
        _courseLabelMeta,
        courseLabel.isAcceptableOrUnknown(
          data['course_label']!,
          _courseLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseLabelMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('downloaded_at')) {
      context.handle(
        _downloadedAtMeta,
        downloadedAt.isAcceptableOrUnknown(
          data['downloaded_at']!,
          _downloadedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    environment,
    accountId,
    noteId,
    episodeKey,
  };
  @override
  StudyPodcastDownload map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPodcastDownload(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      episodeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_key'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_seconds'],
      )!,
      courseLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_label'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      downloadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}downloaded_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $StudyPodcastDownloadsTable createAlias(String alias) {
    return $StudyPodcastDownloadsTable(attachedDatabase, alias);
  }
}

class StudyPodcastDownload extends DataClass
    implements Insertable<StudyPodcastDownload> {
  final String environment;
  final String accountId;
  final int noteId;
  final String episodeKey;
  final String localPath;
  final int sizeBytes;
  final double durationSeconds;
  final String courseLabel;
  final String title;
  final DateTime? downloadedAt;
  final String status;
  const StudyPodcastDownload({
    required this.environment,
    required this.accountId,
    required this.noteId,
    required this.episodeKey,
    required this.localPath,
    required this.sizeBytes,
    required this.durationSeconds,
    required this.courseLabel,
    required this.title,
    this.downloadedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['note_id'] = Variable<int>(noteId);
    map['episode_key'] = Variable<String>(episodeKey);
    map['local_path'] = Variable<String>(localPath);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['duration_seconds'] = Variable<double>(durationSeconds);
    map['course_label'] = Variable<String>(courseLabel);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || downloadedAt != null) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  StudyPodcastDownloadsCompanion toCompanion(bool nullToAbsent) {
    return StudyPodcastDownloadsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      noteId: Value(noteId),
      episodeKey: Value(episodeKey),
      localPath: Value(localPath),
      sizeBytes: Value(sizeBytes),
      durationSeconds: Value(durationSeconds),
      courseLabel: Value(courseLabel),
      title: Value(title),
      downloadedAt: downloadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadedAt),
      status: Value(status),
    );
  }

  factory StudyPodcastDownload.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPodcastDownload(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      episodeKey: serializer.fromJson<String>(json['episodeKey']),
      localPath: serializer.fromJson<String>(json['localPath']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      durationSeconds: serializer.fromJson<double>(json['durationSeconds']),
      courseLabel: serializer.fromJson<String>(json['courseLabel']),
      title: serializer.fromJson<String>(json['title']),
      downloadedAt: serializer.fromJson<DateTime?>(json['downloadedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'noteId': serializer.toJson<int>(noteId),
      'episodeKey': serializer.toJson<String>(episodeKey),
      'localPath': serializer.toJson<String>(localPath),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'durationSeconds': serializer.toJson<double>(durationSeconds),
      'courseLabel': serializer.toJson<String>(courseLabel),
      'title': serializer.toJson<String>(title),
      'downloadedAt': serializer.toJson<DateTime?>(downloadedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  StudyPodcastDownload copyWith({
    String? environment,
    String? accountId,
    int? noteId,
    String? episodeKey,
    String? localPath,
    int? sizeBytes,
    double? durationSeconds,
    String? courseLabel,
    String? title,
    Value<DateTime?> downloadedAt = const Value.absent(),
    String? status,
  }) => StudyPodcastDownload(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    noteId: noteId ?? this.noteId,
    episodeKey: episodeKey ?? this.episodeKey,
    localPath: localPath ?? this.localPath,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    courseLabel: courseLabel ?? this.courseLabel,
    title: title ?? this.title,
    downloadedAt: downloadedAt.present ? downloadedAt.value : this.downloadedAt,
    status: status ?? this.status,
  );
  StudyPodcastDownload copyWithCompanion(StudyPodcastDownloadsCompanion data) {
    return StudyPodcastDownload(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      episodeKey: data.episodeKey.present
          ? data.episodeKey.value
          : this.episodeKey,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      courseLabel: data.courseLabel.present
          ? data.courseLabel.value
          : this.courseLabel,
      title: data.title.present ? data.title.value : this.title,
      downloadedAt: data.downloadedAt.present
          ? data.downloadedAt.value
          : this.downloadedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPodcastDownload(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('episodeKey: $episodeKey, ')
          ..write('localPath: $localPath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('courseLabel: $courseLabel, ')
          ..write('title: $title, ')
          ..write('downloadedAt: $downloadedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environment,
    accountId,
    noteId,
    episodeKey,
    localPath,
    sizeBytes,
    durationSeconds,
    courseLabel,
    title,
    downloadedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPodcastDownload &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.noteId == this.noteId &&
          other.episodeKey == this.episodeKey &&
          other.localPath == this.localPath &&
          other.sizeBytes == this.sizeBytes &&
          other.durationSeconds == this.durationSeconds &&
          other.courseLabel == this.courseLabel &&
          other.title == this.title &&
          other.downloadedAt == this.downloadedAt &&
          other.status == this.status);
}

class StudyPodcastDownloadsCompanion
    extends UpdateCompanion<StudyPodcastDownload> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<int> noteId;
  final Value<String> episodeKey;
  final Value<String> localPath;
  final Value<int> sizeBytes;
  final Value<double> durationSeconds;
  final Value<String> courseLabel;
  final Value<String> title;
  final Value<DateTime?> downloadedAt;
  final Value<String> status;
  final Value<int> rowid;
  const StudyPodcastDownloadsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.episodeKey = const Value.absent(),
    this.localPath = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.courseLabel = const Value.absent(),
    this.title = const Value.absent(),
    this.downloadedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyPodcastDownloadsCompanion.insert({
    required String environment,
    required String accountId,
    required int noteId,
    required String episodeKey,
    required String localPath,
    required int sizeBytes,
    required double durationSeconds,
    required String courseLabel,
    required String title,
    this.downloadedAt = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       noteId = Value(noteId),
       episodeKey = Value(episodeKey),
       localPath = Value(localPath),
       sizeBytes = Value(sizeBytes),
       durationSeconds = Value(durationSeconds),
       courseLabel = Value(courseLabel),
       title = Value(title),
       status = Value(status);
  static Insertable<StudyPodcastDownload> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<int>? noteId,
    Expression<String>? episodeKey,
    Expression<String>? localPath,
    Expression<int>? sizeBytes,
    Expression<double>? durationSeconds,
    Expression<String>? courseLabel,
    Expression<String>? title,
    Expression<DateTime>? downloadedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (noteId != null) 'note_id': noteId,
      if (episodeKey != null) 'episode_key': episodeKey,
      if (localPath != null) 'local_path': localPath,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (courseLabel != null) 'course_label': courseLabel,
      if (title != null) 'title': title,
      if (downloadedAt != null) 'downloaded_at': downloadedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyPodcastDownloadsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<int>? noteId,
    Value<String>? episodeKey,
    Value<String>? localPath,
    Value<int>? sizeBytes,
    Value<double>? durationSeconds,
    Value<String>? courseLabel,
    Value<String>? title,
    Value<DateTime?>? downloadedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return StudyPodcastDownloadsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      noteId: noteId ?? this.noteId,
      episodeKey: episodeKey ?? this.episodeKey,
      localPath: localPath ?? this.localPath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      courseLabel: courseLabel ?? this.courseLabel,
      title: title ?? this.title,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (episodeKey.present) {
      map['episode_key'] = Variable<String>(episodeKey.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<double>(durationSeconds.value);
    }
    if (courseLabel.present) {
      map['course_label'] = Variable<String>(courseLabel.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (downloadedAt.present) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyPodcastDownloadsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('episodeKey: $episodeKey, ')
          ..write('localPath: $localPath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('courseLabel: $courseLabel, ')
          ..write('title: $title, ')
          ..write('downloadedAt: $downloadedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyPlaybackPositionsTable extends StudyPlaybackPositions
    with TableInfo<$StudyPlaybackPositionsTable, StudyPlaybackPosition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPlaybackPositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeKeyMeta = const VerificationMeta(
    'episodeKey',
  );
  @override
  late final GeneratedColumn<String> episodeKey = GeneratedColumn<String>(
    'episode_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMillisecondsMeta =
      const VerificationMeta('positionMilliseconds');
  @override
  late final GeneratedColumn<int> positionMilliseconds = GeneratedColumn<int>(
    'position_milliseconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
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
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    noteId,
    episodeKey,
    positionMilliseconds,
    speed,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_playback_positions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPlaybackPosition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('episode_key')) {
      context.handle(
        _episodeKeyMeta,
        episodeKey.isAcceptableOrUnknown(data['episode_key']!, _episodeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_episodeKeyMeta);
    }
    if (data.containsKey('position_milliseconds')) {
      context.handle(
        _positionMillisecondsMeta,
        positionMilliseconds.isAcceptableOrUnknown(
          data['position_milliseconds']!,
          _positionMillisecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_positionMillisecondsMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    environment,
    accountId,
    noteId,
    episodeKey,
  };
  @override
  StudyPlaybackPosition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPlaybackPosition(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      episodeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_key'],
      )!,
      positionMilliseconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position_milliseconds'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudyPlaybackPositionsTable createAlias(String alias) {
    return $StudyPlaybackPositionsTable(attachedDatabase, alias);
  }
}

class StudyPlaybackPosition extends DataClass
    implements Insertable<StudyPlaybackPosition> {
  final String environment;
  final String accountId;
  final int noteId;
  final String episodeKey;
  final int positionMilliseconds;
  final double speed;
  final DateTime updatedAt;
  const StudyPlaybackPosition({
    required this.environment,
    required this.accountId,
    required this.noteId,
    required this.episodeKey,
    required this.positionMilliseconds,
    required this.speed,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['note_id'] = Variable<int>(noteId);
    map['episode_key'] = Variable<String>(episodeKey);
    map['position_milliseconds'] = Variable<int>(positionMilliseconds);
    map['speed'] = Variable<double>(speed);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudyPlaybackPositionsCompanion toCompanion(bool nullToAbsent) {
    return StudyPlaybackPositionsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      noteId: Value(noteId),
      episodeKey: Value(episodeKey),
      positionMilliseconds: Value(positionMilliseconds),
      speed: Value(speed),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudyPlaybackPosition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPlaybackPosition(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      episodeKey: serializer.fromJson<String>(json['episodeKey']),
      positionMilliseconds: serializer.fromJson<int>(
        json['positionMilliseconds'],
      ),
      speed: serializer.fromJson<double>(json['speed']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'noteId': serializer.toJson<int>(noteId),
      'episodeKey': serializer.toJson<String>(episodeKey),
      'positionMilliseconds': serializer.toJson<int>(positionMilliseconds),
      'speed': serializer.toJson<double>(speed),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudyPlaybackPosition copyWith({
    String? environment,
    String? accountId,
    int? noteId,
    String? episodeKey,
    int? positionMilliseconds,
    double? speed,
    DateTime? updatedAt,
  }) => StudyPlaybackPosition(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    noteId: noteId ?? this.noteId,
    episodeKey: episodeKey ?? this.episodeKey,
    positionMilliseconds: positionMilliseconds ?? this.positionMilliseconds,
    speed: speed ?? this.speed,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudyPlaybackPosition copyWithCompanion(
    StudyPlaybackPositionsCompanion data,
  ) {
    return StudyPlaybackPosition(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      episodeKey: data.episodeKey.present
          ? data.episodeKey.value
          : this.episodeKey,
      positionMilliseconds: data.positionMilliseconds.present
          ? data.positionMilliseconds.value
          : this.positionMilliseconds,
      speed: data.speed.present ? data.speed.value : this.speed,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlaybackPosition(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('episodeKey: $episodeKey, ')
          ..write('positionMilliseconds: $positionMilliseconds, ')
          ..write('speed: $speed, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environment,
    accountId,
    noteId,
    episodeKey,
    positionMilliseconds,
    speed,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPlaybackPosition &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.noteId == this.noteId &&
          other.episodeKey == this.episodeKey &&
          other.positionMilliseconds == this.positionMilliseconds &&
          other.speed == this.speed &&
          other.updatedAt == this.updatedAt);
}

class StudyPlaybackPositionsCompanion
    extends UpdateCompanion<StudyPlaybackPosition> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<int> noteId;
  final Value<String> episodeKey;
  final Value<int> positionMilliseconds;
  final Value<double> speed;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StudyPlaybackPositionsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.episodeKey = const Value.absent(),
    this.positionMilliseconds = const Value.absent(),
    this.speed = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyPlaybackPositionsCompanion.insert({
    required String environment,
    required String accountId,
    required int noteId,
    required String episodeKey,
    required int positionMilliseconds,
    this.speed = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       noteId = Value(noteId),
       episodeKey = Value(episodeKey),
       positionMilliseconds = Value(positionMilliseconds),
       updatedAt = Value(updatedAt);
  static Insertable<StudyPlaybackPosition> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<int>? noteId,
    Expression<String>? episodeKey,
    Expression<int>? positionMilliseconds,
    Expression<double>? speed,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (noteId != null) 'note_id': noteId,
      if (episodeKey != null) 'episode_key': episodeKey,
      if (positionMilliseconds != null)
        'position_milliseconds': positionMilliseconds,
      if (speed != null) 'speed': speed,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyPlaybackPositionsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<int>? noteId,
    Value<String>? episodeKey,
    Value<int>? positionMilliseconds,
    Value<double>? speed,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StudyPlaybackPositionsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      noteId: noteId ?? this.noteId,
      episodeKey: episodeKey ?? this.episodeKey,
      positionMilliseconds: positionMilliseconds ?? this.positionMilliseconds,
      speed: speed ?? this.speed,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (episodeKey.present) {
      map['episode_key'] = Variable<String>(episodeKey.value);
    }
    if (positionMilliseconds.present) {
      map['position_milliseconds'] = Variable<int>(positionMilliseconds.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlaybackPositionsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('noteId: $noteId, ')
          ..write('episodeKey: $episodeKey, ')
          ..write('positionMilliseconds: $positionMilliseconds, ')
          ..write('speed: $speed, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyOfflineEntitlementSnapshotsTable
    extends StudyOfflineEntitlementSnapshots
    with
        TableInfo<
          $StudyOfflineEntitlementSnapshotsTable,
          StudyOfflineEntitlementSnapshot
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyOfflineEntitlementSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPeriodStartMeta =
      const VerificationMeta('currentPeriodStart');
  @override
  late final GeneratedColumn<DateTime> currentPeriodStart =
      GeneratedColumn<DateTime>(
        'current_period_start',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _currentPeriodEndMeta = const VerificationMeta(
    'currentPeriodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> currentPeriodEnd =
      GeneratedColumn<DateTime>(
        'current_period_end',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _verifiedAtMeta = const VerificationMeta(
    'verifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> verifiedAt = GeneratedColumn<DateTime>(
    'verified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    state,
    currentPeriodStart,
    currentPeriodEnd,
    verifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_offline_entitlement_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyOfflineEntitlementSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('current_period_start')) {
      context.handle(
        _currentPeriodStartMeta,
        currentPeriodStart.isAcceptableOrUnknown(
          data['current_period_start']!,
          _currentPeriodStartMeta,
        ),
      );
    }
    if (data.containsKey('current_period_end')) {
      context.handle(
        _currentPeriodEndMeta,
        currentPeriodEnd.isAcceptableOrUnknown(
          data['current_period_end']!,
          _currentPeriodEndMeta,
        ),
      );
    }
    if (data.containsKey('verified_at')) {
      context.handle(
        _verifiedAtMeta,
        verifiedAt.isAcceptableOrUnknown(data['verified_at']!, _verifiedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_verifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {environment, accountId};
  @override
  StudyOfflineEntitlementSnapshot map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyOfflineEntitlementSnapshot(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      currentPeriodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_period_start'],
      ),
      currentPeriodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_period_end'],
      ),
      verifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}verified_at'],
      )!,
    );
  }

  @override
  $StudyOfflineEntitlementSnapshotsTable createAlias(String alias) {
    return $StudyOfflineEntitlementSnapshotsTable(attachedDatabase, alias);
  }
}

class StudyOfflineEntitlementSnapshot extends DataClass
    implements Insertable<StudyOfflineEntitlementSnapshot> {
  final String environment;
  final String accountId;
  final String state;
  final DateTime? currentPeriodStart;
  final DateTime? currentPeriodEnd;
  final DateTime verifiedAt;
  const StudyOfflineEntitlementSnapshot({
    required this.environment,
    required this.accountId,
    required this.state,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    required this.verifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || currentPeriodStart != null) {
      map['current_period_start'] = Variable<DateTime>(currentPeriodStart);
    }
    if (!nullToAbsent || currentPeriodEnd != null) {
      map['current_period_end'] = Variable<DateTime>(currentPeriodEnd);
    }
    map['verified_at'] = Variable<DateTime>(verifiedAt);
    return map;
  }

  StudyOfflineEntitlementSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return StudyOfflineEntitlementSnapshotsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      state: Value(state),
      currentPeriodStart: currentPeriodStart == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPeriodStart),
      currentPeriodEnd: currentPeriodEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPeriodEnd),
      verifiedAt: Value(verifiedAt),
    );
  }

  factory StudyOfflineEntitlementSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyOfflineEntitlementSnapshot(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      state: serializer.fromJson<String>(json['state']),
      currentPeriodStart: serializer.fromJson<DateTime?>(
        json['currentPeriodStart'],
      ),
      currentPeriodEnd: serializer.fromJson<DateTime?>(
        json['currentPeriodEnd'],
      ),
      verifiedAt: serializer.fromJson<DateTime>(json['verifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'state': serializer.toJson<String>(state),
      'currentPeriodStart': serializer.toJson<DateTime?>(currentPeriodStart),
      'currentPeriodEnd': serializer.toJson<DateTime?>(currentPeriodEnd),
      'verifiedAt': serializer.toJson<DateTime>(verifiedAt),
    };
  }

  StudyOfflineEntitlementSnapshot copyWith({
    String? environment,
    String? accountId,
    String? state,
    Value<DateTime?> currentPeriodStart = const Value.absent(),
    Value<DateTime?> currentPeriodEnd = const Value.absent(),
    DateTime? verifiedAt,
  }) => StudyOfflineEntitlementSnapshot(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    state: state ?? this.state,
    currentPeriodStart: currentPeriodStart.present
        ? currentPeriodStart.value
        : this.currentPeriodStart,
    currentPeriodEnd: currentPeriodEnd.present
        ? currentPeriodEnd.value
        : this.currentPeriodEnd,
    verifiedAt: verifiedAt ?? this.verifiedAt,
  );
  StudyOfflineEntitlementSnapshot copyWithCompanion(
    StudyOfflineEntitlementSnapshotsCompanion data,
  ) {
    return StudyOfflineEntitlementSnapshot(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      state: data.state.present ? data.state.value : this.state,
      currentPeriodStart: data.currentPeriodStart.present
          ? data.currentPeriodStart.value
          : this.currentPeriodStart,
      currentPeriodEnd: data.currentPeriodEnd.present
          ? data.currentPeriodEnd.value
          : this.currentPeriodEnd,
      verifiedAt: data.verifiedAt.present
          ? data.verifiedAt.value
          : this.verifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyOfflineEntitlementSnapshot(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('state: $state, ')
          ..write('currentPeriodStart: $currentPeriodStart, ')
          ..write('currentPeriodEnd: $currentPeriodEnd, ')
          ..write('verifiedAt: $verifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environment,
    accountId,
    state,
    currentPeriodStart,
    currentPeriodEnd,
    verifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyOfflineEntitlementSnapshot &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.state == this.state &&
          other.currentPeriodStart == this.currentPeriodStart &&
          other.currentPeriodEnd == this.currentPeriodEnd &&
          other.verifiedAt == this.verifiedAt);
}

class StudyOfflineEntitlementSnapshotsCompanion
    extends UpdateCompanion<StudyOfflineEntitlementSnapshot> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<String> state;
  final Value<DateTime?> currentPeriodStart;
  final Value<DateTime?> currentPeriodEnd;
  final Value<DateTime> verifiedAt;
  final Value<int> rowid;
  const StudyOfflineEntitlementSnapshotsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.state = const Value.absent(),
    this.currentPeriodStart = const Value.absent(),
    this.currentPeriodEnd = const Value.absent(),
    this.verifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyOfflineEntitlementSnapshotsCompanion.insert({
    required String environment,
    required String accountId,
    required String state,
    this.currentPeriodStart = const Value.absent(),
    this.currentPeriodEnd = const Value.absent(),
    required DateTime verifiedAt,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       state = Value(state),
       verifiedAt = Value(verifiedAt);
  static Insertable<StudyOfflineEntitlementSnapshot> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<String>? state,
    Expression<DateTime>? currentPeriodStart,
    Expression<DateTime>? currentPeriodEnd,
    Expression<DateTime>? verifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (state != null) 'state': state,
      if (currentPeriodStart != null)
        'current_period_start': currentPeriodStart,
      if (currentPeriodEnd != null) 'current_period_end': currentPeriodEnd,
      if (verifiedAt != null) 'verified_at': verifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyOfflineEntitlementSnapshotsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<String>? state,
    Value<DateTime?>? currentPeriodStart,
    Value<DateTime?>? currentPeriodEnd,
    Value<DateTime>? verifiedAt,
    Value<int>? rowid,
  }) {
    return StudyOfflineEntitlementSnapshotsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      state: state ?? this.state,
      currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
      currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (currentPeriodStart.present) {
      map['current_period_start'] = Variable<DateTime>(
        currentPeriodStart.value,
      );
    }
    if (currentPeriodEnd.present) {
      map['current_period_end'] = Variable<DateTime>(currentPeriodEnd.value);
    }
    if (verifiedAt.present) {
      map['verified_at'] = Variable<DateTime>(verifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyOfflineEntitlementSnapshotsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('state: $state, ')
          ..write('currentPeriodStart: $currentPeriodStart, ')
          ..write('currentPeriodEnd: $currentPeriodEnd, ')
          ..write('verifiedAt: $verifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyLegacyImportsTable extends StudyLegacyImports
    with TableInfo<$StudyLegacyImportsTable, StudyLegacyImport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyLegacyImportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentMeta = const VerificationMeta(
    'environment',
  );
  @override
  late final GeneratedColumn<String> environment = GeneratedColumn<String>(
    'environment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _legacyKeysJsonMeta = const VerificationMeta(
    'legacyKeysJson',
  );
  @override
  late final GeneratedColumn<String> legacyKeysJson = GeneratedColumn<String>(
    'legacy_keys_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environment,
    accountId,
    legacyKeysJson,
    importedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_legacy_imports';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyLegacyImport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment')) {
      context.handle(
        _environmentMeta,
        environment.isAcceptableOrUnknown(
          data['environment']!,
          _environmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('legacy_keys_json')) {
      context.handle(
        _legacyKeysJsonMeta,
        legacyKeysJson.isAcceptableOrUnknown(
          data['legacy_keys_json']!,
          _legacyKeysJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_legacyKeysJsonMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {environment, accountId};
  @override
  StudyLegacyImport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyLegacyImport(
      environment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      legacyKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legacy_keys_json'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
    );
  }

  @override
  $StudyLegacyImportsTable createAlias(String alias) {
    return $StudyLegacyImportsTable(attachedDatabase, alias);
  }
}

class StudyLegacyImport extends DataClass
    implements Insertable<StudyLegacyImport> {
  final String environment;
  final String accountId;
  final String legacyKeysJson;
  final DateTime importedAt;
  const StudyLegacyImport({
    required this.environment,
    required this.accountId,
    required this.legacyKeysJson,
    required this.importedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment'] = Variable<String>(environment);
    map['account_id'] = Variable<String>(accountId);
    map['legacy_keys_json'] = Variable<String>(legacyKeysJson);
    map['imported_at'] = Variable<DateTime>(importedAt);
    return map;
  }

  StudyLegacyImportsCompanion toCompanion(bool nullToAbsent) {
    return StudyLegacyImportsCompanion(
      environment: Value(environment),
      accountId: Value(accountId),
      legacyKeysJson: Value(legacyKeysJson),
      importedAt: Value(importedAt),
    );
  }

  factory StudyLegacyImport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyLegacyImport(
      environment: serializer.fromJson<String>(json['environment']),
      accountId: serializer.fromJson<String>(json['accountId']),
      legacyKeysJson: serializer.fromJson<String>(json['legacyKeysJson']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environment': serializer.toJson<String>(environment),
      'accountId': serializer.toJson<String>(accountId),
      'legacyKeysJson': serializer.toJson<String>(legacyKeysJson),
      'importedAt': serializer.toJson<DateTime>(importedAt),
    };
  }

  StudyLegacyImport copyWith({
    String? environment,
    String? accountId,
    String? legacyKeysJson,
    DateTime? importedAt,
  }) => StudyLegacyImport(
    environment: environment ?? this.environment,
    accountId: accountId ?? this.accountId,
    legacyKeysJson: legacyKeysJson ?? this.legacyKeysJson,
    importedAt: importedAt ?? this.importedAt,
  );
  StudyLegacyImport copyWithCompanion(StudyLegacyImportsCompanion data) {
    return StudyLegacyImport(
      environment: data.environment.present
          ? data.environment.value
          : this.environment,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      legacyKeysJson: data.legacyKeysJson.present
          ? data.legacyKeysJson.value
          : this.legacyKeysJson,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyLegacyImport(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('legacyKeysJson: $legacyKeysJson, ')
          ..write('importedAt: $importedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(environment, accountId, legacyKeysJson, importedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyLegacyImport &&
          other.environment == this.environment &&
          other.accountId == this.accountId &&
          other.legacyKeysJson == this.legacyKeysJson &&
          other.importedAt == this.importedAt);
}

class StudyLegacyImportsCompanion extends UpdateCompanion<StudyLegacyImport> {
  final Value<String> environment;
  final Value<String> accountId;
  final Value<String> legacyKeysJson;
  final Value<DateTime> importedAt;
  final Value<int> rowid;
  const StudyLegacyImportsCompanion({
    this.environment = const Value.absent(),
    this.accountId = const Value.absent(),
    this.legacyKeysJson = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyLegacyImportsCompanion.insert({
    required String environment,
    required String accountId,
    required String legacyKeysJson,
    required DateTime importedAt,
    this.rowid = const Value.absent(),
  }) : environment = Value(environment),
       accountId = Value(accountId),
       legacyKeysJson = Value(legacyKeysJson),
       importedAt = Value(importedAt);
  static Insertable<StudyLegacyImport> custom({
    Expression<String>? environment,
    Expression<String>? accountId,
    Expression<String>? legacyKeysJson,
    Expression<DateTime>? importedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environment != null) 'environment': environment,
      if (accountId != null) 'account_id': accountId,
      if (legacyKeysJson != null) 'legacy_keys_json': legacyKeysJson,
      if (importedAt != null) 'imported_at': importedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyLegacyImportsCompanion copyWith({
    Value<String>? environment,
    Value<String>? accountId,
    Value<String>? legacyKeysJson,
    Value<DateTime>? importedAt,
    Value<int>? rowid,
  }) {
    return StudyLegacyImportsCompanion(
      environment: environment ?? this.environment,
      accountId: accountId ?? this.accountId,
      legacyKeysJson: legacyKeysJson ?? this.legacyKeysJson,
      importedAt: importedAt ?? this.importedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environment.present) {
      map['environment'] = Variable<String>(environment.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (legacyKeysJson.present) {
      map['legacy_keys_json'] = Variable<String>(legacyKeysJson.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyLegacyImportsCompanion(')
          ..write('environment: $environment, ')
          ..write('accountId: $accountId, ')
          ..write('legacyKeysJson: $legacyKeysJson, ')
          ..write('importedAt: $importedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabaseV2 extends GeneratedDatabase {
  _$AppDatabaseV2(QueryExecutor e) : super(e);
  $AppDatabaseV2Manager get managers => $AppDatabaseV2Manager(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $BillingOrdersTable billingOrders = $BillingOrdersTable(this);
  late final $BillingOrderItemsTable billingOrderItems =
      $BillingOrderItemsTable(this);
  late final $BillingSubscriptionsTable billingSubscriptions =
      $BillingSubscriptionsTable(this);
  late final $BillingSubscriptionStatusesTable billingSubscriptionStatuses =
      $BillingSubscriptionStatusesTable(this);
  late final $BillingEntitlementsTable billingEntitlements =
      $BillingEntitlementsTable(this);
  late final $LockInRuleRecordsTable lockInRuleRecords =
      $LockInRuleRecordsTable(this);
  late final $LockInAttemptsTable lockInAttempts = $LockInAttemptsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $LecturersTable lecturers = $LecturersTable(this);
  late final $ScheduleEntriesTable scheduleEntries = $ScheduleEntriesTable(
    this,
  );
  late final $TodoListsTable todoLists = $TodoListsTable(this);
  late final $TodoTagItemsTable todoTagItems = $TodoTagItemsTable(this);
  late final $TodoItemsTable todoItems = $TodoItemsTable(this);
  late final $TodoItemTagsTable todoItemTags = $TodoItemTagsTable(this);
  late final $StudyMaterialRecordsTable studyMaterialRecords =
      $StudyMaterialRecordsTable(this);
  late final $StudyQuestionSetRecordsTable studyQuestionSetRecords =
      $StudyQuestionSetRecordsTable(this);
  late final $StudyGenerationJobRecordsTable studyGenerationJobRecords =
      $StudyGenerationJobRecordsTable(this);
  late final $StudyPodcastRecordsTable studyPodcastRecords =
      $StudyPodcastRecordsTable(this);
  late final $StudyPodcastDownloadsTable studyPodcastDownloads =
      $StudyPodcastDownloadsTable(this);
  late final $StudyPlaybackPositionsTable studyPlaybackPositions =
      $StudyPlaybackPositionsTable(this);
  late final $StudyOfflineEntitlementSnapshotsTable
  studyOfflineEntitlementSnapshots = $StudyOfflineEntitlementSnapshotsTable(
    this,
  );
  late final $StudyLegacyImportsTable studyLegacyImports =
      $StudyLegacyImportsTable(this);
  late final PlanDao planDao = PlanDao(this as AppDatabaseV2);
  late final OrderDao orderDao = OrderDao(this as AppDatabaseV2);
  late final SubscriptionDao subscriptionDao = SubscriptionDao(
    this as AppDatabaseV2,
  );
  late final EntitlementDao entitlementDao = EntitlementDao(
    this as AppDatabaseV2,
  );
  late final LockInDao lockInDao = LockInDao(this as AppDatabaseV2);
  late final CourseDao courseDao = CourseDao(this as AppDatabaseV2);
  late final TodoListDao todoListDao = TodoListDao(this as AppDatabaseV2);
  late final TodoTagDao todoTagDao = TodoTagDao(this as AppDatabaseV2);
  late final TodoItemDao todoItemDao = TodoItemDao(this as AppDatabaseV2);
  late final StudyToolsDao studyToolsDao = StudyToolsDao(this as AppDatabaseV2);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    plans,
    billingOrders,
    billingOrderItems,
    billingSubscriptions,
    billingSubscriptionStatuses,
    billingEntitlements,
    lockInRuleRecords,
    lockInAttempts,
    courses,
    lecturers,
    scheduleEntries,
    todoLists,
    todoTagItems,
    todoItems,
    todoItemTags,
    studyMaterialRecords,
    studyQuestionSetRecords,
    studyGenerationJobRecords,
    studyPodcastRecords,
    studyPodcastDownloads,
    studyPlaybackPositions,
    studyOfflineEntitlementSnapshots,
    studyLegacyImports,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('schedule_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PlansTableCreateCompanionBuilder = PlansCompanion Function({
  Value<int> id,
  required bool active,
  required int billingIntervalDays,
  required String code,
  Value<DateTime> createdAt,
  required String createdBy,
  required String currency,
  required String description,
  required String name,
  required double price,
  Value<DateTime> updatedAt,
  required bool visible,
});
typedef $$PlansTableUpdateCompanionBuilder = PlansCompanion Function({
  Value<int> id,
  Value<bool> active,
  Value<int> billingIntervalDays,
  Value<String> code,
  Value<DateTime> createdAt,
  Value<String> createdBy,
  Value<String> currency,
  Value<String> description,
  Value<String> name,
  Value<double> price,
  Value<DateTime> updatedAt,
  Value<bool> visible,
});

class $$PlansTableFilterComposer
    extends Composer<_$AppDatabaseV2, $PlansTable> {
  $$PlansTableFilterComposer({
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

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingIntervalDays => $composableBuilder(
    column: $table.billingIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get visible => $composableBuilder(
    column: $table.visible,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $PlansTable> {
  $$PlansTableOrderingComposer({
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

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingIntervalDays => $composableBuilder(
    column: $table.billingIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get visible => $composableBuilder(
    column: $table.visible,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<int> get billingIntervalDays => $composableBuilder(
    column: $table.billingIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get visible =>
      $composableBuilder(column: $table.visible, builder: (column) => column);
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $PlansTable,
          Plan,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (Plan, BaseReferences<_$AppDatabaseV2, $PlansTable, Plan>),
          Plan,
          PrefetchHooks Function()
        > {
  $$PlansTableTableManager(_$AppDatabaseV2 db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> billingIntervalDays = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> visible = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                active: active,
                billingIntervalDays: billingIntervalDays,
                code: code,
                createdAt: createdAt,
                createdBy: createdBy,
                currency: currency,
                description: description,
                name: name,
                price: price,
                updatedAt: updatedAt,
                visible: visible,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool active,
                required int billingIntervalDays,
                required String code,
                Value<DateTime> createdAt = const Value.absent(),
                required String createdBy,
                required String currency,
                required String description,
                required String name,
                required double price,
                Value<DateTime> updatedAt = const Value.absent(),
                required bool visible,
              }) => PlansCompanion.insert(
                id: id,
                active: active,
                billingIntervalDays: billingIntervalDays,
                code: code,
                createdAt: createdAt,
                createdBy: createdBy,
                currency: currency,
                description: description,
                name: name,
                price: price,
                updatedAt: updatedAt,
                visible: visible,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlansTable, Plan>(table),
                  BaseReferences<_$AppDatabaseV2, $PlansTable, Plan>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $PlansTable,
      Plan,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (Plan, BaseReferences<_$AppDatabaseV2, $PlansTable, Plan>),
      Plan,
      PrefetchHooks Function()
    >;
typedef $$BillingOrdersTableCreateCompanionBuilder =
    BillingOrdersCompanion Function({
      required String id,
      required String currency,
      required int discount,
      Value<DateTime?> expiresAt,
      required String metadata,
      Value<DateTime?> paidAt,
      required String status,
      required int subtotal,
      required int tax,
      required int total,
      Value<String?> userId,
      Value<DateTime?> cancelledAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BillingOrdersTableUpdateCompanionBuilder =
    BillingOrdersCompanion Function({
      Value<String> id,
      Value<String> currency,
      Value<int> discount,
      Value<DateTime?> expiresAt,
      Value<String> metadata,
      Value<DateTime?> paidAt,
      Value<String> status,
      Value<int> subtotal,
      Value<int> tax,
      Value<int> total,
      Value<String?> userId,
      Value<DateTime?> cancelledAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BillingOrdersTableFilterComposer
    extends Composer<_$AppDatabaseV2, $BillingOrdersTable> {
  $$BillingOrdersTableFilterComposer({
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

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
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

class $$BillingOrdersTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $BillingOrdersTable> {
  $$BillingOrdersTableOrderingComposer({
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

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
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

class $$BillingOrdersTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $BillingOrdersTable> {
  $$BillingOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BillingOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $BillingOrdersTable,
          BillingOrder,
          $$BillingOrdersTableFilterComposer,
          $$BillingOrdersTableOrderingComposer,
          $$BillingOrdersTableAnnotationComposer,
          $$BillingOrdersTableCreateCompanionBuilder,
          $$BillingOrdersTableUpdateCompanionBuilder,
          (
            BillingOrder,
            BaseReferences<_$AppDatabaseV2, $BillingOrdersTable, BillingOrder>,
          ),
          BillingOrder,
          PrefetchHooks Function()
        > {
  $$BillingOrdersTableTableManager(
    _$AppDatabaseV2 db,
    $BillingOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillingOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> discount = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> tax = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillingOrdersCompanion(
                id: id,
                currency: currency,
                discount: discount,
                expiresAt: expiresAt,
                metadata: metadata,
                paidAt: paidAt,
                status: status,
                subtotal: subtotal,
                tax: tax,
                total: total,
                userId: userId,
                cancelledAt: cancelledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String currency,
                required int discount,
                Value<DateTime?> expiresAt = const Value.absent(),
                required String metadata,
                Value<DateTime?> paidAt = const Value.absent(),
                required String status,
                required int subtotal,
                required int tax,
                required int total,
                Value<String?> userId = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BillingOrdersCompanion.insert(
                id: id,
                currency: currency,
                discount: discount,
                expiresAt: expiresAt,
                metadata: metadata,
                paidAt: paidAt,
                status: status,
                subtotal: subtotal,
                tax: tax,
                total: total,
                userId: userId,
                cancelledAt: cancelledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillingOrdersTable, BillingOrder>(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $BillingOrdersTable,
                    BillingOrder
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillingOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $BillingOrdersTable,
      BillingOrder,
      $$BillingOrdersTableFilterComposer,
      $$BillingOrdersTableOrderingComposer,
      $$BillingOrdersTableAnnotationComposer,
      $$BillingOrdersTableCreateCompanionBuilder,
      $$BillingOrdersTableUpdateCompanionBuilder,
      (
        BillingOrder,
        BaseReferences<_$AppDatabaseV2, $BillingOrdersTable, BillingOrder>,
      ),
      BillingOrder,
      PrefetchHooks Function()
    >;
typedef $$BillingOrderItemsTableCreateCompanionBuilder =
    BillingOrderItemsCompanion Function({
      required String id,
      required String orderId,
      required int planId,
      required int quantity,
      required int unitPrice,
      required int discount,
      required int tax,
      required String addedBy,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BillingOrderItemsTableUpdateCompanionBuilder =
    BillingOrderItemsCompanion Function({
      Value<String> id,
      Value<String> orderId,
      Value<int> planId,
      Value<int> quantity,
      Value<int> unitPrice,
      Value<int> discount,
      Value<int> tax,
      Value<String> addedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BillingOrderItemsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $BillingOrderItemsTable> {
  $$BillingOrderItemsTableFilterComposer({
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

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addedBy => $composableBuilder(
    column: $table.addedBy,
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

class $$BillingOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $BillingOrderItemsTable> {
  $$BillingOrderItemsTableOrderingComposer({
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

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addedBy => $composableBuilder(
    column: $table.addedBy,
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

class $$BillingOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $BillingOrderItemsTable> {
  $$BillingOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<int> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<String> get addedBy =>
      $composableBuilder(column: $table.addedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BillingOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $BillingOrderItemsTable,
          BillingOrderItem,
          $$BillingOrderItemsTableFilterComposer,
          $$BillingOrderItemsTableOrderingComposer,
          $$BillingOrderItemsTableAnnotationComposer,
          $$BillingOrderItemsTableCreateCompanionBuilder,
          $$BillingOrderItemsTableUpdateCompanionBuilder,
          (
            BillingOrderItem,
            BaseReferences<
              _$AppDatabaseV2,
              $BillingOrderItemsTable,
              BillingOrderItem
            >,
          ),
          BillingOrderItem,
          PrefetchHooks Function()
        > {
  $$BillingOrderItemsTableTableManager(
    _$AppDatabaseV2 db,
    $BillingOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillingOrderItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> unitPrice = const Value.absent(),
                Value<int> discount = const Value.absent(),
                Value<int> tax = const Value.absent(),
                Value<String> addedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillingOrderItemsCompanion(
                id: id,
                orderId: orderId,
                planId: planId,
                quantity: quantity,
                unitPrice: unitPrice,
                discount: discount,
                tax: tax,
                addedBy: addedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String orderId,
                required int planId,
                required int quantity,
                required int unitPrice,
                required int discount,
                required int tax,
                required String addedBy,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BillingOrderItemsCompanion.insert(
                id: id,
                orderId: orderId,
                planId: planId,
                quantity: quantity,
                unitPrice: unitPrice,
                discount: discount,
                tax: tax,
                addedBy: addedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillingOrderItemsTable, BillingOrderItem>(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $BillingOrderItemsTable,
                    BillingOrderItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillingOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $BillingOrderItemsTable,
      BillingOrderItem,
      $$BillingOrderItemsTableFilterComposer,
      $$BillingOrderItemsTableOrderingComposer,
      $$BillingOrderItemsTableAnnotationComposer,
      $$BillingOrderItemsTableCreateCompanionBuilder,
      $$BillingOrderItemsTableUpdateCompanionBuilder,
      (
        BillingOrderItem,
        BaseReferences<
          _$AppDatabaseV2,
          $BillingOrderItemsTable,
          BillingOrderItem
        >,
      ),
      BillingOrderItem,
      PrefetchHooks Function()
    >;
typedef $$BillingSubscriptionsTableCreateCompanionBuilder =
    BillingSubscriptionsCompanion Function({
      Value<int> id,
      required String planCode,
      required int planId,
      required String planName,
      required String status,
      required bool cancelAtPeriodEnd,
      Value<DateTime?> cancelledAt,
      required DateTime currentPeriodEnd,
      required DateTime currentPeriodStart,
      required DateTime startedAt,
    });
typedef $$BillingSubscriptionsTableUpdateCompanionBuilder =
    BillingSubscriptionsCompanion Function({
      Value<int> id,
      Value<String> planCode,
      Value<int> planId,
      Value<String> planName,
      Value<String> status,
      Value<bool> cancelAtPeriodEnd,
      Value<DateTime?> cancelledAt,
      Value<DateTime> currentPeriodEnd,
      Value<DateTime> currentPeriodStart,
      Value<DateTime> startedAt,
    });

class $$BillingSubscriptionsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $BillingSubscriptionsTable> {
  $$BillingSubscriptionsTableFilterComposer({
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

  ColumnFilters<String> get planCode => $composableBuilder(
    column: $table.planCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planName => $composableBuilder(
    column: $table.planName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cancelAtPeriodEnd => $composableBuilder(
    column: $table.cancelAtPeriodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillingSubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $BillingSubscriptionsTable> {
  $$BillingSubscriptionsTableOrderingComposer({
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

  ColumnOrderings<String> get planCode => $composableBuilder(
    column: $table.planCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planName => $composableBuilder(
    column: $table.planName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cancelAtPeriodEnd => $composableBuilder(
    column: $table.cancelAtPeriodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillingSubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $BillingSubscriptionsTable> {
  $$BillingSubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planCode =>
      $composableBuilder(column: $table.planCode, builder: (column) => column);

  GeneratedColumn<int> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get planName =>
      $composableBuilder(column: $table.planName, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get cancelAtPeriodEnd => $composableBuilder(
    column: $table.cancelAtPeriodEnd,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);
}

class $$BillingSubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $BillingSubscriptionsTable,
          BillingSubscription,
          $$BillingSubscriptionsTableFilterComposer,
          $$BillingSubscriptionsTableOrderingComposer,
          $$BillingSubscriptionsTableAnnotationComposer,
          $$BillingSubscriptionsTableCreateCompanionBuilder,
          $$BillingSubscriptionsTableUpdateCompanionBuilder,
          (
            BillingSubscription,
            BaseReferences<
              _$AppDatabaseV2,
              $BillingSubscriptionsTable,
              BillingSubscription
            >,
          ),
          BillingSubscription,
          PrefetchHooks Function()
        > {
  $$BillingSubscriptionsTableTableManager(
    _$AppDatabaseV2 db,
    $BillingSubscriptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingSubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingSubscriptionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BillingSubscriptionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> planCode = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<String> planName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> cancelAtPeriodEnd = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<DateTime> currentPeriodEnd = const Value.absent(),
                Value<DateTime> currentPeriodStart = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
              }) => BillingSubscriptionsCompanion(
                id: id,
                planCode: planCode,
                planId: planId,
                planName: planName,
                status: status,
                cancelAtPeriodEnd: cancelAtPeriodEnd,
                cancelledAt: cancelledAt,
                currentPeriodEnd: currentPeriodEnd,
                currentPeriodStart: currentPeriodStart,
                startedAt: startedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String planCode,
                required int planId,
                required String planName,
                required String status,
                required bool cancelAtPeriodEnd,
                Value<DateTime?> cancelledAt = const Value.absent(),
                required DateTime currentPeriodEnd,
                required DateTime currentPeriodStart,
                required DateTime startedAt,
              }) => BillingSubscriptionsCompanion.insert(
                id: id,
                planCode: planCode,
                planId: planId,
                planName: planName,
                status: status,
                cancelAtPeriodEnd: cancelAtPeriodEnd,
                cancelledAt: cancelledAt,
                currentPeriodEnd: currentPeriodEnd,
                currentPeriodStart: currentPeriodStart,
                startedAt: startedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillingSubscriptionsTable, BillingSubscription>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $BillingSubscriptionsTable,
                    BillingSubscription
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillingSubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $BillingSubscriptionsTable,
      BillingSubscription,
      $$BillingSubscriptionsTableFilterComposer,
      $$BillingSubscriptionsTableOrderingComposer,
      $$BillingSubscriptionsTableAnnotationComposer,
      $$BillingSubscriptionsTableCreateCompanionBuilder,
      $$BillingSubscriptionsTableUpdateCompanionBuilder,
      (
        BillingSubscription,
        BaseReferences<
          _$AppDatabaseV2,
          $BillingSubscriptionsTable,
          BillingSubscription
        >,
      ),
      BillingSubscription,
      PrefetchHooks Function()
    >;
typedef $$BillingSubscriptionStatusesTableCreateCompanionBuilder =
    BillingSubscriptionStatusesCompanion Function({
      Value<int> id,
      required bool active,
      Value<int?> subscriptionId,
      required DateTime updatedAt,
    });
typedef $$BillingSubscriptionStatusesTableUpdateCompanionBuilder =
    BillingSubscriptionStatusesCompanion Function({
      Value<int> id,
      Value<bool> active,
      Value<int?> subscriptionId,
      Value<DateTime> updatedAt,
    });

class $$BillingSubscriptionStatusesTableFilterComposer
    extends Composer<_$AppDatabaseV2, $BillingSubscriptionStatusesTable> {
  $$BillingSubscriptionStatusesTableFilterComposer({
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

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillingSubscriptionStatusesTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $BillingSubscriptionStatusesTable> {
  $$BillingSubscriptionStatusesTableOrderingComposer({
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

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillingSubscriptionStatusesTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $BillingSubscriptionStatusesTable> {
  $$BillingSubscriptionStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<int> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BillingSubscriptionStatusesTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $BillingSubscriptionStatusesTable,
          BillingSubscriptionStatuse,
          $$BillingSubscriptionStatusesTableFilterComposer,
          $$BillingSubscriptionStatusesTableOrderingComposer,
          $$BillingSubscriptionStatusesTableAnnotationComposer,
          $$BillingSubscriptionStatusesTableCreateCompanionBuilder,
          $$BillingSubscriptionStatusesTableUpdateCompanionBuilder,
          (
            BillingSubscriptionStatuse,
            BaseReferences<
              _$AppDatabaseV2,
              $BillingSubscriptionStatusesTable,
              BillingSubscriptionStatuse
            >,
          ),
          BillingSubscriptionStatuse,
          PrefetchHooks Function()
        > {
  $$BillingSubscriptionStatusesTableTableManager(
    _$AppDatabaseV2 db,
    $BillingSubscriptionStatusesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingSubscriptionStatusesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BillingSubscriptionStatusesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BillingSubscriptionStatusesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int?> subscriptionId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BillingSubscriptionStatusesCompanion(
                id: id,
                active: active,
                subscriptionId: subscriptionId,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool active,
                Value<int?> subscriptionId = const Value.absent(),
                required DateTime updatedAt,
              }) => BillingSubscriptionStatusesCompanion.insert(
                id: id,
                active: active,
                subscriptionId: subscriptionId,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $BillingSubscriptionStatusesTable,
                    BillingSubscriptionStatuse
                  >(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $BillingSubscriptionStatusesTable,
                    BillingSubscriptionStatuse
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillingSubscriptionStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $BillingSubscriptionStatusesTable,
      BillingSubscriptionStatuse,
      $$BillingSubscriptionStatusesTableFilterComposer,
      $$BillingSubscriptionStatusesTableOrderingComposer,
      $$BillingSubscriptionStatusesTableAnnotationComposer,
      $$BillingSubscriptionStatusesTableCreateCompanionBuilder,
      $$BillingSubscriptionStatusesTableUpdateCompanionBuilder,
      (
        BillingSubscriptionStatuse,
        BaseReferences<
          _$AppDatabaseV2,
          $BillingSubscriptionStatusesTable,
          BillingSubscriptionStatuse
        >,
      ),
      BillingSubscriptionStatuse,
      PrefetchHooks Function()
    >;
typedef $$BillingEntitlementsTableCreateCompanionBuilder =
    BillingEntitlementsCompanion Function({
      required String planCode,
      required String key,
      Value<String?> description,
      required String unit,
      required int value,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BillingEntitlementsTableUpdateCompanionBuilder =
    BillingEntitlementsCompanion Function({
      Value<String> planCode,
      Value<String> key,
      Value<String?> description,
      Value<String> unit,
      Value<int> value,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BillingEntitlementsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $BillingEntitlementsTable> {
  $$BillingEntitlementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get planCode => $composableBuilder(
    column: $table.planCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
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

class $$BillingEntitlementsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $BillingEntitlementsTable> {
  $$BillingEntitlementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get planCode => $composableBuilder(
    column: $table.planCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
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

class $$BillingEntitlementsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $BillingEntitlementsTable> {
  $$BillingEntitlementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get planCode =>
      $composableBuilder(column: $table.planCode, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BillingEntitlementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $BillingEntitlementsTable,
          BillingEntitlement,
          $$BillingEntitlementsTableFilterComposer,
          $$BillingEntitlementsTableOrderingComposer,
          $$BillingEntitlementsTableAnnotationComposer,
          $$BillingEntitlementsTableCreateCompanionBuilder,
          $$BillingEntitlementsTableUpdateCompanionBuilder,
          (
            BillingEntitlement,
            BaseReferences<
              _$AppDatabaseV2,
              $BillingEntitlementsTable,
              BillingEntitlement
            >,
          ),
          BillingEntitlement,
          PrefetchHooks Function()
        > {
  $$BillingEntitlementsTableTableManager(
    _$AppDatabaseV2 db,
    $BillingEntitlementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingEntitlementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingEntitlementsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BillingEntitlementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> planCode = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillingEntitlementsCompanion(
                planCode: planCode,
                key: key,
                description: description,
                unit: unit,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String planCode,
                required String key,
                Value<String?> description = const Value.absent(),
                required String unit,
                required int value,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BillingEntitlementsCompanion.insert(
                planCode: planCode,
                key: key,
                description: description,
                unit: unit,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillingEntitlementsTable, BillingEntitlement>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $BillingEntitlementsTable,
                    BillingEntitlement
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillingEntitlementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $BillingEntitlementsTable,
      BillingEntitlement,
      $$BillingEntitlementsTableFilterComposer,
      $$BillingEntitlementsTableOrderingComposer,
      $$BillingEntitlementsTableAnnotationComposer,
      $$BillingEntitlementsTableCreateCompanionBuilder,
      $$BillingEntitlementsTableUpdateCompanionBuilder,
      (
        BillingEntitlement,
        BaseReferences<
          _$AppDatabaseV2,
          $BillingEntitlementsTable,
          BillingEntitlement
        >,
      ),
      BillingEntitlement,
      PrefetchHooks Function()
    >;
typedef $$LockInRuleRecordsTableCreateCompanionBuilder =
    LockInRuleRecordsCompanion Function({
      required String id,
      required String name,
      required String appsJson,
      required String weekdaysJson,
      required int startMinutes,
      required int endMinutes,
      required bool enabled,
      Value<int> rowid,
    });
typedef $$LockInRuleRecordsTableUpdateCompanionBuilder =
    LockInRuleRecordsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> appsJson,
      Value<String> weekdaysJson,
      Value<int> startMinutes,
      Value<int> endMinutes,
      Value<bool> enabled,
      Value<int> rowid,
    });

class $$LockInRuleRecordsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $LockInRuleRecordsTable> {
  $$LockInRuleRecordsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appsJson => $composableBuilder(
    column: $table.appsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdaysJson => $composableBuilder(
    column: $table.weekdaysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LockInRuleRecordsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $LockInRuleRecordsTable> {
  $$LockInRuleRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appsJson => $composableBuilder(
    column: $table.appsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdaysJson => $composableBuilder(
    column: $table.weekdaysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LockInRuleRecordsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $LockInRuleRecordsTable> {
  $$LockInRuleRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get appsJson =>
      $composableBuilder(column: $table.appsJson, builder: (column) => column);

  GeneratedColumn<String> get weekdaysJson => $composableBuilder(
    column: $table.weekdaysJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$LockInRuleRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $LockInRuleRecordsTable,
          LockInRuleRecord,
          $$LockInRuleRecordsTableFilterComposer,
          $$LockInRuleRecordsTableOrderingComposer,
          $$LockInRuleRecordsTableAnnotationComposer,
          $$LockInRuleRecordsTableCreateCompanionBuilder,
          $$LockInRuleRecordsTableUpdateCompanionBuilder,
          (
            LockInRuleRecord,
            BaseReferences<
              _$AppDatabaseV2,
              $LockInRuleRecordsTable,
              LockInRuleRecord
            >,
          ),
          LockInRuleRecord,
          PrefetchHooks Function()
        > {
  $$LockInRuleRecordsTableTableManager(
    _$AppDatabaseV2 db,
    $LockInRuleRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LockInRuleRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LockInRuleRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LockInRuleRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> appsJson = const Value.absent(),
                Value<String> weekdaysJson = const Value.absent(),
                Value<int> startMinutes = const Value.absent(),
                Value<int> endMinutes = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LockInRuleRecordsCompanion(
                id: id,
                name: name,
                appsJson: appsJson,
                weekdaysJson: weekdaysJson,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String appsJson,
                required String weekdaysJson,
                required int startMinutes,
                required int endMinutes,
                required bool enabled,
                Value<int> rowid = const Value.absent(),
              }) => LockInRuleRecordsCompanion.insert(
                id: id,
                name: name,
                appsJson: appsJson,
                weekdaysJson: weekdaysJson,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LockInRuleRecordsTable, LockInRuleRecord>(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $LockInRuleRecordsTable,
                    LockInRuleRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LockInRuleRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $LockInRuleRecordsTable,
      LockInRuleRecord,
      $$LockInRuleRecordsTableFilterComposer,
      $$LockInRuleRecordsTableOrderingComposer,
      $$LockInRuleRecordsTableAnnotationComposer,
      $$LockInRuleRecordsTableCreateCompanionBuilder,
      $$LockInRuleRecordsTableUpdateCompanionBuilder,
      (
        LockInRuleRecord,
        BaseReferences<
          _$AppDatabaseV2,
          $LockInRuleRecordsTable,
          LockInRuleRecord
        >,
      ),
      LockInRuleRecord,
      PrefetchHooks Function()
    >;
typedef $$LockInAttemptsTableCreateCompanionBuilder =
    LockInAttemptsCompanion Function({
      Value<int> id,
      required String appIdentifier,
      required String appName,
      Value<String?> ruleId,
      required DateTime occurredAt,
    });
typedef $$LockInAttemptsTableUpdateCompanionBuilder =
    LockInAttemptsCompanion Function({
      Value<int> id,
      Value<String> appIdentifier,
      Value<String> appName,
      Value<String?> ruleId,
      Value<DateTime> occurredAt,
    });

class $$LockInAttemptsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $LockInAttemptsTable> {
  $$LockInAttemptsTableFilterComposer({
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

  ColumnFilters<String> get appIdentifier => $composableBuilder(
    column: $table.appIdentifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LockInAttemptsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $LockInAttemptsTable> {
  $$LockInAttemptsTableOrderingComposer({
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

  ColumnOrderings<String> get appIdentifier => $composableBuilder(
    column: $table.appIdentifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LockInAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $LockInAttemptsTable> {
  $$LockInAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get appIdentifier => $composableBuilder(
    column: $table.appIdentifier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appName =>
      $composableBuilder(column: $table.appName, builder: (column) => column);

  GeneratedColumn<String> get ruleId =>
      $composableBuilder(column: $table.ruleId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );
}

class $$LockInAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $LockInAttemptsTable,
          LockInAttempt,
          $$LockInAttemptsTableFilterComposer,
          $$LockInAttemptsTableOrderingComposer,
          $$LockInAttemptsTableAnnotationComposer,
          $$LockInAttemptsTableCreateCompanionBuilder,
          $$LockInAttemptsTableUpdateCompanionBuilder,
          (
            LockInAttempt,
            BaseReferences<
              _$AppDatabaseV2,
              $LockInAttemptsTable,
              LockInAttempt
            >,
          ),
          LockInAttempt,
          PrefetchHooks Function()
        > {
  $$LockInAttemptsTableTableManager(
    _$AppDatabaseV2 db,
    $LockInAttemptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LockInAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LockInAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LockInAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> appIdentifier = const Value.absent(),
                Value<String> appName = const Value.absent(),
                Value<String?> ruleId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
              }) => LockInAttemptsCompanion(
                id: id,
                appIdentifier: appIdentifier,
                appName: appName,
                ruleId: ruleId,
                occurredAt: occurredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String appIdentifier,
                required String appName,
                Value<String?> ruleId = const Value.absent(),
                required DateTime occurredAt,
              }) => LockInAttemptsCompanion.insert(
                id: id,
                appIdentifier: appIdentifier,
                appName: appName,
                ruleId: ruleId,
                occurredAt: occurredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LockInAttemptsTable, LockInAttempt>(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $LockInAttemptsTable,
                    LockInAttempt
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LockInAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $LockInAttemptsTable,
      LockInAttempt,
      $$LockInAttemptsTableFilterComposer,
      $$LockInAttemptsTableOrderingComposer,
      $$LockInAttemptsTableAnnotationComposer,
      $$LockInAttemptsTableCreateCompanionBuilder,
      $$LockInAttemptsTableUpdateCompanionBuilder,
      (
        LockInAttempt,
        BaseReferences<_$AppDatabaseV2, $LockInAttemptsTable, LockInAttempt>,
      ),
      LockInAttempt,
      PrefetchHooks Function()
    >;
typedef $$CoursesTableCreateCompanionBuilder = CoursesCompanion Function({
  required String id,
  Value<String?> serverId,
  Value<String> idempotencyKey,
  Value<String> syncStatus,
  Value<String?> lastSyncError,
  required int institutionId,
  required String title,
  Value<String?> code,
  Value<String?> color,
  Value<String?> termLabel,
  Value<String?> academicYear,
  Value<DateTime?> termStartDate,
  Value<DateTime?> termEndDate,
  Value<String?> previousCourseId,
  Value<DateTime?> archivedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CoursesTableUpdateCompanionBuilder = CoursesCompanion Function({
  Value<String> id,
  Value<String?> serverId,
  Value<String> idempotencyKey,
  Value<String> syncStatus,
  Value<String?> lastSyncError,
  Value<int> institutionId,
  Value<String> title,
  Value<String?> code,
  Value<String?> color,
  Value<String?> termLabel,
  Value<String?> academicYear,
  Value<DateTime?> termStartDate,
  Value<DateTime?> termEndDate,
  Value<String?> previousCourseId,
  Value<DateTime?> archivedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

final class $$CoursesTableReferences
    extends BaseReferences<_$AppDatabaseV2, $CoursesTable, Course> {
  $$CoursesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LecturersTable, List<Lecturer>>
  _lecturersRefsTable(_$AppDatabaseV2 db) => MultiTypedResultKey.fromTable(
    db.lecturers,
    aliasName: 'courses__id__lecturers__student_course_id',
  );

  $$LecturersTableProcessedTableManager get lecturersRefs {
    final manager = $$LecturersTableTableManager($_db, $_db.lecturers).filter(
      (f) => f.studentCourseId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_lecturersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScheduleEntriesTable, List<ScheduleEntry>>
  _scheduleEntriesRefsTable(_$AppDatabaseV2 db) =>
      MultiTypedResultKey.fromTable(
        db.scheduleEntries,
        aliasName: 'courses__id__schedule_entries__student_course_id',
      );

  $$ScheduleEntriesTableProcessedTableManager get scheduleEntriesRefs {
    final manager =
        $$ScheduleEntriesTableTableManager($_db, $_db.scheduleEntries).filter(
          (f) => f.studentCourseId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _scheduleEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoursesTableFilterComposer
    extends Composer<_$AppDatabaseV2, $CoursesTable> {
  $$CoursesTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get institutionId => $composableBuilder(
    column: $table.institutionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termLabel => $composableBuilder(
    column: $table.termLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get termStartDate => $composableBuilder(
    column: $table.termStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get termEndDate => $composableBuilder(
    column: $table.termEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousCourseId => $composableBuilder(
    column: $table.previousCourseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
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

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> lecturersRefs(
    Expression<bool> Function($$LecturersTableFilterComposer f) f,
  ) {
    final $$LecturersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecturers,
      getReferencedColumn: (t) => t.studentCourseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LecturersTableFilterComposer(
            $db: $db,
            $table: $db.lecturers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduleEntriesRefs(
    Expression<bool> Function($$ScheduleEntriesTableFilterComposer f) f,
  ) {
    final $$ScheduleEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleEntries,
      getReferencedColumn: (t) => t.studentCourseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleEntriesTableFilterComposer(
            $db: $db,
            $table: $db.scheduleEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $CoursesTable> {
  $$CoursesTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get institutionId => $composableBuilder(
    column: $table.institutionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termLabel => $composableBuilder(
    column: $table.termLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get termStartDate => $composableBuilder(
    column: $table.termStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get termEndDate => $composableBuilder(
    column: $table.termEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousCourseId => $composableBuilder(
    column: $table.previousCourseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
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

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => column,
  );

  GeneratedColumn<int> get institutionId => $composableBuilder(
    column: $table.institutionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get termLabel =>
      $composableBuilder(column: $table.termLabel, builder: (column) => column);

  GeneratedColumn<String> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get termStartDate => $composableBuilder(
    column: $table.termStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get termEndDate => $composableBuilder(
    column: $table.termEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get previousCourseId => $composableBuilder(
    column: $table.previousCourseId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  Expression<T> lecturersRefs<T extends Object>(
    Expression<T> Function($$LecturersTableAnnotationComposer a) f,
  ) {
    final $$LecturersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecturers,
      getReferencedColumn: (t) => t.studentCourseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LecturersTableAnnotationComposer(
            $db: $db,
            $table: $db.lecturers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scheduleEntriesRefs<T extends Object>(
    Expression<T> Function($$ScheduleEntriesTableAnnotationComposer a) f,
  ) {
    final $$ScheduleEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleEntries,
      getReferencedColumn: (t) => t.studentCourseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.scheduleEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $CoursesTable,
          Course,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (Course, $$CoursesTableReferences),
          Course,
          PrefetchHooks Function({bool lecturersRefs, bool scheduleEntriesRefs})
        > {
  $$CoursesTableTableManager(_$AppDatabaseV2 db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                Value<int> institutionId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> termLabel = const Value.absent(),
                Value<String?> academicYear = const Value.absent(),
                Value<DateTime?> termStartDate = const Value.absent(),
                Value<DateTime?> termEndDate = const Value.absent(),
                Value<String?> previousCourseId = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion(
                id: id,
                serverId: serverId,
                idempotencyKey: idempotencyKey,
                syncStatus: syncStatus,
                lastSyncError: lastSyncError,
                institutionId: institutionId,
                title: title,
                code: code,
                color: color,
                termLabel: termLabel,
                academicYear: academicYear,
                termStartDate: termStartDate,
                termEndDate: termEndDate,
                previousCourseId: previousCourseId,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                required int institutionId,
                required String title,
                Value<String?> code = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> termLabel = const Value.absent(),
                Value<String?> academicYear = const Value.absent(),
                Value<DateTime?> termStartDate = const Value.absent(),
                Value<DateTime?> termEndDate = const Value.absent(),
                Value<String?> previousCourseId = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion.insert(
                id: id,
                serverId: serverId,
                idempotencyKey: idempotencyKey,
                syncStatus: syncStatus,
                lastSyncError: lastSyncError,
                institutionId: institutionId,
                title: title,
                code: code,
                color: color,
                termLabel: termLabel,
                academicYear: academicYear,
                termStartDate: termStartDate,
                termEndDate: termEndDate,
                previousCourseId: previousCourseId,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoursesTable, Course>(table),
                  $$CoursesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({lecturersRefs = false, scheduleEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (lecturersRefs) db.lecturers,
                    if (scheduleEntriesRefs) db.scheduleEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (lecturersRefs)
                        await $_getPrefetchedData<
                          Course,
                          $CoursesTable,
                          Lecturer
                        >(
                          currentTable: table,
                          referencedTable: $$CoursesTableReferences
                              ._lecturersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoursesTableReferences(
                                db,
                                table,
                                p0,
                              ).lecturersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentCourseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scheduleEntriesRefs)
                        await $_getPrefetchedData<
                          Course,
                          $CoursesTable,
                          ScheduleEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CoursesTableReferences
                              ._scheduleEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoursesTableReferences(
                                db,
                                table,
                                p0,
                              ).scheduleEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentCourseId == item.id,
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

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $CoursesTable,
      Course,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (Course, $$CoursesTableReferences),
      Course,
      PrefetchHooks Function({bool lecturersRefs, bool scheduleEntriesRefs})
    >;
typedef $$LecturersTableCreateCompanionBuilder = LecturersCompanion Function({
  required String id,
  required String studentCourseId,
  required String name,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> office,
  Value<int> rowid,
});
typedef $$LecturersTableUpdateCompanionBuilder = LecturersCompanion Function({
  Value<String> id,
  Value<String> studentCourseId,
  Value<String> name,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> office,
  Value<int> rowid,
});

final class $$LecturersTableReferences
    extends BaseReferences<_$AppDatabaseV2, $LecturersTable, Lecturer> {
  $$LecturersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoursesTable _studentCourseIdTable(_$AppDatabaseV2 db) =>
      db.courses.createAlias('lecturers__student_course_id__courses__id');

  $$CoursesTableProcessedTableManager get studentCourseId {
    final $_column = $_itemColumn<String>('student_course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentCourseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LecturersTableFilterComposer
    extends Composer<_$AppDatabaseV2, $LecturersTable> {
  $$LecturersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get office => $composableBuilder(
    column: $table.office,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get studentCourseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentCourseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LecturersTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $LecturersTable> {
  $$LecturersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get office => $composableBuilder(
    column: $table.office,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get studentCourseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentCourseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LecturersTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $LecturersTable> {
  $$LecturersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get office =>
      $composableBuilder(column: $table.office, builder: (column) => column);

  $$CoursesTableAnnotationComposer get studentCourseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentCourseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LecturersTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $LecturersTable,
          Lecturer,
          $$LecturersTableFilterComposer,
          $$LecturersTableOrderingComposer,
          $$LecturersTableAnnotationComposer,
          $$LecturersTableCreateCompanionBuilder,
          $$LecturersTableUpdateCompanionBuilder,
          (Lecturer, $$LecturersTableReferences),
          Lecturer,
          PrefetchHooks Function({bool studentCourseId})
        > {
  $$LecturersTableTableManager(_$AppDatabaseV2 db, $LecturersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LecturersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LecturersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LecturersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studentCourseId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> office = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LecturersCompanion(
                id: id,
                studentCourseId: studentCourseId,
                name: name,
                email: email,
                phone: phone,
                office: office,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studentCourseId,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> office = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LecturersCompanion.insert(
                id: id,
                studentCourseId: studentCourseId,
                name: name,
                email: email,
                phone: phone,
                office: office,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LecturersTable, Lecturer>(table),
                  $$LecturersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studentCourseId = false}) {
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
                    if (studentCourseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studentCourseId,
                        referencedTable: $$LecturersTableReferences
                            ._studentCourseIdTable(db),
                        referencedColumn: $$LecturersTableReferences
                            ._studentCourseIdTable(db)
                            .id,
                      ) as T;
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

typedef $$LecturersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $LecturersTable,
      Lecturer,
      $$LecturersTableFilterComposer,
      $$LecturersTableOrderingComposer,
      $$LecturersTableAnnotationComposer,
      $$LecturersTableCreateCompanionBuilder,
      $$LecturersTableUpdateCompanionBuilder,
      (Lecturer, $$LecturersTableReferences),
      Lecturer,
      PrefetchHooks Function({bool studentCourseId})
    >;
typedef $$ScheduleEntriesTableCreateCompanionBuilder =
    ScheduleEntriesCompanion Function({
      required String id,
      Value<String?> serverId,
      Value<String> idempotencyKey,
      Value<String> syncStatus,
      Value<String?> lastSyncError,
      required String studentCourseId,
      required String dayOfWeek,
      required String startTime,
      required String endTime,
      Value<String?> venue,
      Value<String?> campus,
      Value<String?> section,
      Value<String?> label,
      Value<String?> color,
      Value<bool> isRecurring,
      Value<DateTime?> specificDate,
      required DateTime createdAt,
      required DateTime updatedAt,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$ScheduleEntriesTableUpdateCompanionBuilder =
    ScheduleEntriesCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String> idempotencyKey,
      Value<String> syncStatus,
      Value<String?> lastSyncError,
      Value<String> studentCourseId,
      Value<String> dayOfWeek,
      Value<String> startTime,
      Value<String> endTime,
      Value<String?> venue,
      Value<String?> campus,
      Value<String?> section,
      Value<String?> label,
      Value<String?> color,
      Value<bool> isRecurring,
      Value<DateTime?> specificDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$ScheduleEntriesTableReferences
    extends
        BaseReferences<_$AppDatabaseV2, $ScheduleEntriesTable, ScheduleEntry> {
  $$ScheduleEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoursesTable _studentCourseIdTable(_$AppDatabaseV2 db) => db.courses
      .createAlias('schedule_entries__student_course_id__courses__id');

  $$CoursesTableProcessedTableManager get studentCourseId {
    final $_column = $_itemColumn<String>('student_course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentCourseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScheduleEntriesTableFilterComposer
    extends Composer<_$AppDatabaseV2, $ScheduleEntriesTable> {
  $$ScheduleEntriesTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campus => $composableBuilder(
    column: $table.campus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get specificDate => $composableBuilder(
    column: $table.specificDate,
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

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get studentCourseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentCourseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleEntriesTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $ScheduleEntriesTable> {
  $$ScheduleEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campus => $composableBuilder(
    column: $table.campus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get specificDate => $composableBuilder(
    column: $table.specificDate,
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

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get studentCourseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentCourseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $ScheduleEntriesTable> {
  $$ScheduleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get specificDate => $composableBuilder(
    column: $table.specificDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  $$CoursesTableAnnotationComposer get studentCourseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentCourseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $ScheduleEntriesTable,
          ScheduleEntry,
          $$ScheduleEntriesTableFilterComposer,
          $$ScheduleEntriesTableOrderingComposer,
          $$ScheduleEntriesTableAnnotationComposer,
          $$ScheduleEntriesTableCreateCompanionBuilder,
          $$ScheduleEntriesTableUpdateCompanionBuilder,
          (ScheduleEntry, $$ScheduleEntriesTableReferences),
          ScheduleEntry,
          PrefetchHooks Function({bool studentCourseId})
        > {
  $$ScheduleEntriesTableTableManager(
    _$AppDatabaseV2 db,
    $ScheduleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                Value<String> studentCourseId = const Value.absent(),
                Value<String> dayOfWeek = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String> endTime = const Value.absent(),
                Value<String?> venue = const Value.absent(),
                Value<String?> campus = const Value.absent(),
                Value<String?> section = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<DateTime?> specificDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleEntriesCompanion(
                id: id,
                serverId: serverId,
                idempotencyKey: idempotencyKey,
                syncStatus: syncStatus,
                lastSyncError: lastSyncError,
                studentCourseId: studentCourseId,
                dayOfWeek: dayOfWeek,
                startTime: startTime,
                endTime: endTime,
                venue: venue,
                campus: campus,
                section: section,
                label: label,
                color: color,
                isRecurring: isRecurring,
                specificDate: specificDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                required String studentCourseId,
                required String dayOfWeek,
                required String startTime,
                required String endTime,
                Value<String?> venue = const Value.absent(),
                Value<String?> campus = const Value.absent(),
                Value<String?> section = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<DateTime?> specificDate = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleEntriesCompanion.insert(
                id: id,
                serverId: serverId,
                idempotencyKey: idempotencyKey,
                syncStatus: syncStatus,
                lastSyncError: lastSyncError,
                studentCourseId: studentCourseId,
                dayOfWeek: dayOfWeek,
                startTime: startTime,
                endTime: endTime,
                venue: venue,
                campus: campus,
                section: section,
                label: label,
                color: color,
                isRecurring: isRecurring,
                specificDate: specificDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScheduleEntriesTable, ScheduleEntry>(table),
                  $$ScheduleEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studentCourseId = false}) {
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
                    if (studentCourseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studentCourseId,
                        referencedTable: $$ScheduleEntriesTableReferences
                            ._studentCourseIdTable(db),
                        referencedColumn: $$ScheduleEntriesTableReferences
                            ._studentCourseIdTable(db)
                            .id,
                      ) as T;
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

typedef $$ScheduleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $ScheduleEntriesTable,
      ScheduleEntry,
      $$ScheduleEntriesTableFilterComposer,
      $$ScheduleEntriesTableOrderingComposer,
      $$ScheduleEntriesTableAnnotationComposer,
      $$ScheduleEntriesTableCreateCompanionBuilder,
      $$ScheduleEntriesTableUpdateCompanionBuilder,
      (ScheduleEntry, $$ScheduleEntriesTableReferences),
      ScheduleEntry,
      PrefetchHooks Function({bool studentCourseId})
    >;
typedef $$TodoListsTableCreateCompanionBuilder = TodoListsCompanion Function({
  Value<int> localId,
  Value<String?> id,
  required String title,
  Value<int?> color,
  Value<bool> isDefault,
  Value<String> syncStatus,
  Value<int> taskCount,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isPendingDeletion,
  Value<bool> isDirty,
});
typedef $$TodoListsTableUpdateCompanionBuilder = TodoListsCompanion Function({
  Value<int> localId,
  Value<String?> id,
  Value<String> title,
  Value<int?> color,
  Value<bool> isDefault,
  Value<String> syncStatus,
  Value<int> taskCount,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isPendingDeletion,
  Value<bool> isDirty,
});

final class $$TodoListsTableReferences
    extends BaseReferences<_$AppDatabaseV2, $TodoListsTable, TodoList> {
  $$TodoListsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TodoItemsTable, List<TodoItem>>
  _todoItemsRefsTable(_$AppDatabaseV2 db) => MultiTypedResultKey.fromTable(
    db.todoItems,
    aliasName: 'todo_lists__local_id__todo_items__task_list_local_id',
  );

  $$TodoItemsTableProcessedTableManager get todoItemsRefs {
    final manager = $$TodoItemsTableTableManager($_db, $_db.todoItems).filter(
      (f) =>
          f.taskListLocalId.localId.sqlEquals($_itemColumn<int>('local_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_todoItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TodoListsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $TodoListsTable> {
  $$TodoListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taskCount => $composableBuilder(
    column: $table.taskCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
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

  ColumnFilters<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> todoItemsRefs(
    Expression<bool> Function($$TodoItemsTableFilterComposer f) f,
  ) {
    final $$TodoItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localId,
      referencedTable: $db.todoItems,
      getReferencedColumn: (t) => t.taskListLocalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemsTableFilterComposer(
            $db: $db,
            $table: $db.todoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodoListsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $TodoListsTable> {
  $$TodoListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taskCount => $composableBuilder(
    column: $table.taskCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
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

  ColumnOrderings<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodoListsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $TodoListsTable> {
  $$TodoListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taskCount =>
      $composableBuilder(column: $table.taskCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  Expression<T> todoItemsRefs<T extends Object>(
    Expression<T> Function($$TodoItemsTableAnnotationComposer a) f,
  ) {
    final $$TodoItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localId,
      referencedTable: $db.todoItems,
      getReferencedColumn: (t) => t.taskListLocalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.todoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodoListsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $TodoListsTable,
          TodoList,
          $$TodoListsTableFilterComposer,
          $$TodoListsTableOrderingComposer,
          $$TodoListsTableAnnotationComposer,
          $$TodoListsTableCreateCompanionBuilder,
          $$TodoListsTableUpdateCompanionBuilder,
          (TodoList, $$TodoListsTableReferences),
          TodoList,
          PrefetchHooks Function({bool todoItemsRefs})
        > {
  $$TodoListsTableTableManager(_$AppDatabaseV2 db, $TodoListsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String?> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> color = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> taskCount = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isPendingDeletion = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
              }) => TodoListsCompanion(
                localId: localId,
                id: id,
                title: title,
                color: color,
                isDefault: isDefault,
                syncStatus: syncStatus,
                taskCount: taskCount,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPendingDeletion: isPendingDeletion,
                isDirty: isDirty,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String?> id = const Value.absent(),
                required String title,
                Value<int?> color = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> taskCount = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isPendingDeletion = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
              }) => TodoListsCompanion.insert(
                localId: localId,
                id: id,
                title: title,
                color: color,
                isDefault: isDefault,
                syncStatus: syncStatus,
                taskCount: taskCount,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPendingDeletion: isPendingDeletion,
                isDirty: isDirty,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TodoListsTable, TodoList>(table),
                  $$TodoListsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({todoItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (todoItemsRefs) db.todoItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (todoItemsRefs)
                    await $_getPrefetchedData<
                      TodoList,
                      $TodoListsTable,
                      TodoItem
                    >(
                      currentTable: table,
                      referencedTable: $$TodoListsTableReferences
                          ._todoItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TodoListsTableReferences(
                            db,
                            table,
                            p0,
                          ).todoItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.taskListLocalId == item.localId,
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

typedef $$TodoListsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $TodoListsTable,
      TodoList,
      $$TodoListsTableFilterComposer,
      $$TodoListsTableOrderingComposer,
      $$TodoListsTableAnnotationComposer,
      $$TodoListsTableCreateCompanionBuilder,
      $$TodoListsTableUpdateCompanionBuilder,
      (TodoList, $$TodoListsTableReferences),
      TodoList,
      PrefetchHooks Function({bool todoItemsRefs})
    >;
typedef $$TodoTagItemsTableCreateCompanionBuilder =
    TodoTagItemsCompanion Function({
      Value<int> localId,
      Value<String?> id,
      required String name,
      Value<String?> color,
      Value<String> syncStatus,
      Value<DateTime?> createdAt,
      Value<bool> isPendingDeletion,
      Value<bool> isDirty,
    });
typedef $$TodoTagItemsTableUpdateCompanionBuilder =
    TodoTagItemsCompanion Function({
      Value<int> localId,
      Value<String?> id,
      Value<String> name,
      Value<String?> color,
      Value<String> syncStatus,
      Value<DateTime?> createdAt,
      Value<bool> isPendingDeletion,
      Value<bool> isDirty,
    });

final class $$TodoTagItemsTableReferences
    extends BaseReferences<_$AppDatabaseV2, $TodoTagItemsTable, TodoTagItem> {
  $$TodoTagItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TodoItemTagsTable, List<TodoItemTag>>
  _todoItemTagsRefsTable(_$AppDatabaseV2 db) => MultiTypedResultKey.fromTable(
    db.todoItemTags,
    aliasName: 'todo_tag_items__local_id__todo_item_tags__tag_local_id',
  );

  $$TodoItemTagsTableProcessedTableManager get todoItemTagsRefs {
    final manager = $$TodoItemTagsTableTableManager($_db, $_db.todoItemTags)
        .filter(
          (f) => f.tagLocalId.localId.sqlEquals($_itemColumn<int>('local_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_todoItemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TodoTagItemsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $TodoTagItemsTable> {
  $$TodoTagItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> todoItemTagsRefs(
    Expression<bool> Function($$TodoItemTagsTableFilterComposer f) f,
  ) {
    final $$TodoItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localId,
      referencedTable: $db.todoItemTags,
      getReferencedColumn: (t) => t.tagLocalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.todoItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodoTagItemsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $TodoTagItemsTable> {
  $$TodoTagItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodoTagItemsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $TodoTagItemsTable> {
  $$TodoTagItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  Expression<T> todoItemTagsRefs<T extends Object>(
    Expression<T> Function($$TodoItemTagsTableAnnotationComposer a) f,
  ) {
    final $$TodoItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localId,
      referencedTable: $db.todoItemTags,
      getReferencedColumn: (t) => t.tagLocalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.todoItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodoTagItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $TodoTagItemsTable,
          TodoTagItem,
          $$TodoTagItemsTableFilterComposer,
          $$TodoTagItemsTableOrderingComposer,
          $$TodoTagItemsTableAnnotationComposer,
          $$TodoTagItemsTableCreateCompanionBuilder,
          $$TodoTagItemsTableUpdateCompanionBuilder,
          (TodoTagItem, $$TodoTagItemsTableReferences),
          TodoTagItem,
          PrefetchHooks Function({bool todoItemTagsRefs})
        > {
  $$TodoTagItemsTableTableManager(_$AppDatabaseV2 db, $TodoTagItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoTagItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoTagItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoTagItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String?> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<bool> isPendingDeletion = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
              }) => TodoTagItemsCompanion(
                localId: localId,
                id: id,
                name: name,
                color: color,
                syncStatus: syncStatus,
                createdAt: createdAt,
                isPendingDeletion: isPendingDeletion,
                isDirty: isDirty,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String?> id = const Value.absent(),
                required String name,
                Value<String?> color = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<bool> isPendingDeletion = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
              }) => TodoTagItemsCompanion.insert(
                localId: localId,
                id: id,
                name: name,
                color: color,
                syncStatus: syncStatus,
                createdAt: createdAt,
                isPendingDeletion: isPendingDeletion,
                isDirty: isDirty,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TodoTagItemsTable, TodoTagItem>(table),
                  $$TodoTagItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({todoItemTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (todoItemTagsRefs) db.todoItemTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (todoItemTagsRefs)
                    await $_getPrefetchedData<
                      TodoTagItem,
                      $TodoTagItemsTable,
                      TodoItemTag
                    >(
                      currentTable: table,
                      referencedTable: $$TodoTagItemsTableReferences
                          ._todoItemTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TodoTagItemsTableReferences(
                            db,
                            table,
                            p0,
                          ).todoItemTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.tagLocalId == item.localId,
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

typedef $$TodoTagItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $TodoTagItemsTable,
      TodoTagItem,
      $$TodoTagItemsTableFilterComposer,
      $$TodoTagItemsTableOrderingComposer,
      $$TodoTagItemsTableAnnotationComposer,
      $$TodoTagItemsTableCreateCompanionBuilder,
      $$TodoTagItemsTableUpdateCompanionBuilder,
      (TodoTagItem, $$TodoTagItemsTableReferences),
      TodoTagItem,
      PrefetchHooks Function({bool todoItemTagsRefs})
    >;
typedef $$TodoItemsTableCreateCompanionBuilder = TodoItemsCompanion Function({
  Value<int> localId,
  Value<String?> id,
  required int taskListLocalId,
  required String title,
  Value<String?> notes,
  Value<String> status,
  Value<String> priority,
  Value<DateTime?> due,
  Value<DateTime?> completed,
  Value<int> subtaskCount,
  Value<String?> position,
  Value<bool> hidden,
  Value<String> syncStatus,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isPendingDeletion,
  Value<bool> isDirty,
  Value<int> focusedSeconds,
});
typedef $$TodoItemsTableUpdateCompanionBuilder = TodoItemsCompanion Function({
  Value<int> localId,
  Value<String?> id,
  Value<int> taskListLocalId,
  Value<String> title,
  Value<String?> notes,
  Value<String> status,
  Value<String> priority,
  Value<DateTime?> due,
  Value<DateTime?> completed,
  Value<int> subtaskCount,
  Value<String?> position,
  Value<bool> hidden,
  Value<String> syncStatus,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isPendingDeletion,
  Value<bool> isDirty,
  Value<int> focusedSeconds,
});

final class $$TodoItemsTableReferences
    extends BaseReferences<_$AppDatabaseV2, $TodoItemsTable, TodoItem> {
  $$TodoItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TodoListsTable _taskListLocalIdTable(_$AppDatabaseV2 db) => db
      .todoLists
      .createAlias('todo_items__task_list_local_id__todo_lists__local_id');

  $$TodoListsTableProcessedTableManager get taskListLocalId {
    final $_column = $_itemColumn<int>('task_list_local_id')!;

    final manager = $$TodoListsTableTableManager(
      $_db,
      $_db.todoLists,
    ).filter((f) => f.localId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskListLocalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TodoItemTagsTable, List<TodoItemTag>>
  _todoItemTagsRefsTable(_$AppDatabaseV2 db) => MultiTypedResultKey.fromTable(
    db.todoItemTags,
    aliasName: 'todo_items__local_id__todo_item_tags__todo_local_id',
  );

  $$TodoItemTagsTableProcessedTableManager get todoItemTagsRefs {
    final manager = $$TodoItemTagsTableTableManager($_db, $_db.todoItemTags)
        .filter(
          (f) =>
              f.todoLocalId.localId.sqlEquals($_itemColumn<int>('local_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_todoItemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TodoItemsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $TodoItemsTable> {
  $$TodoItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtaskCount => $composableBuilder(
    column: $table.subtaskCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
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

  ColumnFilters<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusedSeconds => $composableBuilder(
    column: $table.focusedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  $$TodoListsTableFilterComposer get taskListLocalId {
    final $$TodoListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskListLocalId,
      referencedTable: $db.todoLists,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoListsTableFilterComposer(
            $db: $db,
            $table: $db.todoLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> todoItemTagsRefs(
    Expression<bool> Function($$TodoItemTagsTableFilterComposer f) f,
  ) {
    final $$TodoItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localId,
      referencedTable: $db.todoItemTags,
      getReferencedColumn: (t) => t.todoLocalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.todoItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodoItemsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $TodoItemsTable> {
  $$TodoItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtaskCount => $composableBuilder(
    column: $table.subtaskCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
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

  ColumnOrderings<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusedSeconds => $composableBuilder(
    column: $table.focusedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$TodoListsTableOrderingComposer get taskListLocalId {
    final $$TodoListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskListLocalId,
      referencedTable: $db.todoLists,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoListsTableOrderingComposer(
            $db: $db,
            $table: $db.todoLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoItemsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $TodoItemsTable> {
  $$TodoItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<DateTime> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get subtaskCount => $composableBuilder(
    column: $table.subtaskCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get hidden =>
      $composableBuilder(column: $table.hidden, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isPendingDeletion => $composableBuilder(
    column: $table.isPendingDeletion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  GeneratedColumn<int> get focusedSeconds => $composableBuilder(
    column: $table.focusedSeconds,
    builder: (column) => column,
  );

  $$TodoListsTableAnnotationComposer get taskListLocalId {
    final $$TodoListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskListLocalId,
      referencedTable: $db.todoLists,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoListsTableAnnotationComposer(
            $db: $db,
            $table: $db.todoLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> todoItemTagsRefs<T extends Object>(
    Expression<T> Function($$TodoItemTagsTableAnnotationComposer a) f,
  ) {
    final $$TodoItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localId,
      referencedTable: $db.todoItemTags,
      getReferencedColumn: (t) => t.todoLocalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.todoItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodoItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $TodoItemsTable,
          TodoItem,
          $$TodoItemsTableFilterComposer,
          $$TodoItemsTableOrderingComposer,
          $$TodoItemsTableAnnotationComposer,
          $$TodoItemsTableCreateCompanionBuilder,
          $$TodoItemsTableUpdateCompanionBuilder,
          (TodoItem, $$TodoItemsTableReferences),
          TodoItem,
          PrefetchHooks Function({bool taskListLocalId, bool todoItemTagsRefs})
        > {
  $$TodoItemsTableTableManager(_$AppDatabaseV2 db, $TodoItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String?> id = const Value.absent(),
                Value<int> taskListLocalId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                Value<DateTime?> completed = const Value.absent(),
                Value<int> subtaskCount = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<bool> hidden = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isPendingDeletion = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<int> focusedSeconds = const Value.absent(),
              }) => TodoItemsCompanion(
                localId: localId,
                id: id,
                taskListLocalId: taskListLocalId,
                title: title,
                notes: notes,
                status: status,
                priority: priority,
                due: due,
                completed: completed,
                subtaskCount: subtaskCount,
                position: position,
                hidden: hidden,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPendingDeletion: isPendingDeletion,
                isDirty: isDirty,
                focusedSeconds: focusedSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String?> id = const Value.absent(),
                required int taskListLocalId,
                required String title,
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                Value<DateTime?> completed = const Value.absent(),
                Value<int> subtaskCount = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<bool> hidden = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isPendingDeletion = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<int> focusedSeconds = const Value.absent(),
              }) => TodoItemsCompanion.insert(
                localId: localId,
                id: id,
                taskListLocalId: taskListLocalId,
                title: title,
                notes: notes,
                status: status,
                priority: priority,
                due: due,
                completed: completed,
                subtaskCount: subtaskCount,
                position: position,
                hidden: hidden,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPendingDeletion: isPendingDeletion,
                isDirty: isDirty,
                focusedSeconds: focusedSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TodoItemsTable, TodoItem>(table),
                  $$TodoItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({taskListLocalId = false, todoItemTagsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (todoItemTagsRefs) db.todoItemTags,
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
                        if (taskListLocalId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.taskListLocalId,
                            referencedTable: $$TodoItemsTableReferences
                                ._taskListLocalIdTable(db),
                            referencedColumn: $$TodoItemsTableReferences
                                ._taskListLocalIdTable(db)
                                .localId,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (todoItemTagsRefs)
                        await $_getPrefetchedData<
                          TodoItem,
                          $TodoItemsTable,
                          TodoItemTag
                        >(
                          currentTable: table,
                          referencedTable: $$TodoItemsTableReferences
                              ._todoItemTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TodoItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).todoItemTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.todoLocalId == item.localId,
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

typedef $$TodoItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $TodoItemsTable,
      TodoItem,
      $$TodoItemsTableFilterComposer,
      $$TodoItemsTableOrderingComposer,
      $$TodoItemsTableAnnotationComposer,
      $$TodoItemsTableCreateCompanionBuilder,
      $$TodoItemsTableUpdateCompanionBuilder,
      (TodoItem, $$TodoItemsTableReferences),
      TodoItem,
      PrefetchHooks Function({bool taskListLocalId, bool todoItemTagsRefs})
    >;
typedef $$TodoItemTagsTableCreateCompanionBuilder =
    TodoItemTagsCompanion Function({
      required int todoLocalId,
      required int tagLocalId,
      Value<int> rowid,
    });
typedef $$TodoItemTagsTableUpdateCompanionBuilder =
    TodoItemTagsCompanion Function({
      Value<int> todoLocalId,
      Value<int> tagLocalId,
      Value<int> rowid,
    });

final class $$TodoItemTagsTableReferences
    extends BaseReferences<_$AppDatabaseV2, $TodoItemTagsTable, TodoItemTag> {
  $$TodoItemTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TodoItemsTable _todoLocalIdTable(_$AppDatabaseV2 db) => db.todoItems
      .createAlias('todo_item_tags__todo_local_id__todo_items__local_id');

  $$TodoItemsTableProcessedTableManager get todoLocalId {
    final $_column = $_itemColumn<int>('todo_local_id')!;

    final manager = $$TodoItemsTableTableManager(
      $_db,
      $_db.todoItems,
    ).filter((f) => f.localId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_todoLocalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TodoTagItemsTable _tagLocalIdTable(_$AppDatabaseV2 db) => db
      .todoTagItems
      .createAlias('todo_item_tags__tag_local_id__todo_tag_items__local_id');

  $$TodoTagItemsTableProcessedTableManager get tagLocalId {
    final $_column = $_itemColumn<int>('tag_local_id')!;

    final manager = $$TodoTagItemsTableTableManager(
      $_db,
      $_db.todoTagItems,
    ).filter((f) => f.localId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagLocalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TodoItemTagsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $TodoItemTagsTable> {
  $$TodoItemTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TodoItemsTableFilterComposer get todoLocalId {
    final $$TodoItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.todoLocalId,
      referencedTable: $db.todoItems,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemsTableFilterComposer(
            $db: $db,
            $table: $db.todoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TodoTagItemsTableFilterComposer get tagLocalId {
    final $$TodoTagItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagLocalId,
      referencedTable: $db.todoTagItems,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoTagItemsTableFilterComposer(
            $db: $db,
            $table: $db.todoTagItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoItemTagsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $TodoItemTagsTable> {
  $$TodoItemTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TodoItemsTableOrderingComposer get todoLocalId {
    final $$TodoItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.todoLocalId,
      referencedTable: $db.todoItems,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemsTableOrderingComposer(
            $db: $db,
            $table: $db.todoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TodoTagItemsTableOrderingComposer get tagLocalId {
    final $$TodoTagItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagLocalId,
      referencedTable: $db.todoTagItems,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoTagItemsTableOrderingComposer(
            $db: $db,
            $table: $db.todoTagItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoItemTagsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $TodoItemTagsTable> {
  $$TodoItemTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TodoItemsTableAnnotationComposer get todoLocalId {
    final $$TodoItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.todoLocalId,
      referencedTable: $db.todoItems,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.todoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TodoTagItemsTableAnnotationComposer get tagLocalId {
    final $$TodoTagItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagLocalId,
      referencedTable: $db.todoTagItems,
      getReferencedColumn: (t) => t.localId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoTagItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.todoTagItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoItemTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $TodoItemTagsTable,
          TodoItemTag,
          $$TodoItemTagsTableFilterComposer,
          $$TodoItemTagsTableOrderingComposer,
          $$TodoItemTagsTableAnnotationComposer,
          $$TodoItemTagsTableCreateCompanionBuilder,
          $$TodoItemTagsTableUpdateCompanionBuilder,
          (TodoItemTag, $$TodoItemTagsTableReferences),
          TodoItemTag,
          PrefetchHooks Function({bool todoLocalId, bool tagLocalId})
        > {
  $$TodoItemTagsTableTableManager(_$AppDatabaseV2 db, $TodoItemTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoItemTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoItemTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoItemTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> todoLocalId = const Value.absent(),
                Value<int> tagLocalId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodoItemTagsCompanion(
                todoLocalId: todoLocalId,
                tagLocalId: tagLocalId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int todoLocalId,
                required int tagLocalId,
                Value<int> rowid = const Value.absent(),
              }) => TodoItemTagsCompanion.insert(
                todoLocalId: todoLocalId,
                tagLocalId: tagLocalId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TodoItemTagsTable, TodoItemTag>(table),
                  $$TodoItemTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({todoLocalId = false, tagLocalId = false}) {
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
                    if (todoLocalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.todoLocalId,
                        referencedTable: $$TodoItemTagsTableReferences
                            ._todoLocalIdTable(db),
                        referencedColumn: $$TodoItemTagsTableReferences
                            ._todoLocalIdTable(db)
                            .localId,
                      ) as T;
                    }
                    if (tagLocalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagLocalId,
                        referencedTable: $$TodoItemTagsTableReferences
                            ._tagLocalIdTable(db),
                        referencedColumn: $$TodoItemTagsTableReferences
                            ._tagLocalIdTable(db)
                            .localId,
                      ) as T;
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

typedef $$TodoItemTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $TodoItemTagsTable,
      TodoItemTag,
      $$TodoItemTagsTableFilterComposer,
      $$TodoItemTagsTableOrderingComposer,
      $$TodoItemTagsTableAnnotationComposer,
      $$TodoItemTagsTableCreateCompanionBuilder,
      $$TodoItemTagsTableUpdateCompanionBuilder,
      (TodoItemTag, $$TodoItemTagsTableReferences),
      TodoItemTag,
      PrefetchHooks Function({bool todoLocalId, bool tagLocalId})
    >;
typedef $$StudyMaterialRecordsTableCreateCompanionBuilder =
    StudyMaterialRecordsCompanion Function({
      required String environment,
      required String accountId,
      required int noteId,
      required String metadataJson,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$StudyMaterialRecordsTableUpdateCompanionBuilder =
    StudyMaterialRecordsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<int> noteId,
      Value<String> metadataJson,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$StudyMaterialRecordsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyMaterialRecordsTable> {
  $$StudyMaterialRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyMaterialRecordsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyMaterialRecordsTable> {
  $$StudyMaterialRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyMaterialRecordsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyMaterialRecordsTable> {
  $$StudyMaterialRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$StudyMaterialRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyMaterialRecordsTable,
          StudyMaterialRecord,
          $$StudyMaterialRecordsTableFilterComposer,
          $$StudyMaterialRecordsTableOrderingComposer,
          $$StudyMaterialRecordsTableAnnotationComposer,
          $$StudyMaterialRecordsTableCreateCompanionBuilder,
          $$StudyMaterialRecordsTableUpdateCompanionBuilder,
          (
            StudyMaterialRecord,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyMaterialRecordsTable,
              StudyMaterialRecord
            >,
          ),
          StudyMaterialRecord,
          PrefetchHooks Function()
        > {
  $$StudyMaterialRecordsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyMaterialRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyMaterialRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyMaterialRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyMaterialRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyMaterialRecordsCompanion(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                metadataJson: metadataJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required int noteId,
                required String metadataJson,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudyMaterialRecordsCompanion.insert(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                metadataJson: metadataJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyMaterialRecordsTable, StudyMaterialRecord>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyMaterialRecordsTable,
                    StudyMaterialRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyMaterialRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyMaterialRecordsTable,
      StudyMaterialRecord,
      $$StudyMaterialRecordsTableFilterComposer,
      $$StudyMaterialRecordsTableOrderingComposer,
      $$StudyMaterialRecordsTableAnnotationComposer,
      $$StudyMaterialRecordsTableCreateCompanionBuilder,
      $$StudyMaterialRecordsTableUpdateCompanionBuilder,
      (
        StudyMaterialRecord,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyMaterialRecordsTable,
          StudyMaterialRecord
        >,
      ),
      StudyMaterialRecord,
      PrefetchHooks Function()
    >;
typedef $$StudyQuestionSetRecordsTableCreateCompanionBuilder =
    StudyQuestionSetRecordsCompanion Function({
      required String environment,
      required String accountId,
      required int noteId,
      required int setId,
      required String format,
      required String setJson,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$StudyQuestionSetRecordsTableUpdateCompanionBuilder =
    StudyQuestionSetRecordsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<int> noteId,
      Value<int> setId,
      Value<String> format,
      Value<String> setJson,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$StudyQuestionSetRecordsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyQuestionSetRecordsTable> {
  $$StudyQuestionSetRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setJson => $composableBuilder(
    column: $table.setJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyQuestionSetRecordsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyQuestionSetRecordsTable> {
  $$StudyQuestionSetRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setJson => $composableBuilder(
    column: $table.setJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyQuestionSetRecordsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyQuestionSetRecordsTable> {
  $$StudyQuestionSetRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get setId =>
      $composableBuilder(column: $table.setId, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get setJson =>
      $composableBuilder(column: $table.setJson, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$StudyQuestionSetRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyQuestionSetRecordsTable,
          StudyQuestionSetRecord,
          $$StudyQuestionSetRecordsTableFilterComposer,
          $$StudyQuestionSetRecordsTableOrderingComposer,
          $$StudyQuestionSetRecordsTableAnnotationComposer,
          $$StudyQuestionSetRecordsTableCreateCompanionBuilder,
          $$StudyQuestionSetRecordsTableUpdateCompanionBuilder,
          (
            StudyQuestionSetRecord,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyQuestionSetRecordsTable,
              StudyQuestionSetRecord
            >,
          ),
          StudyQuestionSetRecord,
          PrefetchHooks Function()
        > {
  $$StudyQuestionSetRecordsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyQuestionSetRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyQuestionSetRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudyQuestionSetRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyQuestionSetRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<int> setId = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<String> setJson = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyQuestionSetRecordsCompanion(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                setId: setId,
                format: format,
                setJson: setJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required int noteId,
                required int setId,
                required String format,
                required String setJson,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudyQuestionSetRecordsCompanion.insert(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                setId: setId,
                format: format,
                setJson: setJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudyQuestionSetRecordsTable,
                    StudyQuestionSetRecord
                  >(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyQuestionSetRecordsTable,
                    StudyQuestionSetRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyQuestionSetRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyQuestionSetRecordsTable,
      StudyQuestionSetRecord,
      $$StudyQuestionSetRecordsTableFilterComposer,
      $$StudyQuestionSetRecordsTableOrderingComposer,
      $$StudyQuestionSetRecordsTableAnnotationComposer,
      $$StudyQuestionSetRecordsTableCreateCompanionBuilder,
      $$StudyQuestionSetRecordsTableUpdateCompanionBuilder,
      (
        StudyQuestionSetRecord,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyQuestionSetRecordsTable,
          StudyQuestionSetRecord
        >,
      ),
      StudyQuestionSetRecord,
      PrefetchHooks Function()
    >;
typedef $$StudyGenerationJobRecordsTableCreateCompanionBuilder =
    StudyGenerationJobRecordsCompanion Function({
      required String environment,
      required String accountId,
      required int noteId,
      required int jobId,
      Value<String?> requestedOutputsJson,
      required DateTime savedAt,
      Value<int> rowid,
    });
typedef $$StudyGenerationJobRecordsTableUpdateCompanionBuilder =
    StudyGenerationJobRecordsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<int> noteId,
      Value<int> jobId,
      Value<String?> requestedOutputsJson,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$StudyGenerationJobRecordsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyGenerationJobRecordsTable> {
  $$StudyGenerationJobRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jobId => $composableBuilder(
    column: $table.jobId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestedOutputsJson => $composableBuilder(
    column: $table.requestedOutputsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyGenerationJobRecordsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyGenerationJobRecordsTable> {
  $$StudyGenerationJobRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jobId => $composableBuilder(
    column: $table.jobId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestedOutputsJson => $composableBuilder(
    column: $table.requestedOutputsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyGenerationJobRecordsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyGenerationJobRecordsTable> {
  $$StudyGenerationJobRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get jobId =>
      $composableBuilder(column: $table.jobId, builder: (column) => column);

  GeneratedColumn<String> get requestedOutputsJson => $composableBuilder(
    column: $table.requestedOutputsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$StudyGenerationJobRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyGenerationJobRecordsTable,
          StudyGenerationJobRecord,
          $$StudyGenerationJobRecordsTableFilterComposer,
          $$StudyGenerationJobRecordsTableOrderingComposer,
          $$StudyGenerationJobRecordsTableAnnotationComposer,
          $$StudyGenerationJobRecordsTableCreateCompanionBuilder,
          $$StudyGenerationJobRecordsTableUpdateCompanionBuilder,
          (
            StudyGenerationJobRecord,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyGenerationJobRecordsTable,
              StudyGenerationJobRecord
            >,
          ),
          StudyGenerationJobRecord,
          PrefetchHooks Function()
        > {
  $$StudyGenerationJobRecordsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyGenerationJobRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyGenerationJobRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudyGenerationJobRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyGenerationJobRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<int> jobId = const Value.absent(),
                Value<String?> requestedOutputsJson = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyGenerationJobRecordsCompanion(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                jobId: jobId,
                requestedOutputsJson: requestedOutputsJson,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required int noteId,
                required int jobId,
                Value<String?> requestedOutputsJson = const Value.absent(),
                required DateTime savedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudyGenerationJobRecordsCompanion.insert(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                jobId: jobId,
                requestedOutputsJson: requestedOutputsJson,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudyGenerationJobRecordsTable,
                    StudyGenerationJobRecord
                  >(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyGenerationJobRecordsTable,
                    StudyGenerationJobRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyGenerationJobRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyGenerationJobRecordsTable,
      StudyGenerationJobRecord,
      $$StudyGenerationJobRecordsTableFilterComposer,
      $$StudyGenerationJobRecordsTableOrderingComposer,
      $$StudyGenerationJobRecordsTableAnnotationComposer,
      $$StudyGenerationJobRecordsTableCreateCompanionBuilder,
      $$StudyGenerationJobRecordsTableUpdateCompanionBuilder,
      (
        StudyGenerationJobRecord,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyGenerationJobRecordsTable,
          StudyGenerationJobRecord
        >,
      ),
      StudyGenerationJobRecord,
      PrefetchHooks Function()
    >;
typedef $$StudyPodcastRecordsTableCreateCompanionBuilder =
    StudyPodcastRecordsCompanion Function({
      required String environment,
      required String accountId,
      required int noteId,
      Value<int?> episodeId,
      required DateTime generatedAt,
      required String metadataJson,
      Value<int> rowid,
    });
typedef $$StudyPodcastRecordsTableUpdateCompanionBuilder =
    StudyPodcastRecordsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<int> noteId,
      Value<int?> episodeId,
      Value<DateTime> generatedAt,
      Value<String> metadataJson,
      Value<int> rowid,
    });

class $$StudyPodcastRecordsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyPodcastRecordsTable> {
  $$StudyPodcastRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get episodeId => $composableBuilder(
    column: $table.episodeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyPodcastRecordsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyPodcastRecordsTable> {
  $$StudyPodcastRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get episodeId => $composableBuilder(
    column: $table.episodeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyPodcastRecordsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyPodcastRecordsTable> {
  $$StudyPodcastRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get episodeId =>
      $composableBuilder(column: $table.episodeId, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );
}

class $$StudyPodcastRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyPodcastRecordsTable,
          StudyPodcastRecord,
          $$StudyPodcastRecordsTableFilterComposer,
          $$StudyPodcastRecordsTableOrderingComposer,
          $$StudyPodcastRecordsTableAnnotationComposer,
          $$StudyPodcastRecordsTableCreateCompanionBuilder,
          $$StudyPodcastRecordsTableUpdateCompanionBuilder,
          (
            StudyPodcastRecord,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyPodcastRecordsTable,
              StudyPodcastRecord
            >,
          ),
          StudyPodcastRecord,
          PrefetchHooks Function()
        > {
  $$StudyPodcastRecordsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyPodcastRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyPodcastRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyPodcastRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyPodcastRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<int?> episodeId = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPodcastRecordsCompanion(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                episodeId: episodeId,
                generatedAt: generatedAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required int noteId,
                Value<int?> episodeId = const Value.absent(),
                required DateTime generatedAt,
                required String metadataJson,
                Value<int> rowid = const Value.absent(),
              }) => StudyPodcastRecordsCompanion.insert(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                episodeId: episodeId,
                generatedAt: generatedAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyPodcastRecordsTable, StudyPodcastRecord>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyPodcastRecordsTable,
                    StudyPodcastRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyPodcastRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyPodcastRecordsTable,
      StudyPodcastRecord,
      $$StudyPodcastRecordsTableFilterComposer,
      $$StudyPodcastRecordsTableOrderingComposer,
      $$StudyPodcastRecordsTableAnnotationComposer,
      $$StudyPodcastRecordsTableCreateCompanionBuilder,
      $$StudyPodcastRecordsTableUpdateCompanionBuilder,
      (
        StudyPodcastRecord,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyPodcastRecordsTable,
          StudyPodcastRecord
        >,
      ),
      StudyPodcastRecord,
      PrefetchHooks Function()
    >;
typedef $$StudyPodcastDownloadsTableCreateCompanionBuilder =
    StudyPodcastDownloadsCompanion Function({
      required String environment,
      required String accountId,
      required int noteId,
      required String episodeKey,
      required String localPath,
      required int sizeBytes,
      required double durationSeconds,
      required String courseLabel,
      required String title,
      Value<DateTime?> downloadedAt,
      required String status,
      Value<int> rowid,
    });
typedef $$StudyPodcastDownloadsTableUpdateCompanionBuilder =
    StudyPodcastDownloadsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<int> noteId,
      Value<String> episodeKey,
      Value<String> localPath,
      Value<int> sizeBytes,
      Value<double> durationSeconds,
      Value<String> courseLabel,
      Value<String> title,
      Value<DateTime?> downloadedAt,
      Value<String> status,
      Value<int> rowid,
    });

class $$StudyPodcastDownloadsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyPodcastDownloadsTable> {
  $$StudyPodcastDownloadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseLabel => $composableBuilder(
    column: $table.courseLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyPodcastDownloadsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyPodcastDownloadsTable> {
  $$StudyPodcastDownloadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseLabel => $composableBuilder(
    column: $table.courseLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyPodcastDownloadsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyPodcastDownloadsTable> {
  $$StudyPodcastDownloadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<double> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseLabel => $composableBuilder(
    column: $table.courseLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$StudyPodcastDownloadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyPodcastDownloadsTable,
          StudyPodcastDownload,
          $$StudyPodcastDownloadsTableFilterComposer,
          $$StudyPodcastDownloadsTableOrderingComposer,
          $$StudyPodcastDownloadsTableAnnotationComposer,
          $$StudyPodcastDownloadsTableCreateCompanionBuilder,
          $$StudyPodcastDownloadsTableUpdateCompanionBuilder,
          (
            StudyPodcastDownload,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyPodcastDownloadsTable,
              StudyPodcastDownload
            >,
          ),
          StudyPodcastDownload,
          PrefetchHooks Function()
        > {
  $$StudyPodcastDownloadsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyPodcastDownloadsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyPodcastDownloadsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudyPodcastDownloadsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyPodcastDownloadsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<String> episodeKey = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<double> durationSeconds = const Value.absent(),
                Value<String> courseLabel = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> downloadedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPodcastDownloadsCompanion(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                episodeKey: episodeKey,
                localPath: localPath,
                sizeBytes: sizeBytes,
                durationSeconds: durationSeconds,
                courseLabel: courseLabel,
                title: title,
                downloadedAt: downloadedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required int noteId,
                required String episodeKey,
                required String localPath,
                required int sizeBytes,
                required double durationSeconds,
                required String courseLabel,
                required String title,
                Value<DateTime?> downloadedAt = const Value.absent(),
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => StudyPodcastDownloadsCompanion.insert(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                episodeKey: episodeKey,
                localPath: localPath,
                sizeBytes: sizeBytes,
                durationSeconds: durationSeconds,
                courseLabel: courseLabel,
                title: title,
                downloadedAt: downloadedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudyPodcastDownloadsTable,
                    StudyPodcastDownload
                  >(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyPodcastDownloadsTable,
                    StudyPodcastDownload
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyPodcastDownloadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyPodcastDownloadsTable,
      StudyPodcastDownload,
      $$StudyPodcastDownloadsTableFilterComposer,
      $$StudyPodcastDownloadsTableOrderingComposer,
      $$StudyPodcastDownloadsTableAnnotationComposer,
      $$StudyPodcastDownloadsTableCreateCompanionBuilder,
      $$StudyPodcastDownloadsTableUpdateCompanionBuilder,
      (
        StudyPodcastDownload,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyPodcastDownloadsTable,
          StudyPodcastDownload
        >,
      ),
      StudyPodcastDownload,
      PrefetchHooks Function()
    >;
typedef $$StudyPlaybackPositionsTableCreateCompanionBuilder =
    StudyPlaybackPositionsCompanion Function({
      required String environment,
      required String accountId,
      required int noteId,
      required String episodeKey,
      required int positionMilliseconds,
      Value<double> speed,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$StudyPlaybackPositionsTableUpdateCompanionBuilder =
    StudyPlaybackPositionsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<int> noteId,
      Value<String> episodeKey,
      Value<int> positionMilliseconds,
      Value<double> speed,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$StudyPlaybackPositionsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyPlaybackPositionsTable> {
  $$StudyPlaybackPositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get positionMilliseconds => $composableBuilder(
    column: $table.positionMilliseconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyPlaybackPositionsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyPlaybackPositionsTable> {
  $$StudyPlaybackPositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get positionMilliseconds => $composableBuilder(
    column: $table.positionMilliseconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyPlaybackPositionsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyPlaybackPositionsTable> {
  $$StudyPlaybackPositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get positionMilliseconds => $composableBuilder(
    column: $table.positionMilliseconds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudyPlaybackPositionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyPlaybackPositionsTable,
          StudyPlaybackPosition,
          $$StudyPlaybackPositionsTableFilterComposer,
          $$StudyPlaybackPositionsTableOrderingComposer,
          $$StudyPlaybackPositionsTableAnnotationComposer,
          $$StudyPlaybackPositionsTableCreateCompanionBuilder,
          $$StudyPlaybackPositionsTableUpdateCompanionBuilder,
          (
            StudyPlaybackPosition,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyPlaybackPositionsTable,
              StudyPlaybackPosition
            >,
          ),
          StudyPlaybackPosition,
          PrefetchHooks Function()
        > {
  $$StudyPlaybackPositionsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyPlaybackPositionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyPlaybackPositionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudyPlaybackPositionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyPlaybackPositionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<String> episodeKey = const Value.absent(),
                Value<int> positionMilliseconds = const Value.absent(),
                Value<double> speed = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPlaybackPositionsCompanion(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                episodeKey: episodeKey,
                positionMilliseconds: positionMilliseconds,
                speed: speed,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required int noteId,
                required String episodeKey,
                required int positionMilliseconds,
                Value<double> speed = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudyPlaybackPositionsCompanion.insert(
                environment: environment,
                accountId: accountId,
                noteId: noteId,
                episodeKey: episodeKey,
                positionMilliseconds: positionMilliseconds,
                speed: speed,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudyPlaybackPositionsTable,
                    StudyPlaybackPosition
                  >(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyPlaybackPositionsTable,
                    StudyPlaybackPosition
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyPlaybackPositionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyPlaybackPositionsTable,
      StudyPlaybackPosition,
      $$StudyPlaybackPositionsTableFilterComposer,
      $$StudyPlaybackPositionsTableOrderingComposer,
      $$StudyPlaybackPositionsTableAnnotationComposer,
      $$StudyPlaybackPositionsTableCreateCompanionBuilder,
      $$StudyPlaybackPositionsTableUpdateCompanionBuilder,
      (
        StudyPlaybackPosition,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyPlaybackPositionsTable,
          StudyPlaybackPosition
        >,
      ),
      StudyPlaybackPosition,
      PrefetchHooks Function()
    >;
typedef $$StudyOfflineEntitlementSnapshotsTableCreateCompanionBuilder =
    StudyOfflineEntitlementSnapshotsCompanion Function({
      required String environment,
      required String accountId,
      required String state,
      Value<DateTime?> currentPeriodStart,
      Value<DateTime?> currentPeriodEnd,
      required DateTime verifiedAt,
      Value<int> rowid,
    });
typedef $$StudyOfflineEntitlementSnapshotsTableUpdateCompanionBuilder =
    StudyOfflineEntitlementSnapshotsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<String> state,
      Value<DateTime?> currentPeriodStart,
      Value<DateTime?> currentPeriodEnd,
      Value<DateTime> verifiedAt,
      Value<int> rowid,
    });

class $$StudyOfflineEntitlementSnapshotsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyOfflineEntitlementSnapshotsTable> {
  $$StudyOfflineEntitlementSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyOfflineEntitlementSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyOfflineEntitlementSnapshotsTable> {
  $$StudyOfflineEntitlementSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyOfflineEntitlementSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyOfflineEntitlementSnapshotsTable> {
  $$StudyOfflineEntitlementSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => column,
  );
}

class $$StudyOfflineEntitlementSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyOfflineEntitlementSnapshotsTable,
          StudyOfflineEntitlementSnapshot,
          $$StudyOfflineEntitlementSnapshotsTableFilterComposer,
          $$StudyOfflineEntitlementSnapshotsTableOrderingComposer,
          $$StudyOfflineEntitlementSnapshotsTableAnnotationComposer,
          $$StudyOfflineEntitlementSnapshotsTableCreateCompanionBuilder,
          $$StudyOfflineEntitlementSnapshotsTableUpdateCompanionBuilder,
          (
            StudyOfflineEntitlementSnapshot,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyOfflineEntitlementSnapshotsTable,
              StudyOfflineEntitlementSnapshot
            >,
          ),
          StudyOfflineEntitlementSnapshot,
          PrefetchHooks Function()
        > {
  $$StudyOfflineEntitlementSnapshotsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyOfflineEntitlementSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyOfflineEntitlementSnapshotsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudyOfflineEntitlementSnapshotsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyOfflineEntitlementSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<DateTime?> currentPeriodStart = const Value.absent(),
                Value<DateTime?> currentPeriodEnd = const Value.absent(),
                Value<DateTime> verifiedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyOfflineEntitlementSnapshotsCompanion(
                environment: environment,
                accountId: accountId,
                state: state,
                currentPeriodStart: currentPeriodStart,
                currentPeriodEnd: currentPeriodEnd,
                verifiedAt: verifiedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required String state,
                Value<DateTime?> currentPeriodStart = const Value.absent(),
                Value<DateTime?> currentPeriodEnd = const Value.absent(),
                required DateTime verifiedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudyOfflineEntitlementSnapshotsCompanion.insert(
                environment: environment,
                accountId: accountId,
                state: state,
                currentPeriodStart: currentPeriodStart,
                currentPeriodEnd: currentPeriodEnd,
                verifiedAt: verifiedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $StudyOfflineEntitlementSnapshotsTable,
                    StudyOfflineEntitlementSnapshot
                  >(table),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyOfflineEntitlementSnapshotsTable,
                    StudyOfflineEntitlementSnapshot
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyOfflineEntitlementSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyOfflineEntitlementSnapshotsTable,
      StudyOfflineEntitlementSnapshot,
      $$StudyOfflineEntitlementSnapshotsTableFilterComposer,
      $$StudyOfflineEntitlementSnapshotsTableOrderingComposer,
      $$StudyOfflineEntitlementSnapshotsTableAnnotationComposer,
      $$StudyOfflineEntitlementSnapshotsTableCreateCompanionBuilder,
      $$StudyOfflineEntitlementSnapshotsTableUpdateCompanionBuilder,
      (
        StudyOfflineEntitlementSnapshot,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyOfflineEntitlementSnapshotsTable,
          StudyOfflineEntitlementSnapshot
        >,
      ),
      StudyOfflineEntitlementSnapshot,
      PrefetchHooks Function()
    >;
typedef $$StudyLegacyImportsTableCreateCompanionBuilder =
    StudyLegacyImportsCompanion Function({
      required String environment,
      required String accountId,
      required String legacyKeysJson,
      required DateTime importedAt,
      Value<int> rowid,
    });
typedef $$StudyLegacyImportsTableUpdateCompanionBuilder =
    StudyLegacyImportsCompanion Function({
      Value<String> environment,
      Value<String> accountId,
      Value<String> legacyKeysJson,
      Value<DateTime> importedAt,
      Value<int> rowid,
    });

class $$StudyLegacyImportsTableFilterComposer
    extends Composer<_$AppDatabaseV2, $StudyLegacyImportsTable> {
  $$StudyLegacyImportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legacyKeysJson => $composableBuilder(
    column: $table.legacyKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyLegacyImportsTableOrderingComposer
    extends Composer<_$AppDatabaseV2, $StudyLegacyImportsTable> {
  $$StudyLegacyImportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legacyKeysJson => $composableBuilder(
    column: $table.legacyKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyLegacyImportsTableAnnotationComposer
    extends Composer<_$AppDatabaseV2, $StudyLegacyImportsTable> {
  $$StudyLegacyImportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environment => $composableBuilder(
    column: $table.environment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get legacyKeysJson => $composableBuilder(
    column: $table.legacyKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );
}

class $$StudyLegacyImportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabaseV2,
          $StudyLegacyImportsTable,
          StudyLegacyImport,
          $$StudyLegacyImportsTableFilterComposer,
          $$StudyLegacyImportsTableOrderingComposer,
          $$StudyLegacyImportsTableAnnotationComposer,
          $$StudyLegacyImportsTableCreateCompanionBuilder,
          $$StudyLegacyImportsTableUpdateCompanionBuilder,
          (
            StudyLegacyImport,
            BaseReferences<
              _$AppDatabaseV2,
              $StudyLegacyImportsTable,
              StudyLegacyImport
            >,
          ),
          StudyLegacyImport,
          PrefetchHooks Function()
        > {
  $$StudyLegacyImportsTableTableManager(
    _$AppDatabaseV2 db,
    $StudyLegacyImportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyLegacyImportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyLegacyImportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyLegacyImportsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> environment = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> legacyKeysJson = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyLegacyImportsCompanion(
                environment: environment,
                accountId: accountId,
                legacyKeysJson: legacyKeysJson,
                importedAt: importedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environment,
                required String accountId,
                required String legacyKeysJson,
                required DateTime importedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudyLegacyImportsCompanion.insert(
                environment: environment,
                accountId: accountId,
                legacyKeysJson: legacyKeysJson,
                importedAt: importedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyLegacyImportsTable, StudyLegacyImport>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabaseV2,
                    $StudyLegacyImportsTable,
                    StudyLegacyImport
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyLegacyImportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabaseV2,
      $StudyLegacyImportsTable,
      StudyLegacyImport,
      $$StudyLegacyImportsTableFilterComposer,
      $$StudyLegacyImportsTableOrderingComposer,
      $$StudyLegacyImportsTableAnnotationComposer,
      $$StudyLegacyImportsTableCreateCompanionBuilder,
      $$StudyLegacyImportsTableUpdateCompanionBuilder,
      (
        StudyLegacyImport,
        BaseReferences<
          _$AppDatabaseV2,
          $StudyLegacyImportsTable,
          StudyLegacyImport
        >,
      ),
      StudyLegacyImport,
      PrefetchHooks Function()
    >;

class $AppDatabaseV2Manager {
  final _$AppDatabaseV2 _db;
  $AppDatabaseV2Manager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$BillingOrdersTableTableManager get billingOrders =>
      $$BillingOrdersTableTableManager(_db, _db.billingOrders);
  $$BillingOrderItemsTableTableManager get billingOrderItems =>
      $$BillingOrderItemsTableTableManager(_db, _db.billingOrderItems);
  $$BillingSubscriptionsTableTableManager get billingSubscriptions =>
      $$BillingSubscriptionsTableTableManager(_db, _db.billingSubscriptions);
  $$BillingSubscriptionStatusesTableTableManager
  get billingSubscriptionStatuses =>
      $$BillingSubscriptionStatusesTableTableManager(
        _db,
        _db.billingSubscriptionStatuses,
      );
  $$BillingEntitlementsTableTableManager get billingEntitlements =>
      $$BillingEntitlementsTableTableManager(_db, _db.billingEntitlements);
  $$LockInRuleRecordsTableTableManager get lockInRuleRecords =>
      $$LockInRuleRecordsTableTableManager(_db, _db.lockInRuleRecords);
  $$LockInAttemptsTableTableManager get lockInAttempts =>
      $$LockInAttemptsTableTableManager(_db, _db.lockInAttempts);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$LecturersTableTableManager get lecturers =>
      $$LecturersTableTableManager(_db, _db.lecturers);
  $$ScheduleEntriesTableTableManager get scheduleEntries =>
      $$ScheduleEntriesTableTableManager(_db, _db.scheduleEntries);
  $$TodoListsTableTableManager get todoLists =>
      $$TodoListsTableTableManager(_db, _db.todoLists);
  $$TodoTagItemsTableTableManager get todoTagItems =>
      $$TodoTagItemsTableTableManager(_db, _db.todoTagItems);
  $$TodoItemsTableTableManager get todoItems =>
      $$TodoItemsTableTableManager(_db, _db.todoItems);
  $$TodoItemTagsTableTableManager get todoItemTags =>
      $$TodoItemTagsTableTableManager(_db, _db.todoItemTags);
  $$StudyMaterialRecordsTableTableManager get studyMaterialRecords =>
      $$StudyMaterialRecordsTableTableManager(_db, _db.studyMaterialRecords);
  $$StudyQuestionSetRecordsTableTableManager get studyQuestionSetRecords =>
      $$StudyQuestionSetRecordsTableTableManager(
        _db,
        _db.studyQuestionSetRecords,
      );
  $$StudyGenerationJobRecordsTableTableManager get studyGenerationJobRecords =>
      $$StudyGenerationJobRecordsTableTableManager(
        _db,
        _db.studyGenerationJobRecords,
      );
  $$StudyPodcastRecordsTableTableManager get studyPodcastRecords =>
      $$StudyPodcastRecordsTableTableManager(_db, _db.studyPodcastRecords);
  $$StudyPodcastDownloadsTableTableManager get studyPodcastDownloads =>
      $$StudyPodcastDownloadsTableTableManager(_db, _db.studyPodcastDownloads);
  $$StudyPlaybackPositionsTableTableManager get studyPlaybackPositions =>
      $$StudyPlaybackPositionsTableTableManager(
        _db,
        _db.studyPlaybackPositions,
      );
  $$StudyOfflineEntitlementSnapshotsTableTableManager
  get studyOfflineEntitlementSnapshots =>
      $$StudyOfflineEntitlementSnapshotsTableTableManager(
        _db,
        _db.studyOfflineEntitlementSnapshots,
      );
  $$StudyLegacyImportsTableTableManager get studyLegacyImports =>
      $$StudyLegacyImportsTableTableManager(_db, _db.studyLegacyImports);
}
