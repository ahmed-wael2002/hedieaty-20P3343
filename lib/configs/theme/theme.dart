import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme{
  static const colorSeed = Colors.pink;

  static final _lightColorScheme = ColorScheme.fromSeed(seedColor: colorSeed, brightness: Brightness.light);
  static final _darkColorScheme = ColorScheme.fromSeed(seedColor: colorSeed, brightness: Brightness.dark);

   AppBarTheme _getAppBarTheme (ColorScheme colorScheme){
     return AppBarTheme(
       elevation: 5,
       backgroundColor: colorScheme.surface,
       foregroundColor: colorScheme.primary,
     );
   }

   static final _fontFamily = GoogleFonts.poppins().fontFamily;

   static final buttonPrimary = ElevatedButton.styleFrom(
     minimumSize: const Size(327, 50),
     elevation: 0,
     shape: const RoundedRectangleBorder(
       borderRadius: BorderRadius.all(
         Radius.circular(8.0),
       ),
     ),
   );

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
     // labelStyle: TextStyle(color: colorScheme.onSurface),
     floatingLabelBehavior: FloatingLabelBehavior.never,
     // hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
   );

   ThemeData lightThemeData(BuildContext context) {
     return ThemeData(
       colorScheme: _lightColorScheme, // Generates a ColorScheme
       appBarTheme: _getAppBarTheme(_lightColorScheme),
       scaffoldBackgroundColor: _lightColorScheme.surface,
       fontFamily: _fontFamily,
       inputDecorationTheme: _inputDecorationTheme,
       elevatedButtonTheme: ElevatedButtonThemeData(style: buttonPrimary),
       useMaterial3: true,
     );
   }

   ThemeData darkThemeData() {
     return ThemeData(
       colorScheme: ColorScheme.fromSeed(
         seedColor: colorSeed,
         brightness: Brightness.dark, // Adjust for dark mode
       ),
       appBarTheme: _getAppBarTheme(_darkColorScheme).copyWith(
         backgroundColor: Colors.black, // Optional: Customize AppBar for dark theme
       ),
       fontFamily: _fontFamily,
       inputDecorationTheme: _inputDecorationTheme.copyWith(
         fillColor: Colors.grey.shade800, // Adjust text field background for dark theme
       ),
       elevatedButtonTheme: ElevatedButtonThemeData(style: buttonPrimary),
       scaffoldBackgroundColor: _darkColorScheme.surface,
       useMaterial3: true,
     );
   }


}