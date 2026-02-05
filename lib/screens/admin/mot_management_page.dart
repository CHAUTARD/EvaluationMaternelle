// mot_management_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';
import './image_picker_screen.dart'; // Import for image selection

class MotManagementPage extends StatefulWidget {
  final Liste liste;

  const MotManagementPage({super.key, required this.liste});

  @override
  State<MotManagementPage> createState() => _MotManagementPageState();
}

class _MotManagementPageState extends State<MotManagementPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMots();
  }

  Future<void> _loadMots() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    final isar = IsarService.isar;
    await isar.writeTxn(() async {
      await widget.liste.mots.load();
    });
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showFormDialog({Mot? mot}) {
    final formKey = GlobalKey<FormState>();
    String motText = mot?.word ?? '';
    String imageName = mot?.image ?? '';

    showDialog(
      context: context,
      builder: (context) {
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
                      decoration: const InputDecoration(labelText: 'Mot ou texte'),
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Le texte est requis.' : null,
                      onSaved: (value) => motText = value!,
                    ),
                    const SizedBox(height: 20),
                    const Text("Image"),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        final selectedImage = await navigator.push<String>(
                          MaterialPageRoute(
                              builder: (context) => const ImagePickerScreen()),
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
                                child: Icon(Icons.add_photo_alternate,
                                    size: 40, color: Colors.grey))
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
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);

                  if (imageName.isEmpty) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Veuillez sélectionner une image.')),
                    );
                    return;
                  }
                  if (mot == null) {
                    _addMot(motText, imageName);
                  } else {
                    _updateMot(mot, motText, imageName);
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
  }

  Future<void> _addMot(String motText, String imageName) async {
    final isar = IsarService.isar;
    final newMot = Mot(
      idListe: widget.liste.idListe,
      word: motText,
      image: imageName,
    );

    await isar.writeTxn(() async {
      await isar.mots.put(newMot);
      widget.liste.mots.add(newMot);
      await widget.liste.mots.save();
    });
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _updateMot(Mot mot, String motText, String imageName) async {
    final isar = IsarService.isar;
    mot.word = motText;
    mot.image = imageName;
    await isar.writeTxn(() async {
      await isar.mots.put(mot);
    });
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteMot(Mot mot) async {
    final isar = IsarService.isar;
    await isar.writeTxn(() async {
      widget.liste.mots.remove(mot);
      await widget.liste.mots.save();
      await isar.mots.delete(mot.idMot);
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contenu: ${widget.liste.nom}"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.liste.mots.isEmpty
              ? const Center(
                  child: Text(
                      'Cette liste est vide. Ajoutez un mot pour commencer.'))
              : ListView.builder(
                  itemCount: widget.liste.mots.length,
                  itemBuilder: (context, index) {
                    final mot = widget.liste.mots.elementAt(index);
                    return Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/${mot.image}'),
                        ),
                        title: Text(mot.word),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () => _showFormDialog(mot: mot),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.redAccent),
                              onPressed: () => _deleteMot(mot),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        tooltip: 'Ajouter un mot',
        child: const Icon(Icons.add),
      ),
    );
  }
}
