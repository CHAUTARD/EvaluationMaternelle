import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Stack(
        children: [
          Center(
            child: Text('Login Page'),
          ),
          DebugPageIdentifier(pageName: 'LoginPage'),
        ],
      ),
    );
  }
}
