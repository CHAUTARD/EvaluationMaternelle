// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNiveauCollection on Isar {
  IsarCollection<Niveau> get niveaus => this.collection();
}

const NiveauSchema = CollectionSchema(
  name: r'Niveau',
  id: 8804853075422794026,
  properties: {
    r'couleur': PropertySchema(
      id: 0,
      name: r'couleur',
      type: IsarType.string,
    ),
    r'nom': PropertySchema(
      id: 1,
      name: r'nom',
      type: IsarType.string,
    ),
    r'ordre': PropertySchema(
      id: 2,
      name: r'ordre',
      type: IsarType.long,
    )
  },
  estimateSize: _niveauEstimateSize,
  serialize: _niveauSerialize,
  deserialize: _niveauDeserialize,
  deserializeProp: _niveauDeserializeProp,
  idName: r'idNiveau',
  indexes: {},
  links: {
    r'listes': LinkSchema(
      id: 8642717587196882836,
      name: r'listes',
      target: r'Liste',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _niveauGetId,
  getLinks: _niveauGetLinks,
  attach: _niveauAttach,
  version: '3.1.0+1',
);

int _niveauEstimateSize(
  Niveau object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.couleur.length * 3;
  bytesCount += 3 + object.nom.length * 3;
  return bytesCount;
}

void _niveauSerialize(
  Niveau object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.couleur);
  writer.writeString(offsets[1], object.nom);
  writer.writeLong(offsets[2], object.ordre);
}

Niveau _niveauDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Niveau();
  object.couleur = reader.readString(offsets[0]);
  object.idNiveau = id;
  object.nom = reader.readString(offsets[1]);
  object.ordre = reader.readLong(offsets[2]);
  return object;
}

P _niveauDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _niveauGetId(Niveau object) {
  return object.idNiveau;
}

List<IsarLinkBase<dynamic>> _niveauGetLinks(Niveau object) {
  return [object.listes];
}

void _niveauAttach(IsarCollection<dynamic> col, Id id, Niveau object) {
  object.idNiveau = id;
  object.listes.attach(col, col.isar.collection<Liste>(), r'listes', id);
}

extension NiveauQueryWhereSort on QueryBuilder<Niveau, Niveau, QWhere> {
  QueryBuilder<Niveau, Niveau, QAfterWhere> anyIdNiveau() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NiveauQueryWhere on QueryBuilder<Niveau, Niveau, QWhereClause> {
  QueryBuilder<Niveau, Niveau, QAfterWhereClause> idNiveauEqualTo(Id idNiveau) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idNiveau,
        upper: idNiveau,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterWhereClause> idNiveauNotEqualTo(
      Id idNiveau) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idNiveau, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idNiveau, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idNiveau, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idNiveau, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterWhereClause> idNiveauGreaterThan(
      Id idNiveau,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idNiveau, includeLower: include),
      );
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterWhereClause> idNiveauLessThan(Id idNiveau,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idNiveau, includeUpper: include),
      );
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterWhereClause> idNiveauBetween(
    Id lowerIdNiveau,
    Id upperIdNiveau, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdNiveau,
        includeLower: includeLower,
        upper: upperIdNiveau,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NiveauQueryFilter on QueryBuilder<Niveau, Niveau, QFilterCondition> {
  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'couleur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'couleur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'couleur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'couleur',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'couleur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'couleur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'couleur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'couleur',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'couleur',
        value: '',
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> couleurIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'couleur',
        value: '',
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> idNiveauEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idNiveau',
        value: value,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> idNiveauGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idNiveau',
        value: value,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> idNiveauLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idNiveau',
        value: value,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> idNiveauBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idNiveau',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nom',
        value: '',
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> nomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nom',
        value: '',
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> ordreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ordre',
        value: value,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> ordreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ordre',
        value: value,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> ordreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ordre',
        value: value,
      ));
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> ordreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ordre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NiveauQueryObject on QueryBuilder<Niveau, Niveau, QFilterCondition> {}

extension NiveauQueryLinks on QueryBuilder<Niveau, Niveau, QFilterCondition> {
  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listes(
      FilterQuery<Liste> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'listes');
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'listes', length, true, length, true);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'listes', 0, true, 0, true);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'listes', 0, false, 999999, true);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'listes', 0, true, length, include);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'listes', length, include, 999999, true);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterFilterCondition> listesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'listes', lower, includeLower, upper, includeUpper);
    });
  }
}

extension NiveauQuerySortBy on QueryBuilder<Niveau, Niveau, QSortBy> {
  QueryBuilder<Niveau, Niveau, QAfterSortBy> sortByCouleur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couleur', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> sortByCouleurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couleur', Sort.desc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> sortByNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> sortByNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.desc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> sortByOrdre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordre', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> sortByOrdreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordre', Sort.desc);
    });
  }
}

extension NiveauQuerySortThenBy on QueryBuilder<Niveau, Niveau, QSortThenBy> {
  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByCouleur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couleur', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByCouleurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'couleur', Sort.desc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByIdNiveau() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idNiveau', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByIdNiveauDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idNiveau', Sort.desc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.desc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByOrdre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordre', Sort.asc);
    });
  }

  QueryBuilder<Niveau, Niveau, QAfterSortBy> thenByOrdreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordre', Sort.desc);
    });
  }
}

extension NiveauQueryWhereDistinct on QueryBuilder<Niveau, Niveau, QDistinct> {
  QueryBuilder<Niveau, Niveau, QDistinct> distinctByCouleur(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'couleur', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Niveau, Niveau, QDistinct> distinctByNom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Niveau, Niveau, QDistinct> distinctByOrdre() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ordre');
    });
  }
}

extension NiveauQueryProperty on QueryBuilder<Niveau, Niveau, QQueryProperty> {
  QueryBuilder<Niveau, int, QQueryOperations> idNiveauProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idNiveau');
    });
  }

  QueryBuilder<Niveau, String, QQueryOperations> couleurProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'couleur');
    });
  }

  QueryBuilder<Niveau, String, QQueryOperations> nomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nom');
    });
  }

  QueryBuilder<Niveau, int, QQueryOperations> ordreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ordre');
    });
  }
}
