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

  @override
  void initState() {
    super.initState();
    _loadActivites();
  }

  Future<void> _loadActivites() async {
    // Récupérer les boxes Hive
    final niveauxBox = HiveService.niveaux;
    final listesBox = HiveService.listes;

    // Trouver le niveau de l'élève en utilisant son `niveauId`.
    // La `key` dans Hive est un `int`, donc nous utilisons `widget.eleve.niveauId` directement.
    final niveau = niveauxBox.get(widget.eleve.niveauId);

    if (niveau != null) {
      // Pour ce niveau, récupérer toutes les listes d'activités associées.
      // `niveau.listesIds` contient les clés des listes à récupérer.
      final activites = niveau.listesIds
          .map((id) => listesBox.get(id))
          // Filtrer au cas où une liste aurait été supprimée mais sa référence existerait toujours.
          .where((liste) => liste != null)
          .cast<Liste>()
          .toList();

      if (mounted) {
        setState(() {
          _activites = activites;
          _isLoading = false;
        });
      }
    } else {
      // Si aucun niveau n'est trouvé pour l'élève.
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eleve.prenom),
        // Vous pouvez ajouter une CircleAvatar ici si vous le souhaitez
        // leading: CircleAvatar(backgroundImage: AssetImage('assets/images/${widget.eleve.avatar}')),
      ),
      body: _isLoading
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
                          backgroundImage:
                              AssetImage('assets/images/${activite.image}'),
                        ),
                        title: Text(activite.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
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
    );
  }
}
