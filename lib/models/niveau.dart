import 'package:hive/hive.dart';

part 'niveau.g.dart';

@HiveType(typeId: 5)
class Niveau extends HiveObject {
  @HiveField(0)
  late String nom;

  @HiveField(1)
  late String couleur;

  @HiveField(2)
  late int ordre;

  @HiveField(3)
  late List<int> listesIds;
}
