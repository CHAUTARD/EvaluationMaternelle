import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'dart:math';
import '../../models/models.dart';
import '../../services/isar_service.dart';
import 'package:intl/intl.dart';

class ImageListDisplayPage extends StatefulWidget {
  final Liste liste;
  final Eleve eleve;

  const ImageListDisplayPage({super.key, required this.liste, required this.eleve});

  @override
  State<ImageListDisplayPage> createState() => _ImageListDisplayPageState();
}

class _ImageListDisplayPageState extends State<ImageListDisplayPage> {
  final Isar _isar = IsarService.isar;
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
    setState(() => _isLoading = true);
    await _isar.writeTxn(() async {
      await widget.liste.mots.load();
    });
    
    final mots = widget.liste.mots.toList();
    mots.shuffle(Random());

    final lastTest = await _isar.historiques
        .where()
        .idEleveEqualTo(widget.eleve.idEleve)
        .idListeEqualTo(widget.liste.idListe)
        .sortByDateDesc()
        .findFirst();

    setState(() {
      _shuffledMots = mots;
      _lastTest = lastTest;
      _isLoading = false;
    });
  }

  void _recordResultAndNext(bool reussi) {
    final currentMot = _shuffledMots[_currentIndex];
    if (reussi) {
      _motsReussis.add(currentMot.mot);
    } else {
      _motsEchoues.add(currentMot.mot);
    }

    if (_currentIndex < _shuffledMots.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _saveResultsAndExit();
    }
  }

  Future<void> _saveResultsAndExit() async {
    final newHistorique = Historique()
      ..idEleve = widget.eleve.idEleve
      ..idListe = widget.liste.idListe
      ..date = DateTime.now()
      ..motsReussis = _motsReussis
      ..motsEchoues = _motsEchoues;

    await _isar.writeTxn(() async {
      await _isar.historiques.put(newHistorique);
    });

    if (mounted) {
        Navigator.of(context).pop();
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
                        widget.eleve.prenom,
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
                          )
                      ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_shuffledMots[_currentIndex].image?.isNotEmpty ?? false)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.network(
                                  _shuffledMots[_currentIndex].image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            _shuffledMots[_currentIndex].mot,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        ),
        ElevatedButton.icon(
          onPressed: () => _recordResultAndNext(true),
          icon: const Icon(Icons.check),
          label: const Text('Réussi'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        ),
      ],
    );
  }
}
