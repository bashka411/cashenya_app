import 'package:flutter/material.dart';

class ThemeClass {
  static const int seedColorHex = 0xFFA96BE8;
  static const Color seedColor = Color(seedColorHex);
  static final Map<int, Color> seedColorSwatch = {
    50: seedColor.withOpacity(.1),
    100: seedColor.withOpacity(.2),
    200: seedColor.withOpacity(.3),
    300: seedColor.withOpacity(.4),
    400: seedColor.withOpacity(.5),
    500: seedColor.withOpacity(.6),
    600: seedColor.withOpacity(.7),
    700: seedColor.withOpacity(.8),
    800: seedColor.withOpacity(.9),
    900: seedColor,
  };

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Inter',
    primarySwatch: MaterialColor(seedColorHex, seedColorSwatch),
    primaryColor: const Color(seedColorHex),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: const Color(0xFF141418),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFA96BE8),
      onPrimary: Color(0xFFDEDEDE),
      secondary: Color(0xFF1E2025),
      onSecondary: Color(0xFFDEDEDE),
      error: Color.fromARGB(255, 137, 37, 26),
      onError: Color(0xFFDEDEDE),
      background: Color(0xFF141418),
      onBackground: Color(0xFFBAB2B2),
      surface: Color(0xFF948C8C),
      onSurface: Color(0xFFDEDEDE),
    ),
    datePickerTheme: const DatePickerThemeData(),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBarrierColor: Colors.transparent,
      surfaceTintColor: Color(0xFF1E2025),
      modalBackgroundColor: Color(0xFF1E2025),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Color(0xFF1E2025), width: 3),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll<Color>(
          Color(0xFF141418),
        ),
        surfaceTintColor: const MaterialStatePropertyAll<Color>(
          Color(0xFF1E2025),
        ),
        foregroundColor: const MaterialStatePropertyAll<Color>(
          Color(0xFFDEDEDE),
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.pressed)
                ? const Color(0xFF1E2025)
                : null;
          },
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: const BorderSide(color: Color(0xFF1E2025), width: 3),
          ),
        ),
      ),
    ),
    useMaterial3: true,
  );
}
