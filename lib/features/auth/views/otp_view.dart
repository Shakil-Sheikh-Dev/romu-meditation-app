import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/theme/app_typography.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_button.dart';
import 'package:romu/features/auth/viewmodels/auth_view_model.dart';
import 'package:romu/features/auth/widgets/auth_back_button.dart';
import 'package:romu/features/auth/widgets/auth_icon.dart';
import 'package:romu/l10n/app_localizations.dart';

class OtpView extends ConsumerStatefulWidget {
  const OtpView({super.key});

  @override
  ConsumerState<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends ConsumerState<OtpView> {
  static const _length = 6;

  final _controllers = List.generate(_length, (_) => TextEditingController());
  final _nodes = List.generate(_length, (_) => FocusNode());
  var _seconds = 20;
  var _error = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }
      if (_seconds == 0) {
        timer.cancel();
        return;
      }
      setState(() => _seconds -= 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _nodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final email = ref.watch(authViewModelProvider).maskedEmail;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final remaining = _seconds.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 24 + bottomInset),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AuthBackButton(onPressed: () => context.pop()),
              ),
              const SizedBox(height: 24),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.card, width: 6),
                ),
                alignment: Alignment.center,
                child: const AuthIcon('assets/images/auth/shield.svg', size: 28),
              ),
              const SizedBox(height: 16),
              AppText(
                l10n.enterCode,
                variant: AppTextVariant.headline,
                color: AppColors.ink,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 34, height: 41 / 34, letterSpacing: 0.4),
              ),
              const SizedBox(height: 8),
              AppText(
                l10n.otpSent,
                variant: AppTextVariant.link,
                color: AppColors.muted,
                textAlign: TextAlign.center,
              ),
              AppText(
                email.isEmpty ? l10n.otpSampleEmail : email,
                variant: AppTextVariant.button,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var index = 0; index < _length; index++)
                    _OtpBox(
                      controller: _controllers[index],
                      focusNode: _nodes[index],
                      hasError: _error,
                      onChanged: (value) => _onChanged(index, value),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      l10n.resendIn(remaining),
                      variant: AppTextVariant.link,
                      color: AppColors.ink,
                    ),
                  ),
                  AppTextButton(
                    label: l10n.resendCode,
                    variant: AppTextVariant.link,
                    color: _seconds == 0 ? AppColors.ink : AppColors.textTertiary,
                    onPressed: _seconds == 0 ? _resend : null,
                  ),
                ],
              ),
              if (_error)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: AppText(
                    l10n.otpInvalid,
                    variant: AppTextVariant.caption,
                    color: Colors.red.shade700,
                  ),
                ),
              const SizedBox(height: 24),
              AppButton(
                label: l10n.verifyOtp,
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.onImage,
                borderColor: Colors.transparent,
                onPressed: _verify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChanged(int index, String value) {
    setState(() => _error = false);
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (var offset = 0; offset < digits.length && index + offset < _length; offset++) {
        _controllers[index + offset].text = digits[offset];
      }
      final next = (index + digits.length).clamp(0, _length - 1);
      _nodes[next].requestFocus();
      return;
    }
    if (value.isNotEmpty && index < _length - 1) {
      _nodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }
  }

  void _resend() {
    for (final controller in _controllers) {
      controller.clear();
    }
    setState(() {
      _seconds = 20;
      _error = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _seconds == 0) {
        timer.cancel();
        return;
      }
      setState(() => _seconds -= 1);
    });
    _nodes.first.requestFocus();
  }

  void _verify() {
    context.go('/all-set');
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.hasError,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 64,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTypography.button.copyWith(fontSize: 24, color: AppColors.ink),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.card,
          contentPadding: EdgeInsets.zero,
          border: _border(AppColors.stroke),
          enabledBorder: _border(hasError ? Colors.red.shade700 : AppColors.stroke),
          focusedBorder: _border(AppColors.ink),
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 2),
    );
  }
}
