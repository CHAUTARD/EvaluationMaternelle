import 'package:hive/hive.dart';

part 'eleve.g.dart';

@HiveType(typeId: 1)
class Eleve extends HiveObject {
  @HiveField(0)
  late String prenom;

  @HiveField(1)
  late int niveauId;
}
