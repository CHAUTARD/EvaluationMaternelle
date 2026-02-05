import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';
import 'evaluation/word_display_page.dart';
import 'evaluation/image_list_display_page.dart';
import 'package:isar/isar.dart';

class EleveDetailPage extends StatefulWidget {
  final Eleve eleve;

  const EleveDetailPage({super.key, required this.eleve});

  @override
  State<EleveDetailPage> createState() => _EleveDetailPageState();
}

class _EleveDetailPageState extends State<EleveDetailPage> {
  List<Liste> _activites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadActivites();
  }

  Future<void> _loadActivites() async {
    final isar = IsarService.isar;
    await isar.writeTxn(() async {
      await widget.eleve.niveau.load();
    });

    final niveau = widget.eleve.niveau.value;
    if (niveau != null) {
       await isar.writeTxn(() async {
        await niveau.listes.load();
      });
      setState(() {
        _activites = niveau.listes.toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.eleve.prenom)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _activites.isEmpty
              ? const Center(
                  child: Text('Aucune activité trouvée pour ce niveau.'),
                )
              : ListView.builder(
                  itemCount: _activites.length,
                  itemBuilder: (context, index) {
                    final activite = _activites[index];
                    final isImageList = activite.mots.isEmpty;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(activite.image),
                      ),
                      title: Text(activite.nom),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        if (isImageList) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageListDisplayPage(
                                liste: activite,
                                eleve: widget.eleve,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WordDisplayPage(
                                liste: activite,
                                eleve: widget.eleve,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
    );
  }
}
