import 'package:isar/isar.dart';
import './liste.dart';

part 'niveau.g.dart';

@collection
class Niveau {
  Id idNiveau = Isar.autoIncrement;
  late String nom;
  late String couleur;
  late int ordre;

  final listes = IsarLinks<Liste>();
}
