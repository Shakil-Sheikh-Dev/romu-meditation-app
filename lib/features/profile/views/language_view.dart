import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:romu/app/locale_controller.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class LanguageView extends ConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(localeProvider).languageCode;

    return SettingsPage(
      title: 'Language',
      subtitle: 'The app switches straight away — no restart needed.',
      children: [
        _option(
          context,
          ref,
          selected: code == 'en',
          code: 'EN',
          title: 'English',
          body: 'English — current',
          locale: const Locale('en'),
        ),
        const SizedBox(height: 10),
        _option(
          context,
          ref,
          selected: code == 'lt',
          code: 'LT',
          title: 'Lietuvių',
          body: 'Lithuanian',
          locale: const Locale('lt'),
        ),
      ],
    );
  }

  Widget _option(
    BuildContext context,
    WidgetRef ref, {
    required bool selected,
    required String code,
    required String title,
    required String body,
    required Locale locale,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => ref.read(localeProvider.notifier).select(locale),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: selected ? AppColors.ink : AppColors.stroke),
          ),
          child: Row(
            children: [
              AppText(code, variant: AppTextVariant.fieldLabel),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(title, variant: AppTextVariant.fieldLabel),
                    AppText(body, variant: AppTextVariant.caption),
                  ],
                ),
              ),
              if (selected) const Icon(Icons.check, color: AppColors.ink),
            ],
          ),
        ),
      ),
    );
  }
}
