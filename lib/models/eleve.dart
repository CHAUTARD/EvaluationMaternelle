import 'package:isar/isar.dart';
import './niveau.dart';

part 'eleve.g.dart';

@collection
class Eleve {
  Id idEleve = Isar.autoIncrement;
  late String prenom;

  final niveau = IsarLink<Niveau>();
}
