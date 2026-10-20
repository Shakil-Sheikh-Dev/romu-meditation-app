import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/l10n/app_localizations.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final _query = TextEditingController();
  var _open = 0;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = _query.text.trim().toLowerCase();
    final articles = [
      (0, l10n.helpQ1, l10n.helpA1),
      (1, l10n.helpQ2, l10n.helpA2),
      (2, l10n.helpQ3, l10n.helpA3),
      (3, l10n.helpQ4, l10n.helpA4),
      (4, l10n.helpQ5, l10n.helpA5),
    ].where((article) {
      return query.isEmpty ||
          article.$2.toLowerCase().contains(query) ||
          article.$3.toLowerCase().contains(query);
    }).toList();

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
              l10n.helpTitle,
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
              l10n.helpSubtitle,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 24 / 16,
                color: Color(0xFF6E675F),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _query,
              onChanged: (_) => setState(() {}),
              cursorColor: AppColors.ink,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.ink,
              ),
              decoration: InputDecoration(
                hintText: l10n.helpSearch,
                hintStyle: const TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 16,
                  color: Color(0xFF9A938A),
                ),
                filled: true,
                fillColor: const Color(0xFFFDFCFA),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: SvgPicture.asset(
                    'assets/images/profile/help_search.svg',
                    width: 18,
                    height: 18,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 46, maxWidth: 46, minHeight: 18),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: _searchBorder,
                enabledBorder: _searchBorder,
                focusedBorder: _searchBorder,
              ),
            ),
            const SizedBox(height: 14),
            if (articles.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFDFCFA),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDDD6CC)),
                ),
                child: Column(
                  children: [
                    for (var index = 0; index < articles.length; index++) ...[
                      if (index > 0)
                        const ColoredBox(
                          color: Color(0xFFEFEBE5),
                          child: SizedBox(height: 1, width: double.infinity),
                        ),
                      _Article(
                        title: articles[index].$2,
                        body: articles[index].$3,
                        open: _open == articles[index].$1,
                        onTap: () => setState(() {
                          _open = _open == articles[index].$1 ? -1 : articles[index].$1;
                        }),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6E9DF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFECD9C8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.helpPremium,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 24 / 16,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.helpPremiumBody,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 19 / 13,
                      color: Color(0xFF8A6A52),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(22),
                    child: InkWell(
                      onTap: () => context.push('/manage-subscription'),
                      borderRadius: BorderRadius.circular(22),
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                        child: Text(
                          l10n.helpRestore,
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 20 / 14,
                            color: Color(0xFFFAF8F5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Material(
              color: const Color(0xFFFDFCFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFDDD6CC)),
              ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.helpWrite)),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/profile/help_mail.svg',
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.helpEmail,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontSize: 15.5,
                                fontWeight: FontWeight.w500,
                                height: 23 / 15.5,
                                color: AppColors.ink,
                              ),
                            ),
                            Text(
                              l10n.helpEmailDetail,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 18 / 12,
                                color: Color(0xFF7A7671),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/profile/help_next.svg',
                        width: 18,
                        height: 18,
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

final _searchBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(color: Color(0xFFDDD6CC)),
);

class _Article extends StatelessWidget {
  const _Article({
    required this.title,
    required this.body,
    required this.open,
    required this.onTap,
  });

  final String title;
  final String body;
  final bool open;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15.5,
                      fontWeight: open ? FontWeight.w500 : FontWeight.w400,
                      height: 23 / 15.5,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  open
                      ? 'assets/images/profile/help_down.svg'
                      : 'assets/images/profile/help_next.svg',
                  width: 18,
                  height: 18,
                ),
              ],
            ),
            if (open) ...[
              const SizedBox(height: 8),
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
          ],
        ),
      ),
    );
  }
}
