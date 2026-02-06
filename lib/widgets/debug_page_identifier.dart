// debug_page_identification.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DebugPageIdentifier extends StatelessWidget {
  final String pageName;

  const DebugPageIdentifier({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: Colors.black.withAlpha(128),
        child: Text(
          pageName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
