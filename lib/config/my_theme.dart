import 'package:flutter/material.dart';
import 'package:food_delivery/config/my_colors.dart';

ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.red))),
    brightness: Brightness.light,
    // primarySwatch: Colors.blue,
    useMaterial3: true,
    scaffoldBackgroundColor: lightBgColor,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: lightBgColor,
        onPrimary: lightTextColors,
        secondary: redcolors,
        onSecondary: whitecolors,
        error: redcolors,
        onError: redcolors,
        background: lightBgColor,
        onBackground: lightTextColors,
        surface: lightBgColor,
        onSurface: lightTextColors,
        primaryContainer: lightWidgetColor,
        onPrimaryContainer: lightTextColors,
        secondaryContainer: lightSecWidgetColor,
        onSecondaryContainer: lightTextColors));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // primarySwatch: Colors.blue,
    useMaterial3: true,
    scaffoldBackgroundColor: darkBgColor,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: darkBgColor,
        onPrimary: darkTextColors,
        secondary: redcolors,
        onSecondary: whitecolors,
        error: redcolors,
        onError: redcolors,
        background: darkBgColor,
        onBackground: darkTextColors,
        surface: darkBgColor,
        onSurface: darkTextColors,
        primaryContainer: darkWidgetColor,
        onPrimaryContainer: darkTextColors,
        secondaryContainer: darkSecWidgetColor,
        onSecondaryContainer: darkTextColors));
