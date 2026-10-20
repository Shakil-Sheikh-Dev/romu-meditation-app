import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/l10n/app_localizations.dart';

class PrivacyView extends StatefulWidget {
  const PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  var _policy = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sections = _policy
        ? [
            (l10n.privacyCollect, l10n.privacyCollectBody),
            (l10n.privacyNever, l10n.privacyNeverBody),
            (l10n.privacyStored, l10n.privacyStoredBody),
            (l10n.privacyRights, l10n.privacyRightsBody),
            (l10n.privacyQuestions, l10n.privacyQuestionsBody),
          ]
        : [
            (l10n.termsUsing, l10n.termsUsingBody),
            (l10n.termsBilling, l10n.termsBillingBody),
            (l10n.termsAccount, l10n.termsAccountBody),
          ];

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
              l10n.privacyTitle,
              style: TextStyle(
                fontFamily: 'Instrument Serif',
                fontSize: 44,
                fontWeight: FontWeight.w400,
                height: 1.05,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFCFA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFDDD6CC)),
              ),
              child: Row(
                children: [
                  _Segment(
                    label: l10n.privacyPolicy,
                    selected: _policy,
                    onTap: () => setState(() => _policy = true),
                  ),
                  _Segment(
                    label: l10n.privacyTerms,
                    selected: !_policy,
                    onTap: () => setState(() => _policy = false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.privacyUpdated,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 18 / 12,
                color: Color(0xFF9A938A),
              ),
            ),
            const SizedBox(height: 14),
            for (final section in sections) ...[
              _Block(title: section.$1, body: section.$2),
              const SizedBox(height: 18),
            ],
            Material(
              color: const Color(0xFFFDFCFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFDDD6CC)),
              ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.privacyPdfPreview)),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/profile/download.svg',
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.privacyDownload,
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 22 / 15,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      Text(
                        l10n.privacyPdf,
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 18 / 12,
                          color: Color(0xFF9A938A),
                        ),
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

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected ? const Color(0xFF33302C) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 14.5,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                height: 21 / 14.5,
                color: selected ? const Color(0xFFFAF8F5) : const Color(0xFF6E675F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            height: 21 / 13.5,
            color: Color(0xFF6E675F),
          ),
        ),
      ],
    );
  }
}
