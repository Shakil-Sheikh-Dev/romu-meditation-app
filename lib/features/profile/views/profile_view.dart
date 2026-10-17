import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/app/locale_controller.dart';
import 'package:romu/features/profile/viewmodels/account_view_model.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);
    final language = ref.watch(localeProvider).languageCode == 'lt' ? 'Lietuvių' : 'English';
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: AppBackground(
        child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              children: [
                const AppText(
                  'Profile',
                  variant: AppTextVariant.display,
                  color: AppColors.ink,
                  style: TextStyle(fontSize: 40, height: 1.1),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFCFA),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.stroke),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/images/profile/avatar.png'),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(account.name, variant: AppTextVariant.fieldLabel),
                            AppText(account.email, variant: AppTextVariant.caption),
                            const AppText('Member since March 2026', variant: AppTextVariant.caption),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/edit-profile'),
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    _Stat(value: '7', label: 'Day streak'),
                    SizedBox(width: 10),
                    _Stat(value: '428', label: 'Minutes'),
                    SizedBox(width: 10),
                    _Stat(value: '36', label: 'Sessions'),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6E9DF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFECD9C8)),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText('Romù Premium', variant: AppTextVariant.fieldLabel),
                            AppText(
                              'Renews 12 Oct 2026 · €9.99 / month',
                              variant: AppTextVariant.caption,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/manage-subscription'),
                        child: const Text('Manage'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _menu(
                  context,
                  [
                    _Row('Edit profile', onTap: () => context.push('/edit-profile')),
                    _Row('Notifications', trailing: 'On', onTap: () => context.push('/notifications')),
                    _Row('Language', trailing: language, onTap: () => context.push('/language')),
                    _Row('Help & support', onTap: () => context.push('/help')),
                    _Row('Privacy & terms', onTap: () => context.push('/privacy')),
                  ],
                ),
                const SizedBox(height: 12),
                _menu(
                  context,
                  [
                    _Row('Log out', onTap: () => context.go('/')),
                    _Row(
                      'Delete account',
                      danger: true,
                      onTap: () => context.push('/delete-account'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const AppNavBar(current: '/profile'),
        ],
      ),
      ),
    );
  }

  Widget _menu(BuildContext context, List<_Row> rows) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            if (index > 0) const Divider(height: 1, color: Color(0xFFEFEBE5)),
            ListTile(
              title: AppText(
                rows[index].label,
                variant: AppTextVariant.field,
                color: rows[index].danger ? const Color(0xFFC4554B) : AppColors.ink,
              ),
              trailing: rows[index].trailing == null
                  ? const Icon(Icons.chevron_right, color: AppColors.textLight)
                  : AppText(rows[index].trailing!, variant: AppTextVariant.caption),
              onTap: rows[index].onTap,
            ),
          ],
        ],
      ),
    );
  }

}

class _Row {
  const _Row(this.label, {required this.onTap, this.trailing, this.danger = false});

  final String label;
  final String? trailing;
  final bool danger;
  final VoidCallback onTap;
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFCFA),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.stroke),
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
