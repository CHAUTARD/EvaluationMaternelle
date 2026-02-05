// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActivityHistoryCollection on Isar {
  IsarCollection<ActivityHistory> get activityHistorys => this.collection();
}

const ActivityHistorySchema = CollectionSchema(
  name: r'ActivityHistory',
  id: -4491146783466218440,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'eleveId': PropertySchema(
      id: 1,
      name: r'eleveId',
      type: IsarType.long,
    ),
    r'listeId': PropertySchema(
      id: 2,
      name: r'listeId',
      type: IsarType.long,
    ),
    r'score': PropertySchema(
      id: 3,
      name: r'score',
      type: IsarType.long,
    )
  },
  estimateSize: _activityHistoryEstimateSize,
  serialize: _activityHistorySerialize,
  deserialize: _activityHistoryDeserialize,
  deserializeProp: _activityHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _activityHistoryGetId,
  getLinks: _activityHistoryGetLinks,
  attach: _activityHistoryAttach,
  version: '3.1.0+1',
);

int _activityHistoryEstimateSize(
  ActivityHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _activityHistorySerialize(
  ActivityHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.eleveId);
  writer.writeLong(offsets[2], object.listeId);
  writer.writeLong(offsets[3], object.score);
}

ActivityHistory _activityHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActivityHistory();
  object.date = reader.readDateTime(offsets[0]);
  object.eleveId = reader.readLong(offsets[1]);
  object.id = id;
  object.listeId = reader.readLong(offsets[2]);
  object.score = reader.readLong(offsets[3]);
  return object;
}

P _activityHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activityHistoryGetId(ActivityHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activityHistoryGetLinks(ActivityHistory object) {
  return [];
}

void _activityHistoryAttach(
    IsarCollection<dynamic> col, Id id, ActivityHistory object) {
  object.id = id;
}

extension ActivityHistoryQueryWhereSort
    on QueryBuilder<ActivityHistory, ActivityHistory, QWhere> {
  QueryBuilder<ActivityHistory, ActivityHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActivityHistoryQueryWhere
    on QueryBuilder<ActivityHistory, ActivityHistory, QWhereClause> {
  QueryBuilder<ActivityHistory, ActivityHistory, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityHistoryQueryFilter
    on QueryBuilder<ActivityHistory, ActivityHistory, QFilterCondition> {
  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      eleveIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eleveId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      eleveIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eleveId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      eleveIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eleveId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      eleveIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eleveId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      listeIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listeId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      listeIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listeId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      listeIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listeId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      listeIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      scoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterFilterCondition>
      scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityHistoryQueryObject
    on QueryBuilder<ActivityHistory, ActivityHistory, QFilterCondition> {}

extension ActivityHistoryQueryLinks
    on QueryBuilder<ActivityHistory, ActivityHistory, QFilterCondition> {}

extension ActivityHistoryQuerySortBy
    on QueryBuilder<ActivityHistory, ActivityHistory, QSortBy> {
  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> sortByEleveId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eleveId', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      sortByEleveIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eleveId', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> sortByListeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeId', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      sortByListeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeId', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension ActivityHistoryQuerySortThenBy
    on QueryBuilder<ActivityHistory, ActivityHistory, QSortThenBy> {
  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> thenByEleveId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eleveId', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      thenByEleveIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eleveId', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> thenByListeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeId', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      thenByListeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeId', Sort.desc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QAfterSortBy>
      thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension ActivityHistoryQueryWhereDistinct
    on QueryBuilder<ActivityHistory, ActivityHistory, QDistinct> {
  QueryBuilder<ActivityHistory, ActivityHistory, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QDistinct>
      distinctByEleveId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eleveId');
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QDistinct>
      distinctByListeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listeId');
    });
  }

  QueryBuilder<ActivityHistory, ActivityHistory, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }
}

extension ActivityHistoryQueryProperty
    on QueryBuilder<ActivityHistory, ActivityHistory, QQueryProperty> {
  QueryBuilder<ActivityHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActivityHistory, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ActivityHistory, int, QQueryOperations> eleveIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eleveId');
    });
  }

  QueryBuilder<ActivityHistory, int, QQueryOperations> listeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listeId');
    });
  }

  QueryBuilder<ActivityHistory, int, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }
}
