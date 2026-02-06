// lib/screens/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/eleve.dart';
import 'package:myapp/models/niveau.dart';
import 'package:myapp/screens/eleve_detail_page.dart';
import 'package:myapp/screens/settings/settings_page.dart';
import 'package:myapp/services/hive_service.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Niveau> _niveaux = [];
  Map<String, List<Eleve>> _elevesByNiveau = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the boxes to rebuild the UI
    HiveService.niveaux.listenable().addListener(_loadData);
    HiveService.eleves.listenable().addListener(_loadData);
    _loadData(); // Load initial data
  }

  void _updateTabController(int length) {
    if (_tabController?.length != length) {
      _tabController?.dispose(); // Dispose the old one if it exists
      _tabController = TabController(length: length, vsync: this);
    }
  }

  void _loadData() {
    final niveaux = HiveService.niveaux.values.toList();
    final eleves = HiveService.eleves.values.toList();

    // Sort niveaux by their predefined order
    niveaux.sort((a, b) => a.ordre.compareTo(b.ordre));

    _updateTabController(niveaux.length);

    setState(() {
      _niveaux = niveaux;
      _elevesByNiveau = _groupElevesByNiveau(eleves, niveaux);
      _isLoading = false;
    });
  }

  Map<String, List<Eleve>> _groupElevesByNiveau(
    List<Eleve> eleves,
    List<Niveau> niveaux,
  ) {
    final map = <String, List<Eleve>>{};
    for (var niveau in niveaux) {
      map[niveau.id] = eleves
          .where((eleve) => eleve.niveauId == niveau.id)
          .toList();
    }
    return map;
  }

  @override
  void dispose() {
    HiveService.niveaux.listenable().removeListener(_loadData);
    HiveService.eleves.listenable().removeListener(_loadData);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Élèves par niveau'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            tooltip: 'Paramètres',
          ),
        ],
        bottom: _isLoading || _niveaux.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: _niveaux.map((niveau) {
                  return Tab(
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: niveau.color, size: 12),
                        const SizedBox(width: 8),
                        Text(
                          niveau.nom,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: niveau.color, // Use the level's color for the text
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ),
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _niveaux.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucun niveau trouvé.\nAjoutez des niveaux et des élèves dans les paramètres.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: _niveaux.map((niveau) {
                        final eleves = _elevesByNiveau[niveau.id] ?? [];
                        if (eleves.isEmpty) {
                          return const Center(
                            child: Text('Aucun élève dans ce niveau.'),
                          );
                        }
                        return ListView.builder(
                          itemCount: eleves.length,
                          itemBuilder: (context, index) {
                            final eleve = eleves[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: niveau.color,
                                child: Text(
                                  eleve.nom.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(
                                '${eleve.nom} (${niveau.nom})',
                                style: const TextStyle(fontSize: 20),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EleveDetailPage(eleve: eleve),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
          const DebugPageIdentifier(pageName: 'HomePage'),
        ],
      ),
    );
  }
}
