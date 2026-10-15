import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';

class IntentCard extends StatelessWidget {
  const IntentCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String iconAsset;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.ink : AppColors.stroke,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 180),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(iconAsset),
                  const SizedBox(height: 8),
                  AppText(
                    title,
                    variant: AppTextVariant.cardTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    subtitle,
                    variant: AppTextVariant.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
