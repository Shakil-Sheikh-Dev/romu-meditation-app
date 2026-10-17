import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/theme/app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      surface: AppColors.surface,
    );

    return ThemeData(
      colorScheme: colorScheme.copyWith(
        primary: AppColors.accent,
        onPrimary: AppColors.surface,
        surface: AppColors.surface,
        onSurface: AppColors.ink,
        surfaceTint: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTypography.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      dividerColor: AppColors.border,
    );
  }
}
