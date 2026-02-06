import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple script to download Google Fonts and exit.
// This is used to bundle fonts with the application.
void main() {
  if (kDebugMode) {
    print("Downloading fonts...");
  }
  GoogleFonts.config.allowRuntimeFetching = false;
  exit(0);
}
