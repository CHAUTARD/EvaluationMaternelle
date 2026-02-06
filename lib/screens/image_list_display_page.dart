import 'package:flutter/material.dart';
import 'package:myapp/services/hive_service.dart';
import '../models/models.dart';

class ImageListDisplayPage extends StatefulWidget {
  final Liste liste; // La liste d'activités (ex: "Couleur des émotions")

  const ImageListDisplayPage({super.key, required this.liste});

  @override
  State<ImageListDisplayPage> createState() => _ImageListDisplayPageState();
}

class _ImageListDisplayPageState extends State<ImageListDisplayPage> {
  late List<Mot> _mots;

  @override
  void initState() {
    super.initState();
    // Charger les mots de manière synchrone depuis Hive.
    _fetchMots();
  }

  // Récupère les mots associés à la liste directement depuis Hive.
  void _fetchMots() {
    final motBox = HiveService.mots;
    // Pas besoin d'attendre, c'est une opération synchrone.
    _mots = motBox.values
        .where((mot) => mot.idListe == widget.liste.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.liste.nom)),
      body: Stack(
        children: [
          if (_mots.isEmpty)
            const Center(child: Text("Aucun mot ou image à afficher."))
          else
            GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200, // Largeur maximale de chaque tuile
                childAspectRatio: 3 / 3.5, // Ratio pour l'apparence des tuiles
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _mots.length,
              itemBuilder: (context, index) {
                final mot = _mots[index];
                return Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: (mot.image.isNotEmpty)
                            ? Image.asset(
                                'assets/images/${mot.image}', // Charger depuis les assets locaux
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Widget à afficher si l'asset n'est pas trouvé
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          mot.word,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
