import 'package:flutter/material.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.surface,
    this.foregroundColor = AppColors.ink,
    this.borderColor = AppColors.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.expand = true,
    this.leading,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final bool expand;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final labelWidget = AppText(
      label,
      variant: AppTextVariant.button,
      color: foregroundColor,
      textAlign: TextAlign.center,
    );

    final lightBackground = backgroundColor.computeLuminance() > 0.6;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(color: borderColor),
        boxShadow: lightBackground
            ? const [
                BoxShadow(
                  color: Color(0x08000000),
                  offset: Offset(0, 1),
                  blurRadius: 1,
                  spreadRadius: -0.5,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Stack(
          children: [
            Material(
              color: backgroundColor,
              child: InkWell(
                onTap: onPressed,
                child: Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: 10),
                      ],
                      Flexible(child: labelWidget),
                    ],
                  ),
                ),
              ),
            ),
            if (lightBackground)
              const Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.buttonHighlight,
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
