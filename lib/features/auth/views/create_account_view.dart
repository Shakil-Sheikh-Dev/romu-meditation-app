import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_button.dart';
import 'package:romu/core/widgets/app_text_field.dart';
import 'package:romu/features/auth/viewmodels/auth_view_model.dart';
import 'package:romu/features/auth/widgets/auth_back_button.dart';
import 'package:romu/features/auth/widgets/auth_icon.dart';
import 'package:romu/features/auth/widgets/legal_notice.dart';
import 'package:romu/l10n/app_localizations.dart';

class CreateAccountView extends ConsumerStatefulWidget {
  const CreateAccountView({super.key});

  @override
  ConsumerState<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends ConsumerState<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  var _accepted = false;
  var _showPassword = false;
  var _showConfirm = false;
  var _showTermsError = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
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
          padding: EdgeInsets.fromLTRB(15, 16, 15, 24 + bottomInset),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AuthBackButton(onPressed: () => context.pop()),
                ),
                const SizedBox(height: 24),
                AppText(
                  l10n.createAccountTitle,
                  variant: AppTextVariant.headline,
                  color: AppColors.ink,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                AppText(
                  l10n.createAccountBody,
                  variant: AppTextVariant.link,
                  color: AppColors.muted,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                _Field(
                  label: l10n.nameLabel,
                  child: AppTextField(
                    controller: _name,
                    hint: l10n.nameHint,
                    textInputAction: TextInputAction.next,
                    borderRadius: 12,
                    prefix: const AuthIcon('assets/images/auth/person.svg'),
                    validator: (value) => _required(value, l10n.nameRequired),
                  ),
                ),
                _Field(
                  label: l10n.emailLabel,
                  child: AppTextField(
                    controller: _email,
                    hint: l10n.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    borderRadius: 12,
                    prefix: const AuthIcon('assets/images/auth/email.svg'),
                    validator: (value) => _emailError(value, l10n),
                  ),
                ),
                _Field(
                  label: l10n.passwordLabel,
                  child: AppTextField(
                    controller: _password,
                    hint: l10n.passwordHint,
                    obscureText: !_showPassword,
                    textInputAction: TextInputAction.next,
                    borderRadius: 12,
                    prefix: const AuthIcon('assets/images/auth/lock.svg'),
                    suffix: _visibilityButton(
                      visible: _showPassword,
                      onPressed: () => setState(() => _showPassword = !_showPassword),
                    ),
                    validator: (value) => _passwordError(value, l10n),
                  ),
                ),
                _Field(
                  label: l10n.confirmPasswordLabel,
                  child: AppTextField(
                    controller: _confirm,
                    hint: l10n.passwordHint,
                    obscureText: !_showConfirm,
                    textInputAction: TextInputAction.done,
                    borderRadius: 12,
                    prefix: const AuthIcon('assets/images/auth/lock.svg'),
                    suffix: _visibilityButton(
                      visible: _showConfirm,
                      onPressed: () => setState(() => _showConfirm = !_showConfirm),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.passwordRequired;
                      }
                      if (value != _password.text) {
                        return l10n.passwordMismatch;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  key: const Key('accept-terms'),
                  onTap: () => setState(() {
                    _accepted = !_accepted;
                    _showTermsError = false;
                  }),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CheckBox(checked: _accepted),
                      const SizedBox(width: 8),
                      Expanded(child: _TermsLine(l10n: l10n)),
                    ],
                  ),
                ),
                if (_showTermsError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AppText(
                      l10n.termsRequired,
                      variant: AppTextVariant.caption,
                      color: Colors.red.shade700,
                    ),
                  ),
                const SizedBox(height: 24),
                AppButton(
                  label: l10n.createAccountAction,
                  backgroundColor: AppColors.ink,
                  foregroundColor: AppColors.onImage,
                  borderColor: Colors.transparent,
                  onPressed: () => _submit(context),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    AppText(
                      '${l10n.alreadyHaveAccount} ',
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                    ),
                    AppText(l10n.logIn, variant: AppTextVariant.button),
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
    ref.read(authViewModelProvider.notifier).save(
      name: _name.text.trim(),
      email: _email.text,
      password: _password.text,
    );
    context.push('/otp');
  }

  Widget _visibilityButton({
    required bool visible,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: AuthIcon(
        visible ? 'assets/images/auth/eye.svg' : 'assets/images/auth/eye_off.svg',
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(label, variant: AppTextVariant.fieldLabel),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ink, width: 2),
        color: checked ? AppColors.ink : Colors.transparent,
      ),
      child: checked
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }
}

class _TermsLine extends StatelessWidget {
  const _TermsLine({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        AppText(l10n.agreePrefix, variant: AppTextVariant.field, color: AppColors.muted),
        AppTextButton(
          label: l10n.termsOfService,
          variant: AppTextVariant.link,
          color: AppColors.ink,
          onPressed: () => showLegalNotice(context, l10n.termsOfService),
        ),
        AppText(l10n.agreeAnd, variant: AppTextVariant.field, color: AppColors.muted),
        AppTextButton(
          label: l10n.privacyPolicy,
          variant: AppTextVariant.link,
          color: AppColors.ink,
          onPressed: () => showLegalNotice(context, l10n.privacyPolicy),
        ),
      ],
    );
  }
}

String? _required(String? value, String message) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}

String? _emailError(String? value, AppLocalizations l10n) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) {
    return l10n.emailRequired;
  }
  if (!email.contains('@') || !email.contains('.')) {
    return l10n.emailInvalid;
  }
  return null;
}

String? _passwordError(String? value, AppLocalizations l10n) {
  if (value == null || value.isEmpty) {
    return l10n.passwordRequired;
  }
  if (value.length < 6) {
    return l10n.passwordShort;
  }
  return null;
}
