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
        body: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF6EFE6),
                    Color(0xFFE8D5C0),
                    Color(0xFFDFC4A8),
                  ],
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottomInset),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 72,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/auth/logo_dark.png'),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                        semanticLabel: 'Romi Kasdien',
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppText(
                      l10n.signUpTitle,
                      variant: AppTextVariant.headline,
                      color: AppColors.ink,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppText(
                      l10n.signUpBody,
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15, height: 1.35),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      label: l10n.continueApple,
                      backgroundColor: AppColors.ink,
                      foregroundColor: AppColors.onImage,
                      borderColor: Colors.transparent,
                      leading: const AuthIcon('assets/images/auth/apple.svg'),
                      onPressed: null,
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      label: l10n.continueGoogle,
                      backgroundColor: AppColors.onImage,
                      foregroundColor: AppColors.ink,
                      borderColor: Colors.transparent,
                      leading: const AuthIcon('assets/images/auth/google.svg'),
                      onPressed: null,
                    ),
                    const SizedBox(height: 16),
                    OrDivider(label: l10n.orContinueWith),
                    const SizedBox(height: 16),
                    AppButton(
                      label: l10n.continueEmail,
                      backgroundColor: AppColors.onImage,
                      foregroundColor: AppColors.ink,
                      borderColor: AppColors.stroke,
                      leading: const AuthIcon('assets/images/auth/mail.svg'),
                      onPressed: () => context.push('/create-account'),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        AppText(
                          '${l10n.alreadyHaveAccount} ',
                          variant: AppTextVariant.link,
                          color: AppColors.muted,
                          style: const TextStyle(fontSize: 15),
                        ),
                        AppText(
                          l10n.logIn,
                          variant: AppTextVariant.button,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
    final muted = AppTypography.caption.copyWith(
      color: AppColors.muted,
      fontSize: 12,
      height: 1.4,
    );
    final link = muted.copyWith(
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.ink,
    );

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
          TextSpan(text: l10n.agreeAnd),
          TextSpan(
            text: l10n.privacyPolicy,
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => showLegalNotice(context, l10n.privacyPolicy),
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
