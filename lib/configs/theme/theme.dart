import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const Color defaultColor = Colors.pink; // Default color seed

  // Method to generate a ColorScheme from a given seed color
  static ColorScheme _getColorScheme(Color color, Brightness brightness) {
    return ColorScheme.fromSeed(seedColor: color, brightness: brightness);
  }

  // Method to generate AppBar theme based on ColorScheme
  AppBarTheme _getAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      elevation: 5,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.primary,
    );
  }

  // Google Fonts for consistency
  static final _fontFamily = GoogleFonts.poppins().fontFamily;

  // Primary button style
  static final buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: const Size(327, 50),
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
  );

  // Input Decoration theme
  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade200, // Background for text fields
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  // Method to generate the light theme with dynamic color
  ThemeData lightThemeData(BuildContext context, Color color) {
    final lightColorScheme = _getColorScheme(color, Brightness.light); // Generate light theme color scheme
    return ThemeData(
      colorScheme: lightColorScheme, // Generates a ColorScheme
      appBarTheme: _getAppBarTheme(lightColorScheme),
      scaffoldBackgroundColor: lightColorScheme.surface,
      fontFamily: _fontFamily,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonPrimary),
      useMaterial3: true,
    );
  }

  // Method to generate the dark theme with dynamic color
  ThemeData darkThemeData(Color color) {
    final darkColorScheme = _getColorScheme(color, Brightness.dark); // Generate dark theme color scheme
    return ThemeData(
      colorScheme: darkColorScheme,
      appBarTheme: _getAppBarTheme(darkColorScheme),
      scaffoldBackgroundColor: darkColorScheme.surface,
      fontFamily: _fontFamily,
      inputDecorationTheme: _inputDecorationTheme.copyWith(
        fillColor: Colors.grey.shade800, // Adjust text field background for dark theme
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonPrimary),
      useMaterial3: true,
    );
  }
}
