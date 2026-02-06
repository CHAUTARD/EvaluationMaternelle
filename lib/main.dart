// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/services/data_initializer.dart';
import 'package:myapp/services/hive_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initialize();
  await DataInitializer.initializeData();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.deepPurple;

    // Define a common TextTheme
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(
        fontSize: 57,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
    );

    // --- Light Theme --- //
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: primarySeedColor,
      brightness: Brightness.light,
    );

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    // --- Dark Theme --- //
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: primarySeedColor,
      brightness: Brightness.dark,
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor:
            darkColorScheme.surface, // A more standard dark AppBar color
        foregroundColor: darkColorScheme.onSurface,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Quiz App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}
