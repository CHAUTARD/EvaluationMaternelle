import 'package:flutter/material.dart';

class ResultatPage extends StatelessWidget {
  const ResultatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultat')),
      body: Stack(children: [const Center(child: Text('Resultat Page'))]),
    );
  }
}
