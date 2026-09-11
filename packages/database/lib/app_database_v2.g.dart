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
  late final PlanDao planDao = PlanDao(this as AppDatabaseV2);
  late final OrderDao orderDao = OrderDao(this as AppDatabaseV2);
  late final SubscriptionDao subscriptionDao = SubscriptionDao(
    this as AppDatabaseV2,
  );
  late final EntitlementDao entitlementDao = EntitlementDao(
    this as AppDatabaseV2,
  );
  late final LockInDao lockInDao = LockInDao(this as AppDatabaseV2);
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
  ];
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
}
