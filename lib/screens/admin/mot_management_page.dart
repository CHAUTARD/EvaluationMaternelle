// mot_management_page.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';
import './image_picker_screen.dart'; // Import for image selection

class MotManagementPage extends StatefulWidget {
  final Liste liste;

  const MotManagementPage({super.key, required this.liste});

  @override
  State<MotManagementPage> createState() => _MotManagementPageState();
}

class _MotManagementPageState extends State<MotManagementPage> {
  late Box<Mot> _motsBox;

  @override
  void initState() {
    super.initState();
    _motsBox = HiveService.mots;
  }

  void _showFormDialog({Mot? mot}) {
    final formKey = GlobalKey<FormState>();
    String motText = mot?.word ?? '';
    String imageName = mot?.image ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(mot == null ? 'Ajouter un mot' : 'Modifier le mot'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: motText,
                      decoration: const InputDecoration(
                        labelText: 'Mot ou texte',
                      ),
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Le texte est requis.' : null,
                      onSaved: (value) => motText = value!,
                    ),
                    const SizedBox(height: 20),
                    const Text("Image"),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final selectedImage = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImagePickerScreen(),
                          ),
                        );
                        if (selectedImage != null) {
                          setState(() => imageName = selectedImage);
                        }
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: imageName.isEmpty
                            ? const Center(
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  imageName, // All images are now assets
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Text('Image non trouvée'),
                                      ),
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
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  if (imageName.isEmpty) {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez sélectionner une image.'),
                      ),
                    );
                    return;
                  }

                  if (mot == null) {
                    await _addMot(motText, imageName);
                  } else {
                    await _updateMot(mot, motText, imageName);
                  }
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                }
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addMot(String motText, String imageName) async {
    final newMot = Mot()
      ..idListe = widget.liste.key
      ..word = motText
      ..image = imageName;

    final motKey = await _motsBox.add(newMot);
    widget.liste.motsIds.add(motKey);
    await widget.liste.save();
  }

  Future<void> _updateMot(Mot mot, String motText, String imageName) async {
    mot.word = motText;
    mot.image = imageName;
    await mot.save();
  }

  Future<void> _deleteMot(Mot mot) async {
    widget.liste.motsIds.remove(mot.key);
    await widget.liste.save();
    await mot.delete();
  }

  ImageProvider _buildImageProvider(String imagePath) {
    return AssetImage(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contenu: ${widget.liste.nom}")),
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: _motsBox.listenable(),
            builder: (context, Box<Mot> box, _) {
              final mots = box.values
                  .where((m) => widget.liste.motsIds.contains(m.key))
                  .toList();

              if (mots.isEmpty) {
                return const Center(
                  child: Text(
                    'Cette liste est vide. Ajoutez un mot pour commencer.',
                  ),
                );
              }

              return ListView.builder(
                itemCount: mots.length,
                itemBuilder: (context, index) {
                  final mot = mots[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: _buildImageProvider(mot.image),
                      ),
                      title: Text(mot.word),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () => _showFormDialog(mot: mot),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteMot(mot),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        tooltip: 'Ajouter un mot',
        child: const Icon(Icons.add),
      ),
    );
  }
}
