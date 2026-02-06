import 'package:flutter/material.dart';
import 'eleve_management_page.dart';
import 'historique_page.dart';
import 'liste_management_page.dart';
import 'niveau_management_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
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
                  MaterialPageRoute(
                    builder: (context) => const EleveManagementPage(),
                  ),
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
                  MaterialPageRoute(
                    builder: (context) => const NiveauManagementPage(),
                  ),
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
                  MaterialPageRoute(
                    builder: (context) => const ListeManagementPage(),
                  ),
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
                  MaterialPageRoute(
                    builder: (context) => const HistoriquePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shadowColor: colorScheme.shadow.withAlpha(102),
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
