// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eleve.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEleveCollection on Isar {
  IsarCollection<Eleve> get eleves => this.collection();
}

const EleveSchema = CollectionSchema(
  name: r'Eleve',
  id: -8290563367235785141,
  properties: {
    r'prenom': PropertySchema(
      id: 0,
      name: r'prenom',
      type: IsarType.string,
    )
  },
  estimateSize: _eleveEstimateSize,
  serialize: _eleveSerialize,
  deserialize: _eleveDeserialize,
  deserializeProp: _eleveDeserializeProp,
  idName: r'idEleve',
  indexes: {},
  links: {
    r'niveau': LinkSchema(
      id: -8157250431111517553,
      name: r'niveau',
      target: r'Niveau',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _eleveGetId,
  getLinks: _eleveGetLinks,
  attach: _eleveAttach,
  version: '3.1.0+1',
);

int _eleveEstimateSize(
  Eleve object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.prenom.length * 3;
  return bytesCount;
}

void _eleveSerialize(
  Eleve object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.prenom);
}

Eleve _eleveDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Eleve();
  object.idEleve = id;
  object.prenom = reader.readString(offsets[0]);
  return object;
}

P _eleveDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eleveGetId(Eleve object) {
  return object.idEleve;
}

List<IsarLinkBase<dynamic>> _eleveGetLinks(Eleve object) {
  return [object.niveau];
}

void _eleveAttach(IsarCollection<dynamic> col, Id id, Eleve object) {
  object.idEleve = id;
  object.niveau.attach(col, col.isar.collection<Niveau>(), r'niveau', id);
}

extension EleveQueryWhereSort on QueryBuilder<Eleve, Eleve, QWhere> {
  QueryBuilder<Eleve, Eleve, QAfterWhere> anyIdEleve() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EleveQueryWhere on QueryBuilder<Eleve, Eleve, QWhereClause> {
  QueryBuilder<Eleve, Eleve, QAfterWhereClause> idEleveEqualTo(Id idEleve) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idEleve,
        upper: idEleve,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterWhereClause> idEleveNotEqualTo(Id idEleve) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idEleve, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idEleve, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idEleve, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idEleve, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterWhereClause> idEleveGreaterThan(Id idEleve,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idEleve, includeLower: include),
      );
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterWhereClause> idEleveLessThan(Id idEleve,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idEleve, includeUpper: include),
      );
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterWhereClause> idEleveBetween(
    Id lowerIdEleve,
    Id upperIdEleve, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdEleve,
        includeLower: includeLower,
        upper: upperIdEleve,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EleveQueryFilter on QueryBuilder<Eleve, Eleve, QFilterCondition> {
  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> idEleveEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idEleve',
        value: value,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> idEleveGreaterThan(
    Id value, {
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

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> idEleveLessThan(
    Id value, {
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

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> idEleveBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prenom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prenom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prenom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prenom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prenom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prenom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prenom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prenom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prenom',
        value: '',
      ));
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> prenomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prenom',
        value: '',
      ));
    });
  }
}

extension EleveQueryObject on QueryBuilder<Eleve, Eleve, QFilterCondition> {}

extension EleveQueryLinks on QueryBuilder<Eleve, Eleve, QFilterCondition> {
  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> niveau(
      FilterQuery<Niveau> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'niveau');
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterFilterCondition> niveauIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'niveau', 0, true, 0, true);
    });
  }
}

extension EleveQuerySortBy on QueryBuilder<Eleve, Eleve, QSortBy> {
  QueryBuilder<Eleve, Eleve, QAfterSortBy> sortByPrenom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prenom', Sort.asc);
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterSortBy> sortByPrenomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prenom', Sort.desc);
    });
  }
}

extension EleveQuerySortThenBy on QueryBuilder<Eleve, Eleve, QSortThenBy> {
  QueryBuilder<Eleve, Eleve, QAfterSortBy> thenByIdEleve() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idEleve', Sort.asc);
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterSortBy> thenByIdEleveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idEleve', Sort.desc);
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterSortBy> thenByPrenom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prenom', Sort.asc);
    });
  }

  QueryBuilder<Eleve, Eleve, QAfterSortBy> thenByPrenomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prenom', Sort.desc);
    });
  }
}

extension EleveQueryWhereDistinct on QueryBuilder<Eleve, Eleve, QDistinct> {
  QueryBuilder<Eleve, Eleve, QDistinct> distinctByPrenom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prenom', caseSensitive: caseSensitive);
    });
  }
}

extension EleveQueryProperty on QueryBuilder<Eleve, Eleve, QQueryProperty> {
  QueryBuilder<Eleve, int, QQueryOperations> idEleveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idEleve');
    });
  }

  QueryBuilder<Eleve, String, QQueryOperations> prenomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prenom');
    });
  }
}
