import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_field.dart';
import 'package:romu/features/profile/viewmodels/account_view_model.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late final TextEditingController _name;
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    final account = ref.read(accountProvider);
    _name = TextEditingController(text: account.name);
    _email = TextEditingController(text: account.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Edit profile',
      subtitle: 'Update how your account looks in Romù',
      children: [
        const AppText('Profile photo', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 6),
        const AppText(
          'JPG or PNG, square, min 200px',
          variant: AppTextVariant.caption,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile photo updated')),
              );
            },
            child: const Text('Change'),
          ),
        ),
        const AppText('Name', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 8),
        AppTextField(controller: _name, hint: 'Name'),
        const SizedBox(height: 14),
        const AppText('Email', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 8),
        AppTextField(
          controller: _email,
          hint: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => context.push('/change-password'),
            child: const Text('Change password'),
          ),
        ),
        const SizedBox(height: 12),
        AppButton(
          label: 'Save changes',
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.onImage,
          borderColor: Colors.transparent,
          onPressed: () {
            ref.read(accountProvider.notifier).update(
              name: _name.text.trim().isEmpty ? 'Natasha Kazlauskaitė' : _name.text.trim(),
              email: _email.text.trim().isEmpty ? 'natasha.k@email.com' : _email.text.trim(),
            );
            context.pop();
          },
        ),
      ],
    );
  }
}
