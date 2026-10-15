import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/theme/app_typography.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/auth/widgets/auth_icon.dart';
import 'package:romu/features/auth/widgets/legal_notice.dart';
import 'package:romu/features/auth/widgets/or_divider.dart';
import 'package:romu/l10n/app_localizations.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/auth/signup_background.png'),
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14, 24, 14, 24 + bottomInset),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/auth/logo_dark.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppText(
                      l10n.signUpTitle,
                      variant: AppTextVariant.display,
                      color: AppColors.ink,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 48, height: 1.05, letterSpacing: -1.5),
                    ),
                    const SizedBox(height: 8),
                    AppText(
                      l10n.signUpBody,
                      variant: AppTextVariant.prompt,
                      color: AppColors.muted,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      label: l10n.continueApple,
                      backgroundColor: AppColors.ink,
                      foregroundColor: AppColors.onImage,
                      borderColor: Colors.transparent,
                      leading: const AuthIcon('assets/images/auth/apple.svg'),
                      onPressed: null,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: l10n.continueGoogle,
                      backgroundColor: AppColors.onImage,
                      foregroundColor: AppColors.ink,
                      borderColor: Colors.transparent,
                      leading: const AuthIcon('assets/images/auth/google.svg'),
                      onPressed: null,
                    ),
                    const SizedBox(height: 20),
                    OrDivider(label: l10n.orContinueWith),
                    const SizedBox(height: 20),
                    AppButton(
                      label: l10n.continueEmail,
                      backgroundColor: AppColors.onImage,
                      foregroundColor: AppColors.ink,
                      borderColor: AppColors.stroke,
                      leading: const AuthIcon('assets/images/auth/mail.svg'),
                      onPressed: () => context.push('/create-account'),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        AppText(
                          '${l10n.alreadyHaveAccount} ',
                          variant: AppTextVariant.link,
                          color: AppColors.muted,
                        ),
                        AppText(
                          l10n.logIn,
                          variant: AppTextVariant.button,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _LegalLine(l10n: l10n),
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

class _LegalLine extends StatelessWidget {
  const _LegalLine({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final muted = AppTypography.field.copyWith(color: AppColors.muted);
    final link = AppTypography.fieldLabel;

    return Text.rich(
      TextSpan(
        style: muted,
        children: [
          TextSpan(text: l10n.signUpLegalPrefix),
          TextSpan(
            text: l10n.termsOfService,
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => showLegalNotice(context, l10n.termsOfService),
          ),
          const TextSpan(text: ' & '),
          TextSpan(
            text: l10n.privacyPolicy,
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => showLegalNotice(context, l10n.privacyPolicy),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
