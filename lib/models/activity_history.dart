import 'package:hive/hive.dart';

part 'activity_history.g.dart';

@HiveType(typeId: 6)
class ActivityHistory extends HiveObject {
  @HiveField(0)
  late int studentId;

  @HiveField(1)
  late int listId;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late int durationInSeconds;

  @HiveField(4)
  late List<String> words;

  @HiveField(5)
  late String status;
}
