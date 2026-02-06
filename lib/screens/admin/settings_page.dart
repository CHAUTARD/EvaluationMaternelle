import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Stack(
        children: [
          Center(
            child: Text('Settings Page'),
          ),
          DebugPageIdentifier(pageName: 'SettingsPage'),
        ],
      ),
    );
  }
}
