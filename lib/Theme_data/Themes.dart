import 'package:flutter/material.dart';

// Light theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  hintColor: Colors.indigo, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange).copyWith(background: Colors.black),
  // Add more properties as needed
);

// Dark theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: Colors.indigo, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange).copyWith(background: Colors.black),
  // Add more properties as needed
);
