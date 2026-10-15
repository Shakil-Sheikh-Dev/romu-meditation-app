import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';

abstract final class AppTypography {
  static const instrumentSans = 'Instrument Sans';
  static const instrumentSerif = 'Instrument Serif';
  static const jost = 'Jost';

  static const cormorantGaramond = 'Cormorant Garamond';

  static const display = TextStyle(
    fontFamily: instrumentSerif,
    fontSize: 50,
    height: 48 / 50,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const headline = TextStyle(
    fontFamily: instrumentSerif,
    fontSize: 44,
    height: 41 / 44,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: Colors.white,
  );

  static const title = TextStyle(
    fontFamily: jost,
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const body = TextStyle(
    fontFamily: jost,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.09,
    color: Colors.white,
  );

  static const button = TextStyle(
    fontFamily: instrumentSans,
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static const prompt = TextStyle(
    fontFamily: jost,
    fontSize: 20,
    height: 30 / 20,
    fontWeight: FontWeight.w500,
    color: AppColors.onImage,
  );

  static const promptEmphasis = TextStyle(
    fontFamily: jost,
    fontSize: 20,
    height: 30 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onImage,
  );

  static const cardTitle = TextStyle(
    fontFamily: cormorantGaramond,
    fontSize: 22,
    height: 24 / 22,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const caption = TextStyle(
    fontFamily: jost,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: AppColors.muted,
  );

  static const link = TextStyle(
    fontFamily: jost,
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w500,
    color: AppColors.onImage,
  );

  static const fieldLabel = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const field = TextStyle(
    fontFamily: jost,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
  );

  static TextTheme get textTheme {
    return const TextTheme(
      headlineMedium: title,
      bodyLarge: field,
      labelLarge: button,
    );
  }
}
