import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  var _showCurrent = false;
  var _showNext = false;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: AppColors.ink,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => context.pop(),
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(Icons.chevron_left, color: Color(0xFFFAF8F5), size: 26),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Change password',
                style: TextStyle(
                  fontFamily: 'Instrument Serif',
                  fontSize: 44,
                  fontWeight: FontWeight.w400,
                  height: 1.05,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You’ll stay signed in on this device. Other devices will ask you to log in again.',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 23 / 15,
                  color: Color(0xFF6E675F),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _PasswordField(
                      label: 'Current password',
                      controller: _current,
                      obscure: !_showCurrent,
                      onToggle: () => setState(() => _showCurrent = !_showCurrent),
                    ),
                    const SizedBox(height: 12),
                    _PasswordField(
                      label: 'New password',
                      controller: _next,
                      obscure: !_showNext,
                      onToggle: () => setState(() => _showNext = !_showNext),
                    ),
                    const SizedBox(height: 12),
                    _PasswordField(
                      label: 'Confirm new password',
                      controller: _confirm,
                      suffix: _LiveMatch(password: _next, confirm: _confirm),
                    ),
                    const SizedBox(height: 16),
                    _Rules(password: _next),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListenableBuilder(
                listenable: Listenable.merge([_current, _next, _confirm]),
                builder: (context, _) {
                  final password = _next.text;
                  final ready = _current.text.isNotEmpty &&
                      password.length >= 8 &&
                      password.contains(RegExp(r'\d')) &&
                      password.contains(RegExp(r'[A-Z]')) &&
                      password.isNotEmpty &&
                      password == _confirm.text;
                  return AppButton(
                    label: 'Update password',
                    backgroundColor: AppColors.ink,
                    foregroundColor: AppColors.onImage,
                    borderColor: Colors.transparent,
                    onPressed: ready ? () => context.pop() : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    this.obscure = true,
    this.onToggle,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback? onToggle;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 56,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            cursorColor: AppColors.ink,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.ink,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF7F4EF),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 14),
                child: SvgPicture.asset(
                  'assets/images/profile/password_lock.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 50, maxWidth: 50, minHeight: 20),
              suffixIcon: suffix ??
                  (onToggle == null
                  ? null
                  : TextButton(
                      onPressed: onToggle,
                      child: Text(
                        obscure ? 'Show' : 'Hide',
                        style: const TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD89A72),
                        ),
                      ),
                    )),
              suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 16),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
            ),
          ),
        ),
      ],
    );
  }
}

final _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0xFFDDD6CC)),
);

class _Rules extends StatelessWidget {
  const _Rules({required this.password});

  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: password,
      builder: (context, _) {
        final value = password.text;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 15),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFCFA),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFDDD6CC)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'NEW PASSWORD MUST HAVE',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 14 / 10,
                  letterSpacing: 0.9,
                  color: Color(0xFF9A938A),
                ),
              ),
              const SizedBox(height: 10),
              _Rule(started: value.isNotEmpty, met: value.length >= 8, label: 'At least 8 characters'),
              const SizedBox(height: 10),
              _Rule(started: value.isNotEmpty, met: value.contains(RegExp(r'\d')), label: 'One number'),
              const SizedBox(height: 10),
              _Rule(started: value.isNotEmpty, met: value.contains(RegExp(r'[A-Z]')), label: 'One capital letter'),
            ],
          ),
        );
      },
    );
  }
}

class _LiveMatch extends StatelessWidget {
  const _LiveMatch({required this.password, required this.confirm});

  final TextEditingController password;
  final TextEditingController confirm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([password, confirm]),
      builder: (context, _) {
        if (confirm.text.isEmpty) return const SizedBox(width: 20, height: 16);
        final matched = confirm.text == password.text;
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: SvgPicture.asset(
            matched
                ? 'assets/images/profile/rule_met.svg'
                : 'assets/images/profile/rule_miss.svg',
            width: 16,
            height: 16,
          ),
        );
      },
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.started, required this.met, required this.label});

  final bool started;
  final bool met;
  final String label;

  @override
  Widget build(BuildContext context) {
    final icon = met
        ? 'assets/images/profile/rule_met.svg'
        : started
        ? 'assets/images/profile/rule_miss.svg'
        : 'assets/images/profile/rule_open.svg';
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              height: 20 / 13.5,
              color: met ? const Color(0xFF6E675F) : const Color(0xFF7A7671),
            ),
          ),
        ),
      ],
    );
  }
}
