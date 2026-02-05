import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  final List<WordEvaluation> evaluations;

  const ResultPage({super.key, 
    required this.score,
    required this.total,
    required this.evaluations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: $score / $total',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: evaluations.length,
              itemBuilder: (context, index) {
                final eval = evaluations[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/${eval.mot.image}'),
                    ),
                    title: Text(eval.mot.mot),
                    trailing: Icon(
                      eval.isCorrect ? Icons.check_circle : Icons.cancel,
                      color: eval.isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .popUntil((route) => route.isFirst), // Go back to home
              child: const Text('Terminer'),
            ),
          ),
        ],
      ),
    );
  }
}
