import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/l10n/app_localizations.dart';
import 'package:romu/features/breathwork/views/breath_setup_view.dart';

class BreathworkListView extends StatelessWidget {
  const BreathworkListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: AppBackground(
        wash: AppWash.sage,
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                bottom: false,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  children: [
                    AppText(
                      AppLocalizations.of(context).breathworkTitle,
                      variant: AppTextVariant.display,
                      color: AppColors.ink,
                      style: TextStyle(fontSize: 40, height: 1.1),
                    ),
                    const SizedBox(height: 16),
                    const AppText(
                      'Practice',
                      variant: AppTextVariant.link,
                      color: AppColors.ink,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    for (final practice in BreathPractice.all)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _PracticeRow(practice: practice),
                      ),
                  ],
                ),
              ),
            ),
            const AppNavBar(current: '/breathwork'),
          ],
        ),
      ),
    );
  }
}

class _PracticeRow extends StatelessWidget {
  const _PracticeRow({required this.practice});

  final BreathPractice practice;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFDFCFA),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showBreathSetup(context, practice),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFD5D8DE), Color(0xFFAEB4BC)],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(practice.title, variant: AppTextVariant.fieldLabel),
                    const SizedBox(height: 2),
                    AppText(
                      practice.subtitle,
                      variant: AppTextVariant.caption,
                      color: const Color(0xFF7A7671),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEBE5),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: AppText(
                  practice.pattern,
                  variant: AppTextVariant.caption,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
