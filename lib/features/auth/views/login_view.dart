import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_button.dart';
import 'package:romu/core/widgets/app_text_field.dart';
import 'package:romu/features/auth/viewmodels/auth_view_model.dart';
import 'package:romu/features/auth/widgets/auth_icon.dart';
import 'package:romu/features/auth/widgets/or_divider.dart';
import 'package:romu/l10n/app_localizations.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  var _remember = false;
  var _showPassword = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 24 + bottomInset),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 88,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/images/auth/logo_dark.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                AppText(
                  l10n.welcomeBackTitle,
                  variant: AppTextVariant.headline,
                  color: AppColors.ink,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                AppText(
                  l10n.welcomeBackBody,
                  variant: AppTextVariant.link,
                  color: AppColors.muted,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(l10n.emailLabel, variant: AppTextVariant.fieldLabel),
                ),
                const SizedBox(height: 6),
                AppTextField(
                  controller: _email,
                  hint: l10n.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  borderRadius: 12,
                  prefix: const AuthIcon('assets/images/auth/email.svg'),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return l10n.emailRequired;
                    }
                    if (!email.contains('@') || !email.contains('.')) {
                      return l10n.emailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(l10n.passwordLabel, variant: AppTextVariant.fieldLabel),
                ),
                const SizedBox(height: 6),
                AppTextField(
                  controller: _password,
                  hint: l10n.passwordHint,
                  obscureText: !_showPassword,
                  borderRadius: 12,
                  prefix: const AuthIcon('assets/images/auth/lock.svg'),
                  suffix: GestureDetector(
                    onTap: () => setState(() => _showPassword = !_showPassword),
                    behavior: HitTestBehavior.opaque,
                    child: AuthIcon(
                      _showPassword
                          ? 'assets/images/auth/eye.svg'
                          : 'assets/images/auth/eye_off.svg',
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.passwordRequired;
                    }
                    if (value.length < 6) {
                      return l10n.passwordShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () => setState(() => _remember = !_remember),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.ink, width: 2),
                              color: _remember ? AppColors.ink : Colors.transparent,
                            ),
                            child: _remember
                                ? const Icon(Icons.check, size: 16, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 8),
                          AppText(l10n.rememberMe, variant: AppTextVariant.fieldLabel),
                        ],
                      ),
                    ),
                    const Spacer(),
                    AppTextButton(
                      label: l10n.forgotPassword,
                      variant: AppTextVariant.fieldLabel,
                      onPressed: () => _forgotPassword(context, l10n),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: l10n.logIn,
                  backgroundColor: AppColors.ink,
                  foregroundColor: AppColors.onImage,
                  borderColor: Colors.transparent,
                  onPressed: () => _submit(context),
                ),
                const SizedBox(height: 20),
                OrDivider(label: l10n.orContinueWith),
                const SizedBox(height: 16),
                AppButton(
                  label: l10n.continueApple,
                  backgroundColor: AppColors.onImage,
                  foregroundColor: AppColors.ink,
                  borderColor: Colors.transparent,
                  leading: const AuthIcon('assets/images/auth/apple.svg'),
                  onPressed: () => _social(context, 'apple'),
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: l10n.continueGoogle,
                  backgroundColor: AppColors.onImage,
                  foregroundColor: AppColors.ink,
                  borderColor: Colors.transparent,
                  leading: const AuthIcon('assets/images/auth/google.svg'),
                  onPressed: () => _social(context, 'google'),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    AppText(
                      '${l10n.newHere} ',
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                    ),
                    AppTextButton(
                      label: l10n.createAnAccount,
                      onPressed: () => context.push('/create-account'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    ref.read(authViewModelProvider.notifier).save(
      email: _email.text,
      password: _password.text,
    );
    context.go('/onboarding');
  }

  void _social(BuildContext context, String provider) {
    ref.read(authViewModelProvider.notifier).save(email: '$provider@romu.app', name: provider);
    context.go('/onboarding');
  }

  void _forgotPassword(BuildContext context, AppLocalizations l10n) {
    final email = _email.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      _formKey.currentState?.validate();
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: AppText(l10n.forgotPassword, variant: AppTextVariant.fieldLabel),
          content: AppText(l10n.resetSent, variant: AppTextVariant.field),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText(l10n.legalClose, variant: AppTextVariant.fieldLabel),
            ),
          ],
        );
      },
    );
  }
}
