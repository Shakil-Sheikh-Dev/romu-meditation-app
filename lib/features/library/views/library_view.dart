import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/l10n/app_localizations.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                children: [
                  AppText(
                    l10n.libraryTitle,
                    variant: AppTextVariant.display,
                    color: AppColors.ink,
                    style: TextStyle(fontSize: 40, height: 1.1),
                  ),
                  const SizedBox(height: 20),
                  const _CategoryGrid(),
                  const SizedBox(height: 25),
                  const _PopularHeader(),
                  const SizedBox(height: 12),
                  const _PracticeRow(title: "When you can't settle", minutes: 7),
                  const _PracticeRow(title: 'Finding peace in chaos', minutes: 5),
                  const _PracticeRow(title: 'The art of letting go', minutes: 8),
                  const _PracticeRow(title: 'Embracing uncertainty', minutes: 6),
                ],
              ),
            ),
            const AppNavBar(current: '/library'),
          ],
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _CategoryCard(
                title: l10n.feelingCalm,
                body: l10n.libraryCalmBody,
                tint: Color(0xFFDCE9E4),
                icon: 'assets/images/library/calm.svg',
                id: 'calm',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _CategoryCard(
                title: l10n.feelingOverthinking,
                body: l10n.libraryOverBody,
                tint: Color(0xFFF6E2D6),
                icon: 'assets/images/library/overthinking.svg',
                id: 'overthinking',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _CategoryCard(
                title: l10n.feelingSleep,
                body: l10n.librarySleepBody,
                tint: Color(0xFFEBE8E3),
                icon: 'assets/images/library/sleep.svg',
                id: 'sleep',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _CategoryCard(
                title: l10n.feelingMornings,
                body: l10n.libraryMorningBody,
                tint: Color(0xFFF7E9C8),
                icon: 'assets/images/library/mornings.svg',
                id: 'mornings',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.body,
    required this.tint,
    required this.icon,
    required this.id,
  });

  final String title;
  final String body;
  final Color tint;
  final String icon;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFDFCFA),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () => context.push('/category/$id'),
        borderRadius: BorderRadius.circular(22),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 158),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
                  child: SvgPicture.asset(icon, width: 22, height: 22, fit: BoxFit.contain),
                ),
                const SizedBox(height: 10),
                AppText(
                  title,
                  variant: AppTextVariant.fieldLabel,
                  color: const Color(0xFF1C1B1A),
                ),
                const SizedBox(height: 4),
                AppText(
                  body,
                  variant: AppTextVariant.caption,
                  color: const Color(0xFF7A7671),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PopularHeader extends StatelessWidget {
  const _PopularHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: AppText(
            l10n.libraryPopular,
            variant: AppTextVariant.link,
            color: AppColors.ink,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        AppText(l10n.librarySeeAll, variant: AppTextVariant.caption, color: const Color(0xFF7A7671)),
        const SizedBox(width: 4),
        const Icon(Icons.chevron_right, size: 16, color: Color(0xFF7A7671)),
      ],
    );
  }
}

class _PracticeRow extends StatelessWidget {
  const _PracticeRow({required this.title, required this.minutes});

  final String title;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () => context.push(
            '/meditation?title=${Uri.encodeComponent(title)}&minutes=$minutes',
          ),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFC9CFD6), Color(0xFF8A96A0)],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title, variant: AppTextVariant.fieldLabel),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 13, color: Color(0xFF7A7671)),
                          const SizedBox(width: 4),
                          AppText(
                            '$minutes min',
                            variant: AppTextVariant.caption,
                            color: const Color(0xFF7A7671),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEBE5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded, color: Color(0xFF1C1B1A), size: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
