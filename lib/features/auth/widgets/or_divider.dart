import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.stroke, thickness: 1)),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppText(
              label,
              variant: AppTextVariant.link,
              color: AppColors.ink,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.stroke, thickness: 1)),
      ],
    );
  }
}
