import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Colors - Clean, light palette
class AppColors {
  // Primary Brand
  static const Color brand = Color(0xFFFE6535);
  static const Color brandLight = Color(0xFFFF8A65);
  
  // Backgrounds - Very light
  static const Color background = Color(0xFFFCFCFC);
  static const Color surface = Color(0xFFFFFFFF);
  
  // Text - Softer contrast
  static const Color foreground = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  
  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFEFF6FF);
  
  // Neutrals
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);
  static const Color input = Color(0xFFF9FAFB);
  
  // Metric colors
  static const Color metricOrange = Color(0xFFFE6535);
  static const Color metricOrangeBg = Color(0xFFFFF7F5);
  static const Color metricGreen = Color(0xFF10B981);
  static const Color metricGreenBg = Color(0xFFF0FDF9);
  static const Color metricPurple = Color(0xFF8B5CF6);
  static const Color metricPurpleBg = Color(0xFFFAF5FF);
  static const Color metricBlue = Color(0xFF3B82F6);
  static const Color metricBlueBg = Color(0xFFF0F7FF);
  
  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFE6535), Color(0xFFFF8A65)],
  );
  
  // Legacy mappings
  static const Color card = surface;
  static const Color cardForeground = foreground;
  static const Color primary = foreground;
  static const Color primaryForeground = surface;
  static const Color secondary = divider;
  static const Color secondaryForeground = foreground;
  static const Color muted = divider;
  static const Color mutedForeground = textSecondary;
  static const Color accent = divider;
  static const Color accentForeground = foreground;
  static const Color destructive = error;
  static const Color destructiveForeground = surface;
  static const Color ring = foreground;
}

/// Typography Scale - Compact & Uniform
class AppTypography {
  static const double h1 = 22;
  static const double h2 = 18;
  static const double h3 = 16;
  static const double body = 14;
  static const double small = 13;
  static const double caption = 12;
  static const double micro = 11;
}

/// Spacing - Compact
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Border Radius
class AppRadius {
  static const double xs = 4;
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 14;
  static const double xl = 20;
  static const double full = 9999;
}

/// Shadows - Subtle
class AppShadows {
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];
  
  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> colored(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.15),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];
}

/// Theme Data
ThemeData getAppTheme() {
  final textTheme = GoogleFonts.interTextTheme();
  
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    textTheme: textTheme.copyWith(
      headlineLarge: textTheme.headlineLarge?.copyWith(
        fontSize: AppTypography.h1,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
        height: 1.3,
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontSize: AppTypography.h2,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
        height: 1.3,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontSize: AppTypography.h3,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontSize: AppTypography.body,
        color: AppColors.foreground,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        fontSize: AppTypography.small,
        color: AppColors.textSecondary,
      ),
      bodySmall: textTheme.bodySmall?.copyWith(
        fontSize: AppTypography.caption,
        color: AppColors.textMuted,
      ),
    ),
    
    colorScheme: const ColorScheme.light(
      primary: AppColors.brand,
      onPrimary: Colors.white,
      secondary: AppColors.foreground,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.foreground,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.border,
    ),
    
    scaffoldBackgroundColor: AppColors.background,
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.foreground,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 52,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontSize: AppTypography.h3,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brand,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: AppTypography.body,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.foreground,
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppTypography.body,
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brand,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: AppTypography.small,
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.input,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
      ),
      hintStyle: const TextStyle(
        color: AppColors.textMuted,
        fontSize: AppTypography.body,
      ),
    ),
    
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.brand,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.brand,
      unselectedItemColor: AppColors.textMuted,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    ),
    
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.divider,
      selectedColor: AppColors.brand,
      labelStyle: const TextStyle(fontSize: AppTypography.caption, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
    ),

    listTileTheme: const ListTileThemeData(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minVerticalPadding: 8,
    ),
  );
}
