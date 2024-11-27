import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.surface
);

final colorScheme = ColorScheme.fromSeed(seedColor: Colors.pink);