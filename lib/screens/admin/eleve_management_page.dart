import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';

class EleveManagementPage extends StatefulWidget {
  const EleveManagementPage({super.key});

  @override
  State<EleveManagementPage> createState() => _EleveManagementPageState();
}

class _EleveManagementPageState extends State<EleveManagementPage> {
  List<Eleve> _eleves = [];
  List<Niveau> _niveaux = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final isar = IsarService.isar;
      final eleves = await isar.eleves.where().findAll();
      final niveaux = await isar.niveaus.where().findAll();

      await isar.writeTxn(() async {
        for (var eleve in eleves) {
          await eleve.niveau.load();
        }
      });

      eleves.sort((a, b) => a.prenom.compareTo(b.prenom));

      if(mounted){
        setState(() {
          _eleves = eleves;
          _niveaux = niveaux;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
       scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Erreur de chargement des données: $e")),
      );
    }
  }

  void _showFormDialog({Eleve? eleve}) {
    final formKey = GlobalKey<FormState>();
    String prenom = eleve?.prenom ?? '';
    Niveau? selectedNiveau = eleve?.niveau.value;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(eleve == null ? 'Ajouter un élève' : 'Modifier l\'élève'),
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
                  DropdownButtonFormField<Niveau>(
                    initialValue: selectedNiveau,
                    decoration: const InputDecoration(labelText: 'Niveau'),
                    items: _niveaux.map((n) {
                      return DropdownMenuItem(
                        value: n,
                        child: Text(n.nom),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedNiveau = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Le niveau est requis.';
                      }
                      return null;
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
                      _addEleve(prenom, selectedNiveau!);
                    } else {
                      _updateEleve(eleve, prenom, selectedNiveau!);
                    }
                    navigator.pop();
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

  Future<void> _addEleve(String prenom, Niveau niveau) async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final isar = IsarService.isar;
      final newEleve = Eleve()..prenom = prenom;

      await isar.writeTxn(() async {
        await isar.eleves.put(newEleve);
        newEleve.niveau.value = niveau;
        await newEleve.niveau.save();
      });

      await _fetchData();
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
            SnackBar(content: Text("Erreur lors de l'ajout: $e")));
      }
    }
  }

  Future<void> _updateEleve(
      Eleve eleve, String prenom, Niveau niveau) async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final isar = IsarService.isar;
      eleve.prenom = prenom;
      eleve.niveau.value = niveau;

      await isar.writeTxn(() async {
        await isar.eleves.put(eleve);
        await eleve.niveau.save();
      });

      await _fetchData();
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
            SnackBar(content: Text("Erreur de mise à jour: $e")));
      }
    }
  }

  Future<void> _deleteEleve(int idEleve) async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final isar = IsarService.isar;
      await isar.writeTxn(() async {
        await isar.eleves.delete(idEleve);
      });

      await _fetchData();
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
            SnackBar(content: Text("Erreur de suppression: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Élèves')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _eleves.length,
              itemBuilder: (context, index) {
                final eleve = _eleves[index];
                return ListTile(
                  tileColor: index.isEven ? Colors.grey[200] : null,
                  title: Text(eleve.prenom),
                  subtitle: Text('Niveau: ${eleve.niveau.value?.nom ?? "N/A"}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showFormDialog(eleve: eleve),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteEleve(eleve.idEleve),
                      ),
                    ],
                  ),
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
