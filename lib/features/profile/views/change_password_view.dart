import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_field.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  bool get _longEnough => _next.text.length >= 8;
  bool get _hasNumber => _next.text.contains(RegExp(r'\d'));
  bool get _hasCapital => _next.text.contains(RegExp(r'[A-Z]'));
  bool get _matches => _next.text.isNotEmpty && _next.text == _confirm.text;
  bool get _ready =>
      _current.text.isNotEmpty && _longEnough && _hasNumber && _hasCapital && _matches;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Change password',
      subtitle:
          'You’ll stay signed in on this device. Other devices will ask you to log in again.',
      children: [
        AppTextField(
          controller: _current,
          hint: 'Current password',
          obscureText: true,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _next,
          hint: 'New password',
          obscureText: true,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _confirm,
          hint: 'Confirm new password',
          obscureText: true,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 18),
        const AppText('NEW PASSWORD MUST HAVE', variant: AppTextVariant.caption),
        const SizedBox(height: 8),
        _Rule(met: _longEnough, label: 'At least 8 characters'),
        _Rule(met: _hasNumber, label: 'One number'),
        _Rule(met: _hasCapital, label: 'One capital letter'),
        _Rule(met: _matches, label: 'Confirmation matches'),
        const SizedBox(height: 20),
        AppButton(
          label: 'Update password',
          backgroundColor: _ready ? AppColors.ink : AppColors.stroke,
          foregroundColor: AppColors.onImage,
          borderColor: Colors.transparent,
          onPressed: _ready ? () => context.pop() : null,
        ),
      ],
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.met, required this.label});

  final bool met;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle : Icons.circle_outlined,
            size: 18,
            color: met ? const Color(0xFF6E8B74) : AppColors.textLight,
          ),
          const SizedBox(width: 8),
          Expanded(child: AppText(label, variant: AppTextVariant.field)),
        ],
      ),
    );
  }
}
