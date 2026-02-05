import 'package:hive/hive.dart';

part 'historique.g.dart';

@HiveType(typeId: 2)
class Historique extends HiveObject {
  @HiveField(0)
  late int eleveId;

  @HiveField(1)
  late int listeId;

  @HiveField(2)
  late List<String> motsReussis;

  @HiveField(3)
  late List<String> motsEchoues;

  @HiveField(4)
  late DateTime date;
}
