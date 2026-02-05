// matching_game_page.dart

import 'package:flutter/material.dart';
import '../../models/mot.dart';

class MatchingGamePage extends StatefulWidget {
  final List<Mot> words;

  const MatchingGamePage({super.key, required this.words});

  @override
  MatchingGamePageState createState() => MatchingGamePageState();
}

class MatchingGamePageState extends State<MatchingGamePage> {
  Mot? currentWord;
  List<String> options = [];
  int score = 0;
  int questionsAsked = 0;
  final int totalQuestions = 10;

  @override
  void initState() {
    super.initState();
    widget.words.shuffle();
    _nextTurn();
  }

  void _nextTurn() {
    if (questionsAsked >= totalQuestions) {
      _showFinalScore();
      return;
    }
    setState(() {
      questionsAsked++;
      // Select a word
      currentWord = widget.words[questionsAsked % widget.words.length];

      // Get options
      options = _generateOptions(currentWord!);
    });
  }

  List<String> _generateOptions(Mot correctWord) {
    List<String> allWords = widget.words.map((w) => w.word).toList();
    allWords.remove(correctWord.word);
    allWords.shuffle();

    List<String> currentOptions = [correctWord.word];
    currentOptions.addAll(allWords.take(3));
    currentOptions.shuffle();

    // Ensure we have 4 unique options if possible
    while (currentOptions.length < 4 && allWords.isNotEmpty) {
      final nextWord = allWords.removeAt(0);
      if (!currentOptions.contains(nextWord)) {
        currentOptions.add(nextWord);
      }
    }
    currentOptions.shuffle();

    return currentOptions;
  }

  void _checkAnswer(String selectedWord) {
    bool isCorrect = selectedWord == currentWord!.word;

    if (isCorrect) {
      setState(() {
        score++;
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Correct!' : 'Faux! Le mot était "${currentWord!.word}"',
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _nextTurn();
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fin du jeu!'),
          content: Text('Votre score final est: $score / $totalQuestions'),
          actions: <Widget>[
            TextButton(
              child: Text('Rejouer'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  score = 0;
                  questionsAsked = 0;
                  widget.words.shuffle();
                });
                _nextTurn();
              },
            ),
            TextButton(
              child: Text('Quitter'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentWord == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Jeu de correspondance')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    Widget imageWidget;
    if (currentWord!.image.startsWith('http')) {
      imageWidget = Image.network(
        currentWord!.image,
        height: 150,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.broken_image, size: 100, color: Colors.grey),
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : Center(child: CircularProgressIndicator()),
      );
    } else if (currentWord!.image.isNotEmpty) {
      imageWidget = Image.asset(
        'assets/images/${currentWord!.image}',
        height: 150,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.broken_image, size: 100, color: Colors.grey),
      );
    } else {
      imageWidget = Icon(
        Icons.image_not_supported,
        size: 100,
        color: Colors.grey,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Question $questionsAsked/$totalQuestions'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                'Score: $score',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quel est ce mot?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),

              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(77),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageWidget,
                ),
              ),

              SizedBox(height: 35),

              ...options.map((word) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(word),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(word, style: TextStyle(fontSize: 18)),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
