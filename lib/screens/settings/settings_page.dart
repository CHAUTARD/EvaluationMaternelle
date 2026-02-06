
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/admin/admin_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
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
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Admin Dashboard'),
            subtitle: const Text('Gérer les élèves, niveaux, et listes.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

