import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';

class BreathCompleteView extends StatelessWidget {
  const BreathCompleteView({
    super.key,
    required this.title,
    required this.patternId,
    required this.minutes,
    required this.cycles,
  });

  final String title;
  final String patternId;
  final int minutes;
  final int cycles;

  String get _patternLabel => switch (patternId) {
    '4-7-8' => '4-7-8',
    '4-6' => '4-2-6',
    _ => '4-4-4-4',
  };

  @override
  Widget build(BuildContext context) {
    final steps = switch (patternId) {
      '4-7-8' => const ['Inhale 4', 'Hold 7', 'Exhale 8'],
      '4-6' => const ['Inhale 4', 'Hold 2', 'Exhale 6'],
      _ => const ['Inhale 4', 'Hold 4', 'Exhale 4', 'Hold 4'],
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF4F0EB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => context.go('/breathwork'),
                icon: const Icon(Icons.close),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: Icon(Icons.check, color: Color(0xFF6E8B74), size: 32),
              ),
            ),
            const SizedBox(height: 24),
            const AppText(
              'Steady again',
              variant: AppTextVariant.display,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 8),
            AppText(
              '$title · $_patternLabel · $minutes minutes',
              variant: AppTextVariant.field,
              color: AppColors.muted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _Stat('$minutes', minutes == 1 ? 'minute' : 'minutes'),
                const SizedBox(width: 8),
                _Stat('$cycles', 'cycles'),
                const SizedBox(width: 8),
                const _Stat('8', 'day streak'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('PATTERN YOU BREATHED', variant: AppTextVariant.caption),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final step in steps)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7EFE8),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: AppText(step, variant: AppTextVariant.caption),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppText(
                    '$cycles cycles completed · no pauses',
                    variant: AppTextVariant.field,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              label: 'Do it again',
              onPressed: () => context.push(
                '/breath-start?title=${Uri.encodeComponent(title)}&pattern=$patternId&minutes=$minutes',
              ),
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Done',
              backgroundColor: AppColors.ink,
              foregroundColor: AppColors.onImage,
              borderColor: Colors.transparent,
              onPressed: () => context.go('/breathwork'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            AppText(value, variant: AppTextVariant.title, textAlign: TextAlign.center),
            AppText(label, variant: AppTextVariant.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
