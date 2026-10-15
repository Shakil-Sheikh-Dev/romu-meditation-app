import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class ManageSubscriptionView extends StatelessWidget {
  const ManageSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Subscription',
      subtitle: 'Your plan, billing and how to change it',
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF6E9DF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Romù Premium', variant: AppTextVariant.fieldLabel),
              AppText('Active', variant: AppTextVariant.caption),
              SizedBox(height: 8),
              AppText('€9.99 / month', variant: AppTextVariant.title),
              AppText('Renews automatically · 12 Oct 2026', variant: AppTextVariant.caption),
              SizedBox(height: 8),
              AppText('Started 12 Mar 2026', variant: AppTextVariant.caption),
              AppText('Billed through App Store', variant: AppTextVariant.caption),
              AppText('Payment method Apple ID', variant: AppTextVariant.caption),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const AppText("What's included", variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 8),
        const _Included('The full meditation library'),
        const _Included('Every breathing exercise'),
        const _Included('New sessions added each week'),
        const _Included('Progress, streaks and history'),
        const SizedBox(height: 18),
        AppButton(
          label: 'Manage in App Store',
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.onImage,
          borderColor: Colors.transparent,
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                content: const Text(
                  'Plan changes and cancellation are handled by Apple or Google. Romù can’t change your plan from inside the app.',
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Purchases restored')),
            );
          },
          child: const Text('Restore purchases'),
        ),
      ],
    );
  }
}

class _Included extends StatelessWidget {
  const _Included(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check, size: 18, color: Color(0xFFC4784A)),
          const SizedBox(width: 8),
          Expanded(child: AppText(label, variant: AppTextVariant.field)),
        ],
      ),
    );
  }
}
