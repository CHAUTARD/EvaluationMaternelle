// image_list_display_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:math';
import '../../models/models.dart';
import '../../services/hive_service.dart';
import 'package:intl/intl.dart';

class ImageListDisplayPage extends StatefulWidget {
  final Liste liste;
  final Eleve eleve;

  const ImageListDisplayPage({
    super.key,
    required this.liste,
    required this.eleve,
  });

  @override
  State<ImageListDisplayPage> createState() => _ImageListDisplayPageState();
}

class _ImageListDisplayPageState extends State<ImageListDisplayPage> {
  final Box<Mot> _motsBox = HiveService.mots;
  final Box<Historique> _historiqueBox =
      HiveService.historique; // Correction ici

  List<Mot> _shuffledMots = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  final List<String> _motsReussis = [];
  final List<String> _motsEchoues = [];

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
    final lastTest =
        _historiqueBox.values
            .where(
              (h) =>
                  h.eleveId == widget.eleve.key &&
                  h.listeId == widget.liste.key,
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    if (!mounted) return;
    setState(() {
      _shuffledMots = mots;
      _lastTest = lastTest.isNotEmpty ? lastTest.first : null;
      _isLoading = false;
    });
  }

  Future<void> _saveResultsAndExit() async {
    final newHistorique = Historique()
      ..date = DateTime.now()
      ..motsReussis = _motsReussis
      ..motsEchoues = _motsEchoues
      ..eleveId = widget.eleve.key
      ..listeId = widget.liste.key;

    await _historiqueBox.add(newHistorique);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _recordResultAndNext(bool reussi) {
    final currentMot = _shuffledMots[_currentIndex];
    if (reussi) {
      _motsReussis.add(currentMot.word);
    } else {
      _motsEchoues.add(currentMot.word);
    }

    if (_currentIndex < _shuffledMots.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _saveResultsAndExit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.liste.nom)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _shuffledMots.isEmpty
          ? const Center(child: Text('Aucun mot ou image dans cette liste.'))
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
                        Text(
                          'Dernière session: ${DateFormat('dd/MM/yyyy').format(_lastTest!.date)}',
                        ),
                        Text(
                          'Score: ${_lastTest!.motsReussis.length} / ${_lastTest!.motsReussis.length + _lastTest!.motsEchoues.length}',
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_shuffledMots[_currentIndex].image.isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              'assets/images/${_shuffledMots[_currentIndex].image}',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Text('Image non trouvée'),
                                  ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Text(
                        _shuffledMots[_currentIndex].word,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _recordResultAndNext(true),
          icon: const Icon(Icons.check),
          label: const Text('Réussi'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
