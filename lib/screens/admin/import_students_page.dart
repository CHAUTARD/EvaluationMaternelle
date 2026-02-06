import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:myapp/models/eleve.dart';
import 'package:myapp/models/niveau.dart';
import 'package:uuid/uuid.dart';

class ImportStudentsPage extends StatefulWidget {
  const ImportStudentsPage({super.key});

  @override
  ImportStudentsPageState createState() => ImportStudentsPageState();
}

class ImportStudentsPageState extends State<ImportStudentsPage> {
  Niveau? _selectedNiveau;
  bool _isLoading = false;

  Future<void> _importStudents() async {
    if (_selectedNiveau == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner un niveau.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        final lines = await file.readAsLines(encoding: utf8);
        final elevesBox = Hive.box<Eleve>('eleves');
        const uuid = Uuid();

        for (final line in lines) {
          final name = line.trim();
          if (name.isNotEmpty) {
            final newEleve = Eleve(
              id: uuid.v4(),
              nom: name,
              niveauId: _selectedNiveau!.id,
            );
            await elevesBox.add(newEleve);
          }
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${lines.length} élèves ont été importés avec succès.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'importation: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final niveauxBox = Hive.box<Niveau>('niveaux');

    return Scaffold(
      appBar: AppBar(title: const Text('Importer des Élèves')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<Niveau>(
              initialValue: _selectedNiveau,
              hint: const Text('Sélectionner un niveau'),
              items: niveauxBox.values
                  .map(
                    (niveau) => DropdownMenuItem(
                      value: niveau,
                      child: Text(niveau.nom),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedNiveau = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Niveau',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _importStudents,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Importer depuis un fichier .txt'),
                  ),
          ],
        ),
      ),
    );
  }
}
