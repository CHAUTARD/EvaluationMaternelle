// niveau_management_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';
import 'package:uuid/uuid.dart';
import './niveau_liste_page.dart';

class NiveauManagementPage extends StatefulWidget {
  const NiveauManagementPage({super.key});

  @override
  State<NiveauManagementPage> createState() => _NiveauManagementPageState();
}

class _NiveauManagementPageState extends State<NiveauManagementPage> {
  final Uuid _uuid = const Uuid();

  void _showFormDialog({Niveau? niveau}) {
    final formKey = GlobalKey<FormState>();
    String nom = niveau?.nom ?? '';
    Color pickerColor = niveau != null ? Color(niveau.couleur) : Colors.blue;
    int ordre = niveau?.ordre ?? (HiveService.niveaux.length + 1);

    void onColorChanged(Color color) {
      setState(() {
        pickerColor = color;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            niveau == null ? 'Ajouter un niveau' : 'Modifier le niveau',
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: nom,
                    decoration: const InputDecoration(
                      labelText: 'Nom du niveau',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Le nom est requis.';
                      }
                      return null;
                    },
                    onSaved: (value) => nom = value!,
                  ),
                  const SizedBox(height: 20),
                  const Text("Couleur du niveau"),
                  const SizedBox(height: 10),
                  ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: onColorChanged,
                    labelTypes: const [],
                    pickerAreaHeightPercent: 0.8,
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
                    _addNiveau(nom, pickerColor.toARGB32(), ordre);
                  } else {
                    _updateNiveau(niveau, nom, pickerColor.toARGB32(), ordre);
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

  void _addNiveau(String nom, int couleur, int ordre) {
    final newNiveau = Niveau(
      id: _uuid.v4(),
      nom: nom,
      couleur: couleur,
      ordre: ordre,
    );
    HiveService.niveaux.put(newNiveau.id, newNiveau);
  }

  void _updateNiveau(Niveau niveau, String nom, int couleur, int ordre) {
    niveau.nom = nom;
    niveau.couleur = couleur;
    niveau.ordre = ordre;
    niveau.save();
  }

  void _deleteNiveau(Niveau niveau) {
    // First, check if any Eleve is associated with this Niveau
    final isNiveauInUse = HiveService.eleves.values.any(
      (eleve) => eleve.niveauId == niveau.id,
    );

    if (isNiveauInUse) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Impossible de supprimer ce niveau car il est utilisé par un ou plusieurs élèves.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmer la suppression'),
            content: const Text(
              'Êtes-vous sûr de vouloir supprimer ce niveau ?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Supprimer',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  niveau.delete();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToNiveauListe(Niveau niveau) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NiveauListePage(niveau: niveau)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Niveaux')),
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: HiveService.niveaux.listenable(),
            builder: (context, Box<Niveau> box, _) {
              final niveaux = box.values.toList()
                ..sort((a, b) => a.ordre.compareTo(b.ordre));
              return ReorderableListView.builder(
                itemCount: niveaux.length,
                itemBuilder: (context, index) {
                  final niveau = niveaux[index];
                  return ListTile(
                    key: ValueKey(niveau.id),
                    leading: CircleAvatar(
                      backgroundColor: Color(niveau.couleur),
                      child: Text(niveau.nom.substring(0, 1)),
                    ),
                    title: Text(niveau.nom),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.list),
                          onPressed: () => _navigateToNiveauListe(niveau),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showFormDialog(niveau: niveau),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNiveau(niveau),
                        ),
                      ],
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = niveaux.removeAt(oldIndex);
                  niveaux.insert(newIndex, item);
                  // Update order in database
                  for (int i = 0; i < niveaux.length; i++) {
                    final niveau = niveaux[i];
                    niveau.ordre = i;
                    niveau.save();
                  }
                },
              );
            },
          ),
          const DebugPageIdentifier(pageName: 'NiveauManagementPage'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
