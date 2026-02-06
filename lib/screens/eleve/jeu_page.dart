import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class JeuPage extends StatelessWidget {
  const JeuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Jeu Page'),
          ),
          DebugPageIdentifier(pageName: 'JeuPage'),
        ],
      ),
    );
  }
}
