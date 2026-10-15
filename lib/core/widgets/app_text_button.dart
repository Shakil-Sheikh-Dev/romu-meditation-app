import 'package:flutter/material.dart';
import 'package:romu/core/widgets/app_text.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppTextVariant.promptEmphasis,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppTextVariant variant;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: AppText(label, variant: variant, color: color),
    );
  }
}
