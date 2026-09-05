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

abstract class _$AppDatabaseV2 extends GeneratedDatabase {
  _$AppDatabaseV2(QueryExecutor e) : super(e);
  $AppDatabaseV2Manager get managers => $AppDatabaseV2Manager(this);
  late final $PlansTable plans = $PlansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [plans];
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

class $AppDatabaseV2Manager {
  final _$AppDatabaseV2 _db;
  $AppDatabaseV2Manager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
}
