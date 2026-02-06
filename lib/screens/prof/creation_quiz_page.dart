import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class CreationQuizPage extends StatelessWidget {
  const CreationQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation Quiz'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Creation Quiz Page'),
          ),
          DebugPageIdentifier(pageName: 'CreationQuizPage'),
        ],
      ),
    );
  }
}
