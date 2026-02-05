import 'package:isar/isar.dart';

part 'mot.g.dart';

@collection
class Mot {
  Id idMot = Isar.autoIncrement;
  late String word;
  late String image;
}
