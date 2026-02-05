import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';
import './niveau_liste_page.dart';

class NiveauManagementPage extends StatefulWidget {
  const NiveauManagementPage({super.key});

  @override
  State<NiveauManagementPage> createState() => _NiveauManagementPageState();
}

class _NiveauManagementPageState extends State<NiveauManagementPage> {
  late Box<Niveau> _niveauxBox;
  late Box<Eleve> _elevesBox;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    if (!mounted) return;
    try {
      _niveauxBox = HiveService.niveaux;
      _elevesBox = HiveService.eleves;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de chargement des données: $e")),
        );
      }
    }
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
      return Color(int.parse(hexColor, radix: 16));
    }
    return Colors.grey;
  }

  void _showFormDialog({Niveau? niveau}) {
    final formKey = GlobalKey<FormState>();
    String nom = niveau?.nom ?? '';
    String couleur = niveau?.couleur ?? '#4285F4';
    int ordre = niveau?.ordre ??
        (_niveauxBox.isEmpty
            ? 1
            : _niveauxBox.values.map((n) => n.ordre).reduce((a, b) => a > b ? a : b) + 1);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(niveau == null ? 'Ajouter un niveau' : 'Modifier le niveau'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: nom,
                    decoration: const InputDecoration(labelText: 'Nom du niveau'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Le nom est requis.';
                      }
                      return null;
                    },
                    onSaved: (value) => nom = value!,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: couleur,
                          decoration: const InputDecoration(
                              labelText: 'Couleur (ex: #FF0000)'),
                          onChanged: (value) {
                            if (RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value)) {
                              setStateDialog(() {
                                couleur = value;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value)) {
                              return 'Format invalide.';
                            }
                            return null;
                          },
                          onSaved: (value) => couleur = value!,
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        backgroundColor: _getColorFromHex(couleur),
                        radius: 15,
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: ordre.toString(),
                    decoration: const InputDecoration(labelText: 'Ordre'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'L\'ordre doit être un nombre.';
                      }
                      return null;
                    },
                    onSaved: (value) => ordre = int.parse(value!),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (niveau == null) {
                      _addNiveau(nom, couleur, ordre);
                    } else {
                      _updateNiveau(niveau, nom, couleur, ordre);
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text('Enregistrer'),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _addNiveau(String nom, String couleur, int ordre) async {
    try {
      final newNiveau = Niveau()
        ..nom = nom
        ..couleur = couleur
        ..ordre = ordre
        ..listesIds = [];
      await _niveauxBox.add(newNiveau);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur lors de l'ajout: $e")));
      }
    }
  }

  Future<void> _updateNiveau(Niveau niveau, String nom, String couleur, int ordre) async {
    try {
      niveau.nom = nom;
      niveau.couleur = couleur;
      niveau.ordre = ordre;
      await niveau.save();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur de mise à jour: $e")));
      }
    }
  }

    Future<void> _deleteNiveau(Niveau niveau) async {
    final associatedEleves = _elevesBox.values.where((e) => e.niveauId == niveau.key).length;

    if (associatedEleves > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ce niveau est associé à un ou plusieurs élèves et ne peut pas être supprimé.')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le niveau'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce niveau ?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Annuler')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Supprimer', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await niveau.delete();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur de suppression: $e")));
      }
    }
  }

  void _navigateToNiveauListe(Niveau niveau) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NiveauListePage(niveau: niveau),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Niveaux')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
              valueListenable: _niveauxBox.listenable(),
              builder: (context, Box<Niveau> box, _) {
                final niveaux = box.values.toList()..sort((a, b) => a.ordre.compareTo(b.ordre));
                return ReorderableListView.builder(
                  itemCount: niveaux.length,
                  itemBuilder: (context, index) {
                    final niveau = niveaux[index];
                    return ListTile(
                      key: ValueKey(niveau.key),
                      tileColor: index.isEven ? Colors.grey[100] : Colors.white,
                      title: Text(niveau.nom),
                      subtitle: Text('Ordre: ${niveau.ordre}'),
                      leading: CircleAvatar(
                        backgroundColor: _getColorFromHex(niveau.couleur),
                        child: Text((index + 1).toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.list_alt, color: Colors.purple),
                            tooltip: 'Gérer les listes associées',
                            onPressed: () => _navigateToNiveauListe(niveau),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () => _showFormDialog(niveau: niveau),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => _deleteNiveau(niveau),
                          ),
                        ],
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) async {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = niveaux.removeAt(oldIndex);
                    niveaux.insert(newIndex, item);

                    for (int i = 0; i < niveaux.length; i++) {
                      niveaux[i].ordre = i + 1;
                      await niveaux[i].save();
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        tooltip: 'Ajouter un niveau',
        child: const Icon(Icons.add),
      ),
    );
  }
}
