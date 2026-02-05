// lib/screens/admin/image_management_page.dart
// Page pour gérer les images stockées dans Firebase Storage.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageManagementPage extends StatefulWidget {
  const ImageManagementPage({super.key});

  @override
  State<ImageManagementPage> createState() => _ImageManagementPageState();
}

class _ImageManagementPageState extends State<ImageManagementPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _imageRefs = [];
  bool _isLoading = true;
  double? _uploadProgress;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  // Charge la liste des images depuis Firebase Storage
  Future<void> _loadImages() async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    try {
      final ListResult result = await _storage.ref('images').listAll();
      final List<Map<String, dynamic>> files = [];

      for (final Reference ref in result.items) {
        final String url = await ref.getDownloadURL();
        files.add({'ref': ref, 'url': url});
      }

      if (mounted) {
        setState(() {
          _imageRefs = files;
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
        SnackBar(content: Text("Erreur de chargement des images: $e")),
      );
    }
  }

  // Sélectionne et téléverse une image
  Future<void> _uploadImage() async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Aucune image sélectionnée.")),
      );
      return;
    }

    final String fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference ref = _storage.ref('images/$fileName');

    try {
      final UploadTask uploadTask = ref.putFile(File(image.path));

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        if (!mounted) return;
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      await uploadTask;

      if (mounted) {
        setState(() {
          _uploadProgress = null;
        });
      }
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text("Image téléversée avec succès !"),
            backgroundColor: Colors.green),
      );
      await _loadImages(); // Rafraîchit la liste
    } catch (e) {
      if (mounted) {
        setState(() {
          _uploadProgress = null;
        });
      }
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Erreur de téléversement: $e")),
      );
    }
  }

  // Supprime une image
  Future<void> _deleteImage(Reference ref) async {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await ref.delete();
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text("Image supprimée."), backgroundColor: Colors.orange),
      );
      await _loadImages(); // Rafraîchit la liste
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Erreur de suppression: $e")),
      );
    }
  }

  // Copie l'URL dans le presse-papiers
  void _copyUrlToClipboard(String url) {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    Clipboard.setData(ClipboardData(text: url));
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("URL de l'image copiée !"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Images")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _imageRefs.isEmpty
              ? const Center(
                  child: Text(
                      "Aucune image trouvée. Appuyez sur '+' pour commencer.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Column(
                children: [
                  if (_uploadProgress != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(value: _uploadProgress, minHeight: 10,),
                    ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: _imageRefs.length,
                        padding: const EdgeInsets.all(4),
                        itemBuilder: (context, index) {
                          final imageMap = _imageRefs[index];
                          final ref = imageMap['ref'] as Reference;
                          final url = imageMap['url'] as String;

                          return GridTile(
                            header: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                ref.name,
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              leading: IconButton(
                                icon: const Icon(Icons.copy, size: 18),
                                onPressed: () => _copyUrlToClipboard(url),
                                tooltip: "Copier l'URL",
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, size: 18, color: Colors.redAccent,),
                                onPressed: () => _deleteImage(ref),
                                tooltip: "Supprimer",
                              ),
                            ),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : const Center(child: CircularProgressIndicator());
                              },
                            ),
                          );
                        },
                      ),
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadImage,
        tooltip: 'Ajouter une image',
        child: const Icon(Icons.add_photo_alternate_outlined),
      ),
    );
  }
}
