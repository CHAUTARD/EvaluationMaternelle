import 'package:flutter/material.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class EleveDashboardPage extends StatelessWidget {
  const EleveDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eleve Dashboard'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.jeu),
                  child: const Text('Jeu'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.resultat),
                  child: const Text('Resultat'),
                ),
              ],
            ),
          ),
          DebugPageIdentifier(pageName: 'EleveDashboardPage'),
        ],
      ),
    );
  }
}
