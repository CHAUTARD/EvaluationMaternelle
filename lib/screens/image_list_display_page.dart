// lib/screens/image_list_display_page.dart
// Affiche une grille d'images et de mots pour une activité donnée.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/models.dart';

class ImageListDisplayPage extends StatefulWidget {
  final Liste liste; // La liste d'activités (ex: "Couleur des émotions")

  const ImageListDisplayPage({super.key, required this.liste});

  @override
  State<ImageListDisplayPage> createState() => _ImageListDisplayPageState();
}

class _ImageListDisplayPageState extends State<ImageListDisplayPage> {
  late Future<List<Mot>> _motsFuture;

  @override
  void initState() {
    super.initState();
    _motsFuture = _fetchMots();
  }

  // Récupère les mots et les images associés à la liste.
  Future<List<Mot>> _fetchMots() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('mots')
        .where('idListe', isEqualTo: int.tryParse(widget.liste.id) ?? -1)
        .get();

    final mots = querySnapshot.docs.map((doc) => Mot.fromFirestore(doc)).toList();

    // Pour chaque mot, récupérer l'URL de l'image depuis Firebase Storage.
    for (final mot in mots) {
      if (mot.image != null && mot.image!.isNotEmpty) {
        try {
          final url = await FirebaseStorage.instance.ref('images/${mot.image}').getDownloadURL();
          mot.imageUrl = url; // Stocker l'URL dans le modèle
        } catch (e) {
          mot.imageUrl = ''; // Gérer les erreurs (ex: image non trouvée)
        }
      }
    }
    return mots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.liste.nom)),
      body: FutureBuilder<List<Mot>>(
        future: _motsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun mot ou image à afficher."));
          }

          final mots = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Largeur maximale de chaque tuile
              childAspectRatio: 3 / 3.5, // Ratio pour l'apparence des tuiles
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: mots.length,
            itemBuilder: (context, index) {
              final mot = mots[index];
              return Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: (mot.imageUrl != null && mot.imageUrl!.isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl: mot.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50),
                            )
                          : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mot.mot,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
