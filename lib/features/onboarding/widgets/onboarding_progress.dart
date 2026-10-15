import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';

class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({
    super.key,
    required this.count,
    required this.page,
  });

  final int count;
  final double page;

  static const barWidth = 38.0;
  static const barHeight = 3.0;
  static const gap = 2.0;

  @override
  Widget build(BuildContext context) {
    final position = page.clamp(0, count - 1).toDouble();

    return SizedBox(
      width: count * barWidth + (count - 1) * gap,
      height: barHeight,
      child: Stack(
        children: [
          Row(
            children: [
              for (var index = 0; index < count; index++) ...[
                if (index > 0) const SizedBox(width: gap),
                Container(
                  width: barWidth,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: AppColors.progressInactive,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ],
            ],
          ),
          Positioned(
            left: position * (barWidth + gap),
            child: Container(
              width: barWidth,
              height: barHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
