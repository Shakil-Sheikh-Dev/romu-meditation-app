import 'package:flutter/material.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Privacy & terms',
      subtitle: 'Last updated 14 March 2026',
      children: const [
        _Block(
          title: 'What we collect',
          body:
              'Your name and email when you create an account, and which sessions you play so streaks and history work. That is all — no location, no contacts, no device fingerprinting.',
        ),
        _Block(
          title: 'What we never do',
          body:
              'We do not sell your data, track you across other apps, or share what you listen to with advertisers. Romù has no third-party ad SDKs.',
        ),
        _Block(
          title: 'Where it is stored',
          body:
              'Account data sits on servers inside the EU. Audio is streamed from a CDN. Your listening history stays with your account and is never attached to an ad profile.',
        ),
        _Block(
          title: 'Your rights',
          body:
              'You can see, export or erase everything from Profile → Delete account. Deletion is immediate and permanent, and we keep only what tax law requires about payments.',
        ),
        _Block(
          title: 'Questions',
          body: 'Write to privacy@romu.app and a person will answer within one working day.',
        ),
        AppText('Download as PDF', variant: AppTextVariant.fieldLabel),
        AppText('PDF · 84 KB', variant: AppTextVariant.caption),
      ],
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, variant: AppTextVariant.fieldLabel),
          const SizedBox(height: 6),
          AppText(body, variant: AppTextVariant.field),
        ],
      ),
    );
  }
}
