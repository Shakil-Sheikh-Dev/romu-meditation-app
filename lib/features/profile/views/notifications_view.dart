import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final _enabled = <String, bool>{
    'Daily reminder': true,
    'Streak reminders': true,
    'New sessions added': false,
    'Weekly progress recap': true,
    'Subscription & billing': true,
    'Product news': false,
  };
  final _days = <String, bool>{
    'M': true,
    'T': true,
    'W': true,
    'F': true,
    'S1': false,
    'S2': false,
  };

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Notifications',
      subtitle: 'Choose what Romù can nudge you about',
      children: [
        _switch('Daily reminder', 'A gentle nudge at the same time each day'),
        const SizedBox(height: 8),
        const AppText('Time', variant: AppTextVariant.caption),
        const AppText('21:00', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: [
            for (final entry in _days.entries)
              FilterChip(
                label: Text(entry.key.startsWith('S') ? 'S' : entry.key),
                selected: entry.value,
                onSelected: (value) => setState(() => _days[entry.key] = value),
              ),
          ],
        ),
        const SizedBox(height: 22),
        const AppText('PRACTICE', variant: AppTextVariant.caption),
        _switch('Streak reminders'),
        _switch('New sessions added'),
        _switch('Weekly progress recap'),
        const SizedBox(height: 16),
        const AppText('ACCOUNT', variant: AppTextVariant.caption),
        _switch('Subscription & billing'),
        _switch('Product news'),
        const SizedBox(height: 12),
        const AppText(
          'Romù can only send these if notifications are allowed for the app on your phone.',
          variant: AppTextVariant.caption,
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Open Settings and allow notifications for Romù.')),
            );
          },
          child: const Text('Open system settings'),
        ),
      ],
    );
  }

  Widget _switch(String label, [String? subtitle]) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: AppText(label, variant: AppTextVariant.field),
      subtitle: subtitle == null ? null : AppText(subtitle, variant: AppTextVariant.caption),
      value: _enabled[label] ?? false,
      activeThumbColor: AppColors.ink,
      onChanged: (value) => setState(() => _enabled[label] = value),
    );
  }
}
