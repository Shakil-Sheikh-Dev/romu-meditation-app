import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/theme/app_typography.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hint,
    this.label,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.textStyle,
    this.inputFormatters,
    this.borderRadius = 16,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? label;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.field.merge(textStyle);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      inputFormatters: inputFormatters,
      style: style,
      cursorColor: AppColors.ink,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: prefix == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: prefix,
              ),
        suffixIcon: suffix == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 12),
                child: suffix,
              ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 24,
          maxWidth: 56,
          minHeight: 24,
          maxHeight: 24,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          maxWidth: 56,
          minHeight: 24,
          maxHeight: 24,
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.surface,
        hintStyle: style.copyWith(color: AppColors.textLight),
        labelStyle: style,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: _border(AppColors.border),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.ink),
        errorBorder: _border(Colors.red.shade700),
        focusedErrorBorder: _border(Colors.red.shade700),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color),
    );
  }
}
