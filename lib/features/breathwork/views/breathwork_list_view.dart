import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';

class BreathPractice {
  const BreathPractice({
    required this.title,
    required this.subtitle,
    required this.pattern,
    required this.patternId,
  });

  final String title;
  final String subtitle;
  final String pattern;
  final String patternId;
}

class BreathworkListView extends StatelessWidget {
  const BreathworkListView({super.key});

  static const practices = <BreathPractice>[
    BreathPractice(
      title: 'Calm down',
      subtitle: 'Settle your nervous system',
      pattern: '4 · 2 · 6',
      patternId: '4-6',
    ),
    BreathPractice(
      title: 'Focus',
      subtitle: 'Sharpen and steady the mind',
      pattern: '4 · 4 · 4 · 4',
      patternId: '4-4-4-4',
    ),
    BreathPractice(
      title: 'Sleep',
      subtitle: 'Wind down towards rest',
      pattern: '4 · 7 · 8',
      patternId: '4-7-8',
    ),
    BreathPractice(
      title: 'Box Breathing',
      subtitle: 'Settle your nervous system',
      pattern: '4 · 4 · 4 · 4',
      patternId: '4-4-4-4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              children: [
                const AppText(
                  'Breathwork',
                  variant: AppTextVariant.display,
                  color: AppColors.ink,
                  style: TextStyle(fontSize: 40, height: 1.1),
                ),
                const SizedBox(height: 8),
                const AppText('Practice', variant: AppTextVariant.link, color: AppColors.ink),
                const SizedBox(height: 12),
                for (final practice in practices)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: const Color(0xFFFDFCFA),
                      borderRadius: BorderRadius.circular(20),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: AppColors.stroke),
                        ),
                        title: AppText(practice.title, variant: AppTextVariant.button, color: AppColors.ink),
                        subtitle: AppText(practice.subtitle, variant: AppTextVariant.caption),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7EFE8),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: AppText(practice.pattern, variant: AppTextVariant.caption),
                        ),
                        onTap: () => context.push(
                          '/breath-setup?title=${Uri.encodeComponent(practice.title)}&pattern=${practice.patternId}',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: const AppNavBar(current: '/breathwork'),
          ),
        ],
      ),
    );
  }
}
