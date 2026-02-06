import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:math';
import '../../models/models.dart';
import '../../services/hive_service.dart';
import 'package:intl/intl.dart';
import '../game/result_page.dart'; // Import ResultPage

class WordDisplayPage extends StatefulWidget {
  final Liste liste;
  final Eleve eleve;

  const WordDisplayPage({super.key, required this.liste, required this.eleve});

  @override
  State<WordDisplayPage> createState() => _WordDisplayPageState();
}

class _WordDisplayPageState extends State<WordDisplayPage> {
  final Box<Mot> _motsBox = HiveService.mots;
  final Box<Historique> _historiqueBox = HiveService.historique; // Correction ici

  List<Mot> _shuffledMots = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  final List<WordEvaluation> _evaluations = []; // Use WordEvaluation list

  Historique? _lastTest;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    // 1. Charger les mots de la liste
    final mots = _motsBox.values
        .where((mot) => widget.liste.motsIds.contains(mot.key))
        .toList();
    mots.shuffle(Random());

    // 2. Trouver le dernier historique pour cet élève et cette liste
    final lastTest = _historiqueBox.values
        .where((h) =>
            h.eleveId == widget.eleve.key && h.listeId == widget.liste.key)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    if (!mounted) return;
    setState(() {
      _shuffledMots = mots;
      _lastTest = lastTest.isNotEmpty ? lastTest.first : null;
      _isLoading = false;
    });
  }

  void _recordResultAndNext(bool reussi) {
    final currentMot = _shuffledMots[_currentIndex];
    _evaluations.add(WordEvaluation(mot: currentMot, isCorrect: reussi));

    if (_currentIndex < _shuffledMots.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _saveResultsAndNavigate();
    }
  }

  Future<void> _saveResultsAndNavigate() async {
    final motsReussis = _evaluations.where((e) => e.isCorrect).map((e) => e.mot.word).toList();
    final motsEchoues = _evaluations.where((e) => !e.isCorrect).map((e) => e.mot.word).toList();

    final newHistorique = Historique()
      ..date = DateTime.now()
      ..motsReussis = motsReussis
      ..motsEchoues = motsEchoues
      ..eleveId = widget.eleve.key
      ..listeId = widget.liste.key;

    await _historiqueBox.add(newHistorique);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            score: motsReussis.length,
            total: _evaluations.length,
            evaluations: _evaluations,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.liste.nom)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _shuffledMots.isEmpty
              ? const Center(child: Text('Aucun mot dans cette liste.'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        widget.eleve.nom,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (_lastTest != null)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text('Dernière session: ${DateFormat('dd/MM/yyyy').format(_lastTest!.date)}'),
                              Text('Score: ${_lastTest!.motsReussis.length} / ${_lastTest!.motsReussis.length + _lastTest!.motsEchoues.length}')
                            ],
                          )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_shuffledMots[_currentIndex].image.isNotEmpty)
                             Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'assets/images/${_shuffledMots[_currentIndex].image}',
                                  height: 150,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(child: Text('Image non trouvée')),
                                ),
                              ),
                          const SizedBox(height: 20),
                          Text(
                            _shuffledMots[_currentIndex].word,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${_currentIndex + 1} / ${_shuffledMots.length}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    _buildButtonBar(),
                    const SizedBox(height: 20),
                  ],
                ),
    );
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => _recordResultAndNext(false),
          icon: const Icon(Icons.close),
          label: const Text('Pas réussi'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        ),
        ElevatedButton.icon(
          onPressed: () => _recordResultAndNext(true),
          icon: const Icon(Icons.check),
          label: const Text('Réussi'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        ),
      ],
    );
  }
}
