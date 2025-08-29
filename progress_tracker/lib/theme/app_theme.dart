import 'package:flutter/material.dart';

class AppTheme {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textColor;
  final Color textSecondaryColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;

  const AppTheme({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.textColor,
    required this.textSecondaryColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
  });

  // Predefined pastel themes
  static const AppTheme lavender = AppTheme(
    name: 'Lavender Dreams',
    primaryColor: Color(0xFFE6E6FA),
    secondaryColor: Color(0xFFD8BFD8),
    accentColor: Color(0xFF9370DB),
    backgroundColor: Color(0xFFF8F8FF),
    surfaceColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF2C2C2C),
    textSecondaryColor: Color(0xFF6B6B6B),
    successColor: Color(0xFF98FB98),
    warningColor: Color(0xFFFFE4B5),
    errorColor: Color(0xFFFFB6C1),
  );

  static const AppTheme mint = AppTheme(
    name: 'Mint Fresh',
    primaryColor: Color(0xFFF0FFF0),
    secondaryColor: Color(0xFFE0F2E0),
    accentColor: Color(0xFF90EE90),
    backgroundColor: Color(0xFFFAFFFA),
    surfaceColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF2C2C2C),
    textSecondaryColor: Color(0xFF6B6B6B),
    successColor: Color(0xFF98FB98),
    warningColor: Color(0xFFFFE4B5),
    errorColor: Color(0xFFFFB6C1),
  );

  static const AppTheme peach = AppTheme(
    name: 'Peach Sunset',
    primaryColor: Color(0xFFFFF0F5),
    secondaryColor: Color(0xFFFFE4E1),
    accentColor: Color(0xFFFFB6C1),
    backgroundColor: Color(0xFFFFFAFA),
    surfaceColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF2C2C2C),
    textSecondaryColor: Color(0xFF6B6B6B),
    successColor: Color(0xFF98FB98),
    warningColor: Color(0xFFFFE4B5),
    errorColor: Color(0xFFFFB6C1),
  );

  static const AppTheme sky = AppTheme(
    name: 'Sky Blue',
    primaryColor: Color(0xFFF0F8FF),
    secondaryColor: Color(0xFFE0F0FF),
    accentColor: Color(0xFF87CEEB),
    backgroundColor: Color(0xFFFAFCFF),
    surfaceColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF2C2C2C),
    textSecondaryColor: Color(0xFF6B6B6B),
    successColor: Color(0xFF98FB98),
    warningColor: Color(0xFFFFE4B5),
    errorColor: Color(0xFFFFB6C1),
  );

  static const AppTheme rose = AppTheme(
    name: 'Rose Gold',
    primaryColor: Color(0xFFFFF0F5),
    secondaryColor: Color(0xFFFFE4E1),
    accentColor: Color(0xFFE8B4B8),
    backgroundColor: Color(0xFFFFFAFA),
    surfaceColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF2C2C2C),
    textSecondaryColor: Color(0xFF6B6B6B),
    successColor: Color(0xFF98FB98),
    warningColor: Color(0xFFFFE4B5),
    errorColor: Color(0xFFFFB6C1),
  );

  static const AppTheme sage = AppTheme(
    name: 'Sage Green',
    primaryColor: Color(0xFFF0F8F0),
    secondaryColor: Color(0xFFE0F0E0),
    accentColor: Color(0xFF9DC183),
    backgroundColor: Color(0xFFFAFCFA),
    surfaceColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF2C2C2C),
    textSecondaryColor: Color(0xFF6B6B6B),
    successColor: Color(0xFF98FB98),
    warningColor: Color(0xFFFFE4B5),
    errorColor: Color(0xFFFFB6C1),
  );

  static const List<AppTheme> predefinedThemes = [
    lavender,
    mint,
    peach,
    sky,
    rose,
    sage,
  ];

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'primaryColor': primaryColor.value,
      'secondaryColor': secondaryColor.value,
      'accentColor': accentColor.value,
      'backgroundColor': backgroundColor.value,
      'surfaceColor': surfaceColor.value,
      'textColor': textColor.value,
      'textSecondaryColor': textSecondaryColor.value,
      'successColor': successColor.value,
      'warningColor': warningColor.value,
      'errorColor': errorColor.value,
    };
  }

  // Create from JSON
  factory AppTheme.fromJson(Map<String, dynamic> json) {
    return AppTheme(
      name: json['name'],
      primaryColor: Color(json['primaryColor']),
      secondaryColor: Color(json['secondaryColor']),
      accentColor: Color(json['accentColor']),
      backgroundColor: Color(json['backgroundColor']),
      surfaceColor: Color(json['surfaceColor']),
      textColor: Color(json['textColor']),
      textSecondaryColor: Color(json['textSecondaryColor']),
      successColor: Color(json['successColor']),
      warningColor: Color(json['warningColor']),
      errorColor: Color(json['errorColor']),
    );
  }

  // Create a custom theme
  factory AppTheme.custom({
    required String name,
    required Color primaryColor,
    required Color secondaryColor,
    required Color accentColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? textColor,
    Color? textSecondaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
  }) {
    return AppTheme(
      name: name,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor ?? const Color(0xFFFAFAFA),
      surfaceColor: surfaceColor ?? const Color(0xFFFFFFFF),
      textColor: textColor ?? const Color(0xFF2C2C2C),
      textSecondaryColor: textSecondaryColor ?? const Color(0xFF6B6B6B),
      successColor: successColor ?? const Color(0xFF98FB98),
      warningColor: warningColor ?? const Color(0xFFFFE4B5),
      errorColor: errorColor ?? const Color(0xFFFFB6C1),
    );
  }

  // Get Material ThemeData
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        onPrimary: textColor,
        onSecondary: textColor,
        onSurface: textColor,
        onBackground: textColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: surfaceColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        foregroundColor: surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: secondaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: textColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: textSecondaryColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
