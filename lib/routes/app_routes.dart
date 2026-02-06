import 'package:flutter/material.dart';
import 'package:myapp/screens/auth/login_page.dart';
import 'package:myapp/screens/auth/register_page.dart';
import 'package:myapp/screens/eleve/eleve_dashboard_page.dart';
import 'package:myapp/screens/eleve/jeu_page.dart';
import 'package:myapp/screens/eleve/resultat_page.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/screens/prof/prof_dashboard.dart';
import 'package:myapp/screens/prof/creation_quiz_page.dart';
import 'package:myapp/screens/prof/gestion_eleves_page.dart';
import 'package:myapp/screens/prof/analyse_resultats_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String eleveDashboard = '/eleve/dashboard';
  static const String jeu = '/eleve/jeu';
  static const String resultat = '/eleve/resultat';
  static const String profDashboard = '/prof/dashboard';
  static const String creationQuiz = '/prof/creation-quiz';
  static const String gestionEleves = '/prof/gestion-eleves';
  static const String analyseResultats = '/prof/analyse-resultats';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    eleveDashboard: (context) => const EleveDashboardPage(),
    jeu: (context) => const JeuPage(),
    resultat: (context) => const ResultatPage(),
    profDashboard: (context) => const ProfDashboardPage(),
    creationQuiz: (context) => const CreationQuizPage(),
    gestionEleves: (context) => const GestionElevesPage(),
    analyseResultats: (context) => const AnalyseResultatsPage(),
  };
}
