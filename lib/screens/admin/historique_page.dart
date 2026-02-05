import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';
import '../../models/models.dart';
import '../../services/isar_service.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriqueData {
  final Historique historique;
  final Eleve? eleve;
  final Liste? liste;

  _HistoriqueData({required this.historique, this.eleve, this.liste});
}

class _HistoriquePageState extends State<HistoriquePage> {
  final Isar _isar = IsarService.isar;
  List<_HistoriqueData> _historiqueData = [];
  List<_HistoriqueData> _filteredHistoriqueData = [];
  List<Eleve> _eleves = [];
  bool _isLoading = true;

  Eleve? _selectedEleve;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    setState(() => _isLoading = true);

    try {
      _eleves = await _isar.eleves.where().sortByPrenom().findAll();
      final historiques = await _isar.historiques.where().sortByDateDesc().findAll();

      List<_HistoriqueData> tempData = [];
      for (var h in historiques) {
        final eleve = await _isar.eleves.get(h.idEleve);
        final liste = await _isar.listes.get(h.idListe);
        tempData.add(_HistoriqueData(historique: h, eleve: eleve, liste: liste));
      }

      if (mounted) {
        setState(() {
          _historiqueData = tempData;
          _filteredHistoriqueData = tempData;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Erreur de chargement: $e")),
      );
    }
  }

  void _applyFilters() {
    List<_HistoriqueData> tempHistorique = _historiqueData;

    if (_selectedEleve != null) {
      tempHistorique = tempHistorique.where((d) => d.historique.idEleve == _selectedEleve!.idEleve).toList();
    }

    if (_selectedDateRange != null) {
      tempHistorique = tempHistorique.where((d) {
        final date = d.historique.date;
        final startDate = _selectedDateRange!.start;
        final endDate = _selectedDateRange!.end;
        return date.isAfter(startDate.subtract(const Duration(days: 1))) && date.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    }

    setState(() {
      _filteredHistoriqueData = tempHistorique;
    });
  }

  Future<void> _pickDateRange() async {
    final initialDateRange = _selectedDateRange ??
        DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 7)),
          end: DateTime.now(),
        );

    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: initialDateRange,
    );

    if (newDateRange != null) {
      setState(() {
        _selectedDateRange = newDateRange;
      });
      _applyFilters();
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedEleve = null;
      _selectedDateRange = null;
      _filteredHistoriqueData = _historiqueData;
    });
  }

  Future<void> _clearHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Vider l'historique"),
        content: const Text("Êtes-vous sûr de vouloir supprimer tout l'historique ? Cette action est irréversible."),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("Annuler")),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      setState(() => _isLoading = true);
      try {
        await _isar.writeTxn(() async {
          await _isar.historiques.clear();
        });
        await _fetchData();
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text("Erreur de suppression: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des Activités"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            onPressed: _clearHistory,
            tooltip: "Vider l'historique",
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildFilterBar(),
                Expanded(
                  child: _filteredHistoriqueData.isEmpty
                      ? const Center(child: Text("Aucun enregistrement trouvé."))
                      : ListView.builder(
                          itemCount: _filteredHistoriqueData.length,
                          itemBuilder: (context, index) {
                            final data = _filteredHistoriqueData[index];
                            final item = data.historique;
                            final correctes = item.motsReussis.length;
                            final total = item.motsReussis.length + item.motsEchoues.length;

                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              elevation: 2,
                              child: ExpansionTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade100,
                                  child: Text(
                                    '$correctes/$total',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                                title: Text('${data.eleve?.prenom ?? "Élève inconnu"} - ${data.liste?.nom ?? "Liste inconnue"}'),
                                subtitle: Text(DateFormat('dd/MM/yyyy à HH:mm').format(item.date)),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (item.motsReussis.isNotEmpty)
                                          _buildWordList('Mots réussis (${item.motsReussis.length})', item.motsReussis, Colors.green.shade700),
                                        if (item.motsEchoues.isNotEmpty)
                                          _buildWordList('Mots échoués (${item.motsEchoues.length})', item.motsEchoues, Colors.red.shade700),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: [
          DropdownButton<Eleve>(
            value: _selectedEleve,
            hint: const Text("Filtrer par élève"),
            items: _eleves.map((eleve) {
              return DropdownMenuItem(
                value: eleve,
                child: Text(eleve.prenom),
              );
            }).toList(),
            onChanged: (eleve) {
              setState(() {
                _selectedEleve = eleve;
              });
              _applyFilters();
            },
          ),
          ActionChip(
            avatar: const Icon(Icons.calendar_today),
            label: Text(_selectedDateRange != null
                ? '${DateFormat('dd/MM/yy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yy').format(_selectedDateRange!.end)}'
                : "Filtrer par date"),
            onPressed: _pickDateRange,
          ),
          if (_selectedEleve != null || _selectedDateRange != null)
            ActionChip(
              avatar: const Icon(Icons.clear, color: Colors.redAccent),
              label: const Text("Réinitialiser"),
              onPressed: _resetFilters,
            ),
        ],
      ),
    );
  }

  Widget _buildWordList(String title, List<String> words, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: words.map((word) => Chip(label: Text(word), backgroundColor: color.withAlpha((255 * 0.1).round()))).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
