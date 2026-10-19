import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/app/locale_controller.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/l10n/app_localizations.dart';

class LanguageView extends ConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(localeProvider).languageCode;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
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
            ),
            const SizedBox(height: 22),
            Text(
              l10n.languageTitle,
              style: TextStyle(
                fontFamily: 'Instrument Serif',
                fontSize: 44,
                fontWeight: FontWeight.w400,
                height: 1.05,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.languageSubtitle,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 23 / 15,
                color: Color(0xFF6E675F),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFDFCFA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDDD6CC)),
              ),
              child: Column(
                children: [
                  _LanguageRow(
                    code: 'EN',
                    title: l10n.languageEnglish,
                    subtitle: code == 'en' ? l10n.languageEnglishCurrent : l10n.languageEnglish,
                    selected: code == 'en',
                    onTap: () => ref.read(localeProvider.notifier).select(const Locale('en')),
                  ),
                  const ColoredBox(
                    color: Color(0xFFEFEBE5),
                    child: SizedBox(height: 1, width: double.infinity),
                  ),
                  _LanguageRow(
                    code: 'LT',
                    title: l10n.languageLithuanian,
                    subtitle: code == 'lt' ? l10n.languageLithuanianCurrent : l10n.languageLithuanianPlain,
                    selected: code == 'lt',
                    onTap: () => ref.read(localeProvider.notifier).select(const Locale('lt')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String code;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFF6E9DF) : const Color(0xFFF1EDE7),
                shape: BoxShape.circle,
                border: selected ? null : Border.all(color: const Color(0xFFDDD6CC)),
              ),
              child: Text(
                code,
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected ? const Color(0xFFA8734D) : const Color(0xFF7A7671),
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500,
                      height: 24 / 16.5,
                      color: AppColors.ink,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      height: 18 / 12.5,
                      color: Color(0xFF7A7671),
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              selected
                  ? 'assets/images/profile/language_selected.svg'
                  : 'assets/images/profile/language_open.svg',
              width: 22,
              height: 22,
            ),
          ],
        ),
      ),
    );
  }
}
