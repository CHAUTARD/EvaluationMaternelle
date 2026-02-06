import 'package:flutter/material.dart';
import 'package:myapp/widgets/debug_page_identifier.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Register Page'),
          ),
          DebugPageIdentifier(pageName: 'RegisterPage'),
        ],
      ),
    );
  }
}
