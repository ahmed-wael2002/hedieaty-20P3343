import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme{

   static const _appBarTheme =  AppBarTheme(
      elevation: 5,
      foregroundColor: Colors.white,
    );

   static final _fontFamily = GoogleFonts.poppins().fontFamily;

   static final buttonPrimary = ElevatedButton.styleFrom(
     minimumSize: const Size(327, 50),
     elevation: 0,
     shape: const RoundedRectangleBorder(
       borderRadius: BorderRadius.all(
         Radius.circular(8.0),
       ),
     ),
     // backgroundColor: colorScheme.primary, // Use primary color from the ColorScheme
     // foregroundColor: colorScheme.onPrimary, // Text color
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

   static ThemeData lightThemeData(BuildContext context) {
     return ThemeData(
       colorSchemeSeed: Colors.pink, // Generates a ColorScheme
       appBarTheme: _appBarTheme,
       fontFamily: _fontFamily,
       inputDecorationTheme: _inputDecorationTheme,
       elevatedButtonTheme: ElevatedButtonThemeData(style: buttonPrimary),
       useMaterial3: true,
     );
   }

   static ThemeData darkThemeData() {
     return ThemeData(
       colorScheme: ColorScheme.fromSeed(
         seedColor: Colors.pink,
         brightness: Brightness.dark, // Adjust for dark mode
       ),
       appBarTheme: _appBarTheme.copyWith(
         backgroundColor: Colors.black, // Optional: Customize AppBar for dark theme
       ),
       fontFamily: _fontFamily,
       inputDecorationTheme: _inputDecorationTheme.copyWith(
         fillColor: Colors.grey.shade800, // Adjust text field background for dark theme
       ),
       elevatedButtonTheme: ElevatedButtonThemeData(style: buttonPrimary),
       useMaterial3: true,
     );
   }


}