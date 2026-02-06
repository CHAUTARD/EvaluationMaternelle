import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: const Stack(
        children: [
          Center(
            child: Text('Authentication Page'),
          ),
          DebugPageIdentifier(pageName: 'AuthPage'),
        ],
      ),
    );
  }
}
