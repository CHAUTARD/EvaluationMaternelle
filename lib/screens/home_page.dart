import 'package:flutter/material.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.eleveDashboard),
                  child: const Text('Eleve Dashboard'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.profDashboard),
                  child: const Text('Prof Dashboard'),
                ),
              ],
            ),
          ),
          DebugPageIdentifier(pageName: 'HomePage'),
        ],
      ),
    );
  }
}
