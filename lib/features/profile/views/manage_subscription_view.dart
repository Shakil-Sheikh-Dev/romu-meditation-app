import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';

class ManageSubscriptionView extends StatelessWidget {
  const ManageSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Subscription',
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
              'Your plan, billing and how to change it',
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
              child: const Column(
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
                            'Active',
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
                    '€9.99 / month',
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
                          'Renews automatically',
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
                        '12 Oct 2026',
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
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFCFA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDDD6CC)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's included",
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 24 / 16,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: 9),
                  _Included('The full meditation library'),
                  SizedBox(height: 9),
                  _Included('Every breathing exercise'),
                  SizedBox(height: 9),
                  _Included('New sessions added each week'),
                  SizedBox(height: 9),
                  _Included('Progress, streaks and history'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Manage in App Store',
              backgroundColor: AppColors.ink,
              foregroundColor: AppColors.onImage,
              borderColor: Colors.transparent,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text(
                      'Plan changes and cancellation are handled by Apple or Google. Romù can’t change your plan from inside the app.',
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Plan changes and cancellation are handled by Apple. Romù can’t change your plan from inside the app.',
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 18 / 12,
                color: Color(0xFF7A7671),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchases restored')),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    'Restore purchases',
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
    const rows = [
      ('Started', '12 Mar 2026'),
      ('Billed through', 'App Store'),
      ('Payment method', 'Apple ID'),
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
