import 'package:hive/hive.dart';

part 'eleve.g.dart';

@HiveType(typeId: 1)
class Eleve extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nom;

  @HiveField(2)
  late String niveauId;

  Eleve({required this.id, required this.nom, required this.niveauId});
}
