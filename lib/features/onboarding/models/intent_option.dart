import 'package:romu/l10n/app_localizations.dart';

class IntentOption {
  const IntentOption({
    required this.id,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final String iconAsset;
  final String title;
  final String subtitle;

  static List<IntentOption> options(AppLocalizations l10n) {
    return [
      IntentOption(
        id: 'anxiety',
        iconAsset: 'assets/images/intent/anxiety.svg',
        title: l10n.intentAnxietyTitle,
        subtitle: l10n.intentAnxietySubtitle,
      ),
      IntentOption(
        id: 'panic',
        iconAsset: 'assets/images/intent/panic.svg',
        title: l10n.intentPanicTitle,
        subtitle: l10n.intentPanicSubtitle,
      ),
      IntentOption(
        id: 'racing-thoughts',
        iconAsset: 'assets/images/intent/racing_thoughts.svg',
        title: l10n.intentRacingTitle,
        subtitle: l10n.intentRacingSubtitle,
      ),
      IntentOption(
        id: 'anger',
        iconAsset: 'assets/images/intent/anger.svg',
        title: l10n.intentAngerTitle,
        subtitle: l10n.intentAngerSubtitle,
      ),
      IntentOption(
        id: 'sleep',
        iconAsset: 'assets/images/intent/sleep.svg',
        title: l10n.intentSleepTitle,
        subtitle: l10n.intentSleepSubtitle,
      ),
      IntentOption(
        id: 'breathwork',
        iconAsset: 'assets/images/intent/breathwork.svg',
        title: l10n.intentBreathworkTitle,
        subtitle: l10n.intentBreathworkSubtitle,
      ),
    ];
  }
}
