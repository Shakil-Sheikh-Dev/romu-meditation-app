import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/onboarding/models/onboarding_story.dart';
import 'package:romu/features/onboarding/widgets/onboarding_progress.dart';

class OnboardingStoryView extends StatelessWidget {
  const OnboardingStoryView({
    super.key,
    required this.story,
    this.onContinue,
  });

  final OnboardingStory story;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage(story.imageAsset),
              fit: BoxFit.cover,
            ),
            const ColoredBox(color: AppColors.imageScrimStrong),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 46, 16, 28 + bottomInset),
                child: Column(
                  children: [
                    const SizedBox(height: OnboardingProgress.barHeight),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 46),
                            AppText(
                              story.title,
                              variant: AppTextVariant.display,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 18),
                            AppText(
                              story.body,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      label: story.actionLabel,
                      backgroundColor: AppColors.ink,
                      foregroundColor: AppColors.onImage,
                      onPressed: onContinue ?? () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
