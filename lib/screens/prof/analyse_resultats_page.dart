import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class AnalyseResultatsPage extends StatelessWidget {
  const AnalyseResultatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyse Resultats'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Analyse Resultats Page'),
          ),
          DebugPageIdentifier(pageName: 'AnalyseResultatsPage'),
        ],
      ),
    );
  }
}
