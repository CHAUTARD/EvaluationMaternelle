import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/models.dart';

class HiveService extends ChangeNotifier {
  static late Box<Eleve> _eleves;
  static late Box<Niveau> _niveaux;
  static late Box<Liste> _listes;
  static late Box<Mot> _mots;
  static late Box<ActivityHistory> _activityHistory;
  static late Box<Historique> _historique;

  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(EleveAdapter());
    Hive.registerAdapter(NiveauAdapter());
    Hive.registerAdapter(ListeAdapter());
    Hive.registerAdapter(MotAdapter());
    Hive.registerAdapter(ActivityHistoryAdapter());
    Hive.registerAdapter(HistoriqueAdapter());

    _eleves = await Hive.openBox<Eleve>('eleves');
    _niveaux = await Hive.openBox<Niveau>('niveaux');
    _listes = await Hive.openBox<Liste>('listes');
    _mots = await Hive.openBox<Mot>('mots');
    _activityHistory = await Hive.openBox<ActivityHistory>('activity_history');
    _historique = await Hive.openBox<Historique>('historique');
  }

  static Box<Eleve> get eleves => _eleves;
  static Box<Niveau> get niveaux => _niveaux;
  static Box<Liste> get listes => _listes;
  static Box<Mot> get mots => _mots;
  static Box<ActivityHistory> get activityHistory => _activityHistory;
  static Box<Historique> get historique => _historique;
}
