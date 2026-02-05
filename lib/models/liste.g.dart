// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liste.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetListeCollection on Isar {
  IsarCollection<Liste> get listes => this.collection();
}

const ListeSchema = CollectionSchema(
  name: r'Liste',
  id: -8204915628542724751,
  properties: {
    r'image': PropertySchema(
      id: 0,
      name: r'image',
      type: IsarType.string,
    ),
    r'nom': PropertySchema(
      id: 1,
      name: r'nom',
      type: IsarType.string,
    )
  },
  estimateSize: _listeEstimateSize,
  serialize: _listeSerialize,
  deserialize: _listeDeserialize,
  deserializeProp: _listeDeserializeProp,
  idName: r'idListe',
  indexes: {},
  links: {
    r'mots': LinkSchema(
      id: 4906452205222758684,
      name: r'mots',
      target: r'Mot',
      single: false,
    ),
    r'niveaux': LinkSchema(
      id: -3253895352492107593,
      name: r'niveaux',
      target: r'Niveau',
      single: false,
      linkName: r'listes',
    )
  },
  embeddedSchemas: {},
  getId: _listeGetId,
  getLinks: _listeGetLinks,
  attach: _listeAttach,
  version: '3.1.0+1',
);

int _listeEstimateSize(
  Liste object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.image.length * 3;
  bytesCount += 3 + object.nom.length * 3;
  return bytesCount;
}

void _listeSerialize(
  Liste object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.image);
  writer.writeString(offsets[1], object.nom);
}

Liste _listeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Liste();
  object.idListe = id;
  object.image = reader.readString(offsets[0]);
  object.nom = reader.readString(offsets[1]);
  return object;
}

P _listeDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _listeGetId(Liste object) {
  return object.idListe;
}

List<IsarLinkBase<dynamic>> _listeGetLinks(Liste object) {
  return [object.mots, object.niveaux];
}

void _listeAttach(IsarCollection<dynamic> col, Id id, Liste object) {
  object.idListe = id;
  object.mots.attach(col, col.isar.collection<Mot>(), r'mots', id);
  object.niveaux.attach(col, col.isar.collection<Niveau>(), r'niveaux', id);
}

extension ListeQueryWhereSort on QueryBuilder<Liste, Liste, QWhere> {
  QueryBuilder<Liste, Liste, QAfterWhere> anyIdListe() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ListeQueryWhere on QueryBuilder<Liste, Liste, QWhereClause> {
  QueryBuilder<Liste, Liste, QAfterWhereClause> idListeEqualTo(Id idListe) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idListe,
        upper: idListe,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterWhereClause> idListeNotEqualTo(Id idListe) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idListe, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idListe, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idListe, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idListe, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Liste, Liste, QAfterWhereClause> idListeGreaterThan(Id idListe,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idListe, includeLower: include),
      );
    });
  }

  QueryBuilder<Liste, Liste, QAfterWhereClause> idListeLessThan(Id idListe,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idListe, includeUpper: include),
      );
    });
  }

  QueryBuilder<Liste, Liste, QAfterWhereClause> idListeBetween(
    Id lowerIdListe,
    Id upperIdListe, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdListe,
        includeLower: includeLower,
        upper: upperIdListe,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ListeQueryFilter on QueryBuilder<Liste, Liste, QFilterCondition> {
  QueryBuilder<Liste, Liste, QAfterFilterCondition> idListeEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idListe',
        value: value,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> idListeGreaterThan(
    Id value, {
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> idListeLessThan(
    Id value, {
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> idListeBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomEqualTo(
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomGreaterThan(
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomLessThan(
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomBetween(
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomStartsWith(
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomEndsWith(
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

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nom',
        value: '',
      ));
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> nomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nom',
        value: '',
      ));
    });
  }
}

extension ListeQueryObject on QueryBuilder<Liste, Liste, QFilterCondition> {}

extension ListeQueryLinks on QueryBuilder<Liste, Liste, QFilterCondition> {
  QueryBuilder<Liste, Liste, QAfterFilterCondition> mots(FilterQuery<Mot> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'mots');
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> motsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'mots', length, true, length, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> motsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'mots', 0, true, 0, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> motsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'mots', 0, false, 999999, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> motsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'mots', 0, true, length, include);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> motsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'mots', length, include, 999999, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> motsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'mots', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveaux(
      FilterQuery<Niveau> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'niveaux');
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveauxLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'niveaux', length, true, length, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveauxIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'niveaux', 0, true, 0, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveauxIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'niveaux', 0, false, 999999, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveauxLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'niveaux', 0, true, length, include);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveauxLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'niveaux', length, include, 999999, true);
    });
  }

  QueryBuilder<Liste, Liste, QAfterFilterCondition> niveauxLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'niveaux', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ListeQuerySortBy on QueryBuilder<Liste, Liste, QSortBy> {
  QueryBuilder<Liste, Liste, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> sortByNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.asc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> sortByNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.desc);
    });
  }
}

extension ListeQuerySortThenBy on QueryBuilder<Liste, Liste, QSortThenBy> {
  QueryBuilder<Liste, Liste, QAfterSortBy> thenByIdListe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idListe', Sort.asc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> thenByIdListeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idListe', Sort.desc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> thenByNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.asc);
    });
  }

  QueryBuilder<Liste, Liste, QAfterSortBy> thenByNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.desc);
    });
  }
}

extension ListeQueryWhereDistinct on QueryBuilder<Liste, Liste, QDistinct> {
  QueryBuilder<Liste, Liste, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Liste, Liste, QDistinct> distinctByNom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nom', caseSensitive: caseSensitive);
    });
  }
}

extension ListeQueryProperty on QueryBuilder<Liste, Liste, QQueryProperty> {
  QueryBuilder<Liste, int, QQueryOperations> idListeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idListe');
    });
  }

  QueryBuilder<Liste, String, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<Liste, String, QQueryOperations> nomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nom');
    });
  }
}
