import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/models.dart';

class IsarService extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [EleveSchema, NiveauSchema, ListeSchema, MotSchema, ActivityHistorySchema],
      directory: dir.path,
    );
  }
}
