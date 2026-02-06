// setting_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/admin/eleve_management_page.dart';
import 'package:myapp/screens/admin/import_students_page.dart';
import 'package:myapp/screens/admin/niveau_management_page.dart';
import 'package:myapp/screens/admin/liste_management_page.dart';
import 'package:myapp/screens/admin/historique_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Thème'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    themeProvider.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
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
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Administration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text("Gestion du contenu de l'application"),
          ),
          _buildAdminMenuItem(
            context,
            icon: Icons.people_alt_rounded,
            title: 'Gérer les Élèves',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EleveManagementPage()),
              );
            },
          ),
          _buildAdminMenuItem(
            context,
            icon: Icons.upload_file_rounded,
            title: 'Importer des Élèves',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ImportStudentsPage()),
              );
            },
          ),
          _buildAdminMenuItem(
            context,
            icon: Icons.layers_rounded,
            title: 'Gérer les Niveaux',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NiveauManagementPage()),
              );
            },
          ),
          _buildAdminMenuItem(
            context,
            icon: Icons.list_alt_rounded,
            title: 'Gérer les Listes',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListeManagementPage()),
              );
            },
          ),
          _buildAdminMenuItem(
            context,
            icon: Icons.history_edu_rounded,
            title: "Consulter l'Historique",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoriquePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdminMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
