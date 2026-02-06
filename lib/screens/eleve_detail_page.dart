// eleve_detail_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';
import 'evaluation/word_display_page.dart';
import 'evaluation/image_list_display_page.dart';

class EleveDetailPage extends StatefulWidget {
  final Eleve eleve;

  const EleveDetailPage({super.key, required this.eleve});

  @override
  State<EleveDetailPage> createState() => _EleveDetailPageState();
}

class _EleveDetailPageState extends State<EleveDetailPage> {
  List<Liste> _activites = [];
  bool _isLoading = true;
  Niveau? _niveau;

  @override
  void initState() {
    super.initState();
    _loadActivites();
  }

  Future<void> _loadActivites() async {
    // Récupérer les boxes Hive
    final listesBox = HiveService.listes;
    final niveauxBox = HiveService.niveaux;

    // Find the niveau that corresponds to the eleve's niveauId
    final niveau = niveauxBox.values.firstWhere(
      (n) => n.id == widget.eleve.niveauId,
    );

    // Récupérer toutes les listes et les filtrer par niveauId
    final activites = listesBox.values
        .where((liste) => liste.niveauId == niveau.key)
        .toList();

    if (mounted) {
      setState(() {
        _activites = activites;
        _isLoading = false;
        _niveau = niveau;
      });
    }
  }

  String _getNiveauName() {
    if (_niveau != null) {
      return _niveau!.nom;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.eleve.nom} (${_getNiveauName()})')),
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _activites.isEmpty
              ? const Center(
                  child: Text('Aucune activité trouvée pour ce niveau.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _activites.length,
                  itemBuilder: (context, index) {
                    final activite = _activites[index];
                    // On vérifie si la liste de mots est vide pour déterminer le type d'activité.
                    final isImageList = (activite.motsIds).isEmpty;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          // Assurez-vous que le chemin est correct.
                          backgroundImage: AssetImage(activite.image),
                        ),
                        title: Text(
                          activite.nom,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {
                          if (isImageList) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageListDisplayPage(
                                  liste: activite,
                                  eleve: widget.eleve,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WordDisplayPage(
                                  liste: activite,
                                  eleve: widget.eleve,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
