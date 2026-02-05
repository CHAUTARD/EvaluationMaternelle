import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';

class NiveauListePage extends StatefulWidget {
  final Niveau niveau;

  const NiveauListePage({super.key, required this.niveau});

  @override
  State<NiveauListePage> createState() => _NiveauListePageState();
}

class _NiveauListePageState extends State<NiveauListePage> {
  List<Liste> _allListes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final isar = IsarService.isar;
      await isar.writeTxn(() async {
        _allListes = await isar.listes.where().sortByNom().findAll();
        await widget.niveau.listes.load();
      });

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de chargement: $e")),
        );
      }
    }
  }

  Future<void> _onCheckboxChanged(Liste liste, bool isChecked) async {
    final isar = IsarService.isar;
    await isar.writeTxn(() async {
      if (isChecked) {
        widget.niveau.listes.add(liste);
      } else {
        widget.niveau.listes.removeWhere((element) => element.idListe == liste.idListe);
      }
      await widget.niveau.listes.save();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listes pour ${widget.niveau.nom}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _allListes.length,
              itemBuilder: (context, index) {
                final liste = _allListes[index];
                final isAssociated = widget.niveau.listes.any((l) => l.idListe == liste.idListe);

                return CheckboxListTile(
                  title: Text(liste.nom),
                  value: isAssociated,
                  onChanged: (bool? value) {
                    if (value != null) {
                      _onCheckboxChanged(liste, value);
                    }
                  },
                  secondary: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/${liste.image}'),
                  ),
                );
              },
            ),
    );
  }
}
