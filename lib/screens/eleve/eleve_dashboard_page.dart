import 'package:flutter/material.dart';
import 'package:myapp/screens/eleve/resultat_page.dart';

class EleveDashboardPage extends StatelessWidget {
  const EleveDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eleve Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultatPage()),
              ),
              child: const Text('Resultat'),
            ),
          ],
        ),
      ),
    );
  }
}
