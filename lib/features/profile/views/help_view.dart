import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_field.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final _query = TextEditingController();
  var _open = 0;

  static const _articles = <(String, String)>[
    (
      'Audio stops when I lock my phone',
      'Romù keeps playing in the background and on the lock screen. If it cuts out, check that background activity is allowed for Romù and that Low Power Mode is off.',
    ),
    (
      'Why did my streak reset?',
      'A streak continues when you finish at least one session in a day. Missing a day starts the count again. Your best streak stays on your profile.',
    ),
    (
      'How do I change or cancel my plan?',
      'Premium is billed by the App Store or Google Play. Open Manage subscription, then change or cancel the plan in the store. Romù cannot change the charge from inside the app.',
    ),
    (
      'How do I delete my account?',
      'Profile, then Delete account. Type DELETE to confirm. Deleting the account does not cancel a store subscription.',
    ),
    (
      'I’m not getting notifications',
      'Turn the reminder on in Notifications, and allow notifications for Romù in your phone settings.',
    ),
  ];

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.text.trim().toLowerCase();
    final articles = [
      for (final article in _articles)
        if (query.isEmpty ||
            article.$1.toLowerCase().contains(query) ||
            article.$2.toLowerCase().contains(query))
          article,
    ];

    return SettingsPage(
      title: 'Help & support',
      subtitle: 'Answers first — a human if you still need one',
      children: [
        AppTextField(
          controller: _query,
          hint: 'Search help',
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        for (var index = 0; index < articles.length; index++)
          _article(articles[index].$1, articles[index].$2, index),
        const SizedBox(height: 8),
        const AppText('Already bought Premium?', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 6),
        const AppText(
          'Sign in with the same Apple ID or Google account you bought it with, then restore.',
          variant: AppTextVariant.field,
        ),
        TextButton(
          onPressed: () => context.push('/manage-subscription'),
          child: const Text('Restore purchases'),
        ),
        const AppText('Email support', variant: AppTextVariant.fieldLabel),
        const AppText(
          'hello@romu.app · replies within one working day',
          variant: AppTextVariant.caption,
        ),
      ],
    );
  }

  Widget _article(String title, String body, int index) {
    final open = _open == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => setState(() => _open = open ? -1 : index),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title, variant: AppTextVariant.fieldLabel),
                if (open) ...[
                  const SizedBox(height: 8),
                  AppText(body, variant: AppTextVariant.field),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
