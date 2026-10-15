import 'package:romu/l10n/app_localizations.dart';

class OnboardingStory {
  const OnboardingStory({
    required this.imageAsset,
    required this.title,
    required this.body,
    required this.actionLabel,
  });

  final String imageAsset;
  final String title;
  final String body;
  final String actionLabel;

  static List<OnboardingStory> pages(AppLocalizations l10n) {
    return [
      OnboardingStory(
        imageAsset: 'assets/images/onboarding_story_1.png',
        title: l10n.onboardingStoryTitle,
        body: l10n.onboardingStoryBody,
        actionLabel: l10n.onboardingContinue,
      ),
      OnboardingStory(
        imageAsset: 'assets/images/onboarding_story_2.png',
        title: l10n.onboardingStoryTitle2,
        body: l10n.onboardingStoryBody2,
        actionLabel: l10n.onboardingContinue,
      ),
      OnboardingStory(
        imageAsset: 'assets/images/onboarding_story_3.png',
        title: l10n.onboardingStoryTitle3,
        body: l10n.onboardingStoryBody3,
        actionLabel: l10n.onboardingContinue,
      ),
      OnboardingStory(
        imageAsset: 'assets/images/onboarding_story_4.png',
        title: l10n.onboardingStoryTitle4,
        body: l10n.onboardingStoryBody4,
        actionLabel: l10n.onboardingBegin,
      ),
    ];
  }
}
