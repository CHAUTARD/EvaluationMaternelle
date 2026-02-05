import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';
import './niveau_liste_page.dart';

class NiveauManagementPage extends StatefulWidget {
  const NiveauManagementPage({super.key});

  @override
  State<NiveauManagementPage> createState() => _NiveauManagementPageState();
}

class _NiveauManagementPageState extends State<NiveauManagementPage> {
  List<Niveau> _niveaux = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNiveaux();
  }

  Future<void> _fetchNiveaux() async {
    if (!mounted) return;
    try {
      final isar = IsarService.isar;
      final niveaux = await isar.niveaus.where().sortByOrdre().findAll();

      if (mounted) {
        setState(() {
          _niveaux = niveaux;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de chargement des niveaux: $e")),
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
        (_niveaux.isEmpty ? 1 : _niveaux.map((n) => n.ordre).reduce((a, b) => a > b ? a : b) + 1);

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
      final isar = IsarService.isar;
      final newNiveau = Niveau()
        ..nom = nom
        ..couleur = couleur
        ..ordre = ordre;

      await isar.writeTxn(() async {
        await isar.niveaus.put(newNiveau);
      });

      _fetchNiveaux();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur lors de l'ajout: $e")));
      }
    }
  }

  Future<void> _updateNiveau(Niveau niveau, String nom, String couleur, int ordre) async {
    try {
      final isar = IsarService.isar;
      niveau.nom = nom;
      niveau.couleur = couleur;
      niveau.ordre = ordre;

      await isar.writeTxn(() async {
        await isar.niveaus.put(niveau);
      });

      _fetchNiveaux();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur de mise à jour: $e")));
      }
    }
  }

    Future<void> _deleteNiveau(Niveau niveau) async {
    final isar = IsarService.isar;

    // Check for associated students
    final associatedEleves = await isar.eleves.filter().niveau((q) => q.idNiveauEqualTo(niveau.idNiveau)).count();

    if (associatedEleves > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ce niveau est associé à un ou plusieurs élèves et ne peut pas être supprimé.')),
      );
      return;
    }

    // Confirmation dialog
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
      await isar.writeTxn(() async {
        await isar.niveaus.delete(niveau.idNiveau);
      });

      _fetchNiveaux();
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
          : ReorderableListView.builder(
              itemCount: _niveaux.length,
              itemBuilder: (context, index) {
                final niveau = _niveaux[index];
                return ListTile(
                  key: ValueKey(niveau.idNiveau),
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
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = _niveaux.removeAt(oldIndex);
                  _niveaux.insert(newIndex, item);
                });

                final isar = IsarService.isar;
                await isar.writeTxn(() async {
                  for (int i = 0; i < _niveaux.length; i++) {
                    _niveaux[i].ordre = i + 1;
                    await isar.niveaus.put(_niveaux[i]);
                  }
                });

                _fetchNiveaux();
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
