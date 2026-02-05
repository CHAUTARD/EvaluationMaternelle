// historique_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/models.dart';
import '../../services/hive_service.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  late Box<Historique> _historiqueBox;
  late Box<Eleve> _elevesBox;
  late Box<Liste> _listesBox;
  Eleve? _selectedEleve;

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  void _openBoxes() {
    _historiqueBox = HiveService.historique;
    _elevesBox = HiveService.eleves;
    _listesBox = HiveService.listes;
  }

  void _onEleveChanged(Eleve? eleve) {
    setState(() {
      _selectedEleve = eleve;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historique des sessions')),
      body: Column(
        children: [
          _buildFilterDropdown(),
          Expanded(child: _buildHistoriqueList()),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ValueListenableBuilder(
        valueListenable: _elevesBox.listenable(),
        builder: (context, Box<Eleve> box, _) {
          return DropdownButtonFormField<Eleve>(
            initialValue: _selectedEleve,
            hint: const Text('Filtrer par élève'),
            onChanged: (eleve) => _onEleveChanged(eleve),
            items: [
              const DropdownMenuItem<Eleve>(
                value: null,
                child: Text('Tous les élèves'),
              ),
              ...box.values.map((eleve) {
                return DropdownMenuItem<Eleve>(
                  value: eleve,
                  child: Text(eleve.prenom),
                );
              }),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHistoriqueList() {
    return ValueListenableBuilder(
      valueListenable: _historiqueBox.listenable(),
      builder: (context, Box<Historique> box, _) {
        var historiques = box.values.toList();

        if (_selectedEleve != null) {
          historiques = historiques
              .where((h) => h.eleveId == _selectedEleve!.key)
              .toList();
        }

        historiques.sort((a, b) => b.date.compareTo(a.date));

        if (historiques.isEmpty) {
          return const Center(child: Text("Aucun historique trouvé."));
        }

        return ListView.builder(
          itemCount: historiques.length,
          itemBuilder: (context, index) {
            final historique = historiques[index];
            final score =
                (historique.motsReussis.isEmpty &&
                    historique.motsEchoues.isEmpty)
                ? 0
                : (historique.motsReussis.length /
                          (historique.motsReussis.length +
                              historique.motsEchoues.length)) *
                      100;
            final eleve = _elevesBox.get(historique.eleveId);
            final liste = _listesBox.get(historique.listeId);

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 2,
              child: ListTile(
                title: Text(
                  '${eleve?.prenom ?? 'N/A'} - ${liste?.nom ?? 'N/A'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(historique.date)}\n'
                  'Mots réussis: ${historique.motsReussis.join(', ')}\n'
                  'Mots échoués: ${historique.motsEchoues.join(', ')}',
                ),
                trailing: Text(
                  '${score.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
