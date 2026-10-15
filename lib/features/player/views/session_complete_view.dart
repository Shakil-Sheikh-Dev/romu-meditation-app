import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';

class SessionCompleteView extends StatelessWidget {
  const SessionCompleteView({
    super.key,
    required this.title,
    required this.minutes,
    this.subtitle = '',
  });

  final String title;
  final int minutes;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final detail = subtitle.isEmpty ? title : '$title · $subtitle';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F0EB),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE7E2DC), Color(0xFFF6F3EF), Color(0xFFF6F3EF)],
            stops: [0, 0.42, 1],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _RoundButton(
                  icon: Icons.close,
                  onPressed: () => context.pop(),
                ),
              ),
              const SizedBox(height: 28),
              const Center(child: _CheckMark()),
              const SizedBox(height: 28),
              AppText(
                _minutesBack(minutes),
                variant: AppTextVariant.display,
                color: AppColors.ink,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, height: 1.15),
              ),
              const SizedBox(height: 10),
              AppText(
                detail,
                variant: AppTextVariant.field,
                color: AppColors.muted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              const _StreakCard(),
              const SizedBox(height: 10),
              _StatsRow(minutes: minutes),
              const SizedBox(height: 12),
              const _UpNextCard(),
              const SizedBox(height: 20),
              _SoftButton(
                icon: Icons.favorite,
                label: 'Saved to favorites',
                onPressed: () => context.go('/favorites'),
              ),
              const SizedBox(height: 10),
              AppButton(
                label: 'Done',
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.onImage,
                borderColor: Colors.transparent,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _minutesBack(int minutes) {
  const words = <int, String>{
    1: 'one',
    2: 'two',
    3: 'three',
    4: 'four',
    5: 'five',
    6: 'six',
    7: 'seven',
    8: 'eight',
    9: 'nine',
    10: 'ten',
    12: 'twelve',
    14: 'fourteen',
    18: 'eighteen',
  };
  final amount = words[minutes] ?? '$minutes';
  final unit = minutes == 1 ? 'minute' : 'minutes';
  return "That's $amount $unit back";
}

class _CheckMark extends StatelessWidget {
  const _CheckMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, color: Color(0xFFC4784A), size: 34),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: AppText('8 day streak', variant: AppTextVariant.fieldLabel),
              ),
              AppText('Best 12 days', variant: AppTextVariant.caption),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var index = 0; index < days.length; index++)
                _DayDot(label: days[index], filled: index < 6),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.label, required this.filled});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: filled ? AppColors.ink : const Color(0xFFE7E1DA),
            shape: BoxShape.circle,
          ),
          child: filled
              ? const Icon(Icons.check, color: Colors.white, size: 14)
              : null,
        ),
        const SizedBox(height: 6),
        AppText(label, variant: AppTextVariant.caption),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.minutes});

  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Stat(value: '$minutes', label: minutes == 1 ? 'minute' : 'minutes'),
        const SizedBox(width: 8),
        const _Stat(value: '36', label: 'sessions'),
        const SizedBox(width: 8),
        const _Stat(value: '8', label: 'day streak'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            AppText(value, variant: AppTextVariant.title, textAlign: TextAlign.center),
            AppText(label, variant: AppTextVariant.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _UpNextCard extends StatelessWidget {
  const _UpNextCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D3E4),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('UP NEXT', variant: AppTextVariant.caption),
                AppText('Evening body scan', variant: AppTextVariant.fieldLabel),
                AppText('18 min · For sleep', variant: AppTextVariant.caption),
              ],
            ),
          ),
          _RoundButton(
            icon: Icons.play_arrow,
            filled: true,
            onPressed: () => context.push(
              '/player?title=${Uri.encodeComponent('Evening body scan')}&minutes=18&subtitle=${Uri.encodeComponent('For sleep')}',
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftButton extends StatelessWidget {
  const _SoftButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF8EFE8),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFFC4784A), size: 18),
              const SizedBox(width: 8),
              AppText(label, variant: AppTextVariant.button, color: const Color(0xFFC4784A)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.onPressed,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.ink : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: filled ? 40 : 44,
          height: filled ? 40 : 44,
          child: Icon(
            icon,
            color: filled ? Colors.white : AppColors.ink,
            size: filled ? 22 : 20,
          ),
        ),
      ),
    );
  }
}
