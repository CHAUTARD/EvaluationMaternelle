import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';
import 'package:uuid/uuid.dart';

class EleveManagementPage extends StatefulWidget {
  const EleveManagementPage({super.key});

  @override
  State<EleveManagementPage> createState() => _EleveManagementPageState();
}

class _EleveManagementPageState extends State<EleveManagementPage> {
  final Uuid _uuid = const Uuid();

  void _showFormDialog({Eleve? eleve}) {
    final formKey = GlobalKey<FormState>();
    String nom = eleve?.nom ?? '';
    String? selectedNiveauId = eleve?.niveauId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(eleve == null ? 'Ajouter un élève' : 'Modifier l\'élève'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: nom,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Le nom est requis.';
                    }
                    return null;
                  },
                  onSaved: (value) => nom = value!,
                ),
                ValueListenableBuilder(
                  valueListenable: HiveService.niveaux.listenable(),
                  builder: (context, Box<Niveau> box, _) {
                    final niveaux = box.values.toList();
                    return DropdownButtonFormField<String>(
                      initialValue: selectedNiveauId,
                      decoration: const InputDecoration(labelText: 'Niveau'),
                      items: niveaux.map((n) {
                        return DropdownMenuItem(
                          value: n.id,
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
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (eleve == null) {
                    _addEleve(nom, selectedNiveauId!);
                  } else {
                    _updateEleve(eleve, nom, selectedNiveauId!);
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

  void _addEleve(String nom, String niveauId) {
    final newEleve = Eleve(id: _uuid.v4(), nom: nom, niveauId: niveauId);
    HiveService.eleves.put(newEleve.id, newEleve);
  }

  void _updateEleve(Eleve eleve, String nom, String niveauId) {
    eleve.nom = nom;
    eleve.niveauId = niveauId;
    eleve.save();
  }

  void _deleteEleve(String id) {
    HiveService.eleves.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Élèves')),
      body: ValueListenableBuilder(
        valueListenable: HiveService.eleves.listenable(),
        builder: (context, Box<Eleve> box, _) {
          final eleves = box.values.toList()
            ..sort((a, b) => a.nom.compareTo(b.nom));
          return ListView.builder(
            itemCount: eleves.length,
            itemBuilder: (context, index) {
              final eleve = eleves[index];
              final niveau = HiveService.niveaux.get(eleve.niveauId);
              return ListTile(
                title: Text(eleve.nom),
                subtitle: Text('Niveau: ${niveau?.nom ?? "N/A"}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showFormDialog(eleve: eleve),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteEleve(eleve.id),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
