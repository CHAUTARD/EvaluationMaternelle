import 'package:flutter/material.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class ProfDashboardPage extends StatelessWidget {
  const ProfDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prof Dashboard'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.creationQuiz),
                  child: const Text('Creation Quiz'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.gestionEleves),
                  child: const Text('Gestion Eleves'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.analyseResultats),
                  child: const Text('Analyse Resultats'),
                ),
              ],
            ),
          ),
          DebugPageIdentifier(pageName: 'ProfDashboardPage'),
        ],
      ),
    );
  }
}
