import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/theme/app_typography.dart';
import 'package:romu/core/widgets/app_button.dart';
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
              padding: EdgeInsets.fromLTRB(32, 0, 32, 28 + bottomInset),
              child: Column(
                children: [
                  const Spacer(flex: 36),
                  const SizedBox(
                    width: 180,
                    child: Image(
                      image: AssetImage('assets/images/welcome_logo.png'),
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      semanticLabel: 'Romi Kasdien',
                    ),
                  ),
                  const Spacer(flex: 44),
                  Align(
                    child: SizedBox(
                      width: 160,
                      child: AppButton(
                        label: l10n.welcomeGetStarted,
                        onPressed: onGetStarted ?? () {},
                      ),
                    ),
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

class _SignInPrompt extends StatefulWidget {
  const _SignInPrompt({
    required this.prompt,
    required this.action,
    required this.onSignIn,
  });

  final String prompt;
  final String action;
  final VoidCallback onSignIn;

  @override
  State<_SignInPrompt> createState() => _SignInPromptState();
}

class _SignInPromptState extends State<_SignInPrompt> {
  late final TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = () => widget.onSignIn();
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text.rich(
        TextSpan(
          text: '${widget.prompt} ',
          style: AppTypography.prompt.copyWith(fontSize: 16),
          children: [
            TextSpan(
              text: widget.action,
              style: AppTypography.promptEmphasis.copyWith(fontSize: 16),
              recognizer: _tapRecognizer,
            ),
          ],
        ),
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
      ),
    );
  }
}
