// lib/screens/activite_detail_page.dart
// Affiche le contenu d'une activité.
// Prend en charge un mode d'édition pour les listes de type 'images'.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class ActiviteDetailPage extends StatefulWidget {
  final Liste liste; // L'activité (ou liste) à afficher

  const ActiviteDetailPage({super.key, required this.liste});

  @override
  State<ActiviteDetailPage> createState() => _ActiviteDetailPageState();
}

class _ActiviteDetailPageState extends State<ActiviteDetailPage> {
  late Future<List<Mot>> _motsFuture;
  bool _isEditing = false;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _motsFuture = _fetchMotsForListe();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Récupère les mots associés à la liste actuelle depuis Firestore.
  Future<List<Mot>> _fetchMotsForListe() async {
    final query = await FirebaseFirestore.instance
        .collection('mots')
        .where('idListe', isEqualTo: widget.liste.id)
        .get();

    List<Mot> mots = [];
    for (final doc in query.docs) {
      final data = doc.data();
      final mot = Mot(
        data['id'],
        data['mot'],
        data['idListe'],
        data['image'] ?? '',
        data['url'], // L'URL peut être nulle
      );
      mots.add(mot);
      _controllers[mot.idMot] = TextEditingController(text: mot.mot);
    }
    return mots;
  }

  // Méthode pour basculer en mode édition.
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  // Sauvegarde les modifications des noms des mots.
  Future<void> _saveChanges() async {
    final batch = FirebaseFirestore.instance.batch();
    for (var idMot in _controllers.keys) {
      final newWord = _controllers[idMot]!.text;
      final docRef = FirebaseFirestore.instance
          .collection('mots')
          .doc(idMot.toString());
      batch.update(docRef, {'mot': newWord});
    }
    await batch.commit();
    _toggleEditMode(); // Quitte le mode édition après sauvegarde
    setState(() {
      _motsFuture = _fetchMotsForListe(); // Recharge les données
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.liste.nom),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEditMode,
            tooltip: _isEditing ? 'Sauvegarder' : 'Modifier',
          ),
        ],
      ),
      body: FutureBuilder<List<Mot>>(
        future: _motsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun élément trouvé.'));
          }

          final mots = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: mots.length,
            itemBuilder: (context, index) {
              final item = mots[index];
              final controller = _controllers[item.idMot];

              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: (item.url != null && item.url!.isNotEmpty)
                          ? Image.network(
                              item.url!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                            )
                          : const Center(
                              child: Icon(Icons.image_not_supported, size: 50),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _isEditing
                          ? TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mot',
                                isDense: true,
                              ),
                            )
                          : Text(
                              item.mot,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
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
