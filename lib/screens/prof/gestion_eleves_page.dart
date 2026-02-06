import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class GestionElevesPage extends StatelessWidget {
  const GestionElevesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion Eleves'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Gestion Eleves Page'),
          ),
          DebugPageIdentifier(pageName: 'GestionElevesPage'),
        ],
      ),
    );
  }
}
