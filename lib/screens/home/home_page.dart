// home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart'; // Import ThemeProvider
import '../../models/models.dart';
import '../admin/eleve_management_page.dart';
import '../admin/historique_page.dart';
import '../admin/liste_management_page.dart';
import '../admin/niveau_management_page.dart';
import '../game/matching_game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Dummy data for the game
    final List<Mot> dummyWords = [
      Mot()..mot = 'Lion'..image = 'https://picsum.photos/200',
      Mot()..mot = 'Chat'..image = 'https://picsum.photos/201',
      Mot()..mot = 'Chien'..image = 'https://picsum.photos/202',
      Mot()..mot = 'Tigre'..image = 'https://picsum.photos/203',
      Mot()..mot = 'Loup'..image = 'https://picsum.photos/204',
      Mot()..mot = 'Zèbre'..image = 'https://picsum.photos/205',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('App d\'apprentissage'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Changer le thème',
          ),
          IconButton(
            icon: const Icon(Icons.auto_mode),
            onPressed: () => themeProvider.setSystemTheme(),
            tooltip: 'Thème système',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardItem(
              context,
              icon: Icons.people_alt_rounded,
              label: 'Élèves',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EleveManagementPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              icon: Icons.layers_rounded,
              label: 'Niveaux',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NiveauManagementPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              icon: Icons.list_alt_rounded,
              label: 'Listes',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListeManagementPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              icon: Icons.history_edu_rounded,
              label: 'Historique',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoriquePage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              icon: Icons.sports_esports_rounded,
              label: 'Jeu de correspondance',
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchingGamePage(words: dummyWords)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shadowColor: colorScheme.shadow.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color ?? colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
