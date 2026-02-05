// eleve_management_page.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';

class EleveManagementPage extends StatefulWidget {
  const EleveManagementPage({super.key});

  @override
  State<EleveManagementPage> createState() => _EleveManagementPageState();
}

class _EleveManagementPageState extends State<EleveManagementPage> {
  late Box<Eleve> _elevesBox;
  late Box<Niveau> _niveauxBox;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    if (!mounted) return;
    try {
      _elevesBox = HiveService.eleves;
      _niveauxBox = HiveService.niveaux;
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

  void _showFormDialog({Eleve? eleve}) {
    final formKey = GlobalKey<FormState>();
    String prenom = eleve?.prenom ?? '';
    int? selectedNiveauId = eleve?.niveauId;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                eleve == null ? 'Ajouter un élève' : 'Modifier l\'élève',
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: prenom,
                      decoration: const InputDecoration(labelText: 'Prénom'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Le prénom est requis.';
                        }
                        return null;
                      },
                      onSaved: (value) => prenom = value!,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _niveauxBox.listenable(),
                      builder: (context, Box<Niveau> box, _) {
                        return DropdownButtonFormField<int>(
                          initialValue: selectedNiveauId,
                          decoration: const InputDecoration(
                            labelText: 'Niveau',
                          ),
                          items: box.values.map((n) {
                            return DropdownMenuItem(
                              value: n.key as int,
                              child: Text(n.nom),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedNiveauId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Le niveau est requis.';
                            }
                            return null;
                          },
                        );
                      },
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
                    final navigator = Navigator.of(context);
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (eleve == null) {
                        _addEleve(prenom, selectedNiveauId!);
                      } else {
                        _updateEleve(eleve, prenom, selectedNiveauId!);
                      }
                      navigator.pop();
                    }
                  },
                  child: const Text('Enregistrer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _addEleve(String prenom, int niveauId) async {
    if (!mounted) return;
    try {
      final newEleve = Eleve()
        ..prenom = prenom
        ..niveauId = niveauId;
      await _elevesBox.add(newEleve);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur lors de l'ajout: $e")));
      }
    }
  }

  Future<void> _updateEleve(Eleve eleve, String prenom, int niveauId) async {
    if (!mounted) return;
    try {
      eleve.prenom = prenom;
      eleve.niveauId = niveauId;
      await eleve.save();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur de mise à jour: $e")));
      }
    }
  }

  Future<void> _deleteEleve(int key) async {
    if (!mounted) return;
    try {
      await _elevesBox.delete(key);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur de suppression: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Élèves')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
              valueListenable: _elevesBox.listenable(),
              builder: (context, Box<Eleve> box, _) {
                final eleves = box.values.toList()
                  ..sort((a, b) => a.prenom.compareTo(b.prenom));
                return ListView.builder(
                  itemCount: eleves.length,
                  itemBuilder: (context, index) {
                    final eleve = eleves[index];
                    final niveau = _niveauxBox.get(eleve.niveauId);
                    return ListTile(
                      tileColor: index.isEven ? Colors.grey[200] : null,
                      title: Text(eleve.prenom),
                      subtitle: Text('Niveau: ${niveau?.nom ?? "N/A"}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showFormDialog(eleve: eleve),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEleve(eleve.key as int),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        tooltip: 'Ajouter un élève',
        child: const Icon(Icons.add),
      ),
    );
  }
}
