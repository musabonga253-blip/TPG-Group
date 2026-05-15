import 'package:flutter/material.dart';
import 'app_colours.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColours.scaffoldBg,

    colorScheme: ColorScheme.light(
      primary: AppColours.primary,
      onPrimary: Colors.white,
      secondary: AppColours.reward,
      onSecondary: AppColours.rewardDark,
      error: AppColours.urgent,
      onError: Colors.white,
      surface: AppColours.surface,
      onSurface: AppColours.onSurface,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColours.surface,
      foregroundColor: AppColours.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColours.divider,
      titleTextStyle: TextStyle(
        color: AppColours.onSurface,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColours.onSurface),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColours.onSurface, fontSize: 16),
      bodyMedium: TextStyle(color: AppColours.onSurface, fontSize: 14),
      titleLarge: TextStyle(
        color: AppColours.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColours.surface,
      indicatorColor: AppColours.primaryLight,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: AppColours.primary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          );
        }
        return TextStyle(color: AppColours.muted, fontSize: 11);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: AppColours.primary);
        }
        return IconThemeData(color: AppColours.muted);
      }),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColours.primary,
        minimumSize: const Size(double.infinity, 48),
        side: const BorderSide(color: AppColours.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColours.primary),
    ),

    /*cardTheme: CardTheme(
      color: AppColours.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColours.divider),
      ),
      margin: const EdgeInsets.only(bottom: 12),
    ),*/
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColours.scaffoldBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColours.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColours.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColours.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColours.urgent),
      ),
      labelStyle: const TextStyle(color: AppColours.muted, fontSize: 14),
      hintStyle: const TextStyle(color: AppColours.muted, fontSize: 14),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColours.primary;
        return Colors.transparent;
      }),
      side: const BorderSide(color: AppColours.divider, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColours.divider,
      thickness: 1,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColours.primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColours.onSurface,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
