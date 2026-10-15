import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: AppColors.ink,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => context.pop(),
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppText(
              title,
              variant: AppTextVariant.display,
              color: AppColors.ink,
              style: const TextStyle(fontSize: 36, height: 1.1),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              AppText(subtitle!, variant: AppTextVariant.field, color: AppColors.muted),
            ],
            const SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}
