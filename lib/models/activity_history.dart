import 'package:isar/isar.dart';

part 'activity_history.g.dart';

@collection
class ActivityHistory {
  Id id = Isar.autoIncrement;
  late int eleveId;
  late int listeId;
  late int score;
  late DateTime date;
}
