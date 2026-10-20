import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/l10n/app_localizations.dart';

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
    final detail = subtitle.isEmpty ? title : '$title Â· $subtitle';

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        wash: AppWash.session,
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
                _minutesBack(context, minutes),
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
              SizedBox(height: 26),
              _StreakCard(),
              SizedBox(height: 10),
              _StatsRow(minutes: minutes),
              SizedBox(height: 12),
              _UpNextCard(),
              SizedBox(height: 20),
              _SoftButton(
                icon: Icons.favorite,
                label: AppLocalizations.of(context).completeSaved,
                onPressed: () => context.go('/favorites'),
              ),
              SizedBox(height: 10),
              AppButton(
                label: AppLocalizations.of(context).completeDone,
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

String _minutesBack(BuildContext context, int minutes) {
  final l10n = AppLocalizations.of(context);
  final words = <int, String>{
    1: l10n.wordOne,
    2: l10n.wordTwo,
    3: l10n.wordThree,
    4: l10n.wordFour,
    5: l10n.wordFive,
    6: l10n.wordSix,
    7: l10n.wordSeven,
    8: l10n.wordEight,
    9: l10n.wordNine,
    10: l10n.wordTen,
    12: l10n.wordTwelve,
    14: l10n.wordFourteen,
    18: l10n.wordEighteen,
  };
  final amount = words[minutes] ?? '$minutes';
  final unit = minutes == 1 ? l10n.minute : l10n.minutes;
  return l10n.completeBack(amount, unit);
}

class _CheckMark extends StatelessWidget {
  const _CheckMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/images/meditation/session_check.svg',
        width: 28,
        height: 20,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final today = DateTime.now().weekday - 1;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  '8 ${AppLocalizations.of(context).completeStreak}',
                  variant: AppTextVariant.fieldLabel,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              AppText(
                AppLocalizations.of(context).completeBest,
                variant: AppTextVariant.caption,
                color: Color(0xFF7A7671),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var index = 0; index < days.length; index++)
                _DayDot(
                  label: days[index],
                  state: index < today
                      ? _DayState.done
                      : index == today
                      ? _DayState.today
                      : _DayState.upcoming,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _DayState { done, today, upcoming }

class _DayDot extends StatelessWidget {
  const _DayDot({required this.label, required this.state});

  final String label;
  final _DayState state;

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _DayState.done => AppColors.ink,
      _DayState.today => const Color(0xFFD89A72),
      _DayState.upcoming => const Color(0xFFF1EDE7),
    };
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: state == _DayState.upcoming
              ? null
              : const Icon(Icons.check, color: Colors.white, size: 14),
        ),
        const SizedBox(height: 7),
        AppText(
          label,
          variant: AppTextVariant.caption,
          color: state == _DayState.upcoming
              ? const Color(0xFF9A938A)
              : const Color(0xFF7A7671),
          style: const TextStyle(fontSize: 11),
        ),
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
        _Stat(value: '$minutes', label: minutes == 1 ? AppLocalizations.of(context).minute : AppLocalizations.of(context).minutes),
        SizedBox(width: 8),
        _Stat(value: '36', label: AppLocalizations.of(context).completeSessions),
        SizedBox(width: 8),
        _Stat(value: '8', label: AppLocalizations.of(context).completeStreak),
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
          color: const Color(0xFFFDFCFA),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            AppText(value, variant: AppTextVariant.title, textAlign: TextAlign.center),
            AppText(
              label,
              variant: AppTextVariant.caption,
              color: const Color(0xFF7A7671),
              textAlign: TextAlign.center,
            ),
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
      padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFD8CFE0), Color(0xFFA394B0)],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  AppLocalizations.of(context).completeUpNext,
                  variant: AppTextVariant.caption,
                  color: Color(0xFF9A938A),
                  style: TextStyle(fontSize: 10, letterSpacing: 0.4),
                ),
                AppText('Evening body scan', variant: AppTextVariant.fieldLabel),
                AppText(
                  '18 min Â· For sleep',
                  variant: AppTextVariant.caption,
                  color: Color(0xFF7A7671),
                ),
              ],
            ),
          ),
          _RoundButton(
            icon: Icons.play_arrow,
            play: true,
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
      color: const Color(0xFFFDFCFA),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFFD89A72), size: 16),
              const SizedBox(width: 9),
              AppText(label, variant: AppTextVariant.button, color: AppColors.ink),
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
    this.play = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool play;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: play ? const Color(0xFFF1EDE7) : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: play ? 40 : 44,
          height: play ? 40 : 44,
          child: Icon(icon, color: AppColors.ink, size: play ? 20 : 20),
        ),
      ),
    );
  }
}
