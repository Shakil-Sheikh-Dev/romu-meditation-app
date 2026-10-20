import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/l10n/app_localizations.dart';

class ManageSubscriptionView extends StatelessWidget {
  const ManageSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(Icons.chevron_left, color: Color(0xFFFAF8F5), size: 26),
                  ),
                ),
              ),
            ),
            SizedBox(height: 22),
            Text(
              l10n.subTitle,
              style: TextStyle(
                fontFamily: 'Instrument Serif',
                fontSize: 44,
                fontWeight: FontWeight.w400,
                height: 1.05,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: 8),
            Text(
              l10n.subSubtitle,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 24 / 16,
                color: Color(0xFF6E675F),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF6E9DF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFECD9C8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Romù Premium',
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            height: 28 / 21,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFD89A72),
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(
                            l10n.profileActive,
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFAF8F5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    l10n.subPrice,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 24 / 16,
                      color: Color(0xFF8A6A52),
                    ),
                  ),
                  SizedBox(height: 10),
                  ColoredBox(
                    color: Color(0xFFECD9C8),
                    child: SizedBox(height: 1, width: double.infinity),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.subRenews,
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 19 / 13,
                            color: Color(0xFF8A6A52),
                          ),
                        ),
                      ),
                      Text(
                        l10n.subRenewsDate,
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 20 / 14,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const _BillingCard(),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: Color(0xFFFDFCFA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFDDD6CC)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.subIncluded,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 24 / 16,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: 9),
                  _Included(l10n.subItem1),
                  SizedBox(height: 9),
                  _Included(l10n.subItem2),
                  SizedBox(height: 9),
                  _Included(l10n.subItem3),
                  SizedBox(height: 9),
                  _Included(l10n.subItem4),
                ],
              ),
            ),
            SizedBox(height: 12),
            AppButton(
              label: l10n.subManage,
              backgroundColor: AppColors.ink,
              foregroundColor: AppColors.onImage,
              borderColor: Colors.transparent,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(
                      l10n.subManageBody,
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.subClose)),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            Text(
              l10n.subNote,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 18 / 12,
                color: Color(0xFF7A7671),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.helpRestore)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    l10n.helpRestore,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 22 / 15,
                      color: Color(0xFFD89A72),
                    ),
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

class _BillingCard extends StatelessWidget {
  const _BillingCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = [
      (l10n.subStarted, l10n.subStartedDate),
      (l10n.subBilled, l10n.subStore),
      (l10n.subPayment, l10n.subApple),
    ];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDD6CC)),
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            if (index > 0)
              const ColoredBox(
                color: Color(0xFFEFEBE5),
                child: SizedBox(height: 1, width: double.infinity),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rows[index].$1,
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 22 / 15,
                        color: Color(0xFF6E675F),
                      ),
                    ),
                  ),
                  Text(
                    rows[index].$2,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 22 / 15,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Included extends StatelessWidget {
  const _Included(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/profile/included_tick.svg', width: 16, height: 16),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Jost',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 21 / 14,
              color: Color(0xFF6E675F),
            ),
          ),
        ),
      ],
    );
  }
}
