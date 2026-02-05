import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';

class SpellingPage extends StatefulWidget {
  final Mot mot;
  final Function(bool isCorrect) onAnswered;

  const SpellingPage({super.key, required this.mot, required this.onAnswered});

  @override
  State<SpellingPage> createState() => _SpellingPageState();
}

class _SpellingPageState extends State<SpellingPage> {
  late List<String> _shuffledChars;
  late List<String> _currentAnswer;
  late List<bool> _isCharUsed;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _shuffledChars = widget.mot.mot.split('')..shuffle();
    _currentAnswer = List.filled(widget.mot.mot.length, '_');
    _isCharUsed = List.filled(widget.mot.mot.length, false);
  }

  void _onCharTapped(int index) {
    if (_isCharUsed[index]) return;

    setState(() {
      final firstEmptyIndex = _currentAnswer.indexOf('_');
      if (firstEmptyIndex != -1) {
        _currentAnswer[firstEmptyIndex] = _shuffledChars[index];
        _isCharUsed[index] = true;

        if (!_currentAnswer.contains('_')) {
          _checkAnswer();
        }
      }
    });
  }

  void _onAnswerCharTapped(int index) {
    if (_currentAnswer[index] == '_') return;

    setState(() {
      final char = _currentAnswer[index];
      _currentAnswer[index] = '_';

      final originalIndex = _shuffledChars.indexWhere(
        (c, i) => c == char && _isCharUsed[i], // Find the specific used character
      );
      
      if (originalIndex != -1) {
        _isCharUsed[originalIndex] = false;
      }
    });
  }

  void _checkAnswer() {
    final isCorrect = _currentAnswer.join('') == widget.mot.mot;
    widget.onAnswered(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/${widget.mot.image}',
          height: 200,
          errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.image_not_supported, size: 200),
        ),
        const SizedBox(height: 30),
        // Display the answer boxes
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(_currentAnswer.length, (index) {
            return GestureDetector(
              onTap: () => _onAnswerCharTapped(index),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _currentAnswer[index],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 40),
        // Display the shuffled characters
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(_shuffledChars.length, (index) {
            return GestureDetector(
              onTap: () => _onCharTapped(index),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _isCharUsed[index] ? Colors.grey[400] : Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isCharUsed[index]
                      ? []
                      : [const BoxShadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 2)],
                ),
                child: Center(
                  child: Text(
                    _shuffledChars[index],
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
