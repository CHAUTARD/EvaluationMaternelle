import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';
import './image_picker_screen.dart';
import './mot_management_page.dart';

class ListeManagementPage extends StatefulWidget {
  const ListeManagementPage({super.key});

  @override
  State<ListeManagementPage> createState() => _ListeManagementPageState();
}

class _ListeManagementPageState extends State<ListeManagementPage> {
  List<Liste> _listes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchListes();
  }

  Future<void> _fetchListes() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final isar = IsarService.isar;
      final listes = await isar.listes.where().findAll();

      listes.sort((a, b) => a.nom.compareTo(b.nom));

      if (mounted) {
        setState(() {
          _listes = listes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de chargement des listes: $e")),
        );
      }
    }
  }

  void _showFormDialog({Liste? liste}) {
    final formKey = GlobalKey<FormState>();
    String nom = liste?.nom ?? '';
    String imageName = liste?.image ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(liste == null ? 'Ajouter une liste' : 'Modifier la liste'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: nom,
                      decoration: const InputDecoration(labelText: 'Nom de la liste'),
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Le nom est requis.' : null,
                      onSaved: (value) => nom = value!,
                    ),
                    const SizedBox(height: 20),
                    const Text("Image de couverture"),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final selectedImage = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImagePickerScreen()),
                        );
                        if (selectedImage != null) {
                          setState(() => imageName = selectedImage);
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: imageName.isEmpty
                            ? const Center(
                                child: Icon(Icons.add_photo_alternate,
                                    size: 50, color: Colors.grey))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/$imageName',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(child: Text('Image non trouvée')),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler')),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (imageName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Veuillez sélectionner une image.')),
                    );
                    return;
                  }
                  if (liste == null) {
                    _addListe(nom, imageName);
                  } else {
                    _updateListe(liste, nom, imageName);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addListe(String nom, String image) async {
    try {
      final isar = IsarService.isar;
      final newListe = Liste()
        ..nom = nom
        ..image = image;

      await isar.writeTxn(() async {
        await isar.listes.put(newListe);
      });

      _fetchListes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur lors de l\'ajout: $e")));
      }
    }
  }

  Future<void> _updateListe(Liste liste, String nom, String image) async {
    try {
      final isar = IsarService.isar;
      liste.nom = nom;
      liste.image = image;

      await isar.writeTxn(() async {
        await isar.listes.put(liste);
      });

      _fetchListes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur de mise à jour: $e")));
      }
    }
  }

  Future<void> _deleteListe(Liste liste) async {
    final isar = IsarService.isar;

    final associatedNiveaux = await isar.niveaus.filter().listes((q) => q.idListeEqualTo(liste.idListe)).findAll();

    if (associatedNiveaux.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cette liste est associée à un ou plusieurs niveaux et ne peut pas être supprimée.')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la liste'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette liste et tous les mots qu\'elle contient ?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Annuler')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Supprimer', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await isar.writeTxn(() async {
        await liste.mots.load();
        await isar.mots.deleteAll(liste.mots.map((m) => m.idMot).toList());
        await isar.listes.delete(liste.idListe);
      });

      _fetchListes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur de suppression: $e")));
      }
    }
  }

  void _navigateToMotManagement(Liste liste) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MotManagementPage(liste: liste),
      ),
    ).then((_) => _fetchListes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Listes')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listes.length,
              itemBuilder: (context, index) {
                final liste = _listes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/${liste.image}'),
                    ),
                    title: Text(liste.nom),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_note, color: Colors.purple),
                          tooltip: 'Gérer le contenu',
                          onPressed: () => _navigateToMotManagement(liste),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueAccent),
                          tooltip: 'Modifier la liste',
                          onPressed: () => _showFormDialog(liste: liste),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          tooltip: 'Supprimer la liste',
                          onPressed: () => _deleteListe(liste),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        tooltip: 'Ajouter une nouvelle liste',
        child: const Icon(Icons.add),
      ),
    );
  }
}
