import 'package:isar/isar.dart';
import './mot.dart';
import './niveau.dart';

part 'liste.g.dart';

@collection
class Liste {
  Id idListe = Isar.autoIncrement;
  late String nom;
  late String image;

  final mots = IsarLinks<Mot>();

  @Backlink(to: 'listes')
  final niveaux = IsarLinks<Niveau>();
}
