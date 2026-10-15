import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_button.dart';
import 'package:romu/l10n/app_localizations.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    super.key,
    this.onGetStarted,
    this.onSignIn,
  });

  final VoidCallback? onGetStarted;
  final VoidCallback? onSignIn;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/welcome_background.png'),
              fit: BoxFit.cover,
            ),
            const ColoredBox(color: AppColors.imageScrim),
            Positioned(
              top: -5,
              left: 0,
              right: 0,
              height: 180,
              child: IgnorePointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.all(Radius.circular(600)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 28 + bottomInset),
              child: Column(
                children: [
                  const Spacer(flex: 36),
                  const FractionallySizedBox(
                    widthFactor: 318 / 410,
                    child: Image(
                      image: AssetImage('assets/images/welcome_logo.png'),
                      fit: BoxFit.contain,
                      semanticLabel: 'Romi Kasdien',
                    ),
                  ),
                  const Spacer(flex: 44),
                  AppButton(
                    label: l10n.welcomeGetStarted,
                    onPressed: onGetStarted ?? () {},
                  ),
                  const SizedBox(height: 14),
                  _SignInPrompt(
                    prompt: l10n.welcomeHaveAccount,
                    action: l10n.welcomeSignIn,
                    onSignIn: onSignIn ?? () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt({
    required this.prompt,
    required this.action,
    required this.onSignIn,
  });

  final String prompt;
  final String action;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppText('$prompt ', variant: AppTextVariant.prompt),
        AppTextButton(label: action, onPressed: onSignIn),
      ],
    );
  }
}
