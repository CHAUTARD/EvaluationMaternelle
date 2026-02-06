import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/screens/admin/take_photo_screen.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  List<String> _imagePaths = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final imagePaths = manifestMap.keys
          .where((String key) => key.startsWith('assets/images/'))
          .toList(); // Keep the full path

      if (mounted) {
        setState(() {
          _imagePaths = imagePaths;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      // Handle error
    }
  }

  // Correctly handles BuildContext across async gap.
  Future<void> _navigateAndPickImage() async {
    // Navigator.push is async.
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const TakePhotoScreen()));

    // After the await, check if the widget is still mounted.
    if (!mounted) return;

    // If it is, and we have a result, we can safely use the State's context.
    if (result != null) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sélectionner une image')),
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _imagePaths.isEmpty
              ? const Center(
                  child: Text("Aucune image trouvée dans assets/images."),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    final imagePath = _imagePaths[index];
                    final imageName = imagePath.split('/').last;
                    return GestureDetector(
                      onTap: () {
                        // This is synchronous, so it's safe.
                        Navigator.pop(context, imagePath);
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Text(
                              imageName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndPickImage, // Call the safe async method.
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
