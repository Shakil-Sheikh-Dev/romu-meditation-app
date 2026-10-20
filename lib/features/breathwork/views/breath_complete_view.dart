import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/l10n/app_localizations.dart';

class BreathCompleteView extends StatelessWidget {
  const BreathCompleteView({
    super.key,
    required this.title,
    required this.patternId,
    required this.minutes,
    required this.cycles,
  });

  final String title;
  final String patternId;
  final int minutes;
  final int cycles;

  String get _patternLabel => switch (patternId) {
    '4-7-8' => '4-7-8',
    '4-6' => '4-2-6',
    _ => '4-4-4-4',
  };

  List<_PatternChip> _chips(AppLocalizations l10n) => switch (patternId) {
    '4-7-8' => [
      _PatternChip(l10n.phaseInhaleCount(4), accent: true),
      _PatternChip(l10n.phaseHoldCount(7)),
      _PatternChip(l10n.phaseExhaleCount(8), accent: true),
    ],
    '4-6' => [
      _PatternChip(l10n.phaseInhaleCount(4), accent: true),
      _PatternChip(l10n.phaseHoldCount(2)),
      _PatternChip(l10n.phaseExhaleCount(6), accent: true),
    ],
    _ => [
      _PatternChip(l10n.phaseInhaleCount(4), accent: true),
      _PatternChip(l10n.phaseHoldCount(4)),
      _PatternChip(l10n.phaseExhaleCount(4), accent: true),
      _PatternChip(l10n.phaseHoldCount(4)),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        wash: AppWash.breath,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: AppColors.ink,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => context.go('/breathwork'),
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/breath/close.svg',
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 66),
              const Center(child: _AnimatedEmblem()),
              const SizedBox(height: 24),
              Text(
                l10n.breathSteady,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Instrument Serif',
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  height: 40 / 34,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.breathSummary(minutes, _patternLabel, title),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 22 / 15,
                  color: Color(0xFF6E675F),
                ),
              ),
              const SizedBox(height: 26),
              const _StreakCard(),
              const SizedBox(height: 10),
              _StatsRow(minutes: minutes, cycles: cycles),
              const SizedBox(height: 12),
              _PatternCard(chips: _chips(l10n), cycles: cycles),
              const SizedBox(height: 20),
              Material(
                color: const Color(0xFFFDFCFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: const BorderSide(color: Color(0xFFDDD6CC)),
                ),
                child: InkWell(
                  onTap: () => context.push(
                    '/breath-start?title=${Uri.encodeComponent(title)}&pattern=$patternId&minutes=$minutes',
                  ),
                  borderRadius: BorderRadius.circular(28),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/breath/replay.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          l10n.breathDoAgain,
                          style: TextStyle(
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
                ),
              ),
              const SizedBox(height: 10),
              AppButton(
                label: l10n.breathDone,
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.onImage,
                borderColor: Colors.transparent,
                onPressed: () => context.go('/breathwork'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedEmblem extends StatefulWidget {
  const _AnimatedEmblem();

  @override
  State<_AnimatedEmblem> createState() => _AnimatedEmblemState();
}

class _AnimatedEmblemState extends State<_AnimatedEmblem> with TickerProviderStateMixin {
  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );
  var _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _enter.value = 1;
      return;
    }
    _enter.forward();
    _pulse.repeat(reverse: true);
  }

  @override
  void dispose() {
    _enter.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: AnimatedBuilder(
        animation: Listenable.merge([_enter, _pulse]),
        builder: (context, _) {
          final enter = Curves.easeOutCubic.transform(_enter.value);
          final pulse = Curves.easeInOut.transform(_pulse.value);
          return Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: enter,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xB8FFFFFF),
                    border: Border.all(color: const Color(0xE6FFFFFF)),
                  ),
                ),
              ),
              _Ring(
                size: 78.8 * (0.72 + (enter * 0.28) + (pulse * 0.08)),
                opacity: enter * (0.22 - pulse * 0.1),
              ),
              _Ring(
                size: 62.8 * (0.78 + (enter * 0.22) + ((1 - pulse) * 0.05)),
                opacity: enter * (0.28 + pulse * 0.1),
              ),
              Transform.scale(
                scale: 0.82 + enter * 0.18,
                child: Opacity(
                  opacity: enter,
                  child: Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Color(0xFFDBE3EC), Color(0xFFA2B4C8)],
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/breath/day_check.svg',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF6E85A2).withValues(alpha: opacity.clamp(0, 1)),
          width: 1.2,
        ),
      ),
    );
  }
}

class _PatternChip {
  const _PatternChip(this.label, {this.accent = false});

  final String label;
  final bool accent;
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
        border: Border.all(color: const Color(0xFFDDD6CC)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '8 ${AppLocalizations.of(context).breathDayStreak}',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 24 / 17,
                    color: AppColors.ink,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context).breathBest,
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
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: state == _DayState.upcoming
                ? Border.all(color: const Color(0xFFDDD6CC))
                : null,
          ),
          child: state == _DayState.upcoming
              ? null
              : SvgPicture.asset(
                  'assets/images/breath/day_check.svg',
                  width: 13,
                  height: 13,
                ),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            height: 16 / 11,
            color: state == _DayState.upcoming
                ? const Color(0xFF9A938A)
                : const Color(0xFF7A7671),
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.minutes, required this.cycles});

  final int minutes;
  final int cycles;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Stat(
          value: '$minutes',
          label: minutes == 1 ? AppLocalizations.of(context).minute : AppLocalizations.of(context).minutes,
        ),
        const SizedBox(width: 9),
        _Stat(value: '$cycles', label: AppLocalizations.of(context).cyclesLabel),
        const SizedBox(width: 9),
        _Stat(value: '8', label: AppLocalizations.of(context).breathDayStreak),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFCFA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFDDD6CC)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 30 / 24,
                color: AppColors.ink,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                height: 17 / 11.5,
                color: Color(0xFF7A7671),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({required this.chips, required this.cycles});

  final List<_PatternChip> chips;
  final int cycles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDD6CC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).breathPattern,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 14 / 10,
              letterSpacing: 0.9,
              color: Color(0xFF9A938A),
            ),
          ),
          const SizedBox(height: 11),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final chip in chips)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  decoration: BoxDecoration(
                    color: chip.accent ? const Color(0xFFDCE9E4) : const Color(0xFFF1EDE7),
                    borderRadius: BorderRadius.circular(16),
                    border: chip.accent ? null : Border.all(color: const Color(0xFFDDD6CC)),
                  ),
                  child: Text(
                    chip.label,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 19 / 13,
                      color: chip.accent ? const Color(0xFF4F7A68) : const Color(0xFF6E675F),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            AppLocalizations.of(context).breathCycles(cycles),
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
    );
  }
}
