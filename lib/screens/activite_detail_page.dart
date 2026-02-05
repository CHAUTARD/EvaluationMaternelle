import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/models/models.dart';

class ActiviteDetailPage extends StatefulWidget {
  final Liste liste; // L'activité (ou liste) à afficher

  const ActiviteDetailPage({super.key, required this.liste});

  @override
  State<ActiviteDetailPage> createState() => _ActiviteDetailPageState();
}

class _ActiviteDetailPageState extends State<ActiviteDetailPage> {
  late Future<List<Mot>> _motsFuture;

  @override
  void initState() {
    super.initState();
    _motsFuture = _fetchMotsForListe();
  }

  // Récupère les mots associés à la liste actuelle depuis la base de données Hive.
  Future<List<Mot>> _fetchMotsForListe() async {
    final motBox = Hive.box<Mot>('mots');
    // On utilise la `key` de la liste pour filtrer les mots correspondants.
    final mots = motBox.values.where((mot) => mot.idListe == widget.liste.key).toList();
    return mots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.liste.nom),
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
            return const Center(child: Text('Aucun mot trouvé pour cette liste.'));
          }

          final mots = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: mots.length,
            itemBuilder: (context, index) {
              final item = mots[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: (item.image.isNotEmpty)
                          ? Image.asset(
                              item.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  ),
                            )
                          : const Center(
                              child: Icon(Icons.image_not_supported, size: 50),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        item.word,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
