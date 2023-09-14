// import 'package:flutter/material.dart';
// import 'package:food_delivery/config/my_colors.dart';

// ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//     useMaterial3: true,
//     // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
//     scaffoldBackgroundColor: lightBgColor,
//     colorScheme: const ColorScheme(
//         inversePrimary: Colors.red,
//         brightness: Brightness.light,
//         primary: lightBgColor,
//         onPrimary: lightTextColors,
//         secondary: redcolors,
//         onSecondary: whitecolors,
//         error: redcolors,
//         onError: redcolors,
//         background: lightBgColor,
//         onBackground: lightTextColors,
//         surface: lightBgColor,
//         onSurface: lightTextColors,
//         primaryContainer: lightWidgetColor,
//         onPrimaryContainer: lightTextColors,
//         secondaryContainer: lightSecWidgetColor,
//         onSecondaryContainer: lightTextColors));

// ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.blue,
//     useMaterial3: true,
//     scaffoldBackgroundColor: darkBgColor,
//     colorScheme: const ColorScheme(
//         brightness: Brightness.dark,
//         primary: darkBgColor,
//         onPrimary: darkTextColors,
//         secondary: redcolors,
//         onSecondary: whitecolors,
//         error: redcolors,
//         onError: redcolors,
//         background: darkBgColor,
//         onBackground: darkTextColors,
//         surface: darkBgColor,
//         onSurface: darkTextColors,
//         primaryContainer: darkWidgetColor,
//         onPrimaryContainer: darkTextColors,
//         secondaryContainer: darkSecWidgetColor,
//         onSecondaryContainer: darkTextColors));

import 'package:flutter/material.dart';
import 'package:food_delivery/mytheme/my_colors.dart';

class AppTheme {
  static const primaryColor = Color.fromARGB(255, 106, 49, 185);

  static ColorScheme fromBrightnesslight() {
    return ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
        background: whitecolors,
        primaryContainer: lightBgColor,
        secondaryContainer: lightSecWidgetColor,
        onPrimary: blackcolor);
  }

  static ColorScheme fromBrightnessdark() {
    return ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
        background: darkBgColor,
        primaryContainer: darkWidgetColor,
        secondaryContainer: darkSecWidgetColor,
        onPrimary: whitecolors);
  }

  static ThemeData lightTheme() {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: lightWidgetColor,
      )),
      appBarTheme: const AppBarTheme(backgroundColor: lightWidgetColor),
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightnesslight(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: darkWidgetColor,
      )),
      appBarTheme: const AppBarTheme(backgroundColor: darkBgColor),
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightnessdark(),
    );
  }
}
