import 'package:isar/isar.dart';

part 'mot.g.dart';

@collection
class Mot {
  Id idMot = Isar.autoIncrement;
  late int idListe;
  late String word;
  late String image;

  Mot({required this.idListe, required this.word, required this.image});
}
