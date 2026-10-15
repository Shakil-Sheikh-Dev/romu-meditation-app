import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_typography.dart';

enum AppTextVariant {
  display,
  headline,
  title,
  body,
  button,
  prompt,
  promptEmphasis,
  cardTitle,
  caption,
  link,
  fieldLabel,
  field,
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.style,
  });

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: _styleFor(variant).copyWith(color: color).merge(style),
    );
  }

  static TextStyle _styleFor(AppTextVariant variant) {
    return switch (variant) {
      AppTextVariant.display => AppTypography.display,
      AppTextVariant.headline => AppTypography.headline,
      AppTextVariant.title => AppTypography.title,
      AppTextVariant.body => AppTypography.body,
      AppTextVariant.button => AppTypography.button,
      AppTextVariant.prompt => AppTypography.prompt,
      AppTextVariant.promptEmphasis => AppTypography.promptEmphasis,
      AppTextVariant.cardTitle => AppTypography.cardTitle,
      AppTextVariant.caption => AppTypography.caption,
      AppTextVariant.link => AppTypography.link,
      AppTextVariant.fieldLabel => AppTypography.fieldLabel,
      AppTextVariant.field => AppTypography.field,
    };
  }
}
