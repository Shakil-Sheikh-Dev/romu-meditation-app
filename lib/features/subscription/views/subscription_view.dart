import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  var _yearly = true;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD89A72), Color(0x00F1EDE7)],
            stops: [0, 0.32],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 36, 16, 24 + bottomInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Romù , in full',
                  variant: AppTextVariant.headline,
                  color: AppColors.ink,
                ),
                const SizedBox(height: 6),
                const AppText(
                  'Every meditation and every breathing practice, whenever you need them',
                  variant: AppTextVariant.link,
                  color: AppColors.muted,
                ),
                const SizedBox(height: 36),
                const _Step(
                  icon: 'assets/images/subscription/check.svg',
                  title: 'Today',
                  body: 'Everything unlocks. Start listening straight away.',
                ),
                const SizedBox(height: 28),
                const _Step(
                  icon: 'assets/images/subscription/reminder.svg',
                  title: 'Day 5',
                  body: 'A gentle reminder , two days before your trial ends.',
                ),
                const SizedBox(height: 28),
                const _Step(
                  icon: 'assets/images/subscription/star.svg',
                  title: 'Day 7',
                  body: 'Your subscription starts, Cancel any time before then',
                ),
                const SizedBox(height: 28),
                _PlanToggle(
                  yearly: _yearly,
                  onChanged: (yearly) => setState(() => _yearly = yearly),
                ),
                const SizedBox(height: 28),
                Center(
                  child: AppText(
                    _yearly ? '€59.99 a year' : '€5.00 a month',
                    variant: AppTextVariant.cardTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36, height: 1),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: AppText(
                    _yearly
                        ? 'That works out a €5.00 a month'
                        : 'Billed every month. Cancel any time.',
                    variant: AppTextVariant.caption,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                ),
                const SizedBox(height: 36),
                AppButton(
                  label: 'Start 7 days free',
                  backgroundColor: AppColors.ink,
                  foregroundColor: AppColors.onImage,
                  borderColor: Colors.transparent,
                  onPressed: () => context.go('/home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanToggle extends StatelessWidget {
  const _PlanToggle({required this.yearly, required this.onChanged});

  final bool yearly;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFE5DED4),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          _option('Yearly', yearly, () => onChanged(true)),
          _option('Monthly', !yearly, () => onChanged(false)),
        ],
      ),
    );
  }

  Widget _option(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? AppColors.ink : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: SizedBox(
            height: 46,
            child: Center(
              child: AppText(
                label,
                variant: selected ? AppTextVariant.button : AppTextVariant.fieldLabel,
                color: selected ? Colors.white : AppColors.muted,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.icon, required this.title, required this.body});

  final String icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 29,
          height: 29,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.5),
            border: Border.all(color: const Color(0xFFD89A72)),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(icon),
        ),
        const SizedBox(width: 17),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                variant: AppTextVariant.cardTitle,
                style: const TextStyle(fontSize: 24, height: 28 / 24),
              ),
              const SizedBox(height: 6),
              AppText(
                body,
                variant: AppTextVariant.caption,
                style: const TextStyle(fontSize: 14, height: 1.3, letterSpacing: 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
