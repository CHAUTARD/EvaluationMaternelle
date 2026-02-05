import 'package:isar/isar.dart';

part 'historique.g.dart';

@collection
class Historique {
  Id idHistorique = Isar.autoIncrement;

  late int idEleve;
  late int idListe;
  late List<String> motsReussis;
  late List<String> motsEchoues;
  late DateTime date;
}
