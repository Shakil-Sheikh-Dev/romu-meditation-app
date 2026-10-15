import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_field.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  bool get _ready => _confirm.text.trim() == 'DELETE';

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Delete your account?',
      subtitle: 'This erases your Romù account and everything in it. It cannot be undone.',
      children: [
        const AppText(
          'Your subscription is billed by Apple or Google. Deleting the account does not cancel it — cancel in the App Store or Play Store first.',
          variant: AppTextVariant.field,
        ),
        const SizedBox(height: 16),
        const AppText('Type DELETE to confirm', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 8),
        AppTextField(
          controller: _confirm,
          hint: 'DELETE',
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Cancel',
          onPressed: () => context.pop(),
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Delete account',
          backgroundColor: _ready ? const Color(0xFFC4554B) : AppColors.stroke,
          foregroundColor: AppColors.onImage,
          borderColor: Colors.transparent,
          onPressed: _ready ? () => context.go('/') : null,
        ),
      ],
    );
  }
}
