import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';

class NiveauListePage extends StatefulWidget {
  final Niveau niveau;

  const NiveauListePage({super.key, required this.niveau});

  @override
  State<NiveauListePage> createState() => _NiveauListePageState();
}

class _NiveauListePageState extends State<NiveauListePage> {
  late Box<Liste> _listesBox;

  @override
  void initState() {
    super.initState();
    _listesBox = HiveService.listes;
  }

  Future<void> _onCheckboxChanged(Liste liste, bool isChecked) async {
    if (isChecked) {
      widget.niveau.listesIds.add(liste.key);
    } else {
      widget.niveau.listesIds.remove(liste.key);
    }
    await widget.niveau.save();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listes pour ${widget.niveau.nom}'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _listesBox.listenable(),
        builder: (context, Box<Liste> box, _) {
          final allListes = box.values.toList()..sort((a,b) => a.nom.compareTo(b.nom));
          return ListView.builder(
            itemCount: allListes.length,
            itemBuilder: (context, index) {
              final liste = allListes[index];
              final isAssociated = widget.niveau.listesIds.contains(liste.key);

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
          );
        },
      ),
    );
  }
}
