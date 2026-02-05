import 'package:hive/hive.dart';

part 'liste.g.dart';

@HiveType(typeId: 3)
class Liste extends HiveObject {
  @HiveField(0)
  late String nom;

  @HiveField(1)
  late String image;

  @HiveField(2)
  late List<int> motsIds;

  @HiveField(3)
  late int niveauId;
}
