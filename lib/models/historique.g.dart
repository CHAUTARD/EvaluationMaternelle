// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historique.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHistoriqueCollection on Isar {
  IsarCollection<Historique> get historiques => this.collection();
}

const HistoriqueSchema = CollectionSchema(
  name: r'Historique',
  id: 2041168991628856807,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'idEleve': PropertySchema(
      id: 1,
      name: r'idEleve',
      type: IsarType.long,
    ),
    r'idListe': PropertySchema(
      id: 2,
      name: r'idListe',
      type: IsarType.long,
    ),
    r'motsEchoues': PropertySchema(
      id: 3,
      name: r'motsEchoues',
      type: IsarType.stringList,
    ),
    r'motsReussis': PropertySchema(
      id: 4,
      name: r'motsReussis',
      type: IsarType.stringList,
    )
  },
  estimateSize: _historiqueEstimateSize,
  serialize: _historiqueSerialize,
  deserialize: _historiqueDeserialize,
  deserializeProp: _historiqueDeserializeProp,
  idName: r'idHistorique',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _historiqueGetId,
  getLinks: _historiqueGetLinks,
  attach: _historiqueAttach,
  version: '3.1.0+1',
);

int _historiqueEstimateSize(
  Historique object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.motsEchoues.length * 3;
  {
    for (var i = 0; i < object.motsEchoues.length; i++) {
      final value = object.motsEchoues[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.motsReussis.length * 3;
  {
    for (var i = 0; i < object.motsReussis.length; i++) {
      final value = object.motsReussis[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _historiqueSerialize(
  Historique object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.idEleve);
  writer.writeLong(offsets[2], object.idListe);
  writer.writeStringList(offsets[3], object.motsEchoues);
  writer.writeStringList(offsets[4], object.motsReussis);
}

Historique _historiqueDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Historique();
  object.date = reader.readDateTime(offsets[0]);
  object.idEleve = reader.readLong(offsets[1]);
  object.idHistorique = id;
  object.idListe = reader.readLong(offsets[2]);
  object.motsEchoues = reader.readStringList(offsets[3]) ?? [];
  object.motsReussis = reader.readStringList(offsets[4]) ?? [];
  return object;
}

P _historiqueDeserializeProp<P>(
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
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _historiqueGetId(Historique object) {
  return object.idHistorique;
}

List<IsarLinkBase<dynamic>> _historiqueGetLinks(Historique object) {
  return [];
}

void _historiqueAttach(IsarCollection<dynamic> col, Id id, Historique object) {
  object.idHistorique = id;
}

extension HistoriqueQueryWhereSort
    on QueryBuilder<Historique, Historique, QWhere> {
  QueryBuilder<Historique, Historique, QAfterWhere> anyIdHistorique() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HistoriqueQueryWhere
    on QueryBuilder<Historique, Historique, QWhereClause> {
  QueryBuilder<Historique, Historique, QAfterWhereClause> idHistoriqueEqualTo(
      Id idHistorique) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idHistorique,
        upper: idHistorique,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterWhereClause>
      idHistoriqueNotEqualTo(Id idHistorique) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idHistorique, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: idHistorique, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: idHistorique, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idHistorique, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Historique, Historique, QAfterWhereClause>
      idHistoriqueGreaterThan(Id idHistorique, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idHistorique, includeLower: include),
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterWhereClause> idHistoriqueLessThan(
      Id idHistorique,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idHistorique, includeUpper: include),
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterWhereClause> idHistoriqueBetween(
    Id lowerIdHistorique,
    Id upperIdHistorique, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdHistorique,
        includeLower: includeLower,
        upper: upperIdHistorique,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HistoriqueQueryFilter
    on QueryBuilder<Historique, Historique, QFilterCondition> {
  QueryBuilder<Historique, Historique, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<Historique, Historique, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<Historique, Historique, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<Historique, Historique, QAfterFilterCondition> idEleveEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idEleve',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      idEleveGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idEleve',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition> idEleveLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idEleve',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition> idEleveBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idEleve',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      idHistoriqueEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idHistorique',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      idHistoriqueGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idHistorique',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      idHistoriqueLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idHistorique',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      idHistoriqueBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idHistorique',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition> idListeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idListe',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      idListeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idListe',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition> idListeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idListe',
        value: value,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition> idListeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idListe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motsEchoues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motsEchoues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motsEchoues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motsEchoues',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motsEchoues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motsEchoues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motsEchoues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motsEchoues',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motsEchoues',
        value: '',
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motsEchoues',
        value: '',
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsEchoues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsEchoues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsEchoues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsEchoues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsEchoues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsEchouesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsEchoues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motsReussis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motsReussis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motsReussis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motsReussis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motsReussis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motsReussis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motsReussis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motsReussis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motsReussis',
        value: '',
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motsReussis',
        value: '',
      ));
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsReussis',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsReussis',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsReussis',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsReussis',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsReussis',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Historique, Historique, QAfterFilterCondition>
      motsReussisLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'motsReussis',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension HistoriqueQueryObject
    on QueryBuilder<Historique, Historique, QFilterCondition> {}

extension HistoriqueQueryLinks
    on QueryBuilder<Historique, Historique, QFilterCondition> {}

extension HistoriqueQuerySortBy
    on QueryBuilder<Historique, Historique, QSortBy> {
  QueryBuilder<Historique, Historique, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> sortByIdEleve() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idEleve', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> sortByIdEleveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idEleve', Sort.desc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> sortByIdListe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idListe', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> sortByIdListeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idListe', Sort.desc);
    });
  }
}

extension HistoriqueQuerySortThenBy
    on QueryBuilder<Historique, Historique, QSortThenBy> {
  QueryBuilder<Historique, Historique, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByIdEleve() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idEleve', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByIdEleveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idEleve', Sort.desc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByIdHistorique() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idHistorique', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByIdHistoriqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idHistorique', Sort.desc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByIdListe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idListe', Sort.asc);
    });
  }

  QueryBuilder<Historique, Historique, QAfterSortBy> thenByIdListeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idListe', Sort.desc);
    });
  }
}

extension HistoriqueQueryWhereDistinct
    on QueryBuilder<Historique, Historique, QDistinct> {
  QueryBuilder<Historique, Historique, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Historique, Historique, QDistinct> distinctByIdEleve() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idEleve');
    });
  }

  QueryBuilder<Historique, Historique, QDistinct> distinctByIdListe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idListe');
    });
  }

  QueryBuilder<Historique, Historique, QDistinct> distinctByMotsEchoues() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motsEchoues');
    });
  }

  QueryBuilder<Historique, Historique, QDistinct> distinctByMotsReussis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motsReussis');
    });
  }
}

extension HistoriqueQueryProperty
    on QueryBuilder<Historique, Historique, QQueryProperty> {
  QueryBuilder<Historique, int, QQueryOperations> idHistoriqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idHistorique');
    });
  }

  QueryBuilder<Historique, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Historique, int, QQueryOperations> idEleveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idEleve');
    });
  }

  QueryBuilder<Historique, int, QQueryOperations> idListeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idListe');
    });
  }

  QueryBuilder<Historique, List<String>, QQueryOperations>
      motsEchouesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motsEchoues');
    });
  }

  QueryBuilder<Historique, List<String>, QQueryOperations>
      motsReussisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motsReussis');
    });
  }
}
