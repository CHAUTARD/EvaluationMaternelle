import 'package:hive/hive.dart';

part 'mot.g.dart';

@HiveType(typeId: 4)
class Mot extends HiveObject {
  @HiveField(0)
  late int idListe;

  @HiveField(1)
  late String word;

  @HiveField(2)
  late String image;
}
