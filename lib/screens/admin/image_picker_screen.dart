import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          .map((key) => key.split('/').last)
          .toList();

      setState(() {
        _imagePaths = imagePaths;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionner une image'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _imagePaths.isEmpty
              ? const Center(child: Text("Aucune image trouvée dans assets/images."))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    final imageName = _imagePaths[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, imageName);
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
                          child: Image.asset(
                            'assets/images/$imageName',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
