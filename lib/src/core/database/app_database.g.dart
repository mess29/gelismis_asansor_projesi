// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    username,
    fullName,
    companyName,
    token,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String serverId;
  final String username;
  final String fullName;
  final String companyName;
  final String? token;
  const User({
    required this.id,
    required this.serverId,
    required this.username,
    required this.fullName,
    required this.companyName,
    this.token,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['username'] = Variable<String>(username);
    map['full_name'] = Variable<String>(fullName);
    map['company_name'] = Variable<String>(companyName);
    if (!nullToAbsent || token != null) {
      map['token'] = Variable<String>(token);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      serverId: Value(serverId),
      username: Value(username),
      fullName: Value(fullName),
      companyName: Value(companyName),
      token: token == null && nullToAbsent
          ? const Value.absent()
          : Value(token),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      username: serializer.fromJson<String>(json['username']),
      fullName: serializer.fromJson<String>(json['fullName']),
      companyName: serializer.fromJson<String>(json['companyName']),
      token: serializer.fromJson<String?>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'username': serializer.toJson<String>(username),
      'fullName': serializer.toJson<String>(fullName),
      'companyName': serializer.toJson<String>(companyName),
      'token': serializer.toJson<String?>(token),
    };
  }

  User copyWith({
    int? id,
    String? serverId,
    String? username,
    String? fullName,
    String? companyName,
    Value<String?> token = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    username: username ?? this.username,
    fullName: fullName ?? this.fullName,
    companyName: companyName ?? this.companyName,
    token: token.present ? token.value : this.token,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      username: data.username.present ? data.username.value : this.username,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      token: data.token.present ? data.token.value : this.token,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('companyName: $companyName, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, serverId, username, fullName, companyName, token);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.username == this.username &&
          other.fullName == this.fullName &&
          other.companyName == this.companyName &&
          other.token == this.token);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<String> username;
  final Value<String> fullName;
  final Value<String> companyName;
  final Value<String?> token;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.username = const Value.absent(),
    this.fullName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.token = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required String username,
    required String fullName,
    required String companyName,
    this.token = const Value.absent(),
  }) : serverId = Value(serverId),
       username = Value(username),
       fullName = Value(fullName),
       companyName = Value(companyName);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? username,
    Expression<String>? fullName,
    Expression<String>? companyName,
    Expression<String>? token,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (username != null) 'username': username,
      if (fullName != null) 'full_name': fullName,
      if (companyName != null) 'company_name': companyName,
      if (token != null) 'token': token,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<String>? username,
    Value<String>? fullName,
    Value<String>? companyName,
    Value<String?>? token,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      companyName: companyName ?? this.companyName,
      token: token ?? this.token,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('companyName: $companyName, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceGroupsTable extends MaintenanceGroups
    with TableInfo<$MaintenanceGroupsTable, MaintenanceGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceGroupsTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceGroup> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $MaintenanceGroupsTable createAlias(String alias) {
    return $MaintenanceGroupsTable(attachedDatabase, alias);
  }
}

class MaintenanceGroup extends DataClass
    implements Insertable<MaintenanceGroup> {
  final int id;
  final String name;
  const MaintenanceGroup({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  MaintenanceGroupsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceGroupsCompanion(id: Value(id), name: Value(name));
  }

  factory MaintenanceGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceGroup(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  MaintenanceGroup copyWith({int? id, String? name}) =>
      MaintenanceGroup(id: id ?? this.id, name: name ?? this.name);
  MaintenanceGroup copyWithCompanion(MaintenanceGroupsCompanion data) {
    return MaintenanceGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceGroup(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceGroup &&
          other.id == this.id &&
          other.name == this.name);
}

class MaintenanceGroupsCompanion extends UpdateCompanion<MaintenanceGroup> {
  final Value<int> id;
  final Value<String> name;
  const MaintenanceGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MaintenanceGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<MaintenanceGroup> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  MaintenanceGroupsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return MaintenanceGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorizedPersonMeta = const VerificationMeta(
    'authorizedPerson',
  );
  @override
  late final GeneratedColumn<String> authorizedPerson = GeneratedColumn<String>(
    'authorized_person',
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlyMaintenanceFeeMeta =
      const VerificationMeta('monthlyMaintenanceFee');
  @override
  late final GeneratedColumn<double> monthlyMaintenanceFee =
      GeneratedColumn<double>(
        'monthly_maintenance_fee',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastFeeDateMeta = const VerificationMeta(
    'lastFeeDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastFeeDate = GeneratedColumn<DateTime>(
    'last_fee_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  transactionHistory =
      GeneratedColumn<String>(
        'transaction_history',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $CustomersTable.$convertertransactionHistory,
      );
  static const VerificationMeta _maintenanceGroupIdMeta =
      const VerificationMeta('maintenanceGroupId');
  @override
  late final GeneratedColumn<int> maintenanceGroupId = GeneratedColumn<int>(
    'maintenance_group_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES maintenance_groups (id)',
    ),
  );
  static const VerificationMeta _lastUpdatedLocalMeta = const VerificationMeta(
    'lastUpdatedLocal',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedLocal =
      GeneratedColumn<DateTime>(
        'last_updated_local',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isApprovedMeta = const VerificationMeta(
    'isApproved',
  );
  @override
  late final GeneratedColumn<bool> isApproved = GeneratedColumn<bool>(
    'is_approved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_approved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    name,
    address,
    city,
    district,
    latitude,
    longitude,
    authorizedPerson,
    phone,
    notes,
    monthlyMaintenanceFee,
    balance,
    lastFeeDate,
    transactionHistory,
    maintenanceGroupId,
    lastUpdatedLocal,
    isSynced,
    isApproved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('authorized_person')) {
      context.handle(
        _authorizedPersonMeta,
        authorizedPerson.isAcceptableOrUnknown(
          data['authorized_person']!,
          _authorizedPersonMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('monthly_maintenance_fee')) {
      context.handle(
        _monthlyMaintenanceFeeMeta,
        monthlyMaintenanceFee.isAcceptableOrUnknown(
          data['monthly_maintenance_fee']!,
          _monthlyMaintenanceFeeMeta,
        ),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('last_fee_date')) {
      context.handle(
        _lastFeeDateMeta,
        lastFeeDate.isAcceptableOrUnknown(
          data['last_fee_date']!,
          _lastFeeDateMeta,
        ),
      );
    }
    if (data.containsKey('maintenance_group_id')) {
      context.handle(
        _maintenanceGroupIdMeta,
        maintenanceGroupId.isAcceptableOrUnknown(
          data['maintenance_group_id']!,
          _maintenanceGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('last_updated_local')) {
      context.handle(
        _lastUpdatedLocalMeta,
        lastUpdatedLocal.isAcceptableOrUnknown(
          data['last_updated_local']!,
          _lastUpdatedLocalMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_approved')) {
      context.handle(
        _isApprovedMeta,
        isApproved.isAcceptableOrUnknown(data['is_approved']!, _isApprovedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      authorizedPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}authorized_person'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      monthlyMaintenanceFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_maintenance_fee'],
      ),
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      lastFeeDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_fee_date'],
      ),
      transactionHistory: $CustomersTable.$convertertransactionHistory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}transaction_history'],
        )!,
      ),
      maintenanceGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maintenance_group_id'],
      ),
      lastUpdatedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_local'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isApproved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_approved'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Map<String, dynamic>>, String>
  $convertertransactionHistory = const JsonListConverter();
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String serverId;
  final String name;
  final String address;
  final String city;
  final String district;
  final double? latitude;
  final double? longitude;
  final String? authorizedPerson;
  final String? phone;
  final String? notes;
  final double? monthlyMaintenanceFee;
  final double balance;
  final DateTime? lastFeeDate;
  final List<Map<String, dynamic>> transactionHistory;
  final int? maintenanceGroupId;
  final DateTime? lastUpdatedLocal;
  final bool isSynced;
  final bool isApproved;
  const Customer({
    required this.id,
    required this.serverId,
    required this.name,
    required this.address,
    required this.city,
    required this.district,
    this.latitude,
    this.longitude,
    this.authorizedPerson,
    this.phone,
    this.notes,
    this.monthlyMaintenanceFee,
    required this.balance,
    this.lastFeeDate,
    required this.transactionHistory,
    this.maintenanceGroupId,
    this.lastUpdatedLocal,
    required this.isSynced,
    required this.isApproved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    map['district'] = Variable<String>(district);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || authorizedPerson != null) {
      map['authorized_person'] = Variable<String>(authorizedPerson);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || monthlyMaintenanceFee != null) {
      map['monthly_maintenance_fee'] = Variable<double>(monthlyMaintenanceFee);
    }
    map['balance'] = Variable<double>(balance);
    if (!nullToAbsent || lastFeeDate != null) {
      map['last_fee_date'] = Variable<DateTime>(lastFeeDate);
    }
    {
      map['transaction_history'] = Variable<String>(
        $CustomersTable.$convertertransactionHistory.toSql(transactionHistory),
      );
    }
    if (!nullToAbsent || maintenanceGroupId != null) {
      map['maintenance_group_id'] = Variable<int>(maintenanceGroupId);
    }
    if (!nullToAbsent || lastUpdatedLocal != null) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_approved'] = Variable<bool>(isApproved);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      serverId: Value(serverId),
      name: Value(name),
      address: Value(address),
      city: Value(city),
      district: Value(district),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      authorizedPerson: authorizedPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(authorizedPerson),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      monthlyMaintenanceFee: monthlyMaintenanceFee == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyMaintenanceFee),
      balance: Value(balance),
      lastFeeDate: lastFeeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFeeDate),
      transactionHistory: Value(transactionHistory),
      maintenanceGroupId: maintenanceGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(maintenanceGroupId),
      lastUpdatedLocal: lastUpdatedLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedLocal),
      isSynced: Value(isSynced),
      isApproved: Value(isApproved),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      district: serializer.fromJson<String>(json['district']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      authorizedPerson: serializer.fromJson<String?>(json['authorizedPerson']),
      phone: serializer.fromJson<String?>(json['phone']),
      notes: serializer.fromJson<String?>(json['notes']),
      monthlyMaintenanceFee: serializer.fromJson<double?>(
        json['monthlyMaintenanceFee'],
      ),
      balance: serializer.fromJson<double>(json['balance']),
      lastFeeDate: serializer.fromJson<DateTime?>(json['lastFeeDate']),
      transactionHistory: serializer.fromJson<List<Map<String, dynamic>>>(
        json['transactionHistory'],
      ),
      maintenanceGroupId: serializer.fromJson<int?>(json['maintenanceGroupId']),
      lastUpdatedLocal: serializer.fromJson<DateTime?>(
        json['lastUpdatedLocal'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isApproved: serializer.fromJson<bool>(json['isApproved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'district': serializer.toJson<String>(district),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'authorizedPerson': serializer.toJson<String?>(authorizedPerson),
      'phone': serializer.toJson<String?>(phone),
      'notes': serializer.toJson<String?>(notes),
      'monthlyMaintenanceFee': serializer.toJson<double?>(
        monthlyMaintenanceFee,
      ),
      'balance': serializer.toJson<double>(balance),
      'lastFeeDate': serializer.toJson<DateTime?>(lastFeeDate),
      'transactionHistory': serializer.toJson<List<Map<String, dynamic>>>(
        transactionHistory,
      ),
      'maintenanceGroupId': serializer.toJson<int?>(maintenanceGroupId),
      'lastUpdatedLocal': serializer.toJson<DateTime?>(lastUpdatedLocal),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isApproved': serializer.toJson<bool>(isApproved),
    };
  }

  Customer copyWith({
    int? id,
    String? serverId,
    String? name,
    String? address,
    String? city,
    String? district,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> authorizedPerson = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<double?> monthlyMaintenanceFee = const Value.absent(),
    double? balance,
    Value<DateTime?> lastFeeDate = const Value.absent(),
    List<Map<String, dynamic>>? transactionHistory,
    Value<int?> maintenanceGroupId = const Value.absent(),
    Value<DateTime?> lastUpdatedLocal = const Value.absent(),
    bool? isSynced,
    bool? isApproved,
  }) => Customer(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    name: name ?? this.name,
    address: address ?? this.address,
    city: city ?? this.city,
    district: district ?? this.district,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    authorizedPerson: authorizedPerson.present
        ? authorizedPerson.value
        : this.authorizedPerson,
    phone: phone.present ? phone.value : this.phone,
    notes: notes.present ? notes.value : this.notes,
    monthlyMaintenanceFee: monthlyMaintenanceFee.present
        ? monthlyMaintenanceFee.value
        : this.monthlyMaintenanceFee,
    balance: balance ?? this.balance,
    lastFeeDate: lastFeeDate.present ? lastFeeDate.value : this.lastFeeDate,
    transactionHistory: transactionHistory ?? this.transactionHistory,
    maintenanceGroupId: maintenanceGroupId.present
        ? maintenanceGroupId.value
        : this.maintenanceGroupId,
    lastUpdatedLocal: lastUpdatedLocal.present
        ? lastUpdatedLocal.value
        : this.lastUpdatedLocal,
    isSynced: isSynced ?? this.isSynced,
    isApproved: isApproved ?? this.isApproved,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      district: data.district.present ? data.district.value : this.district,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      authorizedPerson: data.authorizedPerson.present
          ? data.authorizedPerson.value
          : this.authorizedPerson,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      monthlyMaintenanceFee: data.monthlyMaintenanceFee.present
          ? data.monthlyMaintenanceFee.value
          : this.monthlyMaintenanceFee,
      balance: data.balance.present ? data.balance.value : this.balance,
      lastFeeDate: data.lastFeeDate.present
          ? data.lastFeeDate.value
          : this.lastFeeDate,
      transactionHistory: data.transactionHistory.present
          ? data.transactionHistory.value
          : this.transactionHistory,
      maintenanceGroupId: data.maintenanceGroupId.present
          ? data.maintenanceGroupId.value
          : this.maintenanceGroupId,
      lastUpdatedLocal: data.lastUpdatedLocal.present
          ? data.lastUpdatedLocal.value
          : this.lastUpdatedLocal,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isApproved: data.isApproved.present
          ? data.isApproved.value
          : this.isApproved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('district: $district, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('authorizedPerson: $authorizedPerson, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('monthlyMaintenanceFee: $monthlyMaintenanceFee, ')
          ..write('balance: $balance, ')
          ..write('lastFeeDate: $lastFeeDate, ')
          ..write('transactionHistory: $transactionHistory, ')
          ..write('maintenanceGroupId: $maintenanceGroupId, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal, ')
          ..write('isSynced: $isSynced, ')
          ..write('isApproved: $isApproved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    name,
    address,
    city,
    district,
    latitude,
    longitude,
    authorizedPerson,
    phone,
    notes,
    monthlyMaintenanceFee,
    balance,
    lastFeeDate,
    transactionHistory,
    maintenanceGroupId,
    lastUpdatedLocal,
    isSynced,
    isApproved,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.name == this.name &&
          other.address == this.address &&
          other.city == this.city &&
          other.district == this.district &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.authorizedPerson == this.authorizedPerson &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.monthlyMaintenanceFee == this.monthlyMaintenanceFee &&
          other.balance == this.balance &&
          other.lastFeeDate == this.lastFeeDate &&
          other.transactionHistory == this.transactionHistory &&
          other.maintenanceGroupId == this.maintenanceGroupId &&
          other.lastUpdatedLocal == this.lastUpdatedLocal &&
          other.isSynced == this.isSynced &&
          other.isApproved == this.isApproved);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<String> name;
  final Value<String> address;
  final Value<String> city;
  final Value<String> district;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> authorizedPerson;
  final Value<String?> phone;
  final Value<String?> notes;
  final Value<double?> monthlyMaintenanceFee;
  final Value<double> balance;
  final Value<DateTime?> lastFeeDate;
  final Value<List<Map<String, dynamic>>> transactionHistory;
  final Value<int?> maintenanceGroupId;
  final Value<DateTime?> lastUpdatedLocal;
  final Value<bool> isSynced;
  final Value<bool> isApproved;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.district = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.authorizedPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.monthlyMaintenanceFee = const Value.absent(),
    this.balance = const Value.absent(),
    this.lastFeeDate = const Value.absent(),
    this.transactionHistory = const Value.absent(),
    this.maintenanceGroupId = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isApproved = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required String name,
    required String address,
    required String city,
    required String district,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.authorizedPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.monthlyMaintenanceFee = const Value.absent(),
    this.balance = const Value.absent(),
    this.lastFeeDate = const Value.absent(),
    this.transactionHistory = const Value.absent(),
    this.maintenanceGroupId = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isApproved = const Value.absent(),
  }) : serverId = Value(serverId),
       name = Value(name),
       address = Value(address),
       city = Value(city),
       district = Value(district);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? district,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? authorizedPerson,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<double>? monthlyMaintenanceFee,
    Expression<double>? balance,
    Expression<DateTime>? lastFeeDate,
    Expression<String>? transactionHistory,
    Expression<int>? maintenanceGroupId,
    Expression<DateTime>? lastUpdatedLocal,
    Expression<bool>? isSynced,
    Expression<bool>? isApproved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (district != null) 'district': district,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (authorizedPerson != null) 'authorized_person': authorizedPerson,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (monthlyMaintenanceFee != null)
        'monthly_maintenance_fee': monthlyMaintenanceFee,
      if (balance != null) 'balance': balance,
      if (lastFeeDate != null) 'last_fee_date': lastFeeDate,
      if (transactionHistory != null) 'transaction_history': transactionHistory,
      if (maintenanceGroupId != null)
        'maintenance_group_id': maintenanceGroupId,
      if (lastUpdatedLocal != null) 'last_updated_local': lastUpdatedLocal,
      if (isSynced != null) 'is_synced': isSynced,
      if (isApproved != null) 'is_approved': isApproved,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<String>? name,
    Value<String>? address,
    Value<String>? city,
    Value<String>? district,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? authorizedPerson,
    Value<String?>? phone,
    Value<String?>? notes,
    Value<double?>? monthlyMaintenanceFee,
    Value<double>? balance,
    Value<DateTime?>? lastFeeDate,
    Value<List<Map<String, dynamic>>>? transactionHistory,
    Value<int?>? maintenanceGroupId,
    Value<DateTime?>? lastUpdatedLocal,
    Value<bool>? isSynced,
    Value<bool>? isApproved,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      authorizedPerson: authorizedPerson ?? this.authorizedPerson,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      monthlyMaintenanceFee:
          monthlyMaintenanceFee ?? this.monthlyMaintenanceFee,
      balance: balance ?? this.balance,
      lastFeeDate: lastFeeDate ?? this.lastFeeDate,
      transactionHistory: transactionHistory ?? this.transactionHistory,
      maintenanceGroupId: maintenanceGroupId ?? this.maintenanceGroupId,
      lastUpdatedLocal: lastUpdatedLocal ?? this.lastUpdatedLocal,
      isSynced: isSynced ?? this.isSynced,
      isApproved: isApproved ?? this.isApproved,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (authorizedPerson.present) {
      map['authorized_person'] = Variable<String>(authorizedPerson.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (monthlyMaintenanceFee.present) {
      map['monthly_maintenance_fee'] = Variable<double>(
        monthlyMaintenanceFee.value,
      );
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (lastFeeDate.present) {
      map['last_fee_date'] = Variable<DateTime>(lastFeeDate.value);
    }
    if (transactionHistory.present) {
      map['transaction_history'] = Variable<String>(
        $CustomersTable.$convertertransactionHistory.toSql(
          transactionHistory.value,
        ),
      );
    }
    if (maintenanceGroupId.present) {
      map['maintenance_group_id'] = Variable<int>(maintenanceGroupId.value);
    }
    if (lastUpdatedLocal.present) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isApproved.present) {
      map['is_approved'] = Variable<bool>(isApproved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('district: $district, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('authorizedPerson: $authorizedPerson, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('monthlyMaintenanceFee: $monthlyMaintenanceFee, ')
          ..write('balance: $balance, ')
          ..write('lastFeeDate: $lastFeeDate, ')
          ..write('transactionHistory: $transactionHistory, ')
          ..write('maintenanceGroupId: $maintenanceGroupId, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal, ')
          ..write('isSynced: $isSynced, ')
          ..write('isApproved: $isApproved')
          ..write(')'))
        .toString();
  }
}

class $ElevatorsTable extends Elevators
    with TableInfo<$ElevatorsTable, Elevator> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElevatorsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idNumberMeta = const VerificationMeta(
    'idNumber',
  );
  @override
  late final GeneratedColumn<String> idNumber = GeneratedColumn<String>(
    'id_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ElevatorType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ElevatorType>($ElevatorsTable.$convertertype);
  static const VerificationMeta _usageTypeDetailMeta = const VerificationMeta(
    'usageTypeDetail',
  );
  @override
  late final GeneratedColumn<String> usageTypeDetail = GeneratedColumn<String>(
    'usage_type_detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _driveTypeMeta = const VerificationMeta(
    'driveType',
  );
  @override
  late final GeneratedColumn<String> driveType = GeneratedColumn<String>(
    'drive_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityPersonMeta = const VerificationMeta(
    'capacityPerson',
  );
  @override
  late final GeneratedColumn<int> capacityPerson = GeneratedColumn<int>(
    'capacity_person',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityWeightMeta = const VerificationMeta(
    'capacityWeight',
  );
  @override
  late final GeneratedColumn<int> capacityWeight = GeneratedColumn<int>(
    'capacity_weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stopsMeta = const VerificationMeta('stops');
  @override
  late final GeneratedColumn<int> stops = GeneratedColumn<int>(
    'stops',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ElevatorTagColor, int> tagColor =
      GeneratedColumn<int>(
        'tag_color',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(4),
      ).withConverter<ElevatorTagColor>($ElevatorsTable.$convertertagColor);
  static const VerificationMeta _tagDateMeta = const VerificationMeta(
    'tagDate',
  );
  @override
  late final GeneratedColumn<DateTime> tagDate = GeneratedColumn<DateTime>(
    'tag_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  pendingMaintenanceTasks =
      GeneratedColumn<String>(
        'pending_maintenance_tasks',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $ElevatorsTable.$converterpendingMaintenanceTasks,
      );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _lastUpdatedLocalMeta = const VerificationMeta(
    'lastUpdatedLocal',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedLocal =
      GeneratedColumn<DateTime>(
        'last_updated_local',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isApprovedMeta = const VerificationMeta(
    'isApproved',
  );
  @override
  late final GeneratedColumn<bool> isApproved = GeneratedColumn<bool>(
    'is_approved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_approved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    code,
    idNumber,
    name,
    type,
    usageTypeDetail,
    driveType,
    capacityPerson,
    capacityWeight,
    stops,
    speed,
    tagColor,
    tagDate,
    pendingMaintenanceTasks,
    customerId,
    lastUpdatedLocal,
    isSynced,
    isApproved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'elevators';
  @override
  VerificationContext validateIntegrity(
    Insertable<Elevator> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('id_number')) {
      context.handle(
        _idNumberMeta,
        idNumber.isAcceptableOrUnknown(data['id_number']!, _idNumberMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('usage_type_detail')) {
      context.handle(
        _usageTypeDetailMeta,
        usageTypeDetail.isAcceptableOrUnknown(
          data['usage_type_detail']!,
          _usageTypeDetailMeta,
        ),
      );
    }
    if (data.containsKey('drive_type')) {
      context.handle(
        _driveTypeMeta,
        driveType.isAcceptableOrUnknown(data['drive_type']!, _driveTypeMeta),
      );
    }
    if (data.containsKey('capacity_person')) {
      context.handle(
        _capacityPersonMeta,
        capacityPerson.isAcceptableOrUnknown(
          data['capacity_person']!,
          _capacityPersonMeta,
        ),
      );
    }
    if (data.containsKey('capacity_weight')) {
      context.handle(
        _capacityWeightMeta,
        capacityWeight.isAcceptableOrUnknown(
          data['capacity_weight']!,
          _capacityWeightMeta,
        ),
      );
    }
    if (data.containsKey('stops')) {
      context.handle(
        _stopsMeta,
        stops.isAcceptableOrUnknown(data['stops']!, _stopsMeta),
      );
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    }
    if (data.containsKey('tag_date')) {
      context.handle(
        _tagDateMeta,
        tagDate.isAcceptableOrUnknown(data['tag_date']!, _tagDateMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('last_updated_local')) {
      context.handle(
        _lastUpdatedLocalMeta,
        lastUpdatedLocal.isAcceptableOrUnknown(
          data['last_updated_local']!,
          _lastUpdatedLocalMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_approved')) {
      context.handle(
        _isApprovedMeta,
        isApproved.isAcceptableOrUnknown(data['is_approved']!, _isApprovedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Elevator map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Elevator(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      idNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_number'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      type: $ElevatorsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      usageTypeDetail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_type_detail'],
      ),
      driveType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drive_type'],
      ),
      capacityPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capacity_person'],
      ),
      capacityWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capacity_weight'],
      ),
      stops: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stops'],
      ),
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed'],
      ),
      tagColor: $ElevatorsTable.$convertertagColor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tag_color'],
        )!,
      ),
      tagDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tag_date'],
      ),
      pendingMaintenanceTasks: $ElevatorsTable.$converterpendingMaintenanceTasks
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}pending_maintenance_tasks'],
            )!,
          ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      lastUpdatedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_local'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isApproved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_approved'],
      )!,
    );
  }

  @override
  $ElevatorsTable createAlias(String alias) {
    return $ElevatorsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ElevatorType, int, int> $convertertype =
      const EnumIndexConverter<ElevatorType>(ElevatorType.values);
  static JsonTypeConverter2<ElevatorTagColor, int, int> $convertertagColor =
      const EnumIndexConverter<ElevatorTagColor>(ElevatorTagColor.values);
  static TypeConverter<List<Map<String, dynamic>>, String>
  $converterpendingMaintenanceTasks = const JsonListConverter();
}

class Elevator extends DataClass implements Insertable<Elevator> {
  final int id;
  final String serverId;
  final String code;
  final String? idNumber;
  final String? name;
  final ElevatorType type;
  final String? usageTypeDetail;
  final String? driveType;
  final int? capacityPerson;
  final int? capacityWeight;
  final int? stops;
  final double? speed;
  final ElevatorTagColor tagColor;
  final DateTime? tagDate;
  final List<Map<String, dynamic>> pendingMaintenanceTasks;
  final int? customerId;
  final DateTime? lastUpdatedLocal;
  final bool isSynced;
  final bool isApproved;
  const Elevator({
    required this.id,
    required this.serverId,
    required this.code,
    this.idNumber,
    this.name,
    required this.type,
    this.usageTypeDetail,
    this.driveType,
    this.capacityPerson,
    this.capacityWeight,
    this.stops,
    this.speed,
    required this.tagColor,
    this.tagDate,
    required this.pendingMaintenanceTasks,
    this.customerId,
    this.lastUpdatedLocal,
    required this.isSynced,
    required this.isApproved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || idNumber != null) {
      map['id_number'] = Variable<String>(idNumber);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    {
      map['type'] = Variable<int>($ElevatorsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || usageTypeDetail != null) {
      map['usage_type_detail'] = Variable<String>(usageTypeDetail);
    }
    if (!nullToAbsent || driveType != null) {
      map['drive_type'] = Variable<String>(driveType);
    }
    if (!nullToAbsent || capacityPerson != null) {
      map['capacity_person'] = Variable<int>(capacityPerson);
    }
    if (!nullToAbsent || capacityWeight != null) {
      map['capacity_weight'] = Variable<int>(capacityWeight);
    }
    if (!nullToAbsent || stops != null) {
      map['stops'] = Variable<int>(stops);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<double>(speed);
    }
    {
      map['tag_color'] = Variable<int>(
        $ElevatorsTable.$convertertagColor.toSql(tagColor),
      );
    }
    if (!nullToAbsent || tagDate != null) {
      map['tag_date'] = Variable<DateTime>(tagDate);
    }
    {
      map['pending_maintenance_tasks'] = Variable<String>(
        $ElevatorsTable.$converterpendingMaintenanceTasks.toSql(
          pendingMaintenanceTasks,
        ),
      );
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || lastUpdatedLocal != null) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_approved'] = Variable<bool>(isApproved);
    return map;
  }

  ElevatorsCompanion toCompanion(bool nullToAbsent) {
    return ElevatorsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      code: Value(code),
      idNumber: idNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(idNumber),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      type: Value(type),
      usageTypeDetail: usageTypeDetail == null && nullToAbsent
          ? const Value.absent()
          : Value(usageTypeDetail),
      driveType: driveType == null && nullToAbsent
          ? const Value.absent()
          : Value(driveType),
      capacityPerson: capacityPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(capacityPerson),
      capacityWeight: capacityWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(capacityWeight),
      stops: stops == null && nullToAbsent
          ? const Value.absent()
          : Value(stops),
      speed: speed == null && nullToAbsent
          ? const Value.absent()
          : Value(speed),
      tagColor: Value(tagColor),
      tagDate: tagDate == null && nullToAbsent
          ? const Value.absent()
          : Value(tagDate),
      pendingMaintenanceTasks: Value(pendingMaintenanceTasks),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      lastUpdatedLocal: lastUpdatedLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedLocal),
      isSynced: Value(isSynced),
      isApproved: Value(isApproved),
    );
  }

  factory Elevator.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Elevator(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      code: serializer.fromJson<String>(json['code']),
      idNumber: serializer.fromJson<String?>(json['idNumber']),
      name: serializer.fromJson<String?>(json['name']),
      type: $ElevatorsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      usageTypeDetail: serializer.fromJson<String?>(json['usageTypeDetail']),
      driveType: serializer.fromJson<String?>(json['driveType']),
      capacityPerson: serializer.fromJson<int?>(json['capacityPerson']),
      capacityWeight: serializer.fromJson<int?>(json['capacityWeight']),
      stops: serializer.fromJson<int?>(json['stops']),
      speed: serializer.fromJson<double?>(json['speed']),
      tagColor: $ElevatorsTable.$convertertagColor.fromJson(
        serializer.fromJson<int>(json['tagColor']),
      ),
      tagDate: serializer.fromJson<DateTime?>(json['tagDate']),
      pendingMaintenanceTasks: serializer.fromJson<List<Map<String, dynamic>>>(
        json['pendingMaintenanceTasks'],
      ),
      customerId: serializer.fromJson<int?>(json['customerId']),
      lastUpdatedLocal: serializer.fromJson<DateTime?>(
        json['lastUpdatedLocal'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isApproved: serializer.fromJson<bool>(json['isApproved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'code': serializer.toJson<String>(code),
      'idNumber': serializer.toJson<String?>(idNumber),
      'name': serializer.toJson<String?>(name),
      'type': serializer.toJson<int>(
        $ElevatorsTable.$convertertype.toJson(type),
      ),
      'usageTypeDetail': serializer.toJson<String?>(usageTypeDetail),
      'driveType': serializer.toJson<String?>(driveType),
      'capacityPerson': serializer.toJson<int?>(capacityPerson),
      'capacityWeight': serializer.toJson<int?>(capacityWeight),
      'stops': serializer.toJson<int?>(stops),
      'speed': serializer.toJson<double?>(speed),
      'tagColor': serializer.toJson<int>(
        $ElevatorsTable.$convertertagColor.toJson(tagColor),
      ),
      'tagDate': serializer.toJson<DateTime?>(tagDate),
      'pendingMaintenanceTasks': serializer.toJson<List<Map<String, dynamic>>>(
        pendingMaintenanceTasks,
      ),
      'customerId': serializer.toJson<int?>(customerId),
      'lastUpdatedLocal': serializer.toJson<DateTime?>(lastUpdatedLocal),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isApproved': serializer.toJson<bool>(isApproved),
    };
  }

  Elevator copyWith({
    int? id,
    String? serverId,
    String? code,
    Value<String?> idNumber = const Value.absent(),
    Value<String?> name = const Value.absent(),
    ElevatorType? type,
    Value<String?> usageTypeDetail = const Value.absent(),
    Value<String?> driveType = const Value.absent(),
    Value<int?> capacityPerson = const Value.absent(),
    Value<int?> capacityWeight = const Value.absent(),
    Value<int?> stops = const Value.absent(),
    Value<double?> speed = const Value.absent(),
    ElevatorTagColor? tagColor,
    Value<DateTime?> tagDate = const Value.absent(),
    List<Map<String, dynamic>>? pendingMaintenanceTasks,
    Value<int?> customerId = const Value.absent(),
    Value<DateTime?> lastUpdatedLocal = const Value.absent(),
    bool? isSynced,
    bool? isApproved,
  }) => Elevator(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    code: code ?? this.code,
    idNumber: idNumber.present ? idNumber.value : this.idNumber,
    name: name.present ? name.value : this.name,
    type: type ?? this.type,
    usageTypeDetail: usageTypeDetail.present
        ? usageTypeDetail.value
        : this.usageTypeDetail,
    driveType: driveType.present ? driveType.value : this.driveType,
    capacityPerson: capacityPerson.present
        ? capacityPerson.value
        : this.capacityPerson,
    capacityWeight: capacityWeight.present
        ? capacityWeight.value
        : this.capacityWeight,
    stops: stops.present ? stops.value : this.stops,
    speed: speed.present ? speed.value : this.speed,
    tagColor: tagColor ?? this.tagColor,
    tagDate: tagDate.present ? tagDate.value : this.tagDate,
    pendingMaintenanceTasks:
        pendingMaintenanceTasks ?? this.pendingMaintenanceTasks,
    customerId: customerId.present ? customerId.value : this.customerId,
    lastUpdatedLocal: lastUpdatedLocal.present
        ? lastUpdatedLocal.value
        : this.lastUpdatedLocal,
    isSynced: isSynced ?? this.isSynced,
    isApproved: isApproved ?? this.isApproved,
  );
  Elevator copyWithCompanion(ElevatorsCompanion data) {
    return Elevator(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      code: data.code.present ? data.code.value : this.code,
      idNumber: data.idNumber.present ? data.idNumber.value : this.idNumber,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      usageTypeDetail: data.usageTypeDetail.present
          ? data.usageTypeDetail.value
          : this.usageTypeDetail,
      driveType: data.driveType.present ? data.driveType.value : this.driveType,
      capacityPerson: data.capacityPerson.present
          ? data.capacityPerson.value
          : this.capacityPerson,
      capacityWeight: data.capacityWeight.present
          ? data.capacityWeight.value
          : this.capacityWeight,
      stops: data.stops.present ? data.stops.value : this.stops,
      speed: data.speed.present ? data.speed.value : this.speed,
      tagColor: data.tagColor.present ? data.tagColor.value : this.tagColor,
      tagDate: data.tagDate.present ? data.tagDate.value : this.tagDate,
      pendingMaintenanceTasks: data.pendingMaintenanceTasks.present
          ? data.pendingMaintenanceTasks.value
          : this.pendingMaintenanceTasks,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      lastUpdatedLocal: data.lastUpdatedLocal.present
          ? data.lastUpdatedLocal.value
          : this.lastUpdatedLocal,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isApproved: data.isApproved.present
          ? data.isApproved.value
          : this.isApproved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Elevator(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('code: $code, ')
          ..write('idNumber: $idNumber, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('usageTypeDetail: $usageTypeDetail, ')
          ..write('driveType: $driveType, ')
          ..write('capacityPerson: $capacityPerson, ')
          ..write('capacityWeight: $capacityWeight, ')
          ..write('stops: $stops, ')
          ..write('speed: $speed, ')
          ..write('tagColor: $tagColor, ')
          ..write('tagDate: $tagDate, ')
          ..write('pendingMaintenanceTasks: $pendingMaintenanceTasks, ')
          ..write('customerId: $customerId, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal, ')
          ..write('isSynced: $isSynced, ')
          ..write('isApproved: $isApproved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    code,
    idNumber,
    name,
    type,
    usageTypeDetail,
    driveType,
    capacityPerson,
    capacityWeight,
    stops,
    speed,
    tagColor,
    tagDate,
    pendingMaintenanceTasks,
    customerId,
    lastUpdatedLocal,
    isSynced,
    isApproved,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Elevator &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.code == this.code &&
          other.idNumber == this.idNumber &&
          other.name == this.name &&
          other.type == this.type &&
          other.usageTypeDetail == this.usageTypeDetail &&
          other.driveType == this.driveType &&
          other.capacityPerson == this.capacityPerson &&
          other.capacityWeight == this.capacityWeight &&
          other.stops == this.stops &&
          other.speed == this.speed &&
          other.tagColor == this.tagColor &&
          other.tagDate == this.tagDate &&
          other.pendingMaintenanceTasks == this.pendingMaintenanceTasks &&
          other.customerId == this.customerId &&
          other.lastUpdatedLocal == this.lastUpdatedLocal &&
          other.isSynced == this.isSynced &&
          other.isApproved == this.isApproved);
}

class ElevatorsCompanion extends UpdateCompanion<Elevator> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<String> code;
  final Value<String?> idNumber;
  final Value<String?> name;
  final Value<ElevatorType> type;
  final Value<String?> usageTypeDetail;
  final Value<String?> driveType;
  final Value<int?> capacityPerson;
  final Value<int?> capacityWeight;
  final Value<int?> stops;
  final Value<double?> speed;
  final Value<ElevatorTagColor> tagColor;
  final Value<DateTime?> tagDate;
  final Value<List<Map<String, dynamic>>> pendingMaintenanceTasks;
  final Value<int?> customerId;
  final Value<DateTime?> lastUpdatedLocal;
  final Value<bool> isSynced;
  final Value<bool> isApproved;
  const ElevatorsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.code = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.usageTypeDetail = const Value.absent(),
    this.driveType = const Value.absent(),
    this.capacityPerson = const Value.absent(),
    this.capacityWeight = const Value.absent(),
    this.stops = const Value.absent(),
    this.speed = const Value.absent(),
    this.tagColor = const Value.absent(),
    this.tagDate = const Value.absent(),
    this.pendingMaintenanceTasks = const Value.absent(),
    this.customerId = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isApproved = const Value.absent(),
  });
  ElevatorsCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required String code,
    this.idNumber = const Value.absent(),
    this.name = const Value.absent(),
    required ElevatorType type,
    this.usageTypeDetail = const Value.absent(),
    this.driveType = const Value.absent(),
    this.capacityPerson = const Value.absent(),
    this.capacityWeight = const Value.absent(),
    this.stops = const Value.absent(),
    this.speed = const Value.absent(),
    this.tagColor = const Value.absent(),
    this.tagDate = const Value.absent(),
    this.pendingMaintenanceTasks = const Value.absent(),
    this.customerId = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isApproved = const Value.absent(),
  }) : serverId = Value(serverId),
       code = Value(code),
       type = Value(type);
  static Insertable<Elevator> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? code,
    Expression<String>? idNumber,
    Expression<String>? name,
    Expression<int>? type,
    Expression<String>? usageTypeDetail,
    Expression<String>? driveType,
    Expression<int>? capacityPerson,
    Expression<int>? capacityWeight,
    Expression<int>? stops,
    Expression<double>? speed,
    Expression<int>? tagColor,
    Expression<DateTime>? tagDate,
    Expression<String>? pendingMaintenanceTasks,
    Expression<int>? customerId,
    Expression<DateTime>? lastUpdatedLocal,
    Expression<bool>? isSynced,
    Expression<bool>? isApproved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (code != null) 'code': code,
      if (idNumber != null) 'id_number': idNumber,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (usageTypeDetail != null) 'usage_type_detail': usageTypeDetail,
      if (driveType != null) 'drive_type': driveType,
      if (capacityPerson != null) 'capacity_person': capacityPerson,
      if (capacityWeight != null) 'capacity_weight': capacityWeight,
      if (stops != null) 'stops': stops,
      if (speed != null) 'speed': speed,
      if (tagColor != null) 'tag_color': tagColor,
      if (tagDate != null) 'tag_date': tagDate,
      if (pendingMaintenanceTasks != null)
        'pending_maintenance_tasks': pendingMaintenanceTasks,
      if (customerId != null) 'customer_id': customerId,
      if (lastUpdatedLocal != null) 'last_updated_local': lastUpdatedLocal,
      if (isSynced != null) 'is_synced': isSynced,
      if (isApproved != null) 'is_approved': isApproved,
    });
  }

  ElevatorsCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<String>? code,
    Value<String?>? idNumber,
    Value<String?>? name,
    Value<ElevatorType>? type,
    Value<String?>? usageTypeDetail,
    Value<String?>? driveType,
    Value<int?>? capacityPerson,
    Value<int?>? capacityWeight,
    Value<int?>? stops,
    Value<double?>? speed,
    Value<ElevatorTagColor>? tagColor,
    Value<DateTime?>? tagDate,
    Value<List<Map<String, dynamic>>>? pendingMaintenanceTasks,
    Value<int?>? customerId,
    Value<DateTime?>? lastUpdatedLocal,
    Value<bool>? isSynced,
    Value<bool>? isApproved,
  }) {
    return ElevatorsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      code: code ?? this.code,
      idNumber: idNumber ?? this.idNumber,
      name: name ?? this.name,
      type: type ?? this.type,
      usageTypeDetail: usageTypeDetail ?? this.usageTypeDetail,
      driveType: driveType ?? this.driveType,
      capacityPerson: capacityPerson ?? this.capacityPerson,
      capacityWeight: capacityWeight ?? this.capacityWeight,
      stops: stops ?? this.stops,
      speed: speed ?? this.speed,
      tagColor: tagColor ?? this.tagColor,
      tagDate: tagDate ?? this.tagDate,
      pendingMaintenanceTasks:
          pendingMaintenanceTasks ?? this.pendingMaintenanceTasks,
      customerId: customerId ?? this.customerId,
      lastUpdatedLocal: lastUpdatedLocal ?? this.lastUpdatedLocal,
      isSynced: isSynced ?? this.isSynced,
      isApproved: isApproved ?? this.isApproved,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (idNumber.present) {
      map['id_number'] = Variable<String>(idNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $ElevatorsTable.$convertertype.toSql(type.value),
      );
    }
    if (usageTypeDetail.present) {
      map['usage_type_detail'] = Variable<String>(usageTypeDetail.value);
    }
    if (driveType.present) {
      map['drive_type'] = Variable<String>(driveType.value);
    }
    if (capacityPerson.present) {
      map['capacity_person'] = Variable<int>(capacityPerson.value);
    }
    if (capacityWeight.present) {
      map['capacity_weight'] = Variable<int>(capacityWeight.value);
    }
    if (stops.present) {
      map['stops'] = Variable<int>(stops.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (tagColor.present) {
      map['tag_color'] = Variable<int>(
        $ElevatorsTable.$convertertagColor.toSql(tagColor.value),
      );
    }
    if (tagDate.present) {
      map['tag_date'] = Variable<DateTime>(tagDate.value);
    }
    if (pendingMaintenanceTasks.present) {
      map['pending_maintenance_tasks'] = Variable<String>(
        $ElevatorsTable.$converterpendingMaintenanceTasks.toSql(
          pendingMaintenanceTasks.value,
        ),
      );
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (lastUpdatedLocal.present) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isApproved.present) {
      map['is_approved'] = Variable<bool>(isApproved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElevatorsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('code: $code, ')
          ..write('idNumber: $idNumber, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('usageTypeDetail: $usageTypeDetail, ')
          ..write('driveType: $driveType, ')
          ..write('capacityPerson: $capacityPerson, ')
          ..write('capacityWeight: $capacityWeight, ')
          ..write('stops: $stops, ')
          ..write('speed: $speed, ')
          ..write('tagColor: $tagColor, ')
          ..write('tagDate: $tagDate, ')
          ..write('pendingMaintenanceTasks: $pendingMaintenanceTasks, ')
          ..write('customerId: $customerId, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal, ')
          ..write('isSynced: $isSynced, ')
          ..write('isApproved: $isApproved')
          ..write(')'))
        .toString();
  }
}

class $MaintenancesTable extends Maintenances
    with TableInfo<$MaintenancesTable, Maintenance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenancesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _elevatorIdMeta = const VerificationMeta(
    'elevatorId',
  );
  @override
  late final GeneratedColumn<int> elevatorId = GeneratedColumn<int>(
    'elevator_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES elevators (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _maintenanceDateMeta = const VerificationMeta(
    'maintenanceDate',
  );
  @override
  late final GeneratedColumn<DateTime> maintenanceDate =
      GeneratedColumn<DateTime>(
        'maintenance_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _technicianNameMeta = const VerificationMeta(
    'technicianName',
  );
  @override
  late final GeneratedColumn<String> technicianName = GeneratedColumn<String>(
    'technician_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  checklist =
      GeneratedColumn<String>(
        'checklist',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $MaintenancesTable.$converterchecklist,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  carryOverNotes =
      GeneratedColumn<String>(
        'carry_over_notes',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $MaintenancesTable.$convertercarryOverNotes,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  usedMaterials =
      GeneratedColumn<String>(
        'used_materials',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $MaintenancesTable.$converterusedMaterials,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUpdatedLocalMeta = const VerificationMeta(
    'lastUpdatedLocal',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedLocal =
      GeneratedColumn<DateTime>(
        'last_updated_local',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    elevatorId,
    customerId,
    maintenanceDate,
    year,
    month,
    technicianName,
    notes,
    checklist,
    carryOverNotes,
    usedMaterials,
    isSynced,
    lastUpdatedLocal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Maintenance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('elevator_id')) {
      context.handle(
        _elevatorIdMeta,
        elevatorId.isAcceptableOrUnknown(data['elevator_id']!, _elevatorIdMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('maintenance_date')) {
      context.handle(
        _maintenanceDateMeta,
        maintenanceDate.isAcceptableOrUnknown(
          data['maintenance_date']!,
          _maintenanceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maintenanceDateMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('technician_name')) {
      context.handle(
        _technicianNameMeta,
        technicianName.isAcceptableOrUnknown(
          data['technician_name']!,
          _technicianNameMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_updated_local')) {
      context.handle(
        _lastUpdatedLocalMeta,
        lastUpdatedLocal.isAcceptableOrUnknown(
          data['last_updated_local']!,
          _lastUpdatedLocalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Maintenance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Maintenance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      elevatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elevator_id'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      maintenanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}maintenance_date'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      technicianName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_name'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      checklist: $MaintenancesTable.$converterchecklist.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}checklist'],
        )!,
      ),
      carryOverNotes: $MaintenancesTable.$convertercarryOverNotes.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}carry_over_notes'],
        )!,
      ),
      usedMaterials: $MaintenancesTable.$converterusedMaterials.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}used_materials'],
        )!,
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      lastUpdatedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_local'],
      ),
    );
  }

  @override
  $MaintenancesTable createAlias(String alias) {
    return $MaintenancesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Map<String, dynamic>>, String> $converterchecklist =
      const JsonListConverter();
  static TypeConverter<List<Map<String, dynamic>>, String>
  $convertercarryOverNotes = const JsonListConverter();
  static TypeConverter<List<Map<String, dynamic>>, String>
  $converterusedMaterials = const JsonListConverter();
}

class Maintenance extends DataClass implements Insertable<Maintenance> {
  final int id;
  final String serverId;
  final int? elevatorId;
  final int? customerId;
  final DateTime maintenanceDate;
  final int year;
  final int month;
  final String? technicianName;
  final String? notes;
  final List<Map<String, dynamic>> checklist;
  final List<Map<String, dynamic>> carryOverNotes;
  final List<Map<String, dynamic>> usedMaterials;
  final bool isSynced;
  final DateTime? lastUpdatedLocal;
  const Maintenance({
    required this.id,
    required this.serverId,
    this.elevatorId,
    this.customerId,
    required this.maintenanceDate,
    required this.year,
    required this.month,
    this.technicianName,
    this.notes,
    required this.checklist,
    required this.carryOverNotes,
    required this.usedMaterials,
    required this.isSynced,
    this.lastUpdatedLocal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    if (!nullToAbsent || elevatorId != null) {
      map['elevator_id'] = Variable<int>(elevatorId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['maintenance_date'] = Variable<DateTime>(maintenanceDate);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    if (!nullToAbsent || technicianName != null) {
      map['technician_name'] = Variable<String>(technicianName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['checklist'] = Variable<String>(
        $MaintenancesTable.$converterchecklist.toSql(checklist),
      );
    }
    {
      map['carry_over_notes'] = Variable<String>(
        $MaintenancesTable.$convertercarryOverNotes.toSql(carryOverNotes),
      );
    }
    {
      map['used_materials'] = Variable<String>(
        $MaintenancesTable.$converterusedMaterials.toSql(usedMaterials),
      );
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastUpdatedLocal != null) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal);
    }
    return map;
  }

  MaintenancesCompanion toCompanion(bool nullToAbsent) {
    return MaintenancesCompanion(
      id: Value(id),
      serverId: Value(serverId),
      elevatorId: elevatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(elevatorId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      maintenanceDate: Value(maintenanceDate),
      year: Value(year),
      month: Value(month),
      technicianName: technicianName == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianName),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      checklist: Value(checklist),
      carryOverNotes: Value(carryOverNotes),
      usedMaterials: Value(usedMaterials),
      isSynced: Value(isSynced),
      lastUpdatedLocal: lastUpdatedLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedLocal),
    );
  }

  factory Maintenance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Maintenance(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      elevatorId: serializer.fromJson<int?>(json['elevatorId']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      maintenanceDate: serializer.fromJson<DateTime>(json['maintenanceDate']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      technicianName: serializer.fromJson<String?>(json['technicianName']),
      notes: serializer.fromJson<String?>(json['notes']),
      checklist: serializer.fromJson<List<Map<String, dynamic>>>(
        json['checklist'],
      ),
      carryOverNotes: serializer.fromJson<List<Map<String, dynamic>>>(
        json['carryOverNotes'],
      ),
      usedMaterials: serializer.fromJson<List<Map<String, dynamic>>>(
        json['usedMaterials'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdatedLocal: serializer.fromJson<DateTime?>(
        json['lastUpdatedLocal'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'elevatorId': serializer.toJson<int?>(elevatorId),
      'customerId': serializer.toJson<int?>(customerId),
      'maintenanceDate': serializer.toJson<DateTime>(maintenanceDate),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'technicianName': serializer.toJson<String?>(technicianName),
      'notes': serializer.toJson<String?>(notes),
      'checklist': serializer.toJson<List<Map<String, dynamic>>>(checklist),
      'carryOverNotes': serializer.toJson<List<Map<String, dynamic>>>(
        carryOverNotes,
      ),
      'usedMaterials': serializer.toJson<List<Map<String, dynamic>>>(
        usedMaterials,
      ),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdatedLocal': serializer.toJson<DateTime?>(lastUpdatedLocal),
    };
  }

  Maintenance copyWith({
    int? id,
    String? serverId,
    Value<int?> elevatorId = const Value.absent(),
    Value<int?> customerId = const Value.absent(),
    DateTime? maintenanceDate,
    int? year,
    int? month,
    Value<String?> technicianName = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    List<Map<String, dynamic>>? checklist,
    List<Map<String, dynamic>>? carryOverNotes,
    List<Map<String, dynamic>>? usedMaterials,
    bool? isSynced,
    Value<DateTime?> lastUpdatedLocal = const Value.absent(),
  }) => Maintenance(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    elevatorId: elevatorId.present ? elevatorId.value : this.elevatorId,
    customerId: customerId.present ? customerId.value : this.customerId,
    maintenanceDate: maintenanceDate ?? this.maintenanceDate,
    year: year ?? this.year,
    month: month ?? this.month,
    technicianName: technicianName.present
        ? technicianName.value
        : this.technicianName,
    notes: notes.present ? notes.value : this.notes,
    checklist: checklist ?? this.checklist,
    carryOverNotes: carryOverNotes ?? this.carryOverNotes,
    usedMaterials: usedMaterials ?? this.usedMaterials,
    isSynced: isSynced ?? this.isSynced,
    lastUpdatedLocal: lastUpdatedLocal.present
        ? lastUpdatedLocal.value
        : this.lastUpdatedLocal,
  );
  Maintenance copyWithCompanion(MaintenancesCompanion data) {
    return Maintenance(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      elevatorId: data.elevatorId.present
          ? data.elevatorId.value
          : this.elevatorId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      maintenanceDate: data.maintenanceDate.present
          ? data.maintenanceDate.value
          : this.maintenanceDate,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      technicianName: data.technicianName.present
          ? data.technicianName.value
          : this.technicianName,
      notes: data.notes.present ? data.notes.value : this.notes,
      checklist: data.checklist.present ? data.checklist.value : this.checklist,
      carryOverNotes: data.carryOverNotes.present
          ? data.carryOverNotes.value
          : this.carryOverNotes,
      usedMaterials: data.usedMaterials.present
          ? data.usedMaterials.value
          : this.usedMaterials,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdatedLocal: data.lastUpdatedLocal.present
          ? data.lastUpdatedLocal.value
          : this.lastUpdatedLocal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Maintenance(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('maintenanceDate: $maintenanceDate, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('technicianName: $technicianName, ')
          ..write('notes: $notes, ')
          ..write('checklist: $checklist, ')
          ..write('carryOverNotes: $carryOverNotes, ')
          ..write('usedMaterials: $usedMaterials, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    elevatorId,
    customerId,
    maintenanceDate,
    year,
    month,
    technicianName,
    notes,
    checklist,
    carryOverNotes,
    usedMaterials,
    isSynced,
    lastUpdatedLocal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Maintenance &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.elevatorId == this.elevatorId &&
          other.customerId == this.customerId &&
          other.maintenanceDate == this.maintenanceDate &&
          other.year == this.year &&
          other.month == this.month &&
          other.technicianName == this.technicianName &&
          other.notes == this.notes &&
          other.checklist == this.checklist &&
          other.carryOverNotes == this.carryOverNotes &&
          other.usedMaterials == this.usedMaterials &&
          other.isSynced == this.isSynced &&
          other.lastUpdatedLocal == this.lastUpdatedLocal);
}

class MaintenancesCompanion extends UpdateCompanion<Maintenance> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<int?> elevatorId;
  final Value<int?> customerId;
  final Value<DateTime> maintenanceDate;
  final Value<int> year;
  final Value<int> month;
  final Value<String?> technicianName;
  final Value<String?> notes;
  final Value<List<Map<String, dynamic>>> checklist;
  final Value<List<Map<String, dynamic>>> carryOverNotes;
  final Value<List<Map<String, dynamic>>> usedMaterials;
  final Value<bool> isSynced;
  final Value<DateTime?> lastUpdatedLocal;
  const MaintenancesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.maintenanceDate = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.technicianName = const Value.absent(),
    this.notes = const Value.absent(),
    this.checklist = const Value.absent(),
    this.carryOverNotes = const Value.absent(),
    this.usedMaterials = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  });
  MaintenancesCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    required DateTime maintenanceDate,
    required int year,
    required int month,
    this.technicianName = const Value.absent(),
    this.notes = const Value.absent(),
    this.checklist = const Value.absent(),
    this.carryOverNotes = const Value.absent(),
    this.usedMaterials = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  }) : serverId = Value(serverId),
       maintenanceDate = Value(maintenanceDate),
       year = Value(year),
       month = Value(month);
  static Insertable<Maintenance> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? elevatorId,
    Expression<int>? customerId,
    Expression<DateTime>? maintenanceDate,
    Expression<int>? year,
    Expression<int>? month,
    Expression<String>? technicianName,
    Expression<String>? notes,
    Expression<String>? checklist,
    Expression<String>? carryOverNotes,
    Expression<String>? usedMaterials,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdatedLocal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (elevatorId != null) 'elevator_id': elevatorId,
      if (customerId != null) 'customer_id': customerId,
      if (maintenanceDate != null) 'maintenance_date': maintenanceDate,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (technicianName != null) 'technician_name': technicianName,
      if (notes != null) 'notes': notes,
      if (checklist != null) 'checklist': checklist,
      if (carryOverNotes != null) 'carry_over_notes': carryOverNotes,
      if (usedMaterials != null) 'used_materials': usedMaterials,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdatedLocal != null) 'last_updated_local': lastUpdatedLocal,
    });
  }

  MaintenancesCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<int?>? elevatorId,
    Value<int?>? customerId,
    Value<DateTime>? maintenanceDate,
    Value<int>? year,
    Value<int>? month,
    Value<String?>? technicianName,
    Value<String?>? notes,
    Value<List<Map<String, dynamic>>>? checklist,
    Value<List<Map<String, dynamic>>>? carryOverNotes,
    Value<List<Map<String, dynamic>>>? usedMaterials,
    Value<bool>? isSynced,
    Value<DateTime?>? lastUpdatedLocal,
  }) {
    return MaintenancesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      elevatorId: elevatorId ?? this.elevatorId,
      customerId: customerId ?? this.customerId,
      maintenanceDate: maintenanceDate ?? this.maintenanceDate,
      year: year ?? this.year,
      month: month ?? this.month,
      technicianName: technicianName ?? this.technicianName,
      notes: notes ?? this.notes,
      checklist: checklist ?? this.checklist,
      carryOverNotes: carryOverNotes ?? this.carryOverNotes,
      usedMaterials: usedMaterials ?? this.usedMaterials,
      isSynced: isSynced ?? this.isSynced,
      lastUpdatedLocal: lastUpdatedLocal ?? this.lastUpdatedLocal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (elevatorId.present) {
      map['elevator_id'] = Variable<int>(elevatorId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (maintenanceDate.present) {
      map['maintenance_date'] = Variable<DateTime>(maintenanceDate.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (technicianName.present) {
      map['technician_name'] = Variable<String>(technicianName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (checklist.present) {
      map['checklist'] = Variable<String>(
        $MaintenancesTable.$converterchecklist.toSql(checklist.value),
      );
    }
    if (carryOverNotes.present) {
      map['carry_over_notes'] = Variable<String>(
        $MaintenancesTable.$convertercarryOverNotes.toSql(carryOverNotes.value),
      );
    }
    if (usedMaterials.present) {
      map['used_materials'] = Variable<String>(
        $MaintenancesTable.$converterusedMaterials.toSql(usedMaterials.value),
      );
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdatedLocal.present) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenancesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('maintenanceDate: $maintenanceDate, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('technicianName: $technicianName, ')
          ..write('notes: $notes, ')
          ..write('checklist: $checklist, ')
          ..write('carryOverNotes: $carryOverNotes, ')
          ..write('usedMaterials: $usedMaterials, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }
}

class $FaultsTable extends Faults with TableInfo<$FaultsTable, Fault> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FaultsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _elevatorIdMeta = const VerificationMeta(
    'elevatorId',
  );
  @override
  late final GeneratedColumn<int> elevatorId = GeneratedColumn<int>(
    'elevator_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES elevators (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _reportedDateMeta = const VerificationMeta(
    'reportedDate',
  );
  @override
  late final GeneratedColumn<DateTime> reportedDate = GeneratedColumn<DateTime>(
    'reported_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedDateMeta = const VerificationMeta(
    'resolvedDate',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedDate = GeneratedColumn<DateTime>(
    'resolved_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  static const VerificationMeta _technicianNoteMeta = const VerificationMeta(
    'technicianNote',
  );
  @override
  late final GeneratedColumn<String> technicianNote = GeneratedColumn<String>(
    'technician_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FaultStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<FaultStatus>($FaultsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  usedMaterials =
      GeneratedColumn<String>(
        'used_materials',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $FaultsTable.$converterusedMaterials,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUpdatedLocalMeta = const VerificationMeta(
    'lastUpdatedLocal',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedLocal =
      GeneratedColumn<DateTime>(
        'last_updated_local',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    elevatorId,
    customerId,
    reportedDate,
    resolvedDate,
    description,
    technicianNote,
    status,
    usedMaterials,
    isSynced,
    lastUpdatedLocal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'faults';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fault> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('elevator_id')) {
      context.handle(
        _elevatorIdMeta,
        elevatorId.isAcceptableOrUnknown(data['elevator_id']!, _elevatorIdMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('reported_date')) {
      context.handle(
        _reportedDateMeta,
        reportedDate.isAcceptableOrUnknown(
          data['reported_date']!,
          _reportedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportedDateMeta);
    }
    if (data.containsKey('resolved_date')) {
      context.handle(
        _resolvedDateMeta,
        resolvedDate.isAcceptableOrUnknown(
          data['resolved_date']!,
          _resolvedDateMeta,
        ),
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('technician_note')) {
      context.handle(
        _technicianNoteMeta,
        technicianNote.isAcceptableOrUnknown(
          data['technician_note']!,
          _technicianNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_updated_local')) {
      context.handle(
        _lastUpdatedLocalMeta,
        lastUpdatedLocal.isAcceptableOrUnknown(
          data['last_updated_local']!,
          _lastUpdatedLocalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fault map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fault(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      elevatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elevator_id'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      reportedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reported_date'],
      )!,
      resolvedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_date'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      technicianNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_note'],
      ),
      status: $FaultsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      usedMaterials: $FaultsTable.$converterusedMaterials.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}used_materials'],
        )!,
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      lastUpdatedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_local'],
      ),
    );
  }

  @override
  $FaultsTable createAlias(String alias) {
    return $FaultsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FaultStatus, int, int> $converterstatus =
      const EnumIndexConverter<FaultStatus>(FaultStatus.values);
  static TypeConverter<List<Map<String, dynamic>>, String>
  $converterusedMaterials = const JsonListConverter();
}

class Fault extends DataClass implements Insertable<Fault> {
  final int id;
  final String serverId;
  final int? elevatorId;
  final int? customerId;
  final DateTime reportedDate;
  final DateTime? resolvedDate;
  final String description;
  final String? technicianNote;
  final FaultStatus status;
  final List<Map<String, dynamic>> usedMaterials;
  final bool isSynced;
  final DateTime? lastUpdatedLocal;
  const Fault({
    required this.id,
    required this.serverId,
    this.elevatorId,
    this.customerId,
    required this.reportedDate,
    this.resolvedDate,
    required this.description,
    this.technicianNote,
    required this.status,
    required this.usedMaterials,
    required this.isSynced,
    this.lastUpdatedLocal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    if (!nullToAbsent || elevatorId != null) {
      map['elevator_id'] = Variable<int>(elevatorId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['reported_date'] = Variable<DateTime>(reportedDate);
    if (!nullToAbsent || resolvedDate != null) {
      map['resolved_date'] = Variable<DateTime>(resolvedDate);
    }
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || technicianNote != null) {
      map['technician_note'] = Variable<String>(technicianNote);
    }
    {
      map['status'] = Variable<int>(
        $FaultsTable.$converterstatus.toSql(status),
      );
    }
    {
      map['used_materials'] = Variable<String>(
        $FaultsTable.$converterusedMaterials.toSql(usedMaterials),
      );
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastUpdatedLocal != null) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal);
    }
    return map;
  }

  FaultsCompanion toCompanion(bool nullToAbsent) {
    return FaultsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      elevatorId: elevatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(elevatorId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      reportedDate: Value(reportedDate),
      resolvedDate: resolvedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedDate),
      description: Value(description),
      technicianNote: technicianNote == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianNote),
      status: Value(status),
      usedMaterials: Value(usedMaterials),
      isSynced: Value(isSynced),
      lastUpdatedLocal: lastUpdatedLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedLocal),
    );
  }

  factory Fault.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fault(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      elevatorId: serializer.fromJson<int?>(json['elevatorId']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      reportedDate: serializer.fromJson<DateTime>(json['reportedDate']),
      resolvedDate: serializer.fromJson<DateTime?>(json['resolvedDate']),
      description: serializer.fromJson<String>(json['description']),
      technicianNote: serializer.fromJson<String?>(json['technicianNote']),
      status: $FaultsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      usedMaterials: serializer.fromJson<List<Map<String, dynamic>>>(
        json['usedMaterials'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdatedLocal: serializer.fromJson<DateTime?>(
        json['lastUpdatedLocal'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'elevatorId': serializer.toJson<int?>(elevatorId),
      'customerId': serializer.toJson<int?>(customerId),
      'reportedDate': serializer.toJson<DateTime>(reportedDate),
      'resolvedDate': serializer.toJson<DateTime?>(resolvedDate),
      'description': serializer.toJson<String>(description),
      'technicianNote': serializer.toJson<String?>(technicianNote),
      'status': serializer.toJson<int>(
        $FaultsTable.$converterstatus.toJson(status),
      ),
      'usedMaterials': serializer.toJson<List<Map<String, dynamic>>>(
        usedMaterials,
      ),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdatedLocal': serializer.toJson<DateTime?>(lastUpdatedLocal),
    };
  }

  Fault copyWith({
    int? id,
    String? serverId,
    Value<int?> elevatorId = const Value.absent(),
    Value<int?> customerId = const Value.absent(),
    DateTime? reportedDate,
    Value<DateTime?> resolvedDate = const Value.absent(),
    String? description,
    Value<String?> technicianNote = const Value.absent(),
    FaultStatus? status,
    List<Map<String, dynamic>>? usedMaterials,
    bool? isSynced,
    Value<DateTime?> lastUpdatedLocal = const Value.absent(),
  }) => Fault(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    elevatorId: elevatorId.present ? elevatorId.value : this.elevatorId,
    customerId: customerId.present ? customerId.value : this.customerId,
    reportedDate: reportedDate ?? this.reportedDate,
    resolvedDate: resolvedDate.present ? resolvedDate.value : this.resolvedDate,
    description: description ?? this.description,
    technicianNote: technicianNote.present
        ? technicianNote.value
        : this.technicianNote,
    status: status ?? this.status,
    usedMaterials: usedMaterials ?? this.usedMaterials,
    isSynced: isSynced ?? this.isSynced,
    lastUpdatedLocal: lastUpdatedLocal.present
        ? lastUpdatedLocal.value
        : this.lastUpdatedLocal,
  );
  Fault copyWithCompanion(FaultsCompanion data) {
    return Fault(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      elevatorId: data.elevatorId.present
          ? data.elevatorId.value
          : this.elevatorId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      reportedDate: data.reportedDate.present
          ? data.reportedDate.value
          : this.reportedDate,
      resolvedDate: data.resolvedDate.present
          ? data.resolvedDate.value
          : this.resolvedDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      technicianNote: data.technicianNote.present
          ? data.technicianNote.value
          : this.technicianNote,
      status: data.status.present ? data.status.value : this.status,
      usedMaterials: data.usedMaterials.present
          ? data.usedMaterials.value
          : this.usedMaterials,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdatedLocal: data.lastUpdatedLocal.present
          ? data.lastUpdatedLocal.value
          : this.lastUpdatedLocal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fault(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('reportedDate: $reportedDate, ')
          ..write('resolvedDate: $resolvedDate, ')
          ..write('description: $description, ')
          ..write('technicianNote: $technicianNote, ')
          ..write('status: $status, ')
          ..write('usedMaterials: $usedMaterials, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    elevatorId,
    customerId,
    reportedDate,
    resolvedDate,
    description,
    technicianNote,
    status,
    usedMaterials,
    isSynced,
    lastUpdatedLocal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fault &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.elevatorId == this.elevatorId &&
          other.customerId == this.customerId &&
          other.reportedDate == this.reportedDate &&
          other.resolvedDate == this.resolvedDate &&
          other.description == this.description &&
          other.technicianNote == this.technicianNote &&
          other.status == this.status &&
          other.usedMaterials == this.usedMaterials &&
          other.isSynced == this.isSynced &&
          other.lastUpdatedLocal == this.lastUpdatedLocal);
}

class FaultsCompanion extends UpdateCompanion<Fault> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<int?> elevatorId;
  final Value<int?> customerId;
  final Value<DateTime> reportedDate;
  final Value<DateTime?> resolvedDate;
  final Value<String> description;
  final Value<String?> technicianNote;
  final Value<FaultStatus> status;
  final Value<List<Map<String, dynamic>>> usedMaterials;
  final Value<bool> isSynced;
  final Value<DateTime?> lastUpdatedLocal;
  const FaultsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.reportedDate = const Value.absent(),
    this.resolvedDate = const Value.absent(),
    this.description = const Value.absent(),
    this.technicianNote = const Value.absent(),
    this.status = const Value.absent(),
    this.usedMaterials = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  });
  FaultsCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    required DateTime reportedDate,
    this.resolvedDate = const Value.absent(),
    required String description,
    this.technicianNote = const Value.absent(),
    required FaultStatus status,
    this.usedMaterials = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  }) : serverId = Value(serverId),
       reportedDate = Value(reportedDate),
       description = Value(description),
       status = Value(status);
  static Insertable<Fault> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? elevatorId,
    Expression<int>? customerId,
    Expression<DateTime>? reportedDate,
    Expression<DateTime>? resolvedDate,
    Expression<String>? description,
    Expression<String>? technicianNote,
    Expression<int>? status,
    Expression<String>? usedMaterials,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdatedLocal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (elevatorId != null) 'elevator_id': elevatorId,
      if (customerId != null) 'customer_id': customerId,
      if (reportedDate != null) 'reported_date': reportedDate,
      if (resolvedDate != null) 'resolved_date': resolvedDate,
      if (description != null) 'description': description,
      if (technicianNote != null) 'technician_note': technicianNote,
      if (status != null) 'status': status,
      if (usedMaterials != null) 'used_materials': usedMaterials,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdatedLocal != null) 'last_updated_local': lastUpdatedLocal,
    });
  }

  FaultsCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<int?>? elevatorId,
    Value<int?>? customerId,
    Value<DateTime>? reportedDate,
    Value<DateTime?>? resolvedDate,
    Value<String>? description,
    Value<String?>? technicianNote,
    Value<FaultStatus>? status,
    Value<List<Map<String, dynamic>>>? usedMaterials,
    Value<bool>? isSynced,
    Value<DateTime?>? lastUpdatedLocal,
  }) {
    return FaultsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      elevatorId: elevatorId ?? this.elevatorId,
      customerId: customerId ?? this.customerId,
      reportedDate: reportedDate ?? this.reportedDate,
      resolvedDate: resolvedDate ?? this.resolvedDate,
      description: description ?? this.description,
      technicianNote: technicianNote ?? this.technicianNote,
      status: status ?? this.status,
      usedMaterials: usedMaterials ?? this.usedMaterials,
      isSynced: isSynced ?? this.isSynced,
      lastUpdatedLocal: lastUpdatedLocal ?? this.lastUpdatedLocal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (elevatorId.present) {
      map['elevator_id'] = Variable<int>(elevatorId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (reportedDate.present) {
      map['reported_date'] = Variable<DateTime>(reportedDate.value);
    }
    if (resolvedDate.present) {
      map['resolved_date'] = Variable<DateTime>(resolvedDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (technicianNote.present) {
      map['technician_note'] = Variable<String>(technicianNote.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $FaultsTable.$converterstatus.toSql(status.value),
      );
    }
    if (usedMaterials.present) {
      map['used_materials'] = Variable<String>(
        $FaultsTable.$converterusedMaterials.toSql(usedMaterials.value),
      );
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdatedLocal.present) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FaultsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('reportedDate: $reportedDate, ')
          ..write('resolvedDate: $resolvedDate, ')
          ..write('description: $description, ')
          ..write('technicianNote: $technicianNote, ')
          ..write('status: $status, ')
          ..write('usedMaterials: $usedMaterials, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }
}

class $DailyRoutesTable extends DailyRoutes
    with TableInfo<$DailyRoutesTable, DailyRoute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyRoutesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _plannerNameMeta = const VerificationMeta(
    'plannerName',
  );
  @override
  late final GeneratedColumn<String> plannerName = GeneratedColumn<String>(
    'planner_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedDateMeta = const VerificationMeta(
    'plannedDate',
  );
  @override
  late final GeneratedColumn<DateTime> plannedDate = GeneratedColumn<DateTime>(
    'planned_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String>
  maintenanceGroupIds = GeneratedColumn<String>(
    'maintenance_group_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<int>>($DailyRoutesTable.$convertermaintenanceGroupIds);
  @override
  late final GeneratedColumnWithTypeConverter<DailyRouteStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DailyRouteStatus>($DailyRoutesTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String>
  completedCustomerIds = GeneratedColumn<String>(
    'completed_customer_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<int>>($DailyRoutesTable.$convertercompletedCustomerIds);
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUpdatedLocalMeta = const VerificationMeta(
    'lastUpdatedLocal',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedLocal =
      GeneratedColumn<DateTime>(
        'last_updated_local',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    plannerName,
    plannedDate,
    maintenanceGroupIds,
    status,
    completedCustomerIds,
    isSynced,
    lastUpdatedLocal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_routes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyRoute> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('planner_name')) {
      context.handle(
        _plannerNameMeta,
        plannerName.isAcceptableOrUnknown(
          data['planner_name']!,
          _plannerNameMeta,
        ),
      );
    }
    if (data.containsKey('planned_date')) {
      context.handle(
        _plannedDateMeta,
        plannedDate.isAcceptableOrUnknown(
          data['planned_date']!,
          _plannedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedDateMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_updated_local')) {
      context.handle(
        _lastUpdatedLocalMeta,
        lastUpdatedLocal.isAcceptableOrUnknown(
          data['last_updated_local']!,
          _lastUpdatedLocalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyRoute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRoute(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      plannerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planner_name'],
      ),
      plannedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_date'],
      )!,
      maintenanceGroupIds: $DailyRoutesTable.$convertermaintenanceGroupIds
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}maintenance_group_ids'],
            )!,
          ),
      status: $DailyRoutesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      completedCustomerIds: $DailyRoutesTable.$convertercompletedCustomerIds
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}completed_customer_ids'],
            )!,
          ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      lastUpdatedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_local'],
      ),
    );
  }

  @override
  $DailyRoutesTable createAlias(String alias) {
    return $DailyRoutesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $convertermaintenanceGroupIds =
      const IntListConverter();
  static JsonTypeConverter2<DailyRouteStatus, int, int> $converterstatus =
      const EnumIndexConverter<DailyRouteStatus>(DailyRouteStatus.values);
  static TypeConverter<List<int>, String> $convertercompletedCustomerIds =
      const IntListConverter();
}

class DailyRoute extends DataClass implements Insertable<DailyRoute> {
  final int id;
  final String serverId;
  final String? plannerName;
  final DateTime plannedDate;
  final List<int> maintenanceGroupIds;
  final DailyRouteStatus status;
  final List<int> completedCustomerIds;
  final bool isSynced;
  final DateTime? lastUpdatedLocal;
  const DailyRoute({
    required this.id,
    required this.serverId,
    this.plannerName,
    required this.plannedDate,
    required this.maintenanceGroupIds,
    required this.status,
    required this.completedCustomerIds,
    required this.isSynced,
    this.lastUpdatedLocal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    if (!nullToAbsent || plannerName != null) {
      map['planner_name'] = Variable<String>(plannerName);
    }
    map['planned_date'] = Variable<DateTime>(plannedDate);
    {
      map['maintenance_group_ids'] = Variable<String>(
        $DailyRoutesTable.$convertermaintenanceGroupIds.toSql(
          maintenanceGroupIds,
        ),
      );
    }
    {
      map['status'] = Variable<int>(
        $DailyRoutesTable.$converterstatus.toSql(status),
      );
    }
    {
      map['completed_customer_ids'] = Variable<String>(
        $DailyRoutesTable.$convertercompletedCustomerIds.toSql(
          completedCustomerIds,
        ),
      );
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastUpdatedLocal != null) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal);
    }
    return map;
  }

  DailyRoutesCompanion toCompanion(bool nullToAbsent) {
    return DailyRoutesCompanion(
      id: Value(id),
      serverId: Value(serverId),
      plannerName: plannerName == null && nullToAbsent
          ? const Value.absent()
          : Value(plannerName),
      plannedDate: Value(plannedDate),
      maintenanceGroupIds: Value(maintenanceGroupIds),
      status: Value(status),
      completedCustomerIds: Value(completedCustomerIds),
      isSynced: Value(isSynced),
      lastUpdatedLocal: lastUpdatedLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedLocal),
    );
  }

  factory DailyRoute.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRoute(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      plannerName: serializer.fromJson<String?>(json['plannerName']),
      plannedDate: serializer.fromJson<DateTime>(json['plannedDate']),
      maintenanceGroupIds: serializer.fromJson<List<int>>(
        json['maintenanceGroupIds'],
      ),
      status: $DailyRoutesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      completedCustomerIds: serializer.fromJson<List<int>>(
        json['completedCustomerIds'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdatedLocal: serializer.fromJson<DateTime?>(
        json['lastUpdatedLocal'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'plannerName': serializer.toJson<String?>(plannerName),
      'plannedDate': serializer.toJson<DateTime>(plannedDate),
      'maintenanceGroupIds': serializer.toJson<List<int>>(maintenanceGroupIds),
      'status': serializer.toJson<int>(
        $DailyRoutesTable.$converterstatus.toJson(status),
      ),
      'completedCustomerIds': serializer.toJson<List<int>>(
        completedCustomerIds,
      ),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdatedLocal': serializer.toJson<DateTime?>(lastUpdatedLocal),
    };
  }

  DailyRoute copyWith({
    int? id,
    String? serverId,
    Value<String?> plannerName = const Value.absent(),
    DateTime? plannedDate,
    List<int>? maintenanceGroupIds,
    DailyRouteStatus? status,
    List<int>? completedCustomerIds,
    bool? isSynced,
    Value<DateTime?> lastUpdatedLocal = const Value.absent(),
  }) => DailyRoute(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    plannerName: plannerName.present ? plannerName.value : this.plannerName,
    plannedDate: plannedDate ?? this.plannedDate,
    maintenanceGroupIds: maintenanceGroupIds ?? this.maintenanceGroupIds,
    status: status ?? this.status,
    completedCustomerIds: completedCustomerIds ?? this.completedCustomerIds,
    isSynced: isSynced ?? this.isSynced,
    lastUpdatedLocal: lastUpdatedLocal.present
        ? lastUpdatedLocal.value
        : this.lastUpdatedLocal,
  );
  DailyRoute copyWithCompanion(DailyRoutesCompanion data) {
    return DailyRoute(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      plannerName: data.plannerName.present
          ? data.plannerName.value
          : this.plannerName,
      plannedDate: data.plannedDate.present
          ? data.plannedDate.value
          : this.plannedDate,
      maintenanceGroupIds: data.maintenanceGroupIds.present
          ? data.maintenanceGroupIds.value
          : this.maintenanceGroupIds,
      status: data.status.present ? data.status.value : this.status,
      completedCustomerIds: data.completedCustomerIds.present
          ? data.completedCustomerIds.value
          : this.completedCustomerIds,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdatedLocal: data.lastUpdatedLocal.present
          ? data.lastUpdatedLocal.value
          : this.lastUpdatedLocal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyRoute(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('plannerName: $plannerName, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('maintenanceGroupIds: $maintenanceGroupIds, ')
          ..write('status: $status, ')
          ..write('completedCustomerIds: $completedCustomerIds, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    plannerName,
    plannedDate,
    maintenanceGroupIds,
    status,
    completedCustomerIds,
    isSynced,
    lastUpdatedLocal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRoute &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.plannerName == this.plannerName &&
          other.plannedDate == this.plannedDate &&
          other.maintenanceGroupIds == this.maintenanceGroupIds &&
          other.status == this.status &&
          other.completedCustomerIds == this.completedCustomerIds &&
          other.isSynced == this.isSynced &&
          other.lastUpdatedLocal == this.lastUpdatedLocal);
}

class DailyRoutesCompanion extends UpdateCompanion<DailyRoute> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<String?> plannerName;
  final Value<DateTime> plannedDate;
  final Value<List<int>> maintenanceGroupIds;
  final Value<DailyRouteStatus> status;
  final Value<List<int>> completedCustomerIds;
  final Value<bool> isSynced;
  final Value<DateTime?> lastUpdatedLocal;
  const DailyRoutesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.plannerName = const Value.absent(),
    this.plannedDate = const Value.absent(),
    this.maintenanceGroupIds = const Value.absent(),
    this.status = const Value.absent(),
    this.completedCustomerIds = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  });
  DailyRoutesCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    this.plannerName = const Value.absent(),
    required DateTime plannedDate,
    this.maintenanceGroupIds = const Value.absent(),
    required DailyRouteStatus status,
    this.completedCustomerIds = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  }) : serverId = Value(serverId),
       plannedDate = Value(plannedDate),
       status = Value(status);
  static Insertable<DailyRoute> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? plannerName,
    Expression<DateTime>? plannedDate,
    Expression<String>? maintenanceGroupIds,
    Expression<int>? status,
    Expression<String>? completedCustomerIds,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdatedLocal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (plannerName != null) 'planner_name': plannerName,
      if (plannedDate != null) 'planned_date': plannedDate,
      if (maintenanceGroupIds != null)
        'maintenance_group_ids': maintenanceGroupIds,
      if (status != null) 'status': status,
      if (completedCustomerIds != null)
        'completed_customer_ids': completedCustomerIds,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdatedLocal != null) 'last_updated_local': lastUpdatedLocal,
    });
  }

  DailyRoutesCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<String?>? plannerName,
    Value<DateTime>? plannedDate,
    Value<List<int>>? maintenanceGroupIds,
    Value<DailyRouteStatus>? status,
    Value<List<int>>? completedCustomerIds,
    Value<bool>? isSynced,
    Value<DateTime?>? lastUpdatedLocal,
  }) {
    return DailyRoutesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      plannerName: plannerName ?? this.plannerName,
      plannedDate: plannedDate ?? this.plannedDate,
      maintenanceGroupIds: maintenanceGroupIds ?? this.maintenanceGroupIds,
      status: status ?? this.status,
      completedCustomerIds: completedCustomerIds ?? this.completedCustomerIds,
      isSynced: isSynced ?? this.isSynced,
      lastUpdatedLocal: lastUpdatedLocal ?? this.lastUpdatedLocal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (plannerName.present) {
      map['planner_name'] = Variable<String>(plannerName.value);
    }
    if (plannedDate.present) {
      map['planned_date'] = Variable<DateTime>(plannedDate.value);
    }
    if (maintenanceGroupIds.present) {
      map['maintenance_group_ids'] = Variable<String>(
        $DailyRoutesTable.$convertermaintenanceGroupIds.toSql(
          maintenanceGroupIds.value,
        ),
      );
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $DailyRoutesTable.$converterstatus.toSql(status.value),
      );
    }
    if (completedCustomerIds.present) {
      map['completed_customer_ids'] = Variable<String>(
        $DailyRoutesTable.$convertercompletedCustomerIds.toSql(
          completedCustomerIds.value,
        ),
      );
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdatedLocal.present) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRoutesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('plannerName: $plannerName, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('maintenanceGroupIds: $maintenanceGroupIds, ')
          ..write('status: $status, ')
          ..write('completedCustomerIds: $completedCustomerIds, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }
}

class $ServiceFormsTable extends ServiceForms
    with TableInfo<$ServiceFormsTable, ServiceForm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceFormsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formStartedAtMeta = const VerificationMeta(
    'formStartedAt',
  );
  @override
  late final GeneratedColumn<DateTime> formStartedAt =
      GeneratedColumn<DateTime>(
        'form_started_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _formCompletedAtMeta = const VerificationMeta(
    'formCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> formCompletedAt =
      GeneratedColumn<DateTime>(
        'form_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    List<Map<String, dynamic>>,
    String
  >
  maintenanceChecklist =
      GeneratedColumn<String>(
        'maintenance_checklist',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Map<String, dynamic>>>(
        $ServiceFormsTable.$convertermaintenanceChecklist,
      );
  static const VerificationMeta _technicianNotesMeta = const VerificationMeta(
    'technicianNotes',
  );
  @override
  late final GeneratedColumn<String> technicianNotes = GeneratedColumn<String>(
    'technician_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerSignatureMeta = const VerificationMeta(
    'customerSignature',
  );
  @override
  late final GeneratedColumn<String> customerSignature =
      GeneratedColumn<String>(
        'customer_signature',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workOrderId,
    formStartedAt,
    formCompletedAt,
    maintenanceChecklist,
    technicianNotes,
    customerSignature,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_forms';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceForm> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('form_started_at')) {
      context.handle(
        _formStartedAtMeta,
        formStartedAt.isAcceptableOrUnknown(
          data['form_started_at']!,
          _formStartedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_formStartedAtMeta);
    }
    if (data.containsKey('form_completed_at')) {
      context.handle(
        _formCompletedAtMeta,
        formCompletedAt.isAcceptableOrUnknown(
          data['form_completed_at']!,
          _formCompletedAtMeta,
        ),
      );
    }
    if (data.containsKey('technician_notes')) {
      context.handle(
        _technicianNotesMeta,
        technicianNotes.isAcceptableOrUnknown(
          data['technician_notes']!,
          _technicianNotesMeta,
        ),
      );
    }
    if (data.containsKey('customer_signature')) {
      context.handle(
        _customerSignatureMeta,
        customerSignature.isAcceptableOrUnknown(
          data['customer_signature']!,
          _customerSignatureMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceForm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceForm(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      formStartedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}form_started_at'],
      )!,
      formCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}form_completed_at'],
      ),
      maintenanceChecklist: $ServiceFormsTable.$convertermaintenanceChecklist
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}maintenance_checklist'],
            )!,
          ),
      technicianNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_notes'],
      ),
      customerSignature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_signature'],
      ),
    );
  }

  @override
  $ServiceFormsTable createAlias(String alias) {
    return $ServiceFormsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Map<String, dynamic>>, String>
  $convertermaintenanceChecklist = const JsonListConverter();
}

class ServiceForm extends DataClass implements Insertable<ServiceForm> {
  final int id;
  final String workOrderId;
  final DateTime formStartedAt;
  final DateTime? formCompletedAt;
  final List<Map<String, dynamic>> maintenanceChecklist;
  final String? technicianNotes;
  final String? customerSignature;
  const ServiceForm({
    required this.id,
    required this.workOrderId,
    required this.formStartedAt,
    this.formCompletedAt,
    required this.maintenanceChecklist,
    this.technicianNotes,
    this.customerSignature,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['work_order_id'] = Variable<String>(workOrderId);
    map['form_started_at'] = Variable<DateTime>(formStartedAt);
    if (!nullToAbsent || formCompletedAt != null) {
      map['form_completed_at'] = Variable<DateTime>(formCompletedAt);
    }
    {
      map['maintenance_checklist'] = Variable<String>(
        $ServiceFormsTable.$convertermaintenanceChecklist.toSql(
          maintenanceChecklist,
        ),
      );
    }
    if (!nullToAbsent || technicianNotes != null) {
      map['technician_notes'] = Variable<String>(technicianNotes);
    }
    if (!nullToAbsent || customerSignature != null) {
      map['customer_signature'] = Variable<String>(customerSignature);
    }
    return map;
  }

  ServiceFormsCompanion toCompanion(bool nullToAbsent) {
    return ServiceFormsCompanion(
      id: Value(id),
      workOrderId: Value(workOrderId),
      formStartedAt: Value(formStartedAt),
      formCompletedAt: formCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(formCompletedAt),
      maintenanceChecklist: Value(maintenanceChecklist),
      technicianNotes: technicianNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianNotes),
      customerSignature: customerSignature == null && nullToAbsent
          ? const Value.absent()
          : Value(customerSignature),
    );
  }

  factory ServiceForm.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceForm(
      id: serializer.fromJson<int>(json['id']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      formStartedAt: serializer.fromJson<DateTime>(json['formStartedAt']),
      formCompletedAt: serializer.fromJson<DateTime?>(json['formCompletedAt']),
      maintenanceChecklist: serializer.fromJson<List<Map<String, dynamic>>>(
        json['maintenanceChecklist'],
      ),
      technicianNotes: serializer.fromJson<String?>(json['technicianNotes']),
      customerSignature: serializer.fromJson<String?>(
        json['customerSignature'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'formStartedAt': serializer.toJson<DateTime>(formStartedAt),
      'formCompletedAt': serializer.toJson<DateTime?>(formCompletedAt),
      'maintenanceChecklist': serializer.toJson<List<Map<String, dynamic>>>(
        maintenanceChecklist,
      ),
      'technicianNotes': serializer.toJson<String?>(technicianNotes),
      'customerSignature': serializer.toJson<String?>(customerSignature),
    };
  }

  ServiceForm copyWith({
    int? id,
    String? workOrderId,
    DateTime? formStartedAt,
    Value<DateTime?> formCompletedAt = const Value.absent(),
    List<Map<String, dynamic>>? maintenanceChecklist,
    Value<String?> technicianNotes = const Value.absent(),
    Value<String?> customerSignature = const Value.absent(),
  }) => ServiceForm(
    id: id ?? this.id,
    workOrderId: workOrderId ?? this.workOrderId,
    formStartedAt: formStartedAt ?? this.formStartedAt,
    formCompletedAt: formCompletedAt.present
        ? formCompletedAt.value
        : this.formCompletedAt,
    maintenanceChecklist: maintenanceChecklist ?? this.maintenanceChecklist,
    technicianNotes: technicianNotes.present
        ? technicianNotes.value
        : this.technicianNotes,
    customerSignature: customerSignature.present
        ? customerSignature.value
        : this.customerSignature,
  );
  ServiceForm copyWithCompanion(ServiceFormsCompanion data) {
    return ServiceForm(
      id: data.id.present ? data.id.value : this.id,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      formStartedAt: data.formStartedAt.present
          ? data.formStartedAt.value
          : this.formStartedAt,
      formCompletedAt: data.formCompletedAt.present
          ? data.formCompletedAt.value
          : this.formCompletedAt,
      maintenanceChecklist: data.maintenanceChecklist.present
          ? data.maintenanceChecklist.value
          : this.maintenanceChecklist,
      technicianNotes: data.technicianNotes.present
          ? data.technicianNotes.value
          : this.technicianNotes,
      customerSignature: data.customerSignature.present
          ? data.customerSignature.value
          : this.customerSignature,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceForm(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('formStartedAt: $formStartedAt, ')
          ..write('formCompletedAt: $formCompletedAt, ')
          ..write('maintenanceChecklist: $maintenanceChecklist, ')
          ..write('technicianNotes: $technicianNotes, ')
          ..write('customerSignature: $customerSignature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workOrderId,
    formStartedAt,
    formCompletedAt,
    maintenanceChecklist,
    technicianNotes,
    customerSignature,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceForm &&
          other.id == this.id &&
          other.workOrderId == this.workOrderId &&
          other.formStartedAt == this.formStartedAt &&
          other.formCompletedAt == this.formCompletedAt &&
          other.maintenanceChecklist == this.maintenanceChecklist &&
          other.technicianNotes == this.technicianNotes &&
          other.customerSignature == this.customerSignature);
}

class ServiceFormsCompanion extends UpdateCompanion<ServiceForm> {
  final Value<int> id;
  final Value<String> workOrderId;
  final Value<DateTime> formStartedAt;
  final Value<DateTime?> formCompletedAt;
  final Value<List<Map<String, dynamic>>> maintenanceChecklist;
  final Value<String?> technicianNotes;
  final Value<String?> customerSignature;
  const ServiceFormsCompanion({
    this.id = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.formStartedAt = const Value.absent(),
    this.formCompletedAt = const Value.absent(),
    this.maintenanceChecklist = const Value.absent(),
    this.technicianNotes = const Value.absent(),
    this.customerSignature = const Value.absent(),
  });
  ServiceFormsCompanion.insert({
    this.id = const Value.absent(),
    required String workOrderId,
    required DateTime formStartedAt,
    this.formCompletedAt = const Value.absent(),
    this.maintenanceChecklist = const Value.absent(),
    this.technicianNotes = const Value.absent(),
    this.customerSignature = const Value.absent(),
  }) : workOrderId = Value(workOrderId),
       formStartedAt = Value(formStartedAt);
  static Insertable<ServiceForm> custom({
    Expression<int>? id,
    Expression<String>? workOrderId,
    Expression<DateTime>? formStartedAt,
    Expression<DateTime>? formCompletedAt,
    Expression<String>? maintenanceChecklist,
    Expression<String>? technicianNotes,
    Expression<String>? customerSignature,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (formStartedAt != null) 'form_started_at': formStartedAt,
      if (formCompletedAt != null) 'form_completed_at': formCompletedAt,
      if (maintenanceChecklist != null)
        'maintenance_checklist': maintenanceChecklist,
      if (technicianNotes != null) 'technician_notes': technicianNotes,
      if (customerSignature != null) 'customer_signature': customerSignature,
    });
  }

  ServiceFormsCompanion copyWith({
    Value<int>? id,
    Value<String>? workOrderId,
    Value<DateTime>? formStartedAt,
    Value<DateTime?>? formCompletedAt,
    Value<List<Map<String, dynamic>>>? maintenanceChecklist,
    Value<String?>? technicianNotes,
    Value<String?>? customerSignature,
  }) {
    return ServiceFormsCompanion(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      formStartedAt: formStartedAt ?? this.formStartedAt,
      formCompletedAt: formCompletedAt ?? this.formCompletedAt,
      maintenanceChecklist: maintenanceChecklist ?? this.maintenanceChecklist,
      technicianNotes: technicianNotes ?? this.technicianNotes,
      customerSignature: customerSignature ?? this.customerSignature,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (formStartedAt.present) {
      map['form_started_at'] = Variable<DateTime>(formStartedAt.value);
    }
    if (formCompletedAt.present) {
      map['form_completed_at'] = Variable<DateTime>(formCompletedAt.value);
    }
    if (maintenanceChecklist.present) {
      map['maintenance_checklist'] = Variable<String>(
        $ServiceFormsTable.$convertermaintenanceChecklist.toSql(
          maintenanceChecklist.value,
        ),
      );
    }
    if (technicianNotes.present) {
      map['technician_notes'] = Variable<String>(technicianNotes.value);
    }
    if (customerSignature.present) {
      map['customer_signature'] = Variable<String>(customerSignature.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceFormsCompanion(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('formStartedAt: $formStartedAt, ')
          ..write('formCompletedAt: $formCompletedAt, ')
          ..write('maintenanceChecklist: $maintenanceChecklist, ')
          ..write('technicianNotes: $technicianNotes, ')
          ..write('customerSignature: $customerSignature')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _partCodeMeta = const VerificationMeta(
    'partCode',
  );
  @override
  late final GeneratedColumn<String> partCode = GeneratedColumn<String>(
    'part_code',
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityInVanMeta = const VerificationMeta(
    'quantityInVan',
  );
  @override
  late final GeneratedColumn<int> quantityInVan = GeneratedColumn<int>(
    'quantity_in_van',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minQuantityThresholdMeta =
      const VerificationMeta('minQuantityThreshold');
  @override
  late final GeneratedColumn<int> minQuantityThreshold = GeneratedColumn<int>(
    'min_quantity_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Adet'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    partCode,
    name,
    category,
    quantityInVan,
    minQuantityThreshold,
    unitPrice,
    unit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('part_code')) {
      context.handle(
        _partCodeMeta,
        partCode.isAcceptableOrUnknown(data['part_code']!, _partCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_partCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('quantity_in_van')) {
      context.handle(
        _quantityInVanMeta,
        quantityInVan.isAcceptableOrUnknown(
          data['quantity_in_van']!,
          _quantityInVanMeta,
        ),
      );
    }
    if (data.containsKey('min_quantity_threshold')) {
      context.handle(
        _minQuantityThresholdMeta,
        minQuantityThreshold.isAcceptableOrUnknown(
          data['min_quantity_threshold']!,
          _minQuantityThresholdMeta,
        ),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      partCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      quantityInVan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_in_van'],
      )!,
      minQuantityThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_quantity_threshold'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final int id;
  final String serverId;
  final String partCode;
  final String name;
  final String category;
  final int quantityInVan;
  final int minQuantityThreshold;
  final double unitPrice;
  final String unit;
  const InventoryItem({
    required this.id,
    required this.serverId,
    required this.partCode,
    required this.name,
    required this.category,
    required this.quantityInVan,
    required this.minQuantityThreshold,
    required this.unitPrice,
    required this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['part_code'] = Variable<String>(partCode);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['quantity_in_van'] = Variable<int>(quantityInVan);
    map['min_quantity_threshold'] = Variable<int>(minQuantityThreshold);
    map['unit_price'] = Variable<double>(unitPrice);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      partCode: Value(partCode),
      name: Value(name),
      category: Value(category),
      quantityInVan: Value(quantityInVan),
      minQuantityThreshold: Value(minQuantityThreshold),
      unitPrice: Value(unitPrice),
      unit: Value(unit),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      partCode: serializer.fromJson<String>(json['partCode']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      quantityInVan: serializer.fromJson<int>(json['quantityInVan']),
      minQuantityThreshold: serializer.fromJson<int>(
        json['minQuantityThreshold'],
      ),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'partCode': serializer.toJson<String>(partCode),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'quantityInVan': serializer.toJson<int>(quantityInVan),
      'minQuantityThreshold': serializer.toJson<int>(minQuantityThreshold),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'unit': serializer.toJson<String>(unit),
    };
  }

  InventoryItem copyWith({
    int? id,
    String? serverId,
    String? partCode,
    String? name,
    String? category,
    int? quantityInVan,
    int? minQuantityThreshold,
    double? unitPrice,
    String? unit,
  }) => InventoryItem(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    partCode: partCode ?? this.partCode,
    name: name ?? this.name,
    category: category ?? this.category,
    quantityInVan: quantityInVan ?? this.quantityInVan,
    minQuantityThreshold: minQuantityThreshold ?? this.minQuantityThreshold,
    unitPrice: unitPrice ?? this.unitPrice,
    unit: unit ?? this.unit,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      partCode: data.partCode.present ? data.partCode.value : this.partCode,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      quantityInVan: data.quantityInVan.present
          ? data.quantityInVan.value
          : this.quantityInVan,
      minQuantityThreshold: data.minQuantityThreshold.present
          ? data.minQuantityThreshold.value
          : this.minQuantityThreshold,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('partCode: $partCode, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('quantityInVan: $quantityInVan, ')
          ..write('minQuantityThreshold: $minQuantityThreshold, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    partCode,
    name,
    category,
    quantityInVan,
    minQuantityThreshold,
    unitPrice,
    unit,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.partCode == this.partCode &&
          other.name == this.name &&
          other.category == this.category &&
          other.quantityInVan == this.quantityInVan &&
          other.minQuantityThreshold == this.minQuantityThreshold &&
          other.unitPrice == this.unitPrice &&
          other.unit == this.unit);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<String> partCode;
  final Value<String> name;
  final Value<String> category;
  final Value<int> quantityInVan;
  final Value<int> minQuantityThreshold;
  final Value<double> unitPrice;
  final Value<String> unit;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.partCode = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.quantityInVan = const Value.absent(),
    this.minQuantityThreshold = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.unit = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required String partCode,
    required String name,
    required String category,
    this.quantityInVan = const Value.absent(),
    this.minQuantityThreshold = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.unit = const Value.absent(),
  }) : serverId = Value(serverId),
       partCode = Value(partCode),
       name = Value(name),
       category = Value(category);
  static Insertable<InventoryItem> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? partCode,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? quantityInVan,
    Expression<int>? minQuantityThreshold,
    Expression<double>? unitPrice,
    Expression<String>? unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (partCode != null) 'part_code': partCode,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (quantityInVan != null) 'quantity_in_van': quantityInVan,
      if (minQuantityThreshold != null)
        'min_quantity_threshold': minQuantityThreshold,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (unit != null) 'unit': unit,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<String>? partCode,
    Value<String>? name,
    Value<String>? category,
    Value<int>? quantityInVan,
    Value<int>? minQuantityThreshold,
    Value<double>? unitPrice,
    Value<String>? unit,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      partCode: partCode ?? this.partCode,
      name: name ?? this.name,
      category: category ?? this.category,
      quantityInVan: quantityInVan ?? this.quantityInVan,
      minQuantityThreshold: minQuantityThreshold ?? this.minQuantityThreshold,
      unitPrice: unitPrice ?? this.unitPrice,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (partCode.present) {
      map['part_code'] = Variable<String>(partCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (quantityInVan.present) {
      map['quantity_in_van'] = Variable<int>(quantityInVan.value);
    }
    if (minQuantityThreshold.present) {
      map['min_quantity_threshold'] = Variable<int>(minQuantityThreshold.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('partCode: $partCode, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('quantityInVan: $quantityInVan, ')
          ..write('minQuantityThreshold: $minQuantityThreshold, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $PartRequestsTable extends PartRequests
    with TableInfo<$PartRequestsTable, PartRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartRequestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _elevatorIdMeta = const VerificationMeta(
    'elevatorId',
  );
  @override
  late final GeneratedColumn<int> elevatorId = GeneratedColumn<int>(
    'elevator_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES elevators (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _partNameMeta = const VerificationMeta(
    'partName',
  );
  @override
  late final GeneratedColumn<String> partName = GeneratedColumn<String>(
    'part_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _urgencyMeta = const VerificationMeta(
    'urgency',
  );
  @override
  late final GeneratedColumn<String> urgency = GeneratedColumn<String>(
    'urgency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Medium'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Pending'),
  );
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
    'requested_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    elevatorId,
    customerId,
    partName,
    quantity,
    urgency,
    status,
    requestedAt,
    notes,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartRequest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('elevator_id')) {
      context.handle(
        _elevatorIdMeta,
        elevatorId.isAcceptableOrUnknown(data['elevator_id']!, _elevatorIdMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('part_name')) {
      context.handle(
        _partNameMeta,
        partName.isAcceptableOrUnknown(data['part_name']!, _partNameMeta),
      );
    } else if (isInserting) {
      context.missing(_partNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('urgency')) {
      context.handle(
        _urgencyMeta,
        urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartRequest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      elevatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elevator_id'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      partName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      urgency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}urgency'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}requested_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $PartRequestsTable createAlias(String alias) {
    return $PartRequestsTable(attachedDatabase, alias);
  }
}

class PartRequest extends DataClass implements Insertable<PartRequest> {
  final int id;
  final String serverId;
  final int? elevatorId;
  final int? customerId;
  final String partName;
  final int quantity;
  final String urgency;
  final String status;
  final DateTime requestedAt;
  final String? notes;
  final bool isSynced;
  const PartRequest({
    required this.id,
    required this.serverId,
    this.elevatorId,
    this.customerId,
    required this.partName,
    required this.quantity,
    required this.urgency,
    required this.status,
    required this.requestedAt,
    this.notes,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    if (!nullToAbsent || elevatorId != null) {
      map['elevator_id'] = Variable<int>(elevatorId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['part_name'] = Variable<String>(partName);
    map['quantity'] = Variable<int>(quantity);
    map['urgency'] = Variable<String>(urgency);
    map['status'] = Variable<String>(status);
    map['requested_at'] = Variable<DateTime>(requestedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PartRequestsCompanion toCompanion(bool nullToAbsent) {
    return PartRequestsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      elevatorId: elevatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(elevatorId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      partName: Value(partName),
      quantity: Value(quantity),
      urgency: Value(urgency),
      status: Value(status),
      requestedAt: Value(requestedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isSynced: Value(isSynced),
    );
  }

  factory PartRequest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartRequest(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      elevatorId: serializer.fromJson<int?>(json['elevatorId']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      partName: serializer.fromJson<String>(json['partName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      urgency: serializer.fromJson<String>(json['urgency']),
      status: serializer.fromJson<String>(json['status']),
      requestedAt: serializer.fromJson<DateTime>(json['requestedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'elevatorId': serializer.toJson<int?>(elevatorId),
      'customerId': serializer.toJson<int?>(customerId),
      'partName': serializer.toJson<String>(partName),
      'quantity': serializer.toJson<int>(quantity),
      'urgency': serializer.toJson<String>(urgency),
      'status': serializer.toJson<String>(status),
      'requestedAt': serializer.toJson<DateTime>(requestedAt),
      'notes': serializer.toJson<String?>(notes),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PartRequest copyWith({
    int? id,
    String? serverId,
    Value<int?> elevatorId = const Value.absent(),
    Value<int?> customerId = const Value.absent(),
    String? partName,
    int? quantity,
    String? urgency,
    String? status,
    DateTime? requestedAt,
    Value<String?> notes = const Value.absent(),
    bool? isSynced,
  }) => PartRequest(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    elevatorId: elevatorId.present ? elevatorId.value : this.elevatorId,
    customerId: customerId.present ? customerId.value : this.customerId,
    partName: partName ?? this.partName,
    quantity: quantity ?? this.quantity,
    urgency: urgency ?? this.urgency,
    status: status ?? this.status,
    requestedAt: requestedAt ?? this.requestedAt,
    notes: notes.present ? notes.value : this.notes,
    isSynced: isSynced ?? this.isSynced,
  );
  PartRequest copyWithCompanion(PartRequestsCompanion data) {
    return PartRequest(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      elevatorId: data.elevatorId.present
          ? data.elevatorId.value
          : this.elevatorId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      partName: data.partName.present ? data.partName.value : this.partName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      status: data.status.present ? data.status.value : this.status,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartRequest(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('partName: $partName, ')
          ..write('quantity: $quantity, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('notes: $notes, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    elevatorId,
    customerId,
    partName,
    quantity,
    urgency,
    status,
    requestedAt,
    notes,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartRequest &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.elevatorId == this.elevatorId &&
          other.customerId == this.customerId &&
          other.partName == this.partName &&
          other.quantity == this.quantity &&
          other.urgency == this.urgency &&
          other.status == this.status &&
          other.requestedAt == this.requestedAt &&
          other.notes == this.notes &&
          other.isSynced == this.isSynced);
}

class PartRequestsCompanion extends UpdateCompanion<PartRequest> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<int?> elevatorId;
  final Value<int?> customerId;
  final Value<String> partName;
  final Value<int> quantity;
  final Value<String> urgency;
  final Value<String> status;
  final Value<DateTime> requestedAt;
  final Value<String?> notes;
  final Value<bool> isSynced;
  const PartRequestsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.partName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  PartRequestsCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    required String partName,
    this.quantity = const Value.absent(),
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime requestedAt,
    this.notes = const Value.absent(),
    this.isSynced = const Value.absent(),
  }) : serverId = Value(serverId),
       partName = Value(partName),
       requestedAt = Value(requestedAt);
  static Insertable<PartRequest> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? elevatorId,
    Expression<int>? customerId,
    Expression<String>? partName,
    Expression<int>? quantity,
    Expression<String>? urgency,
    Expression<String>? status,
    Expression<DateTime>? requestedAt,
    Expression<String>? notes,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (elevatorId != null) 'elevator_id': elevatorId,
      if (customerId != null) 'customer_id': customerId,
      if (partName != null) 'part_name': partName,
      if (quantity != null) 'quantity': quantity,
      if (urgency != null) 'urgency': urgency,
      if (status != null) 'status': status,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (notes != null) 'notes': notes,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  PartRequestsCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<int?>? elevatorId,
    Value<int?>? customerId,
    Value<String>? partName,
    Value<int>? quantity,
    Value<String>? urgency,
    Value<String>? status,
    Value<DateTime>? requestedAt,
    Value<String?>? notes,
    Value<bool>? isSynced,
  }) {
    return PartRequestsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      elevatorId: elevatorId ?? this.elevatorId,
      customerId: customerId ?? this.customerId,
      partName: partName ?? this.partName,
      quantity: quantity ?? this.quantity,
      urgency: urgency ?? this.urgency,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      notes: notes ?? this.notes,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (elevatorId.present) {
      map['elevator_id'] = Variable<int>(elevatorId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (partName.present) {
      map['part_name'] = Variable<String>(partName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(urgency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartRequestsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('partName: $partName, ')
          ..write('quantity: $quantity, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('notes: $notes, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $ErrorCodesTable extends ErrorCodes
    with TableInfo<$ErrorCodesTable, ErrorCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ErrorCodesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
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
  static const VerificationMeta _rootCauseMeta = const VerificationMeta(
    'rootCause',
  );
  @override
  late final GeneratedColumn<String> rootCause = GeneratedColumn<String>(
    'root_cause',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  solutionSteps = GeneratedColumn<String>(
    'solution_steps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<String>>($ErrorCodesTable.$convertersolutionSteps);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brand,
    code,
    title,
    rootCause,
    solutionSteps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'error_codes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ErrorCode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('root_cause')) {
      context.handle(
        _rootCauseMeta,
        rootCause.isAcceptableOrUnknown(data['root_cause']!, _rootCauseMeta),
      );
    } else if (isInserting) {
      context.missing(_rootCauseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ErrorCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ErrorCode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      rootCause: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}root_cause'],
      )!,
      solutionSteps: $ErrorCodesTable.$convertersolutionSteps.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}solution_steps'],
        )!,
      ),
    );
  }

  @override
  $ErrorCodesTable createAlias(String alias) {
    return $ErrorCodesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertersolutionSteps =
      const StringListConverter();
}

class ErrorCode extends DataClass implements Insertable<ErrorCode> {
  final int id;
  final String brand;
  final String code;
  final String title;
  final String rootCause;
  final List<String> solutionSteps;
  const ErrorCode({
    required this.id,
    required this.brand,
    required this.code,
    required this.title,
    required this.rootCause,
    required this.solutionSteps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brand'] = Variable<String>(brand);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['root_cause'] = Variable<String>(rootCause);
    {
      map['solution_steps'] = Variable<String>(
        $ErrorCodesTable.$convertersolutionSteps.toSql(solutionSteps),
      );
    }
    return map;
  }

  ErrorCodesCompanion toCompanion(bool nullToAbsent) {
    return ErrorCodesCompanion(
      id: Value(id),
      brand: Value(brand),
      code: Value(code),
      title: Value(title),
      rootCause: Value(rootCause),
      solutionSteps: Value(solutionSteps),
    );
  }

  factory ErrorCode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ErrorCode(
      id: serializer.fromJson<int>(json['id']),
      brand: serializer.fromJson<String>(json['brand']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      rootCause: serializer.fromJson<String>(json['rootCause']),
      solutionSteps: serializer.fromJson<List<String>>(json['solutionSteps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brand': serializer.toJson<String>(brand),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'rootCause': serializer.toJson<String>(rootCause),
      'solutionSteps': serializer.toJson<List<String>>(solutionSteps),
    };
  }

  ErrorCode copyWith({
    int? id,
    String? brand,
    String? code,
    String? title,
    String? rootCause,
    List<String>? solutionSteps,
  }) => ErrorCode(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    code: code ?? this.code,
    title: title ?? this.title,
    rootCause: rootCause ?? this.rootCause,
    solutionSteps: solutionSteps ?? this.solutionSteps,
  );
  ErrorCode copyWithCompanion(ErrorCodesCompanion data) {
    return ErrorCode(
      id: data.id.present ? data.id.value : this.id,
      brand: data.brand.present ? data.brand.value : this.brand,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      rootCause: data.rootCause.present ? data.rootCause.value : this.rootCause,
      solutionSteps: data.solutionSteps.present
          ? data.solutionSteps.value
          : this.solutionSteps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ErrorCode(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('rootCause: $rootCause, ')
          ..write('solutionSteps: $solutionSteps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, brand, code, title, rootCause, solutionSteps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ErrorCode &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.code == this.code &&
          other.title == this.title &&
          other.rootCause == this.rootCause &&
          other.solutionSteps == this.solutionSteps);
}

class ErrorCodesCompanion extends UpdateCompanion<ErrorCode> {
  final Value<int> id;
  final Value<String> brand;
  final Value<String> code;
  final Value<String> title;
  final Value<String> rootCause;
  final Value<List<String>> solutionSteps;
  const ErrorCodesCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.rootCause = const Value.absent(),
    this.solutionSteps = const Value.absent(),
  });
  ErrorCodesCompanion.insert({
    this.id = const Value.absent(),
    required String brand,
    required String code,
    required String title,
    required String rootCause,
    this.solutionSteps = const Value.absent(),
  }) : brand = Value(brand),
       code = Value(code),
       title = Value(title),
       rootCause = Value(rootCause);
  static Insertable<ErrorCode> custom({
    Expression<int>? id,
    Expression<String>? brand,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? rootCause,
    Expression<String>? solutionSteps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (rootCause != null) 'root_cause': rootCause,
      if (solutionSteps != null) 'solution_steps': solutionSteps,
    });
  }

  ErrorCodesCompanion copyWith({
    Value<int>? id,
    Value<String>? brand,
    Value<String>? code,
    Value<String>? title,
    Value<String>? rootCause,
    Value<List<String>>? solutionSteps,
  }) {
    return ErrorCodesCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      code: code ?? this.code,
      title: title ?? this.title,
      rootCause: rootCause ?? this.rootCause,
      solutionSteps: solutionSteps ?? this.solutionSteps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (rootCause.present) {
      map['root_cause'] = Variable<String>(rootCause.value);
    }
    if (solutionSteps.present) {
      map['solution_steps'] = Variable<String>(
        $ErrorCodesTable.$convertersolutionSteps.toSql(solutionSteps.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ErrorCodesCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('rootCause: $rootCause, ')
          ..write('solutionSteps: $solutionSteps')
          ..write(')'))
        .toString();
  }
}

class $TroubleshootingGuidesTable extends TroubleshootingGuides
    with TableInfo<$TroubleshootingGuidesTable, TroubleshootingGuide> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TroubleshootingGuidesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
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
  static const VerificationMeta _symptomMeta = const VerificationMeta(
    'symptom',
  );
  @override
  late final GeneratedColumn<String> symptom = GeneratedColumn<String>(
    'symptom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  diagnosticSteps =
      GeneratedColumn<String>(
        'diagnostic_steps',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<String>>(
        $TroubleshootingGuidesTable.$converterdiagnosticSteps,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brand,
    category,
    title,
    symptom,
    diagnosticSteps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'troubleshooting_guides';
  @override
  VerificationContext validateIntegrity(
    Insertable<TroubleshootingGuide> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('symptom')) {
      context.handle(
        _symptomMeta,
        symptom.isAcceptableOrUnknown(data['symptom']!, _symptomMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TroubleshootingGuide map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TroubleshootingGuide(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      symptom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptom'],
      )!,
      diagnosticSteps: $TroubleshootingGuidesTable.$converterdiagnosticSteps
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}diagnostic_steps'],
            )!,
          ),
    );
  }

  @override
  $TroubleshootingGuidesTable createAlias(String alias) {
    return $TroubleshootingGuidesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdiagnosticSteps =
      const StringListConverter();
}

class TroubleshootingGuide extends DataClass
    implements Insertable<TroubleshootingGuide> {
  final int id;
  final String brand;
  final String category;
  final String title;
  final String symptom;
  final List<String> diagnosticSteps;
  const TroubleshootingGuide({
    required this.id,
    required this.brand,
    required this.category,
    required this.title,
    required this.symptom,
    required this.diagnosticSteps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brand'] = Variable<String>(brand);
    map['category'] = Variable<String>(category);
    map['title'] = Variable<String>(title);
    map['symptom'] = Variable<String>(symptom);
    {
      map['diagnostic_steps'] = Variable<String>(
        $TroubleshootingGuidesTable.$converterdiagnosticSteps.toSql(
          diagnosticSteps,
        ),
      );
    }
    return map;
  }

  TroubleshootingGuidesCompanion toCompanion(bool nullToAbsent) {
    return TroubleshootingGuidesCompanion(
      id: Value(id),
      brand: Value(brand),
      category: Value(category),
      title: Value(title),
      symptom: Value(symptom),
      diagnosticSteps: Value(diagnosticSteps),
    );
  }

  factory TroubleshootingGuide.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TroubleshootingGuide(
      id: serializer.fromJson<int>(json['id']),
      brand: serializer.fromJson<String>(json['brand']),
      category: serializer.fromJson<String>(json['category']),
      title: serializer.fromJson<String>(json['title']),
      symptom: serializer.fromJson<String>(json['symptom']),
      diagnosticSteps: serializer.fromJson<List<String>>(
        json['diagnosticSteps'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brand': serializer.toJson<String>(brand),
      'category': serializer.toJson<String>(category),
      'title': serializer.toJson<String>(title),
      'symptom': serializer.toJson<String>(symptom),
      'diagnosticSteps': serializer.toJson<List<String>>(diagnosticSteps),
    };
  }

  TroubleshootingGuide copyWith({
    int? id,
    String? brand,
    String? category,
    String? title,
    String? symptom,
    List<String>? diagnosticSteps,
  }) => TroubleshootingGuide(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    category: category ?? this.category,
    title: title ?? this.title,
    symptom: symptom ?? this.symptom,
    diagnosticSteps: diagnosticSteps ?? this.diagnosticSteps,
  );
  TroubleshootingGuide copyWithCompanion(TroubleshootingGuidesCompanion data) {
    return TroubleshootingGuide(
      id: data.id.present ? data.id.value : this.id,
      brand: data.brand.present ? data.brand.value : this.brand,
      category: data.category.present ? data.category.value : this.category,
      title: data.title.present ? data.title.value : this.title,
      symptom: data.symptom.present ? data.symptom.value : this.symptom,
      diagnosticSteps: data.diagnosticSteps.present
          ? data.diagnosticSteps.value
          : this.diagnosticSteps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TroubleshootingGuide(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('symptom: $symptom, ')
          ..write('diagnosticSteps: $diagnosticSteps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, brand, category, title, symptom, diagnosticSteps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TroubleshootingGuide &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.category == this.category &&
          other.title == this.title &&
          other.symptom == this.symptom &&
          other.diagnosticSteps == this.diagnosticSteps);
}

class TroubleshootingGuidesCompanion
    extends UpdateCompanion<TroubleshootingGuide> {
  final Value<int> id;
  final Value<String> brand;
  final Value<String> category;
  final Value<String> title;
  final Value<String> symptom;
  final Value<List<String>> diagnosticSteps;
  const TroubleshootingGuidesCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.symptom = const Value.absent(),
    this.diagnosticSteps = const Value.absent(),
  });
  TroubleshootingGuidesCompanion.insert({
    this.id = const Value.absent(),
    required String brand,
    required String category,
    required String title,
    required String symptom,
    this.diagnosticSteps = const Value.absent(),
  }) : brand = Value(brand),
       category = Value(category),
       title = Value(title),
       symptom = Value(symptom);
  static Insertable<TroubleshootingGuide> custom({
    Expression<int>? id,
    Expression<String>? brand,
    Expression<String>? category,
    Expression<String>? title,
    Expression<String>? symptom,
    Expression<String>? diagnosticSteps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (symptom != null) 'symptom': symptom,
      if (diagnosticSteps != null) 'diagnostic_steps': diagnosticSteps,
    });
  }

  TroubleshootingGuidesCompanion copyWith({
    Value<int>? id,
    Value<String>? brand,
    Value<String>? category,
    Value<String>? title,
    Value<String>? symptom,
    Value<List<String>>? diagnosticSteps,
  }) {
    return TroubleshootingGuidesCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      title: title ?? this.title,
      symptom: symptom ?? this.symptom,
      diagnosticSteps: diagnosticSteps ?? this.diagnosticSteps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (symptom.present) {
      map['symptom'] = Variable<String>(symptom.value);
    }
    if (diagnosticSteps.present) {
      map['diagnostic_steps'] = Variable<String>(
        $TroubleshootingGuidesTable.$converterdiagnosticSteps.toSql(
          diagnosticSteps.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TroubleshootingGuidesCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('symptom: $symptom, ')
          ..write('diagnosticSteps: $diagnosticSteps')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _actionTypeMeta = const VerificationMeta(
    'actionType',
  );
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
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
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
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
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    actionType,
    payloadJson,
    createdAt,
    retryCount,
    lastError,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action_type')) {
      context.handle(
        _actionTypeMeta,
        actionType.isAcceptableOrUnknown(data['action_type']!, _actionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      actionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String actionType;
  final String payloadJson;
  final DateTime createdAt;
  final int retryCount;
  final String? lastError;
  final String status;
  const SyncQueueData({
    required this.id,
    required this.actionType,
    required this.payloadJson,
    required this.createdAt,
    required this.retryCount,
    this.lastError,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action_type'] = Variable<String>(actionType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      actionType: Value(actionType),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      status: Value(status),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      actionType: serializer.fromJson<String>(json['actionType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'actionType': serializer.toJson<String>(actionType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'status': serializer.toJson<String>(status),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? actionType,
    String? payloadJson,
    DateTime? createdAt,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    String? status,
  }) => SyncQueueData(
    id: id ?? this.id,
    actionType: actionType ?? this.actionType,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    status: status ?? this.status,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      actionType: data.actionType.present
          ? data.actionType.value
          : this.actionType,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('actionType: $actionType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    actionType,
    payloadJson,
    createdAt,
    retryCount,
    lastError,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.actionType == this.actionType &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.status == this.status);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> actionType;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<String> status;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.actionType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.status = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String actionType,
    required String payloadJson,
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.status = const Value.absent(),
  }) : actionType = Value(actionType),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? actionType,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actionType != null) 'action_type': actionType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (status != null) 'status': status,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? actionType,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<String>? status,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      actionType: actionType ?? this.actionType,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('actionType: $actionType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $InspectionFormsTable extends InspectionForms
    with TableInfo<$InspectionFormsTable, InspectionForm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionFormsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _elevatorIdMeta = const VerificationMeta(
    'elevatorId',
  );
  @override
  late final GeneratedColumn<int> elevatorId = GeneratedColumn<int>(
    'elevator_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES elevators (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _inspectionDateMeta = const VerificationMeta(
    'inspectionDate',
  );
  @override
  late final GeneratedColumn<DateTime> inspectionDate =
      GeneratedColumn<DateTime>(
        'inspection_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _brakeClearanceMmMeta = const VerificationMeta(
    'brakeClearanceMm',
  );
  @override
  late final GeneratedColumn<double> brakeClearanceMm = GeneratedColumn<double>(
    'brake_clearance_mm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cableWearPercentageMeta =
      const VerificationMeta('cableWearPercentage');
  @override
  late final GeneratedColumn<double> cableWearPercentage =
      GeneratedColumn<double>(
        'cable_wear_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _safetyGearTripSpeedMeta =
      const VerificationMeta('safetyGearTripSpeed');
  @override
  late final GeneratedColumn<double> safetyGearTripSpeed =
      GeneratedColumn<double>(
        'safety_gear_trip_speed',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _machineRoomTempMeta = const VerificationMeta(
    'machineRoomTemp',
  );
  @override
  late final GeneratedColumn<double> machineRoomTemp = GeneratedColumn<double>(
    'machine_room_temp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overallPassStatusMeta = const VerificationMeta(
    'overallPassStatus',
  );
  @override
  late final GeneratedColumn<String> overallPassStatus =
      GeneratedColumn<String>(
        'overall_pass_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('Pass'),
      );
  static const VerificationMeta _technicianNotesMeta = const VerificationMeta(
    'technicianNotes',
  );
  @override
  late final GeneratedColumn<String> technicianNotes = GeneratedColumn<String>(
    'technician_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerSignatureMeta = const VerificationMeta(
    'customerSignature',
  );
  @override
  late final GeneratedColumn<String> customerSignature =
      GeneratedColumn<String>(
        'customer_signature',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUpdatedLocalMeta = const VerificationMeta(
    'lastUpdatedLocal',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedLocal =
      GeneratedColumn<DateTime>(
        'last_updated_local',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    elevatorId,
    customerId,
    inspectionDate,
    brakeClearanceMm,
    cableWearPercentage,
    safetyGearTripSpeed,
    machineRoomTemp,
    overallPassStatus,
    technicianNotes,
    customerSignature,
    isSynced,
    lastUpdatedLocal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspection_forms';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionForm> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('elevator_id')) {
      context.handle(
        _elevatorIdMeta,
        elevatorId.isAcceptableOrUnknown(data['elevator_id']!, _elevatorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_elevatorIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('inspection_date')) {
      context.handle(
        _inspectionDateMeta,
        inspectionDate.isAcceptableOrUnknown(
          data['inspection_date']!,
          _inspectionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionDateMeta);
    }
    if (data.containsKey('brake_clearance_mm')) {
      context.handle(
        _brakeClearanceMmMeta,
        brakeClearanceMm.isAcceptableOrUnknown(
          data['brake_clearance_mm']!,
          _brakeClearanceMmMeta,
        ),
      );
    }
    if (data.containsKey('cable_wear_percentage')) {
      context.handle(
        _cableWearPercentageMeta,
        cableWearPercentage.isAcceptableOrUnknown(
          data['cable_wear_percentage']!,
          _cableWearPercentageMeta,
        ),
      );
    }
    if (data.containsKey('safety_gear_trip_speed')) {
      context.handle(
        _safetyGearTripSpeedMeta,
        safetyGearTripSpeed.isAcceptableOrUnknown(
          data['safety_gear_trip_speed']!,
          _safetyGearTripSpeedMeta,
        ),
      );
    }
    if (data.containsKey('machine_room_temp')) {
      context.handle(
        _machineRoomTempMeta,
        machineRoomTemp.isAcceptableOrUnknown(
          data['machine_room_temp']!,
          _machineRoomTempMeta,
        ),
      );
    }
    if (data.containsKey('overall_pass_status')) {
      context.handle(
        _overallPassStatusMeta,
        overallPassStatus.isAcceptableOrUnknown(
          data['overall_pass_status']!,
          _overallPassStatusMeta,
        ),
      );
    }
    if (data.containsKey('technician_notes')) {
      context.handle(
        _technicianNotesMeta,
        technicianNotes.isAcceptableOrUnknown(
          data['technician_notes']!,
          _technicianNotesMeta,
        ),
      );
    }
    if (data.containsKey('customer_signature')) {
      context.handle(
        _customerSignatureMeta,
        customerSignature.isAcceptableOrUnknown(
          data['customer_signature']!,
          _customerSignatureMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_updated_local')) {
      context.handle(
        _lastUpdatedLocalMeta,
        lastUpdatedLocal.isAcceptableOrUnknown(
          data['last_updated_local']!,
          _lastUpdatedLocalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionForm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionForm(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      elevatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elevator_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      inspectionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inspection_date'],
      )!,
      brakeClearanceMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}brake_clearance_mm'],
      ),
      cableWearPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cable_wear_percentage'],
      ),
      safetyGearTripSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}safety_gear_trip_speed'],
      ),
      machineRoomTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}machine_room_temp'],
      ),
      overallPassStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overall_pass_status'],
      )!,
      technicianNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_notes'],
      ),
      customerSignature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_signature'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      lastUpdatedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_local'],
      ),
    );
  }

  @override
  $InspectionFormsTable createAlias(String alias) {
    return $InspectionFormsTable(attachedDatabase, alias);
  }
}

class InspectionForm extends DataClass implements Insertable<InspectionForm> {
  final int id;
  final String serverId;
  final int elevatorId;
  final int customerId;
  final DateTime inspectionDate;
  final double? brakeClearanceMm;
  final double? cableWearPercentage;
  final double? safetyGearTripSpeed;
  final double? machineRoomTemp;
  final String overallPassStatus;
  final String? technicianNotes;
  final String? customerSignature;
  final bool isSynced;
  final DateTime? lastUpdatedLocal;
  const InspectionForm({
    required this.id,
    required this.serverId,
    required this.elevatorId,
    required this.customerId,
    required this.inspectionDate,
    this.brakeClearanceMm,
    this.cableWearPercentage,
    this.safetyGearTripSpeed,
    this.machineRoomTemp,
    required this.overallPassStatus,
    this.technicianNotes,
    this.customerSignature,
    required this.isSynced,
    this.lastUpdatedLocal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['elevator_id'] = Variable<int>(elevatorId);
    map['customer_id'] = Variable<int>(customerId);
    map['inspection_date'] = Variable<DateTime>(inspectionDate);
    if (!nullToAbsent || brakeClearanceMm != null) {
      map['brake_clearance_mm'] = Variable<double>(brakeClearanceMm);
    }
    if (!nullToAbsent || cableWearPercentage != null) {
      map['cable_wear_percentage'] = Variable<double>(cableWearPercentage);
    }
    if (!nullToAbsent || safetyGearTripSpeed != null) {
      map['safety_gear_trip_speed'] = Variable<double>(safetyGearTripSpeed);
    }
    if (!nullToAbsent || machineRoomTemp != null) {
      map['machine_room_temp'] = Variable<double>(machineRoomTemp);
    }
    map['overall_pass_status'] = Variable<String>(overallPassStatus);
    if (!nullToAbsent || technicianNotes != null) {
      map['technician_notes'] = Variable<String>(technicianNotes);
    }
    if (!nullToAbsent || customerSignature != null) {
      map['customer_signature'] = Variable<String>(customerSignature);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastUpdatedLocal != null) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal);
    }
    return map;
  }

  InspectionFormsCompanion toCompanion(bool nullToAbsent) {
    return InspectionFormsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      elevatorId: Value(elevatorId),
      customerId: Value(customerId),
      inspectionDate: Value(inspectionDate),
      brakeClearanceMm: brakeClearanceMm == null && nullToAbsent
          ? const Value.absent()
          : Value(brakeClearanceMm),
      cableWearPercentage: cableWearPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(cableWearPercentage),
      safetyGearTripSpeed: safetyGearTripSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(safetyGearTripSpeed),
      machineRoomTemp: machineRoomTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(machineRoomTemp),
      overallPassStatus: Value(overallPassStatus),
      technicianNotes: technicianNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianNotes),
      customerSignature: customerSignature == null && nullToAbsent
          ? const Value.absent()
          : Value(customerSignature),
      isSynced: Value(isSynced),
      lastUpdatedLocal: lastUpdatedLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedLocal),
    );
  }

  factory InspectionForm.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionForm(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      elevatorId: serializer.fromJson<int>(json['elevatorId']),
      customerId: serializer.fromJson<int>(json['customerId']),
      inspectionDate: serializer.fromJson<DateTime>(json['inspectionDate']),
      brakeClearanceMm: serializer.fromJson<double?>(json['brakeClearanceMm']),
      cableWearPercentage: serializer.fromJson<double?>(
        json['cableWearPercentage'],
      ),
      safetyGearTripSpeed: serializer.fromJson<double?>(
        json['safetyGearTripSpeed'],
      ),
      machineRoomTemp: serializer.fromJson<double?>(json['machineRoomTemp']),
      overallPassStatus: serializer.fromJson<String>(json['overallPassStatus']),
      technicianNotes: serializer.fromJson<String?>(json['technicianNotes']),
      customerSignature: serializer.fromJson<String?>(
        json['customerSignature'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastUpdatedLocal: serializer.fromJson<DateTime?>(
        json['lastUpdatedLocal'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'elevatorId': serializer.toJson<int>(elevatorId),
      'customerId': serializer.toJson<int>(customerId),
      'inspectionDate': serializer.toJson<DateTime>(inspectionDate),
      'brakeClearanceMm': serializer.toJson<double?>(brakeClearanceMm),
      'cableWearPercentage': serializer.toJson<double?>(cableWearPercentage),
      'safetyGearTripSpeed': serializer.toJson<double?>(safetyGearTripSpeed),
      'machineRoomTemp': serializer.toJson<double?>(machineRoomTemp),
      'overallPassStatus': serializer.toJson<String>(overallPassStatus),
      'technicianNotes': serializer.toJson<String?>(technicianNotes),
      'customerSignature': serializer.toJson<String?>(customerSignature),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastUpdatedLocal': serializer.toJson<DateTime?>(lastUpdatedLocal),
    };
  }

  InspectionForm copyWith({
    int? id,
    String? serverId,
    int? elevatorId,
    int? customerId,
    DateTime? inspectionDate,
    Value<double?> brakeClearanceMm = const Value.absent(),
    Value<double?> cableWearPercentage = const Value.absent(),
    Value<double?> safetyGearTripSpeed = const Value.absent(),
    Value<double?> machineRoomTemp = const Value.absent(),
    String? overallPassStatus,
    Value<String?> technicianNotes = const Value.absent(),
    Value<String?> customerSignature = const Value.absent(),
    bool? isSynced,
    Value<DateTime?> lastUpdatedLocal = const Value.absent(),
  }) => InspectionForm(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    elevatorId: elevatorId ?? this.elevatorId,
    customerId: customerId ?? this.customerId,
    inspectionDate: inspectionDate ?? this.inspectionDate,
    brakeClearanceMm: brakeClearanceMm.present
        ? brakeClearanceMm.value
        : this.brakeClearanceMm,
    cableWearPercentage: cableWearPercentage.present
        ? cableWearPercentage.value
        : this.cableWearPercentage,
    safetyGearTripSpeed: safetyGearTripSpeed.present
        ? safetyGearTripSpeed.value
        : this.safetyGearTripSpeed,
    machineRoomTemp: machineRoomTemp.present
        ? machineRoomTemp.value
        : this.machineRoomTemp,
    overallPassStatus: overallPassStatus ?? this.overallPassStatus,
    technicianNotes: technicianNotes.present
        ? technicianNotes.value
        : this.technicianNotes,
    customerSignature: customerSignature.present
        ? customerSignature.value
        : this.customerSignature,
    isSynced: isSynced ?? this.isSynced,
    lastUpdatedLocal: lastUpdatedLocal.present
        ? lastUpdatedLocal.value
        : this.lastUpdatedLocal,
  );
  InspectionForm copyWithCompanion(InspectionFormsCompanion data) {
    return InspectionForm(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      elevatorId: data.elevatorId.present
          ? data.elevatorId.value
          : this.elevatorId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      inspectionDate: data.inspectionDate.present
          ? data.inspectionDate.value
          : this.inspectionDate,
      brakeClearanceMm: data.brakeClearanceMm.present
          ? data.brakeClearanceMm.value
          : this.brakeClearanceMm,
      cableWearPercentage: data.cableWearPercentage.present
          ? data.cableWearPercentage.value
          : this.cableWearPercentage,
      safetyGearTripSpeed: data.safetyGearTripSpeed.present
          ? data.safetyGearTripSpeed.value
          : this.safetyGearTripSpeed,
      machineRoomTemp: data.machineRoomTemp.present
          ? data.machineRoomTemp.value
          : this.machineRoomTemp,
      overallPassStatus: data.overallPassStatus.present
          ? data.overallPassStatus.value
          : this.overallPassStatus,
      technicianNotes: data.technicianNotes.present
          ? data.technicianNotes.value
          : this.technicianNotes,
      customerSignature: data.customerSignature.present
          ? data.customerSignature.value
          : this.customerSignature,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastUpdatedLocal: data.lastUpdatedLocal.present
          ? data.lastUpdatedLocal.value
          : this.lastUpdatedLocal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionForm(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('inspectionDate: $inspectionDate, ')
          ..write('brakeClearanceMm: $brakeClearanceMm, ')
          ..write('cableWearPercentage: $cableWearPercentage, ')
          ..write('safetyGearTripSpeed: $safetyGearTripSpeed, ')
          ..write('machineRoomTemp: $machineRoomTemp, ')
          ..write('overallPassStatus: $overallPassStatus, ')
          ..write('technicianNotes: $technicianNotes, ')
          ..write('customerSignature: $customerSignature, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    elevatorId,
    customerId,
    inspectionDate,
    brakeClearanceMm,
    cableWearPercentage,
    safetyGearTripSpeed,
    machineRoomTemp,
    overallPassStatus,
    technicianNotes,
    customerSignature,
    isSynced,
    lastUpdatedLocal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionForm &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.elevatorId == this.elevatorId &&
          other.customerId == this.customerId &&
          other.inspectionDate == this.inspectionDate &&
          other.brakeClearanceMm == this.brakeClearanceMm &&
          other.cableWearPercentage == this.cableWearPercentage &&
          other.safetyGearTripSpeed == this.safetyGearTripSpeed &&
          other.machineRoomTemp == this.machineRoomTemp &&
          other.overallPassStatus == this.overallPassStatus &&
          other.technicianNotes == this.technicianNotes &&
          other.customerSignature == this.customerSignature &&
          other.isSynced == this.isSynced &&
          other.lastUpdatedLocal == this.lastUpdatedLocal);
}

class InspectionFormsCompanion extends UpdateCompanion<InspectionForm> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<int> elevatorId;
  final Value<int> customerId;
  final Value<DateTime> inspectionDate;
  final Value<double?> brakeClearanceMm;
  final Value<double?> cableWearPercentage;
  final Value<double?> safetyGearTripSpeed;
  final Value<double?> machineRoomTemp;
  final Value<String> overallPassStatus;
  final Value<String?> technicianNotes;
  final Value<String?> customerSignature;
  final Value<bool> isSynced;
  final Value<DateTime?> lastUpdatedLocal;
  const InspectionFormsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.elevatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.inspectionDate = const Value.absent(),
    this.brakeClearanceMm = const Value.absent(),
    this.cableWearPercentage = const Value.absent(),
    this.safetyGearTripSpeed = const Value.absent(),
    this.machineRoomTemp = const Value.absent(),
    this.overallPassStatus = const Value.absent(),
    this.technicianNotes = const Value.absent(),
    this.customerSignature = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  });
  InspectionFormsCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required int elevatorId,
    required int customerId,
    required DateTime inspectionDate,
    this.brakeClearanceMm = const Value.absent(),
    this.cableWearPercentage = const Value.absent(),
    this.safetyGearTripSpeed = const Value.absent(),
    this.machineRoomTemp = const Value.absent(),
    this.overallPassStatus = const Value.absent(),
    this.technicianNotes = const Value.absent(),
    this.customerSignature = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastUpdatedLocal = const Value.absent(),
  }) : serverId = Value(serverId),
       elevatorId = Value(elevatorId),
       customerId = Value(customerId),
       inspectionDate = Value(inspectionDate);
  static Insertable<InspectionForm> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? elevatorId,
    Expression<int>? customerId,
    Expression<DateTime>? inspectionDate,
    Expression<double>? brakeClearanceMm,
    Expression<double>? cableWearPercentage,
    Expression<double>? safetyGearTripSpeed,
    Expression<double>? machineRoomTemp,
    Expression<String>? overallPassStatus,
    Expression<String>? technicianNotes,
    Expression<String>? customerSignature,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastUpdatedLocal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (elevatorId != null) 'elevator_id': elevatorId,
      if (customerId != null) 'customer_id': customerId,
      if (inspectionDate != null) 'inspection_date': inspectionDate,
      if (brakeClearanceMm != null) 'brake_clearance_mm': brakeClearanceMm,
      if (cableWearPercentage != null)
        'cable_wear_percentage': cableWearPercentage,
      if (safetyGearTripSpeed != null)
        'safety_gear_trip_speed': safetyGearTripSpeed,
      if (machineRoomTemp != null) 'machine_room_temp': machineRoomTemp,
      if (overallPassStatus != null) 'overall_pass_status': overallPassStatus,
      if (technicianNotes != null) 'technician_notes': technicianNotes,
      if (customerSignature != null) 'customer_signature': customerSignature,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastUpdatedLocal != null) 'last_updated_local': lastUpdatedLocal,
    });
  }

  InspectionFormsCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<int>? elevatorId,
    Value<int>? customerId,
    Value<DateTime>? inspectionDate,
    Value<double?>? brakeClearanceMm,
    Value<double?>? cableWearPercentage,
    Value<double?>? safetyGearTripSpeed,
    Value<double?>? machineRoomTemp,
    Value<String>? overallPassStatus,
    Value<String?>? technicianNotes,
    Value<String?>? customerSignature,
    Value<bool>? isSynced,
    Value<DateTime?>? lastUpdatedLocal,
  }) {
    return InspectionFormsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      elevatorId: elevatorId ?? this.elevatorId,
      customerId: customerId ?? this.customerId,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      brakeClearanceMm: brakeClearanceMm ?? this.brakeClearanceMm,
      cableWearPercentage: cableWearPercentage ?? this.cableWearPercentage,
      safetyGearTripSpeed: safetyGearTripSpeed ?? this.safetyGearTripSpeed,
      machineRoomTemp: machineRoomTemp ?? this.machineRoomTemp,
      overallPassStatus: overallPassStatus ?? this.overallPassStatus,
      technicianNotes: technicianNotes ?? this.technicianNotes,
      customerSignature: customerSignature ?? this.customerSignature,
      isSynced: isSynced ?? this.isSynced,
      lastUpdatedLocal: lastUpdatedLocal ?? this.lastUpdatedLocal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (elevatorId.present) {
      map['elevator_id'] = Variable<int>(elevatorId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (inspectionDate.present) {
      map['inspection_date'] = Variable<DateTime>(inspectionDate.value);
    }
    if (brakeClearanceMm.present) {
      map['brake_clearance_mm'] = Variable<double>(brakeClearanceMm.value);
    }
    if (cableWearPercentage.present) {
      map['cable_wear_percentage'] = Variable<double>(
        cableWearPercentage.value,
      );
    }
    if (safetyGearTripSpeed.present) {
      map['safety_gear_trip_speed'] = Variable<double>(
        safetyGearTripSpeed.value,
      );
    }
    if (machineRoomTemp.present) {
      map['machine_room_temp'] = Variable<double>(machineRoomTemp.value);
    }
    if (overallPassStatus.present) {
      map['overall_pass_status'] = Variable<String>(overallPassStatus.value);
    }
    if (technicianNotes.present) {
      map['technician_notes'] = Variable<String>(technicianNotes.value);
    }
    if (customerSignature.present) {
      map['customer_signature'] = Variable<String>(customerSignature.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastUpdatedLocal.present) {
      map['last_updated_local'] = Variable<DateTime>(lastUpdatedLocal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionFormsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('elevatorId: $elevatorId, ')
          ..write('customerId: $customerId, ')
          ..write('inspectionDate: $inspectionDate, ')
          ..write('brakeClearanceMm: $brakeClearanceMm, ')
          ..write('cableWearPercentage: $cableWearPercentage, ')
          ..write('safetyGearTripSpeed: $safetyGearTripSpeed, ')
          ..write('machineRoomTemp: $machineRoomTemp, ')
          ..write('overallPassStatus: $overallPassStatus, ')
          ..write('technicianNotes: $technicianNotes, ')
          ..write('customerSignature: $customerSignature, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastUpdatedLocal: $lastUpdatedLocal')
          ..write(')'))
        .toString();
  }
}

class $FieldMediaTable extends FieldMedia
    with TableInfo<$FieldMediaTable, FieldMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldMediaTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
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
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    mediaType,
    filePath,
    caption,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_media';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldMediaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
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
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldMediaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $FieldMediaTable createAlias(String alias) {
    return $FieldMediaTable(attachedDatabase, alias);
  }
}

class FieldMediaData extends DataClass implements Insertable<FieldMediaData> {
  final int id;
  final String entityType;
  final int entityId;
  final String mediaType;
  final String filePath;
  final String? caption;
  final DateTime createdAt;
  final bool isSynced;
  const FieldMediaData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.mediaType,
    required this.filePath,
    this.caption,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<int>(entityId);
    map['media_type'] = Variable<String>(mediaType);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  FieldMediaCompanion toCompanion(bool nullToAbsent) {
    return FieldMediaCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      mediaType: Value(mediaType),
      filePath: Value(filePath),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory FieldMediaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldMediaData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int>(json['entityId']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      filePath: serializer.fromJson<String>(json['filePath']),
      caption: serializer.fromJson<String?>(json['caption']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int>(entityId),
      'mediaType': serializer.toJson<String>(mediaType),
      'filePath': serializer.toJson<String>(filePath),
      'caption': serializer.toJson<String?>(caption),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  FieldMediaData copyWith({
    int? id,
    String? entityType,
    int? entityId,
    String? mediaType,
    String? filePath,
    Value<String?> caption = const Value.absent(),
    DateTime? createdAt,
    bool? isSynced,
  }) => FieldMediaData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    mediaType: mediaType ?? this.mediaType,
    filePath: filePath ?? this.filePath,
    caption: caption.present ? caption.value : this.caption,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  FieldMediaData copyWithCompanion(FieldMediaCompanion data) {
    return FieldMediaData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      caption: data.caption.present ? data.caption.value : this.caption,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldMediaData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('mediaType: $mediaType, ')
          ..write('filePath: $filePath, ')
          ..write('caption: $caption, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    mediaType,
    filePath,
    caption,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldMediaData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.mediaType == this.mediaType &&
          other.filePath == this.filePath &&
          other.caption == this.caption &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class FieldMediaCompanion extends UpdateCompanion<FieldMediaData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int> entityId;
  final Value<String> mediaType;
  final Value<String> filePath;
  final Value<String?> caption;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  const FieldMediaCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.caption = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  FieldMediaCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required int entityId,
    required String mediaType,
    required String filePath,
    this.caption = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       mediaType = Value(mediaType),
       filePath = Value(filePath),
       createdAt = Value(createdAt);
  static Insertable<FieldMediaData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? mediaType,
    Expression<String>? filePath,
    Expression<String>? caption,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (mediaType != null) 'media_type': mediaType,
      if (filePath != null) 'file_path': filePath,
      if (caption != null) 'caption': caption,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  FieldMediaCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<int>? entityId,
    Value<String>? mediaType,
    Value<String>? filePath,
    Value<String?>? caption,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
  }) {
    return FieldMediaCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      mediaType: mediaType ?? this.mediaType,
      filePath: filePath ?? this.filePath,
      caption: caption ?? this.caption,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldMediaCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('mediaType: $mediaType, ')
          ..write('filePath: $filePath, ')
          ..write('caption: $caption, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MaintenanceGroupsTable maintenanceGroups =
      $MaintenanceGroupsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $ElevatorsTable elevators = $ElevatorsTable(this);
  late final $MaintenancesTable maintenances = $MaintenancesTable(this);
  late final $FaultsTable faults = $FaultsTable(this);
  late final $DailyRoutesTable dailyRoutes = $DailyRoutesTable(this);
  late final $ServiceFormsTable serviceForms = $ServiceFormsTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $PartRequestsTable partRequests = $PartRequestsTable(this);
  late final $ErrorCodesTable errorCodes = $ErrorCodesTable(this);
  late final $TroubleshootingGuidesTable troubleshootingGuides =
      $TroubleshootingGuidesTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $InspectionFormsTable inspectionForms = $InspectionFormsTable(
    this,
  );
  late final $FieldMediaTable fieldMedia = $FieldMediaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    maintenanceGroups,
    customers,
    elevators,
    maintenances,
    faults,
    dailyRoutes,
    serviceForms,
    inventoryItems,
    partRequests,
    errorCodes,
    troubleshootingGuides,
    syncQueue,
    inspectionForms,
    fieldMedia,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String serverId,
      required String username,
      required String fullName,
      required String companyName,
      Value<String?> token,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<String> username,
      Value<String> fullName,
      Value<String> companyName,
      Value<String?> token,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String?> token = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                serverId: serverId,
                username: username,
                fullName: fullName,
                companyName: companyName,
                token: token,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required String username,
                required String fullName,
                required String companyName,
                Value<String?> token = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                serverId: serverId,
                username: username,
                fullName: fullName,
                companyName: companyName,
                token: token,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$MaintenanceGroupsTableCreateCompanionBuilder =
    MaintenanceGroupsCompanion Function({Value<int> id, required String name});
typedef $$MaintenanceGroupsTableUpdateCompanionBuilder =
    MaintenanceGroupsCompanion Function({Value<int> id, Value<String> name});

final class $$MaintenanceGroupsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceGroupsTable,
          MaintenanceGroup
        > {
  $$MaintenanceGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CustomersTable, List<Customer>>
  _customersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customers,
    aliasName: $_aliasNameGenerator(
      db.maintenanceGroups.id,
      db.customers.maintenanceGroupId,
    ),
  );

  $$CustomersTableProcessedTableManager get customersRefs {
    final manager = $$CustomersTableTableManager($_db, $_db.customers).filter(
      (f) => f.maintenanceGroupId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_customersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaintenanceGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceGroupsTable> {
  $$MaintenanceGroupsTableFilterComposer({
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

  Expression<bool> customersRefs(
    Expression<bool> Function($$CustomersTableFilterComposer f) f,
  ) {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.maintenanceGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceGroupsTable> {
  $$MaintenanceGroupsTableOrderingComposer({
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
}

class $$MaintenanceGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceGroupsTable> {
  $$MaintenanceGroupsTableAnnotationComposer({
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

  Expression<T> customersRefs<T extends Object>(
    Expression<T> Function($$CustomersTableAnnotationComposer a) f,
  ) {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.maintenanceGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceGroupsTable,
          MaintenanceGroup,
          $$MaintenanceGroupsTableFilterComposer,
          $$MaintenanceGroupsTableOrderingComposer,
          $$MaintenanceGroupsTableAnnotationComposer,
          $$MaintenanceGroupsTableCreateCompanionBuilder,
          $$MaintenanceGroupsTableUpdateCompanionBuilder,
          (MaintenanceGroup, $$MaintenanceGroupsTableReferences),
          MaintenanceGroup,
          PrefetchHooks Function({bool customersRefs})
        > {
  $$MaintenanceGroupsTableTableManager(
    _$AppDatabase db,
    $MaintenanceGroupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceGroupsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => MaintenanceGroupsCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  MaintenanceGroupsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({customersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (customersRefs) db.customers],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (customersRefs)
                    await $_getPrefetchedData<
                      MaintenanceGroup,
                      $MaintenanceGroupsTable,
                      Customer
                    >(
                      currentTable: table,
                      referencedTable: $$MaintenanceGroupsTableReferences
                          ._customersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MaintenanceGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).customersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.maintenanceGroupId == item.id,
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

typedef $$MaintenanceGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceGroupsTable,
      MaintenanceGroup,
      $$MaintenanceGroupsTableFilterComposer,
      $$MaintenanceGroupsTableOrderingComposer,
      $$MaintenanceGroupsTableAnnotationComposer,
      $$MaintenanceGroupsTableCreateCompanionBuilder,
      $$MaintenanceGroupsTableUpdateCompanionBuilder,
      (MaintenanceGroup, $$MaintenanceGroupsTableReferences),
      MaintenanceGroup,
      PrefetchHooks Function({bool customersRefs})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String serverId,
      required String name,
      required String address,
      required String city,
      required String district,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> authorizedPerson,
      Value<String?> phone,
      Value<String?> notes,
      Value<double?> monthlyMaintenanceFee,
      Value<double> balance,
      Value<DateTime?> lastFeeDate,
      Value<List<Map<String, dynamic>>> transactionHistory,
      Value<int?> maintenanceGroupId,
      Value<DateTime?> lastUpdatedLocal,
      Value<bool> isSynced,
      Value<bool> isApproved,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<String> name,
      Value<String> address,
      Value<String> city,
      Value<String> district,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> authorizedPerson,
      Value<String?> phone,
      Value<String?> notes,
      Value<double?> monthlyMaintenanceFee,
      Value<double> balance,
      Value<DateTime?> lastFeeDate,
      Value<List<Map<String, dynamic>>> transactionHistory,
      Value<int?> maintenanceGroupId,
      Value<DateTime?> lastUpdatedLocal,
      Value<bool> isSynced,
      Value<bool> isApproved,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MaintenanceGroupsTable _maintenanceGroupIdTable(_$AppDatabase db) =>
      db.maintenanceGroups.createAlias(
        $_aliasNameGenerator(
          db.customers.maintenanceGroupId,
          db.maintenanceGroups.id,
        ),
      );

  $$MaintenanceGroupsTableProcessedTableManager? get maintenanceGroupId {
    final $_column = $_itemColumn<int>('maintenance_group_id');
    if ($_column == null) return null;
    final manager = $$MaintenanceGroupsTableTableManager(
      $_db,
      $_db.maintenanceGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_maintenanceGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ElevatorsTable, List<Elevator>>
  _elevatorsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.elevators,
    aliasName: $_aliasNameGenerator(db.customers.id, db.elevators.customerId),
  );

  $$ElevatorsTableProcessedTableManager get elevatorsRefs {
    final manager = $$ElevatorsTableTableManager(
      $_db,
      $_db.elevators,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_elevatorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenancesTable, List<Maintenance>>
  _maintenancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenances,
    aliasName: $_aliasNameGenerator(
      db.customers.id,
      db.maintenances.customerId,
    ),
  );

  $$MaintenancesTableProcessedTableManager get maintenancesRefs {
    final manager = $$MaintenancesTableTableManager(
      $_db,
      $_db.maintenances,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_maintenancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FaultsTable, List<Fault>> _faultsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.faults,
    aliasName: $_aliasNameGenerator(db.customers.id, db.faults.customerId),
  );

  $$FaultsTableProcessedTableManager get faultsRefs {
    final manager = $$FaultsTableTableManager(
      $_db,
      $_db.faults,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_faultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartRequestsTable, List<PartRequest>>
  _partRequestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partRequests,
    aliasName: $_aliasNameGenerator(
      db.customers.id,
      db.partRequests.customerId,
    ),
  );

  $$PartRequestsTableProcessedTableManager get partRequestsRefs {
    final manager = $$PartRequestsTableTableManager(
      $_db,
      $_db.partRequests,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partRequestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InspectionFormsTable, List<InspectionForm>>
  _inspectionFormsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inspectionForms,
    aliasName: $_aliasNameGenerator(
      db.customers.id,
      db.inspectionForms.customerId,
    ),
  );

  $$InspectionFormsTableProcessedTableManager get inspectionFormsRefs {
    final manager = $$InspectionFormsTableTableManager(
      $_db,
      $_db.inspectionForms,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inspectionFormsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorizedPerson => $composableBuilder(
    column: $table.authorizedPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyMaintenanceFee => $composableBuilder(
    column: $table.monthlyMaintenanceFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFeeDate => $composableBuilder(
    column: $table.lastFeeDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get transactionHistory => $composableBuilder(
    column: $table.transactionHistory,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isApproved => $composableBuilder(
    column: $table.isApproved,
    builder: (column) => ColumnFilters(column),
  );

  $$MaintenanceGroupsTableFilterComposer get maintenanceGroupId {
    final $$MaintenanceGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceGroupId,
      referencedTable: $db.maintenanceGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceGroupsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> elevatorsRefs(
    Expression<bool> Function($$ElevatorsTableFilterComposer f) f,
  ) {
    final $$ElevatorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableFilterComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenancesRefs(
    Expression<bool> Function($$MaintenancesTableFilterComposer f) f,
  ) {
    final $$MaintenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenances,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenancesTableFilterComposer(
            $db: $db,
            $table: $db.maintenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> faultsRefs(
    Expression<bool> Function($$FaultsTableFilterComposer f) f,
  ) {
    final $$FaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.faults,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaultsTableFilterComposer(
            $db: $db,
            $table: $db.faults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partRequestsRefs(
    Expression<bool> Function($$PartRequestsTableFilterComposer f) f,
  ) {
    final $$PartRequestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partRequests,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartRequestsTableFilterComposer(
            $db: $db,
            $table: $db.partRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inspectionFormsRefs(
    Expression<bool> Function($$InspectionFormsTableFilterComposer f) f,
  ) {
    final $$InspectionFormsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspectionForms,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionFormsTableFilterComposer(
            $db: $db,
            $table: $db.inspectionForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorizedPerson => $composableBuilder(
    column: $table.authorizedPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyMaintenanceFee => $composableBuilder(
    column: $table.monthlyMaintenanceFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFeeDate => $composableBuilder(
    column: $table.lastFeeDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionHistory => $composableBuilder(
    column: $table.transactionHistory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isApproved => $composableBuilder(
    column: $table.isApproved,
    builder: (column) => ColumnOrderings(column),
  );

  $$MaintenanceGroupsTableOrderingComposer get maintenanceGroupId {
    final $$MaintenanceGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceGroupId,
      referencedTable: $db.maintenanceGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.maintenanceGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get authorizedPerson => $composableBuilder(
    column: $table.authorizedPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get monthlyMaintenanceFee => $composableBuilder(
    column: $table.monthlyMaintenanceFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<DateTime> get lastFeeDate => $composableBuilder(
    column: $table.lastFeeDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get transactionHistory => $composableBuilder(
    column: $table.transactionHistory,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isApproved => $composableBuilder(
    column: $table.isApproved,
    builder: (column) => column,
  );

  $$MaintenanceGroupsTableAnnotationComposer get maintenanceGroupId {
    final $$MaintenanceGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.maintenanceGroupId,
          referencedTable: $db.maintenanceGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> elevatorsRefs<T extends Object>(
    Expression<T> Function($$ElevatorsTableAnnotationComposer a) f,
  ) {
    final $$ElevatorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableAnnotationComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenancesRefs<T extends Object>(
    Expression<T> Function($$MaintenancesTableAnnotationComposer a) f,
  ) {
    final $$MaintenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenances,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> faultsRefs<T extends Object>(
    Expression<T> Function($$FaultsTableAnnotationComposer a) f,
  ) {
    final $$FaultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.faults,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaultsTableAnnotationComposer(
            $db: $db,
            $table: $db.faults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> partRequestsRefs<T extends Object>(
    Expression<T> Function($$PartRequestsTableAnnotationComposer a) f,
  ) {
    final $$PartRequestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partRequests,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartRequestsTableAnnotationComposer(
            $db: $db,
            $table: $db.partRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inspectionFormsRefs<T extends Object>(
    Expression<T> Function($$InspectionFormsTableAnnotationComposer a) f,
  ) {
    final $$InspectionFormsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspectionForms,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionFormsTableAnnotationComposer(
            $db: $db,
            $table: $db.inspectionForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({
            bool maintenanceGroupId,
            bool elevatorsRefs,
            bool maintenancesRefs,
            bool faultsRefs,
            bool partRequestsRefs,
            bool inspectionFormsRefs,
          })
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> district = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> authorizedPerson = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> monthlyMaintenanceFee = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime?> lastFeeDate = const Value.absent(),
                Value<List<Map<String, dynamic>>> transactionHistory =
                    const Value.absent(),
                Value<int?> maintenanceGroupId = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isApproved = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                serverId: serverId,
                name: name,
                address: address,
                city: city,
                district: district,
                latitude: latitude,
                longitude: longitude,
                authorizedPerson: authorizedPerson,
                phone: phone,
                notes: notes,
                monthlyMaintenanceFee: monthlyMaintenanceFee,
                balance: balance,
                lastFeeDate: lastFeeDate,
                transactionHistory: transactionHistory,
                maintenanceGroupId: maintenanceGroupId,
                lastUpdatedLocal: lastUpdatedLocal,
                isSynced: isSynced,
                isApproved: isApproved,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required String name,
                required String address,
                required String city,
                required String district,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> authorizedPerson = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> monthlyMaintenanceFee = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime?> lastFeeDate = const Value.absent(),
                Value<List<Map<String, dynamic>>> transactionHistory =
                    const Value.absent(),
                Value<int?> maintenanceGroupId = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isApproved = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                serverId: serverId,
                name: name,
                address: address,
                city: city,
                district: district,
                latitude: latitude,
                longitude: longitude,
                authorizedPerson: authorizedPerson,
                phone: phone,
                notes: notes,
                monthlyMaintenanceFee: monthlyMaintenanceFee,
                balance: balance,
                lastFeeDate: lastFeeDate,
                transactionHistory: transactionHistory,
                maintenanceGroupId: maintenanceGroupId,
                lastUpdatedLocal: lastUpdatedLocal,
                isSynced: isSynced,
                isApproved: isApproved,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                maintenanceGroupId = false,
                elevatorsRefs = false,
                maintenancesRefs = false,
                faultsRefs = false,
                partRequestsRefs = false,
                inspectionFormsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (elevatorsRefs) db.elevators,
                    if (maintenancesRefs) db.maintenances,
                    if (faultsRefs) db.faults,
                    if (partRequestsRefs) db.partRequests,
                    if (inspectionFormsRefs) db.inspectionForms,
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
                        if (maintenanceGroupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.maintenanceGroupId,
                                    referencedTable: $$CustomersTableReferences
                                        ._maintenanceGroupIdTable(db),
                                    referencedColumn: $$CustomersTableReferences
                                        ._maintenanceGroupIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (elevatorsRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          Elevator
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._elevatorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).elevatorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenancesRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          Maintenance
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._maintenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (faultsRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          Fault
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._faultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).faultsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (partRequestsRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          PartRequest
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._partRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).partRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inspectionFormsRefs)
                        await $_getPrefetchedData<
                          Customer,
                          $CustomersTable,
                          InspectionForm
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._inspectionFormsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).inspectionFormsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
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

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({
        bool maintenanceGroupId,
        bool elevatorsRefs,
        bool maintenancesRefs,
        bool faultsRefs,
        bool partRequestsRefs,
        bool inspectionFormsRefs,
      })
    >;
typedef $$ElevatorsTableCreateCompanionBuilder =
    ElevatorsCompanion Function({
      Value<int> id,
      required String serverId,
      required String code,
      Value<String?> idNumber,
      Value<String?> name,
      required ElevatorType type,
      Value<String?> usageTypeDetail,
      Value<String?> driveType,
      Value<int?> capacityPerson,
      Value<int?> capacityWeight,
      Value<int?> stops,
      Value<double?> speed,
      Value<ElevatorTagColor> tagColor,
      Value<DateTime?> tagDate,
      Value<List<Map<String, dynamic>>> pendingMaintenanceTasks,
      Value<int?> customerId,
      Value<DateTime?> lastUpdatedLocal,
      Value<bool> isSynced,
      Value<bool> isApproved,
    });
typedef $$ElevatorsTableUpdateCompanionBuilder =
    ElevatorsCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<String> code,
      Value<String?> idNumber,
      Value<String?> name,
      Value<ElevatorType> type,
      Value<String?> usageTypeDetail,
      Value<String?> driveType,
      Value<int?> capacityPerson,
      Value<int?> capacityWeight,
      Value<int?> stops,
      Value<double?> speed,
      Value<ElevatorTagColor> tagColor,
      Value<DateTime?> tagDate,
      Value<List<Map<String, dynamic>>> pendingMaintenanceTasks,
      Value<int?> customerId,
      Value<DateTime?> lastUpdatedLocal,
      Value<bool> isSynced,
      Value<bool> isApproved,
    });

final class $$ElevatorsTableReferences
    extends BaseReferences<_$AppDatabase, $ElevatorsTable, Elevator> {
  $$ElevatorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.elevators.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MaintenancesTable, List<Maintenance>>
  _maintenancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenances,
    aliasName: $_aliasNameGenerator(
      db.elevators.id,
      db.maintenances.elevatorId,
    ),
  );

  $$MaintenancesTableProcessedTableManager get maintenancesRefs {
    final manager = $$MaintenancesTableTableManager(
      $_db,
      $_db.maintenances,
    ).filter((f) => f.elevatorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_maintenancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FaultsTable, List<Fault>> _faultsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.faults,
    aliasName: $_aliasNameGenerator(db.elevators.id, db.faults.elevatorId),
  );

  $$FaultsTableProcessedTableManager get faultsRefs {
    final manager = $$FaultsTableTableManager(
      $_db,
      $_db.faults,
    ).filter((f) => f.elevatorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_faultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartRequestsTable, List<PartRequest>>
  _partRequestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partRequests,
    aliasName: $_aliasNameGenerator(
      db.elevators.id,
      db.partRequests.elevatorId,
    ),
  );

  $$PartRequestsTableProcessedTableManager get partRequestsRefs {
    final manager = $$PartRequestsTableTableManager(
      $_db,
      $_db.partRequests,
    ).filter((f) => f.elevatorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partRequestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InspectionFormsTable, List<InspectionForm>>
  _inspectionFormsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inspectionForms,
    aliasName: $_aliasNameGenerator(
      db.elevators.id,
      db.inspectionForms.elevatorId,
    ),
  );

  $$InspectionFormsTableProcessedTableManager get inspectionFormsRefs {
    final manager = $$InspectionFormsTableTableManager(
      $_db,
      $_db.inspectionForms,
    ).filter((f) => f.elevatorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inspectionFormsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ElevatorsTableFilterComposer
    extends Composer<_$AppDatabase, $ElevatorsTable> {
  $$ElevatorsTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idNumber => $composableBuilder(
    column: $table.idNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ElevatorType, ElevatorType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get usageTypeDetail => $composableBuilder(
    column: $table.usageTypeDetail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get driveType => $composableBuilder(
    column: $table.driveType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capacityPerson => $composableBuilder(
    column: $table.capacityPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capacityWeight => $composableBuilder(
    column: $table.capacityWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stops => $composableBuilder(
    column: $table.stops,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ElevatorTagColor, ElevatorTagColor, int>
  get tagColor => $composableBuilder(
    column: $table.tagColor,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get tagDate => $composableBuilder(
    column: $table.tagDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get pendingMaintenanceTasks => $composableBuilder(
    column: $table.pendingMaintenanceTasks,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isApproved => $composableBuilder(
    column: $table.isApproved,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> maintenancesRefs(
    Expression<bool> Function($$MaintenancesTableFilterComposer f) f,
  ) {
    final $$MaintenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenances,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenancesTableFilterComposer(
            $db: $db,
            $table: $db.maintenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> faultsRefs(
    Expression<bool> Function($$FaultsTableFilterComposer f) f,
  ) {
    final $$FaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.faults,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaultsTableFilterComposer(
            $db: $db,
            $table: $db.faults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partRequestsRefs(
    Expression<bool> Function($$PartRequestsTableFilterComposer f) f,
  ) {
    final $$PartRequestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partRequests,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartRequestsTableFilterComposer(
            $db: $db,
            $table: $db.partRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inspectionFormsRefs(
    Expression<bool> Function($$InspectionFormsTableFilterComposer f) f,
  ) {
    final $$InspectionFormsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspectionForms,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionFormsTableFilterComposer(
            $db: $db,
            $table: $db.inspectionForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElevatorsTableOrderingComposer
    extends Composer<_$AppDatabase, $ElevatorsTable> {
  $$ElevatorsTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idNumber => $composableBuilder(
    column: $table.idNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageTypeDetail => $composableBuilder(
    column: $table.usageTypeDetail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get driveType => $composableBuilder(
    column: $table.driveType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capacityPerson => $composableBuilder(
    column: $table.capacityPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capacityWeight => $composableBuilder(
    column: $table.capacityWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stops => $composableBuilder(
    column: $table.stops,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tagColor => $composableBuilder(
    column: $table.tagColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tagDate => $composableBuilder(
    column: $table.tagDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pendingMaintenanceTasks => $composableBuilder(
    column: $table.pendingMaintenanceTasks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isApproved => $composableBuilder(
    column: $table.isApproved,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElevatorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElevatorsTable> {
  $$ElevatorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get idNumber =>
      $composableBuilder(column: $table.idNumber, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ElevatorType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get usageTypeDetail => $composableBuilder(
    column: $table.usageTypeDetail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get driveType =>
      $composableBuilder(column: $table.driveType, builder: (column) => column);

  GeneratedColumn<int> get capacityPerson => $composableBuilder(
    column: $table.capacityPerson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get capacityWeight => $composableBuilder(
    column: $table.capacityWeight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stops =>
      $composableBuilder(column: $table.stops, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ElevatorTagColor, int> get tagColor =>
      $composableBuilder(column: $table.tagColor, builder: (column) => column);

  GeneratedColumn<DateTime> get tagDate =>
      $composableBuilder(column: $table.tagDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get pendingMaintenanceTasks => $composableBuilder(
    column: $table.pendingMaintenanceTasks,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isApproved => $composableBuilder(
    column: $table.isApproved,
    builder: (column) => column,
  );

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> maintenancesRefs<T extends Object>(
    Expression<T> Function($$MaintenancesTableAnnotationComposer a) f,
  ) {
    final $$MaintenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenances,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> faultsRefs<T extends Object>(
    Expression<T> Function($$FaultsTableAnnotationComposer a) f,
  ) {
    final $$FaultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.faults,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaultsTableAnnotationComposer(
            $db: $db,
            $table: $db.faults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> partRequestsRefs<T extends Object>(
    Expression<T> Function($$PartRequestsTableAnnotationComposer a) f,
  ) {
    final $$PartRequestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partRequests,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartRequestsTableAnnotationComposer(
            $db: $db,
            $table: $db.partRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inspectionFormsRefs<T extends Object>(
    Expression<T> Function($$InspectionFormsTableAnnotationComposer a) f,
  ) {
    final $$InspectionFormsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspectionForms,
      getReferencedColumn: (t) => t.elevatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionFormsTableAnnotationComposer(
            $db: $db,
            $table: $db.inspectionForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElevatorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ElevatorsTable,
          Elevator,
          $$ElevatorsTableFilterComposer,
          $$ElevatorsTableOrderingComposer,
          $$ElevatorsTableAnnotationComposer,
          $$ElevatorsTableCreateCompanionBuilder,
          $$ElevatorsTableUpdateCompanionBuilder,
          (Elevator, $$ElevatorsTableReferences),
          Elevator,
          PrefetchHooks Function({
            bool customerId,
            bool maintenancesRefs,
            bool faultsRefs,
            bool partRequestsRefs,
            bool inspectionFormsRefs,
          })
        > {
  $$ElevatorsTableTableManager(_$AppDatabase db, $ElevatorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElevatorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElevatorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElevatorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> idNumber = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<ElevatorType> type = const Value.absent(),
                Value<String?> usageTypeDetail = const Value.absent(),
                Value<String?> driveType = const Value.absent(),
                Value<int?> capacityPerson = const Value.absent(),
                Value<int?> capacityWeight = const Value.absent(),
                Value<int?> stops = const Value.absent(),
                Value<double?> speed = const Value.absent(),
                Value<ElevatorTagColor> tagColor = const Value.absent(),
                Value<DateTime?> tagDate = const Value.absent(),
                Value<List<Map<String, dynamic>>> pendingMaintenanceTasks =
                    const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isApproved = const Value.absent(),
              }) => ElevatorsCompanion(
                id: id,
                serverId: serverId,
                code: code,
                idNumber: idNumber,
                name: name,
                type: type,
                usageTypeDetail: usageTypeDetail,
                driveType: driveType,
                capacityPerson: capacityPerson,
                capacityWeight: capacityWeight,
                stops: stops,
                speed: speed,
                tagColor: tagColor,
                tagDate: tagDate,
                pendingMaintenanceTasks: pendingMaintenanceTasks,
                customerId: customerId,
                lastUpdatedLocal: lastUpdatedLocal,
                isSynced: isSynced,
                isApproved: isApproved,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required String code,
                Value<String?> idNumber = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required ElevatorType type,
                Value<String?> usageTypeDetail = const Value.absent(),
                Value<String?> driveType = const Value.absent(),
                Value<int?> capacityPerson = const Value.absent(),
                Value<int?> capacityWeight = const Value.absent(),
                Value<int?> stops = const Value.absent(),
                Value<double?> speed = const Value.absent(),
                Value<ElevatorTagColor> tagColor = const Value.absent(),
                Value<DateTime?> tagDate = const Value.absent(),
                Value<List<Map<String, dynamic>>> pendingMaintenanceTasks =
                    const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isApproved = const Value.absent(),
              }) => ElevatorsCompanion.insert(
                id: id,
                serverId: serverId,
                code: code,
                idNumber: idNumber,
                name: name,
                type: type,
                usageTypeDetail: usageTypeDetail,
                driveType: driveType,
                capacityPerson: capacityPerson,
                capacityWeight: capacityWeight,
                stops: stops,
                speed: speed,
                tagColor: tagColor,
                tagDate: tagDate,
                pendingMaintenanceTasks: pendingMaintenanceTasks,
                customerId: customerId,
                lastUpdatedLocal: lastUpdatedLocal,
                isSynced: isSynced,
                isApproved: isApproved,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ElevatorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                maintenancesRefs = false,
                faultsRefs = false,
                partRequestsRefs = false,
                inspectionFormsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (maintenancesRefs) db.maintenances,
                    if (faultsRefs) db.faults,
                    if (partRequestsRefs) db.partRequests,
                    if (inspectionFormsRefs) db.inspectionForms,
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
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$ElevatorsTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn: $$ElevatorsTableReferences
                                        ._customerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (maintenancesRefs)
                        await $_getPrefetchedData<
                          Elevator,
                          $ElevatorsTable,
                          Maintenance
                        >(
                          currentTable: table,
                          referencedTable: $$ElevatorsTableReferences
                              ._maintenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevatorsTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.elevatorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (faultsRefs)
                        await $_getPrefetchedData<
                          Elevator,
                          $ElevatorsTable,
                          Fault
                        >(
                          currentTable: table,
                          referencedTable: $$ElevatorsTableReferences
                              ._faultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevatorsTableReferences(
                                db,
                                table,
                                p0,
                              ).faultsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.elevatorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (partRequestsRefs)
                        await $_getPrefetchedData<
                          Elevator,
                          $ElevatorsTable,
                          PartRequest
                        >(
                          currentTable: table,
                          referencedTable: $$ElevatorsTableReferences
                              ._partRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevatorsTableReferences(
                                db,
                                table,
                                p0,
                              ).partRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.elevatorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inspectionFormsRefs)
                        await $_getPrefetchedData<
                          Elevator,
                          $ElevatorsTable,
                          InspectionForm
                        >(
                          currentTable: table,
                          referencedTable: $$ElevatorsTableReferences
                              ._inspectionFormsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ElevatorsTableReferences(
                                db,
                                table,
                                p0,
                              ).inspectionFormsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.elevatorId == item.id,
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

typedef $$ElevatorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ElevatorsTable,
      Elevator,
      $$ElevatorsTableFilterComposer,
      $$ElevatorsTableOrderingComposer,
      $$ElevatorsTableAnnotationComposer,
      $$ElevatorsTableCreateCompanionBuilder,
      $$ElevatorsTableUpdateCompanionBuilder,
      (Elevator, $$ElevatorsTableReferences),
      Elevator,
      PrefetchHooks Function({
        bool customerId,
        bool maintenancesRefs,
        bool faultsRefs,
        bool partRequestsRefs,
        bool inspectionFormsRefs,
      })
    >;
typedef $$MaintenancesTableCreateCompanionBuilder =
    MaintenancesCompanion Function({
      Value<int> id,
      required String serverId,
      Value<int?> elevatorId,
      Value<int?> customerId,
      required DateTime maintenanceDate,
      required int year,
      required int month,
      Value<String?> technicianName,
      Value<String?> notes,
      Value<List<Map<String, dynamic>>> checklist,
      Value<List<Map<String, dynamic>>> carryOverNotes,
      Value<List<Map<String, dynamic>>> usedMaterials,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });
typedef $$MaintenancesTableUpdateCompanionBuilder =
    MaintenancesCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<int?> elevatorId,
      Value<int?> customerId,
      Value<DateTime> maintenanceDate,
      Value<int> year,
      Value<int> month,
      Value<String?> technicianName,
      Value<String?> notes,
      Value<List<Map<String, dynamic>>> checklist,
      Value<List<Map<String, dynamic>>> carryOverNotes,
      Value<List<Map<String, dynamic>>> usedMaterials,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });

final class $$MaintenancesTableReferences
    extends BaseReferences<_$AppDatabase, $MaintenancesTable, Maintenance> {
  $$MaintenancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElevatorsTable _elevatorIdTable(_$AppDatabase db) =>
      db.elevators.createAlias(
        $_aliasNameGenerator(db.maintenances.elevatorId, db.elevators.id),
      );

  $$ElevatorsTableProcessedTableManager? get elevatorId {
    final $_column = $_itemColumn<int>('elevator_id');
    if ($_column == null) return null;
    final manager = $$ElevatorsTableTableManager(
      $_db,
      $_db.elevators,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_elevatorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.maintenances.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenancesTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenancesTable> {
  $$MaintenancesTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get maintenanceDate => $composableBuilder(
    column: $table.maintenanceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicianName => $composableBuilder(
    column: $table.technicianName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get checklist => $composableBuilder(
    column: $table.checklist,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get carryOverNotes => $composableBuilder(
    column: $table.carryOverNotes,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get usedMaterials => $composableBuilder(
    column: $table.usedMaterials,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevatorsTableFilterComposer get elevatorId {
    final $$ElevatorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableFilterComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenancesTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenancesTable> {
  $$MaintenancesTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get maintenanceDate => $composableBuilder(
    column: $table.maintenanceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianName => $composableBuilder(
    column: $table.technicianName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checklist => $composableBuilder(
    column: $table.checklist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carryOverNotes => $composableBuilder(
    column: $table.carryOverNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usedMaterials => $composableBuilder(
    column: $table.usedMaterials,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevatorsTableOrderingComposer get elevatorId {
    final $$ElevatorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableOrderingComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenancesTable> {
  $$MaintenancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<DateTime> get maintenanceDate => $composableBuilder(
    column: $table.maintenanceDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<String> get technicianName => $composableBuilder(
    column: $table.technicianName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get checklist =>
      $composableBuilder(column: $table.checklist, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get carryOverNotes => $composableBuilder(
    column: $table.carryOverNotes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get usedMaterials => $composableBuilder(
    column: $table.usedMaterials,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => column,
  );

  $$ElevatorsTableAnnotationComposer get elevatorId {
    final $$ElevatorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableAnnotationComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenancesTable,
          Maintenance,
          $$MaintenancesTableFilterComposer,
          $$MaintenancesTableOrderingComposer,
          $$MaintenancesTableAnnotationComposer,
          $$MaintenancesTableCreateCompanionBuilder,
          $$MaintenancesTableUpdateCompanionBuilder,
          (Maintenance, $$MaintenancesTableReferences),
          Maintenance,
          PrefetchHooks Function({bool elevatorId, bool customerId})
        > {
  $$MaintenancesTableTableManager(_$AppDatabase db, $MaintenancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<int?> elevatorId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<DateTime> maintenanceDate = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<String?> technicianName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<List<Map<String, dynamic>>> checklist =
                    const Value.absent(),
                Value<List<Map<String, dynamic>>> carryOverNotes =
                    const Value.absent(),
                Value<List<Map<String, dynamic>>> usedMaterials =
                    const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => MaintenancesCompanion(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                maintenanceDate: maintenanceDate,
                year: year,
                month: month,
                technicianName: technicianName,
                notes: notes,
                checklist: checklist,
                carryOverNotes: carryOverNotes,
                usedMaterials: usedMaterials,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                Value<int?> elevatorId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                required DateTime maintenanceDate,
                required int year,
                required int month,
                Value<String?> technicianName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<List<Map<String, dynamic>>> checklist =
                    const Value.absent(),
                Value<List<Map<String, dynamic>>> carryOverNotes =
                    const Value.absent(),
                Value<List<Map<String, dynamic>>> usedMaterials =
                    const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => MaintenancesCompanion.insert(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                maintenanceDate: maintenanceDate,
                year: year,
                month: month,
                technicianName: technicianName,
                notes: notes,
                checklist: checklist,
                carryOverNotes: carryOverNotes,
                usedMaterials: usedMaterials,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({elevatorId = false, customerId = false}) {
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
                    if (elevatorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.elevatorId,
                                referencedTable: $$MaintenancesTableReferences
                                    ._elevatorIdTable(db),
                                referencedColumn: $$MaintenancesTableReferences
                                    ._elevatorIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$MaintenancesTableReferences
                                    ._customerIdTable(db),
                                referencedColumn: $$MaintenancesTableReferences
                                    ._customerIdTable(db)
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

typedef $$MaintenancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenancesTable,
      Maintenance,
      $$MaintenancesTableFilterComposer,
      $$MaintenancesTableOrderingComposer,
      $$MaintenancesTableAnnotationComposer,
      $$MaintenancesTableCreateCompanionBuilder,
      $$MaintenancesTableUpdateCompanionBuilder,
      (Maintenance, $$MaintenancesTableReferences),
      Maintenance,
      PrefetchHooks Function({bool elevatorId, bool customerId})
    >;
typedef $$FaultsTableCreateCompanionBuilder =
    FaultsCompanion Function({
      Value<int> id,
      required String serverId,
      Value<int?> elevatorId,
      Value<int?> customerId,
      required DateTime reportedDate,
      Value<DateTime?> resolvedDate,
      required String description,
      Value<String?> technicianNote,
      required FaultStatus status,
      Value<List<Map<String, dynamic>>> usedMaterials,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });
typedef $$FaultsTableUpdateCompanionBuilder =
    FaultsCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<int?> elevatorId,
      Value<int?> customerId,
      Value<DateTime> reportedDate,
      Value<DateTime?> resolvedDate,
      Value<String> description,
      Value<String?> technicianNote,
      Value<FaultStatus> status,
      Value<List<Map<String, dynamic>>> usedMaterials,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });

final class $$FaultsTableReferences
    extends BaseReferences<_$AppDatabase, $FaultsTable, Fault> {
  $$FaultsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElevatorsTable _elevatorIdTable(_$AppDatabase db) => db.elevators
      .createAlias($_aliasNameGenerator(db.faults.elevatorId, db.elevators.id));

  $$ElevatorsTableProcessedTableManager? get elevatorId {
    final $_column = $_itemColumn<int>('elevator_id');
    if ($_column == null) return null;
    final manager = $$ElevatorsTableTableManager(
      $_db,
      $_db.elevators,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_elevatorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) => db.customers
      .createAlias($_aliasNameGenerator(db.faults.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FaultsTableFilterComposer
    extends Composer<_$AppDatabase, $FaultsTable> {
  $$FaultsTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportedDate => $composableBuilder(
    column: $table.reportedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedDate => $composableBuilder(
    column: $table.resolvedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicianNote => $composableBuilder(
    column: $table.technicianNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FaultStatus, FaultStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get usedMaterials => $composableBuilder(
    column: $table.usedMaterials,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevatorsTableFilterComposer get elevatorId {
    final $$ElevatorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableFilterComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FaultsTableOrderingComposer
    extends Composer<_$AppDatabase, $FaultsTable> {
  $$FaultsTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportedDate => $composableBuilder(
    column: $table.reportedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedDate => $composableBuilder(
    column: $table.resolvedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianNote => $composableBuilder(
    column: $table.technicianNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usedMaterials => $composableBuilder(
    column: $table.usedMaterials,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevatorsTableOrderingComposer get elevatorId {
    final $$ElevatorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableOrderingComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FaultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FaultsTable> {
  $$FaultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<DateTime> get reportedDate => $composableBuilder(
    column: $table.reportedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get resolvedDate => $composableBuilder(
    column: $table.resolvedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get technicianNote => $composableBuilder(
    column: $table.technicianNote,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FaultStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get usedMaterials => $composableBuilder(
    column: $table.usedMaterials,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => column,
  );

  $$ElevatorsTableAnnotationComposer get elevatorId {
    final $$ElevatorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableAnnotationComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FaultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FaultsTable,
          Fault,
          $$FaultsTableFilterComposer,
          $$FaultsTableOrderingComposer,
          $$FaultsTableAnnotationComposer,
          $$FaultsTableCreateCompanionBuilder,
          $$FaultsTableUpdateCompanionBuilder,
          (Fault, $$FaultsTableReferences),
          Fault,
          PrefetchHooks Function({bool elevatorId, bool customerId})
        > {
  $$FaultsTableTableManager(_$AppDatabase db, $FaultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FaultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FaultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FaultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<int?> elevatorId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<DateTime> reportedDate = const Value.absent(),
                Value<DateTime?> resolvedDate = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> technicianNote = const Value.absent(),
                Value<FaultStatus> status = const Value.absent(),
                Value<List<Map<String, dynamic>>> usedMaterials =
                    const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => FaultsCompanion(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                reportedDate: reportedDate,
                resolvedDate: resolvedDate,
                description: description,
                technicianNote: technicianNote,
                status: status,
                usedMaterials: usedMaterials,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                Value<int?> elevatorId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                required DateTime reportedDate,
                Value<DateTime?> resolvedDate = const Value.absent(),
                required String description,
                Value<String?> technicianNote = const Value.absent(),
                required FaultStatus status,
                Value<List<Map<String, dynamic>>> usedMaterials =
                    const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => FaultsCompanion.insert(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                reportedDate: reportedDate,
                resolvedDate: resolvedDate,
                description: description,
                technicianNote: technicianNote,
                status: status,
                usedMaterials: usedMaterials,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FaultsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({elevatorId = false, customerId = false}) {
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
                    if (elevatorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.elevatorId,
                                referencedTable: $$FaultsTableReferences
                                    ._elevatorIdTable(db),
                                referencedColumn: $$FaultsTableReferences
                                    ._elevatorIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$FaultsTableReferences
                                    ._customerIdTable(db),
                                referencedColumn: $$FaultsTableReferences
                                    ._customerIdTable(db)
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

typedef $$FaultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FaultsTable,
      Fault,
      $$FaultsTableFilterComposer,
      $$FaultsTableOrderingComposer,
      $$FaultsTableAnnotationComposer,
      $$FaultsTableCreateCompanionBuilder,
      $$FaultsTableUpdateCompanionBuilder,
      (Fault, $$FaultsTableReferences),
      Fault,
      PrefetchHooks Function({bool elevatorId, bool customerId})
    >;
typedef $$DailyRoutesTableCreateCompanionBuilder =
    DailyRoutesCompanion Function({
      Value<int> id,
      required String serverId,
      Value<String?> plannerName,
      required DateTime plannedDate,
      Value<List<int>> maintenanceGroupIds,
      required DailyRouteStatus status,
      Value<List<int>> completedCustomerIds,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });
typedef $$DailyRoutesTableUpdateCompanionBuilder =
    DailyRoutesCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<String?> plannerName,
      Value<DateTime> plannedDate,
      Value<List<int>> maintenanceGroupIds,
      Value<DailyRouteStatus> status,
      Value<List<int>> completedCustomerIds,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });

class $$DailyRoutesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyRoutesTable> {
  $$DailyRoutesTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plannerName => $composableBuilder(
    column: $table.plannerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedDate => $composableBuilder(
    column: $table.plannedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get maintenanceGroupIds => $composableBuilder(
    column: $table.maintenanceGroupIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DailyRouteStatus, DailyRouteStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get completedCustomerIds => $composableBuilder(
    column: $table.completedCustomerIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyRoutesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyRoutesTable> {
  $$DailyRoutesTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plannerName => $composableBuilder(
    column: $table.plannerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedDate => $composableBuilder(
    column: $table.plannedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maintenanceGroupIds => $composableBuilder(
    column: $table.maintenanceGroupIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedCustomerIds => $composableBuilder(
    column: $table.completedCustomerIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyRoutesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyRoutesTable> {
  $$DailyRoutesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get plannerName => $composableBuilder(
    column: $table.plannerName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get plannedDate => $composableBuilder(
    column: $table.plannedDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<int>, String> get maintenanceGroupIds =>
      $composableBuilder(
        column: $table.maintenanceGroupIds,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<DailyRouteStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>, String>
  get completedCustomerIds => $composableBuilder(
    column: $table.completedCustomerIds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => column,
  );
}

class $$DailyRoutesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyRoutesTable,
          DailyRoute,
          $$DailyRoutesTableFilterComposer,
          $$DailyRoutesTableOrderingComposer,
          $$DailyRoutesTableAnnotationComposer,
          $$DailyRoutesTableCreateCompanionBuilder,
          $$DailyRoutesTableUpdateCompanionBuilder,
          (
            DailyRoute,
            BaseReferences<_$AppDatabase, $DailyRoutesTable, DailyRoute>,
          ),
          DailyRoute,
          PrefetchHooks Function()
        > {
  $$DailyRoutesTableTableManager(_$AppDatabase db, $DailyRoutesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyRoutesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyRoutesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyRoutesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<String?> plannerName = const Value.absent(),
                Value<DateTime> plannedDate = const Value.absent(),
                Value<List<int>> maintenanceGroupIds = const Value.absent(),
                Value<DailyRouteStatus> status = const Value.absent(),
                Value<List<int>> completedCustomerIds = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => DailyRoutesCompanion(
                id: id,
                serverId: serverId,
                plannerName: plannerName,
                plannedDate: plannedDate,
                maintenanceGroupIds: maintenanceGroupIds,
                status: status,
                completedCustomerIds: completedCustomerIds,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                Value<String?> plannerName = const Value.absent(),
                required DateTime plannedDate,
                Value<List<int>> maintenanceGroupIds = const Value.absent(),
                required DailyRouteStatus status,
                Value<List<int>> completedCustomerIds = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => DailyRoutesCompanion.insert(
                id: id,
                serverId: serverId,
                plannerName: plannerName,
                plannedDate: plannedDate,
                maintenanceGroupIds: maintenanceGroupIds,
                status: status,
                completedCustomerIds: completedCustomerIds,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyRoutesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyRoutesTable,
      DailyRoute,
      $$DailyRoutesTableFilterComposer,
      $$DailyRoutesTableOrderingComposer,
      $$DailyRoutesTableAnnotationComposer,
      $$DailyRoutesTableCreateCompanionBuilder,
      $$DailyRoutesTableUpdateCompanionBuilder,
      (
        DailyRoute,
        BaseReferences<_$AppDatabase, $DailyRoutesTable, DailyRoute>,
      ),
      DailyRoute,
      PrefetchHooks Function()
    >;
typedef $$ServiceFormsTableCreateCompanionBuilder =
    ServiceFormsCompanion Function({
      Value<int> id,
      required String workOrderId,
      required DateTime formStartedAt,
      Value<DateTime?> formCompletedAt,
      Value<List<Map<String, dynamic>>> maintenanceChecklist,
      Value<String?> technicianNotes,
      Value<String?> customerSignature,
    });
typedef $$ServiceFormsTableUpdateCompanionBuilder =
    ServiceFormsCompanion Function({
      Value<int> id,
      Value<String> workOrderId,
      Value<DateTime> formStartedAt,
      Value<DateTime?> formCompletedAt,
      Value<List<Map<String, dynamic>>> maintenanceChecklist,
      Value<String?> technicianNotes,
      Value<String?> customerSignature,
    });

class $$ServiceFormsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceFormsTable> {
  $$ServiceFormsTableFilterComposer({
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

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get formStartedAt => $composableBuilder(
    column: $table.formStartedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get formCompletedAt => $composableBuilder(
    column: $table.formCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<Map<String, dynamic>>,
    List<Map<String, dynamic>>,
    String
  >
  get maintenanceChecklist => $composableBuilder(
    column: $table.maintenanceChecklist,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get technicianNotes => $composableBuilder(
    column: $table.technicianNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerSignature => $composableBuilder(
    column: $table.customerSignature,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServiceFormsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceFormsTable> {
  $$ServiceFormsTableOrderingComposer({
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

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get formStartedAt => $composableBuilder(
    column: $table.formStartedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get formCompletedAt => $composableBuilder(
    column: $table.formCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maintenanceChecklist => $composableBuilder(
    column: $table.maintenanceChecklist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianNotes => $composableBuilder(
    column: $table.technicianNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerSignature => $composableBuilder(
    column: $table.customerSignature,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiceFormsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceFormsTable> {
  $$ServiceFormsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get formStartedAt => $composableBuilder(
    column: $table.formStartedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get formCompletedAt => $composableBuilder(
    column: $table.formCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
  get maintenanceChecklist => $composableBuilder(
    column: $table.maintenanceChecklist,
    builder: (column) => column,
  );

  GeneratedColumn<String> get technicianNotes => $composableBuilder(
    column: $table.technicianNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerSignature => $composableBuilder(
    column: $table.customerSignature,
    builder: (column) => column,
  );
}

class $$ServiceFormsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceFormsTable,
          ServiceForm,
          $$ServiceFormsTableFilterComposer,
          $$ServiceFormsTableOrderingComposer,
          $$ServiceFormsTableAnnotationComposer,
          $$ServiceFormsTableCreateCompanionBuilder,
          $$ServiceFormsTableUpdateCompanionBuilder,
          (
            ServiceForm,
            BaseReferences<_$AppDatabase, $ServiceFormsTable, ServiceForm>,
          ),
          ServiceForm,
          PrefetchHooks Function()
        > {
  $$ServiceFormsTableTableManager(_$AppDatabase db, $ServiceFormsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceFormsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceFormsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceFormsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<DateTime> formStartedAt = const Value.absent(),
                Value<DateTime?> formCompletedAt = const Value.absent(),
                Value<List<Map<String, dynamic>>> maintenanceChecklist =
                    const Value.absent(),
                Value<String?> technicianNotes = const Value.absent(),
                Value<String?> customerSignature = const Value.absent(),
              }) => ServiceFormsCompanion(
                id: id,
                workOrderId: workOrderId,
                formStartedAt: formStartedAt,
                formCompletedAt: formCompletedAt,
                maintenanceChecklist: maintenanceChecklist,
                technicianNotes: technicianNotes,
                customerSignature: customerSignature,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String workOrderId,
                required DateTime formStartedAt,
                Value<DateTime?> formCompletedAt = const Value.absent(),
                Value<List<Map<String, dynamic>>> maintenanceChecklist =
                    const Value.absent(),
                Value<String?> technicianNotes = const Value.absent(),
                Value<String?> customerSignature = const Value.absent(),
              }) => ServiceFormsCompanion.insert(
                id: id,
                workOrderId: workOrderId,
                formStartedAt: formStartedAt,
                formCompletedAt: formCompletedAt,
                maintenanceChecklist: maintenanceChecklist,
                technicianNotes: technicianNotes,
                customerSignature: customerSignature,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServiceFormsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceFormsTable,
      ServiceForm,
      $$ServiceFormsTableFilterComposer,
      $$ServiceFormsTableOrderingComposer,
      $$ServiceFormsTableAnnotationComposer,
      $$ServiceFormsTableCreateCompanionBuilder,
      $$ServiceFormsTableUpdateCompanionBuilder,
      (
        ServiceForm,
        BaseReferences<_$AppDatabase, $ServiceFormsTable, ServiceForm>,
      ),
      ServiceForm,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<int> id,
      required String serverId,
      required String partCode,
      required String name,
      required String category,
      Value<int> quantityInVan,
      Value<int> minQuantityThreshold,
      Value<double> unitPrice,
      Value<String> unit,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<String> partCode,
      Value<String> name,
      Value<String> category,
      Value<int> quantityInVan,
      Value<int> minQuantityThreshold,
      Value<double> unitPrice,
      Value<String> unit,
    });

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partCode => $composableBuilder(
    column: $table.partCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityInVan => $composableBuilder(
    column: $table.quantityInVan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minQuantityThreshold => $composableBuilder(
    column: $table.minQuantityThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partCode => $composableBuilder(
    column: $table.partCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityInVan => $composableBuilder(
    column: $table.quantityInVan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minQuantityThreshold => $composableBuilder(
    column: $table.minQuantityThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get partCode =>
      $composableBuilder(column: $table.partCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get quantityInVan => $composableBuilder(
    column: $table.quantityInVan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minQuantityThreshold => $composableBuilder(
    column: $table.minQuantityThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (
            InventoryItem,
            BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
          ),
          InventoryItem,
          PrefetchHooks Function()
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<String> partCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> quantityInVan = const Value.absent(),
                Value<int> minQuantityThreshold = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<String> unit = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                serverId: serverId,
                partCode: partCode,
                name: name,
                category: category,
                quantityInVan: quantityInVan,
                minQuantityThreshold: minQuantityThreshold,
                unitPrice: unitPrice,
                unit: unit,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required String partCode,
                required String name,
                required String category,
                Value<int> quantityInVan = const Value.absent(),
                Value<int> minQuantityThreshold = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<String> unit = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                serverId: serverId,
                partCode: partCode,
                name: name,
                category: category,
                quantityInVan: quantityInVan,
                minQuantityThreshold: minQuantityThreshold,
                unitPrice: unitPrice,
                unit: unit,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (
        InventoryItem,
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
      ),
      InventoryItem,
      PrefetchHooks Function()
    >;
typedef $$PartRequestsTableCreateCompanionBuilder =
    PartRequestsCompanion Function({
      Value<int> id,
      required String serverId,
      Value<int?> elevatorId,
      Value<int?> customerId,
      required String partName,
      Value<int> quantity,
      Value<String> urgency,
      Value<String> status,
      required DateTime requestedAt,
      Value<String?> notes,
      Value<bool> isSynced,
    });
typedef $$PartRequestsTableUpdateCompanionBuilder =
    PartRequestsCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<int?> elevatorId,
      Value<int?> customerId,
      Value<String> partName,
      Value<int> quantity,
      Value<String> urgency,
      Value<String> status,
      Value<DateTime> requestedAt,
      Value<String?> notes,
      Value<bool> isSynced,
    });

final class $$PartRequestsTableReferences
    extends BaseReferences<_$AppDatabase, $PartRequestsTable, PartRequest> {
  $$PartRequestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElevatorsTable _elevatorIdTable(_$AppDatabase db) =>
      db.elevators.createAlias(
        $_aliasNameGenerator(db.partRequests.elevatorId, db.elevators.id),
      );

  $$ElevatorsTableProcessedTableManager? get elevatorId {
    final $_column = $_itemColumn<int>('elevator_id');
    if ($_column == null) return null;
    final manager = $$ElevatorsTableTableManager(
      $_db,
      $_db.elevators,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_elevatorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.partRequests.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PartRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $PartRequestsTable> {
  $$PartRequestsTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partName => $composableBuilder(
    column: $table.partName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevatorsTableFilterComposer get elevatorId {
    final $$ElevatorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableFilterComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $PartRequestsTable> {
  $$PartRequestsTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partName => $composableBuilder(
    column: $table.partName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevatorsTableOrderingComposer get elevatorId {
    final $$ElevatorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableOrderingComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartRequestsTable> {
  $$PartRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get partName =>
      $composableBuilder(column: $table.partName, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$ElevatorsTableAnnotationComposer get elevatorId {
    final $$ElevatorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableAnnotationComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartRequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartRequestsTable,
          PartRequest,
          $$PartRequestsTableFilterComposer,
          $$PartRequestsTableOrderingComposer,
          $$PartRequestsTableAnnotationComposer,
          $$PartRequestsTableCreateCompanionBuilder,
          $$PartRequestsTableUpdateCompanionBuilder,
          (PartRequest, $$PartRequestsTableReferences),
          PartRequest,
          PrefetchHooks Function({bool elevatorId, bool customerId})
        > {
  $$PartRequestsTableTableManager(_$AppDatabase db, $PartRequestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<int?> elevatorId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String> partName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> urgency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> requestedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => PartRequestsCompanion(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                partName: partName,
                quantity: quantity,
                urgency: urgency,
                status: status,
                requestedAt: requestedAt,
                notes: notes,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                Value<int?> elevatorId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                required String partName,
                Value<int> quantity = const Value.absent(),
                Value<String> urgency = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime requestedAt,
                Value<String?> notes = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => PartRequestsCompanion.insert(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                partName: partName,
                quantity: quantity,
                urgency: urgency,
                status: status,
                requestedAt: requestedAt,
                notes: notes,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PartRequestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({elevatorId = false, customerId = false}) {
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
                    if (elevatorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.elevatorId,
                                referencedTable: $$PartRequestsTableReferences
                                    ._elevatorIdTable(db),
                                referencedColumn: $$PartRequestsTableReferences
                                    ._elevatorIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$PartRequestsTableReferences
                                    ._customerIdTable(db),
                                referencedColumn: $$PartRequestsTableReferences
                                    ._customerIdTable(db)
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

typedef $$PartRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartRequestsTable,
      PartRequest,
      $$PartRequestsTableFilterComposer,
      $$PartRequestsTableOrderingComposer,
      $$PartRequestsTableAnnotationComposer,
      $$PartRequestsTableCreateCompanionBuilder,
      $$PartRequestsTableUpdateCompanionBuilder,
      (PartRequest, $$PartRequestsTableReferences),
      PartRequest,
      PrefetchHooks Function({bool elevatorId, bool customerId})
    >;
typedef $$ErrorCodesTableCreateCompanionBuilder =
    ErrorCodesCompanion Function({
      Value<int> id,
      required String brand,
      required String code,
      required String title,
      required String rootCause,
      Value<List<String>> solutionSteps,
    });
typedef $$ErrorCodesTableUpdateCompanionBuilder =
    ErrorCodesCompanion Function({
      Value<int> id,
      Value<String> brand,
      Value<String> code,
      Value<String> title,
      Value<String> rootCause,
      Value<List<String>> solutionSteps,
    });

class $$ErrorCodesTableFilterComposer
    extends Composer<_$AppDatabase, $ErrorCodesTable> {
  $$ErrorCodesTableFilterComposer({
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

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rootCause => $composableBuilder(
    column: $table.rootCause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get solutionSteps => $composableBuilder(
    column: $table.solutionSteps,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$ErrorCodesTableOrderingComposer
    extends Composer<_$AppDatabase, $ErrorCodesTable> {
  $$ErrorCodesTableOrderingComposer({
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

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rootCause => $composableBuilder(
    column: $table.rootCause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solutionSteps => $composableBuilder(
    column: $table.solutionSteps,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ErrorCodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ErrorCodesTable> {
  $$ErrorCodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get rootCause =>
      $composableBuilder(column: $table.rootCause, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get solutionSteps =>
      $composableBuilder(
        column: $table.solutionSteps,
        builder: (column) => column,
      );
}

class $$ErrorCodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ErrorCodesTable,
          ErrorCode,
          $$ErrorCodesTableFilterComposer,
          $$ErrorCodesTableOrderingComposer,
          $$ErrorCodesTableAnnotationComposer,
          $$ErrorCodesTableCreateCompanionBuilder,
          $$ErrorCodesTableUpdateCompanionBuilder,
          (
            ErrorCode,
            BaseReferences<_$AppDatabase, $ErrorCodesTable, ErrorCode>,
          ),
          ErrorCode,
          PrefetchHooks Function()
        > {
  $$ErrorCodesTableTableManager(_$AppDatabase db, $ErrorCodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ErrorCodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ErrorCodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ErrorCodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> rootCause = const Value.absent(),
                Value<List<String>> solutionSteps = const Value.absent(),
              }) => ErrorCodesCompanion(
                id: id,
                brand: brand,
                code: code,
                title: title,
                rootCause: rootCause,
                solutionSteps: solutionSteps,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String brand,
                required String code,
                required String title,
                required String rootCause,
                Value<List<String>> solutionSteps = const Value.absent(),
              }) => ErrorCodesCompanion.insert(
                id: id,
                brand: brand,
                code: code,
                title: title,
                rootCause: rootCause,
                solutionSteps: solutionSteps,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ErrorCodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ErrorCodesTable,
      ErrorCode,
      $$ErrorCodesTableFilterComposer,
      $$ErrorCodesTableOrderingComposer,
      $$ErrorCodesTableAnnotationComposer,
      $$ErrorCodesTableCreateCompanionBuilder,
      $$ErrorCodesTableUpdateCompanionBuilder,
      (ErrorCode, BaseReferences<_$AppDatabase, $ErrorCodesTable, ErrorCode>),
      ErrorCode,
      PrefetchHooks Function()
    >;
typedef $$TroubleshootingGuidesTableCreateCompanionBuilder =
    TroubleshootingGuidesCompanion Function({
      Value<int> id,
      required String brand,
      required String category,
      required String title,
      required String symptom,
      Value<List<String>> diagnosticSteps,
    });
typedef $$TroubleshootingGuidesTableUpdateCompanionBuilder =
    TroubleshootingGuidesCompanion Function({
      Value<int> id,
      Value<String> brand,
      Value<String> category,
      Value<String> title,
      Value<String> symptom,
      Value<List<String>> diagnosticSteps,
    });

class $$TroubleshootingGuidesTableFilterComposer
    extends Composer<_$AppDatabase, $TroubleshootingGuidesTable> {
  $$TroubleshootingGuidesTableFilterComposer({
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

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptom => $composableBuilder(
    column: $table.symptom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get diagnosticSteps => $composableBuilder(
    column: $table.diagnosticSteps,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$TroubleshootingGuidesTableOrderingComposer
    extends Composer<_$AppDatabase, $TroubleshootingGuidesTable> {
  $$TroubleshootingGuidesTableOrderingComposer({
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

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptom => $composableBuilder(
    column: $table.symptom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diagnosticSteps => $composableBuilder(
    column: $table.diagnosticSteps,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TroubleshootingGuidesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TroubleshootingGuidesTable> {
  $$TroubleshootingGuidesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get symptom =>
      $composableBuilder(column: $table.symptom, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get diagnosticSteps =>
      $composableBuilder(
        column: $table.diagnosticSteps,
        builder: (column) => column,
      );
}

class $$TroubleshootingGuidesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TroubleshootingGuidesTable,
          TroubleshootingGuide,
          $$TroubleshootingGuidesTableFilterComposer,
          $$TroubleshootingGuidesTableOrderingComposer,
          $$TroubleshootingGuidesTableAnnotationComposer,
          $$TroubleshootingGuidesTableCreateCompanionBuilder,
          $$TroubleshootingGuidesTableUpdateCompanionBuilder,
          (
            TroubleshootingGuide,
            BaseReferences<
              _$AppDatabase,
              $TroubleshootingGuidesTable,
              TroubleshootingGuide
            >,
          ),
          TroubleshootingGuide,
          PrefetchHooks Function()
        > {
  $$TroubleshootingGuidesTableTableManager(
    _$AppDatabase db,
    $TroubleshootingGuidesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TroubleshootingGuidesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TroubleshootingGuidesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TroubleshootingGuidesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> symptom = const Value.absent(),
                Value<List<String>> diagnosticSteps = const Value.absent(),
              }) => TroubleshootingGuidesCompanion(
                id: id,
                brand: brand,
                category: category,
                title: title,
                symptom: symptom,
                diagnosticSteps: diagnosticSteps,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String brand,
                required String category,
                required String title,
                required String symptom,
                Value<List<String>> diagnosticSteps = const Value.absent(),
              }) => TroubleshootingGuidesCompanion.insert(
                id: id,
                brand: brand,
                category: category,
                title: title,
                symptom: symptom,
                diagnosticSteps: diagnosticSteps,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TroubleshootingGuidesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TroubleshootingGuidesTable,
      TroubleshootingGuide,
      $$TroubleshootingGuidesTableFilterComposer,
      $$TroubleshootingGuidesTableOrderingComposer,
      $$TroubleshootingGuidesTableAnnotationComposer,
      $$TroubleshootingGuidesTableCreateCompanionBuilder,
      $$TroubleshootingGuidesTableUpdateCompanionBuilder,
      (
        TroubleshootingGuide,
        BaseReferences<
          _$AppDatabase,
          $TroubleshootingGuidesTable,
          TroubleshootingGuide
        >,
      ),
      TroubleshootingGuide,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String actionType,
      required String payloadJson,
      required DateTime createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<String> status,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> actionType,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<String> status,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
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

  ColumnFilters<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
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

  ColumnOrderings<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> actionType = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                actionType: actionType,
                payloadJson: payloadJson,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String actionType,
                required String payloadJson,
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                actionType: actionType,
                payloadJson: payloadJson,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$InspectionFormsTableCreateCompanionBuilder =
    InspectionFormsCompanion Function({
      Value<int> id,
      required String serverId,
      required int elevatorId,
      required int customerId,
      required DateTime inspectionDate,
      Value<double?> brakeClearanceMm,
      Value<double?> cableWearPercentage,
      Value<double?> safetyGearTripSpeed,
      Value<double?> machineRoomTemp,
      Value<String> overallPassStatus,
      Value<String?> technicianNotes,
      Value<String?> customerSignature,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });
typedef $$InspectionFormsTableUpdateCompanionBuilder =
    InspectionFormsCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<int> elevatorId,
      Value<int> customerId,
      Value<DateTime> inspectionDate,
      Value<double?> brakeClearanceMm,
      Value<double?> cableWearPercentage,
      Value<double?> safetyGearTripSpeed,
      Value<double?> machineRoomTemp,
      Value<String> overallPassStatus,
      Value<String?> technicianNotes,
      Value<String?> customerSignature,
      Value<bool> isSynced,
      Value<DateTime?> lastUpdatedLocal,
    });

final class $$InspectionFormsTableReferences
    extends
        BaseReferences<_$AppDatabase, $InspectionFormsTable, InspectionForm> {
  $$InspectionFormsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ElevatorsTable _elevatorIdTable(_$AppDatabase db) =>
      db.elevators.createAlias(
        $_aliasNameGenerator(db.inspectionForms.elevatorId, db.elevators.id),
      );

  $$ElevatorsTableProcessedTableManager get elevatorId {
    final $_column = $_itemColumn<int>('elevator_id')!;

    final manager = $$ElevatorsTableTableManager(
      $_db,
      $_db.elevators,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_elevatorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.inspectionForms.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InspectionFormsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionFormsTable> {
  $$InspectionFormsTableFilterComposer({
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

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get inspectionDate => $composableBuilder(
    column: $table.inspectionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brakeClearanceMm => $composableBuilder(
    column: $table.brakeClearanceMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cableWearPercentage => $composableBuilder(
    column: $table.cableWearPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get safetyGearTripSpeed => $composableBuilder(
    column: $table.safetyGearTripSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get machineRoomTemp => $composableBuilder(
    column: $table.machineRoomTemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overallPassStatus => $composableBuilder(
    column: $table.overallPassStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicianNotes => $composableBuilder(
    column: $table.technicianNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerSignature => $composableBuilder(
    column: $table.customerSignature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnFilters(column),
  );

  $$ElevatorsTableFilterComposer get elevatorId {
    final $$ElevatorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableFilterComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionFormsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionFormsTable> {
  $$InspectionFormsTableOrderingComposer({
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

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get inspectionDate => $composableBuilder(
    column: $table.inspectionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brakeClearanceMm => $composableBuilder(
    column: $table.brakeClearanceMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cableWearPercentage => $composableBuilder(
    column: $table.cableWearPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get safetyGearTripSpeed => $composableBuilder(
    column: $table.safetyGearTripSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get machineRoomTemp => $composableBuilder(
    column: $table.machineRoomTemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overallPassStatus => $composableBuilder(
    column: $table.overallPassStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianNotes => $composableBuilder(
    column: $table.technicianNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerSignature => $composableBuilder(
    column: $table.customerSignature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElevatorsTableOrderingComposer get elevatorId {
    final $$ElevatorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableOrderingComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionFormsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionFormsTable> {
  $$InspectionFormsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<DateTime> get inspectionDate => $composableBuilder(
    column: $table.inspectionDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get brakeClearanceMm => $composableBuilder(
    column: $table.brakeClearanceMm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cableWearPercentage => $composableBuilder(
    column: $table.cableWearPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get safetyGearTripSpeed => $composableBuilder(
    column: $table.safetyGearTripSpeed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get machineRoomTemp => $composableBuilder(
    column: $table.machineRoomTemp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overallPassStatus => $composableBuilder(
    column: $table.overallPassStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get technicianNotes => $composableBuilder(
    column: $table.technicianNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerSignature => $composableBuilder(
    column: $table.customerSignature,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedLocal => $composableBuilder(
    column: $table.lastUpdatedLocal,
    builder: (column) => column,
  );

  $$ElevatorsTableAnnotationComposer get elevatorId {
    final $$ElevatorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elevatorId,
      referencedTable: $db.elevators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElevatorsTableAnnotationComposer(
            $db: $db,
            $table: $db.elevators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionFormsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionFormsTable,
          InspectionForm,
          $$InspectionFormsTableFilterComposer,
          $$InspectionFormsTableOrderingComposer,
          $$InspectionFormsTableAnnotationComposer,
          $$InspectionFormsTableCreateCompanionBuilder,
          $$InspectionFormsTableUpdateCompanionBuilder,
          (InspectionForm, $$InspectionFormsTableReferences),
          InspectionForm,
          PrefetchHooks Function({bool elevatorId, bool customerId})
        > {
  $$InspectionFormsTableTableManager(
    _$AppDatabase db,
    $InspectionFormsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionFormsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionFormsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionFormsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<int> elevatorId = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<DateTime> inspectionDate = const Value.absent(),
                Value<double?> brakeClearanceMm = const Value.absent(),
                Value<double?> cableWearPercentage = const Value.absent(),
                Value<double?> safetyGearTripSpeed = const Value.absent(),
                Value<double?> machineRoomTemp = const Value.absent(),
                Value<String> overallPassStatus = const Value.absent(),
                Value<String?> technicianNotes = const Value.absent(),
                Value<String?> customerSignature = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => InspectionFormsCompanion(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                inspectionDate: inspectionDate,
                brakeClearanceMm: brakeClearanceMm,
                cableWearPercentage: cableWearPercentage,
                safetyGearTripSpeed: safetyGearTripSpeed,
                machineRoomTemp: machineRoomTemp,
                overallPassStatus: overallPassStatus,
                technicianNotes: technicianNotes,
                customerSignature: customerSignature,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required int elevatorId,
                required int customerId,
                required DateTime inspectionDate,
                Value<double?> brakeClearanceMm = const Value.absent(),
                Value<double?> cableWearPercentage = const Value.absent(),
                Value<double?> safetyGearTripSpeed = const Value.absent(),
                Value<double?> machineRoomTemp = const Value.absent(),
                Value<String> overallPassStatus = const Value.absent(),
                Value<String?> technicianNotes = const Value.absent(),
                Value<String?> customerSignature = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastUpdatedLocal = const Value.absent(),
              }) => InspectionFormsCompanion.insert(
                id: id,
                serverId: serverId,
                elevatorId: elevatorId,
                customerId: customerId,
                inspectionDate: inspectionDate,
                brakeClearanceMm: brakeClearanceMm,
                cableWearPercentage: cableWearPercentage,
                safetyGearTripSpeed: safetyGearTripSpeed,
                machineRoomTemp: machineRoomTemp,
                overallPassStatus: overallPassStatus,
                technicianNotes: technicianNotes,
                customerSignature: customerSignature,
                isSynced: isSynced,
                lastUpdatedLocal: lastUpdatedLocal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InspectionFormsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({elevatorId = false, customerId = false}) {
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
                    if (elevatorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.elevatorId,
                                referencedTable:
                                    $$InspectionFormsTableReferences
                                        ._elevatorIdTable(db),
                                referencedColumn:
                                    $$InspectionFormsTableReferences
                                        ._elevatorIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable:
                                    $$InspectionFormsTableReferences
                                        ._customerIdTable(db),
                                referencedColumn:
                                    $$InspectionFormsTableReferences
                                        ._customerIdTable(db)
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

typedef $$InspectionFormsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionFormsTable,
      InspectionForm,
      $$InspectionFormsTableFilterComposer,
      $$InspectionFormsTableOrderingComposer,
      $$InspectionFormsTableAnnotationComposer,
      $$InspectionFormsTableCreateCompanionBuilder,
      $$InspectionFormsTableUpdateCompanionBuilder,
      (InspectionForm, $$InspectionFormsTableReferences),
      InspectionForm,
      PrefetchHooks Function({bool elevatorId, bool customerId})
    >;
typedef $$FieldMediaTableCreateCompanionBuilder =
    FieldMediaCompanion Function({
      Value<int> id,
      required String entityType,
      required int entityId,
      required String mediaType,
      required String filePath,
      Value<String?> caption,
      required DateTime createdAt,
      Value<bool> isSynced,
    });
typedef $$FieldMediaTableUpdateCompanionBuilder =
    FieldMediaCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<int> entityId,
      Value<String> mediaType,
      Value<String> filePath,
      Value<String?> caption,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
    });

class $$FieldMediaTableFilterComposer
    extends Composer<_$AppDatabase, $FieldMediaTable> {
  $$FieldMediaTableFilterComposer({
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

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FieldMediaTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldMediaTable> {
  $$FieldMediaTableOrderingComposer({
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

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FieldMediaTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldMediaTable> {
  $$FieldMediaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$FieldMediaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldMediaTable,
          FieldMediaData,
          $$FieldMediaTableFilterComposer,
          $$FieldMediaTableOrderingComposer,
          $$FieldMediaTableAnnotationComposer,
          $$FieldMediaTableCreateCompanionBuilder,
          $$FieldMediaTableUpdateCompanionBuilder,
          (
            FieldMediaData,
            BaseReferences<_$AppDatabase, $FieldMediaTable, FieldMediaData>,
          ),
          FieldMediaData,
          PrefetchHooks Function()
        > {
  $$FieldMediaTableTableManager(_$AppDatabase db, $FieldMediaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldMediaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldMediaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldMediaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int> entityId = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => FieldMediaCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                mediaType: mediaType,
                filePath: filePath,
                caption: caption,
                createdAt: createdAt,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required int entityId,
                required String mediaType,
                required String filePath,
                Value<String?> caption = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
              }) => FieldMediaCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                mediaType: mediaType,
                filePath: filePath,
                caption: caption,
                createdAt: createdAt,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FieldMediaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldMediaTable,
      FieldMediaData,
      $$FieldMediaTableFilterComposer,
      $$FieldMediaTableOrderingComposer,
      $$FieldMediaTableAnnotationComposer,
      $$FieldMediaTableCreateCompanionBuilder,
      $$FieldMediaTableUpdateCompanionBuilder,
      (
        FieldMediaData,
        BaseReferences<_$AppDatabase, $FieldMediaTable, FieldMediaData>,
      ),
      FieldMediaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$MaintenanceGroupsTableTableManager get maintenanceGroups =>
      $$MaintenanceGroupsTableTableManager(_db, _db.maintenanceGroups);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$ElevatorsTableTableManager get elevators =>
      $$ElevatorsTableTableManager(_db, _db.elevators);
  $$MaintenancesTableTableManager get maintenances =>
      $$MaintenancesTableTableManager(_db, _db.maintenances);
  $$FaultsTableTableManager get faults =>
      $$FaultsTableTableManager(_db, _db.faults);
  $$DailyRoutesTableTableManager get dailyRoutes =>
      $$DailyRoutesTableTableManager(_db, _db.dailyRoutes);
  $$ServiceFormsTableTableManager get serviceForms =>
      $$ServiceFormsTableTableManager(_db, _db.serviceForms);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$PartRequestsTableTableManager get partRequests =>
      $$PartRequestsTableTableManager(_db, _db.partRequests);
  $$ErrorCodesTableTableManager get errorCodes =>
      $$ErrorCodesTableTableManager(_db, _db.errorCodes);
  $$TroubleshootingGuidesTableTableManager get troubleshootingGuides =>
      $$TroubleshootingGuidesTableTableManager(_db, _db.troubleshootingGuides);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$InspectionFormsTableTableManager get inspectionForms =>
      $$InspectionFormsTableTableManager(_db, _db.inspectionForms);
  $$FieldMediaTableTableManager get fieldMedia =>
      $$FieldMediaTableTableManager(_db, _db.fieldMedia);
}
