import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/features/breathing/engine/breathing_clock.dart';
import 'package:romu/features/breathing/models/breathing_pattern.dart';
import 'package:romu/features/breathing/models/breathing_phase.dart';
import 'package:romu/features/breathing/models/breathing_session_plan.dart';

class BreathSessionView extends StatefulWidget {
  const BreathSessionView({
    super.key,
    required this.title,
    required this.patternId,
    required this.minutes,
  });

  final String title;
  final String patternId;
  final int minutes;

  @override
  State<BreathSessionView> createState() => _BreathSessionViewState();
}

class _BreathSessionViewState extends State<BreathSessionView>
    with SingleTickerProviderStateMixin {
  late final BreathingPattern _pattern = switch (widget.patternId) {
    '4-7-8' => BreathingPattern.fourSevenEight,
    '4-6' => BreathingPattern.fourSix,
    _ => BreathingPattern.box,
  };
  late final BreathingSessionPlan _plan = BreathingSessionPlan.forDuration(
    _pattern,
    Duration(minutes: widget.minutes),
  );
  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  var _elapsed = Duration.zero;
  var _running = true;
  var _finished = false;
  var _sound = true;
  var _haptics = true;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _enter.forward();
    _ticker = Timer.periodic(const Duration(milliseconds: 2), (_) {
      if (!_running || !mounted || _finished) {
        return;
      }
      setState(() {
        _elapsed += const Duration(milliseconds: 50);
        if (_elapsed.inMilliseconds >= _plan.totalSeconds * 1000) {
          _finished = true;
          _running = false;
          _openComplete();
        }
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _enter.dispose();
    super.dispose();
  }

  void _openComplete() {
    final title = Uri.encodeComponent(widget.title);
    context.push(
      '/breath-complete?title=$title&pattern=${widget.patternId}&minutes=${widget.minutes}&cycles=${_plan.cycleCount}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final frame = BreathingClock.at(plan: _plan, elapsed: _elapsed);
    final phase = _phaseNow();
    final remaining = Duration(seconds: _plan.totalSeconds) - _elapsed;
    final label = switch (phase.type) {
      BreathingPhaseType.inhale => 'Inhale',
      BreathingPhaseType.hold => 'Hold',
      BreathingPhaseType.exhale => 'Exhale',
    };
    final guide = switch (phase.type) {
      BreathingPhaseType.inhale => 'Breathe in slowly through your nose',
      BreathingPhaseType.hold => 'Stay with the breath',
      BreathingPhaseType.exhale => 'Let the breath leave',
    };

    final clock = _clock(remaining.isNegative ? Duration.zero : remaining);

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        wash: AppWash.breathSession,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Material(
                      color: AppColors.ink,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () => context.pop(),
                        customBorder: const CircleBorder(),
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.chevron_left,
                            color: Color(0xFFFAF8F5),
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF33302C)),
                      ),
                      child: Text(
                        clock,
                        style: const TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _enter,
                    curve: Curves.easeOutCubic,
                  ),
                  child: Transform.scale(
                    scale: frame.scale,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 312,
                      height: 312,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const _Ring(size: 312, color: Color(0x2E7E97B4)),
                          const _Ring(size: 256, color: Color(0x4789A1BB)),
                          const _Ring(size: 200, color: Color(0x669AB1C8)),
                          const _Ring(size: 148, color: Color(0x8CB6C7D8)),
                          const _Ring(size: 120, color: Color(0xFFF7EFE3)),
                          Text(
                            '${phase.secondsLeft}',
                            style: const TextStyle(
                              fontFamily: 'Cormorant Garamond',
                              fontSize: 34,
                              fontWeight: FontWeight.w300,
                              height: 1,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  guide,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6E675F),
                  ),
                ),
                const SizedBox(height: 18),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (
                        var index = 0;
                        index < _pattern.phases.length;
                        index++
                      ) ...[
                        if (index > 0) const SizedBox(width: 8),
                        _PhaseChip(
                          label:
                              '${_phaseName(_pattern.phases[index].type)} ${_pattern.phases[index].seconds}s',
                          active: _pattern.phases[index] == phase.phase,
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _RoundToggle(
                      asset: 'assets/images/breath/sound.svg',
                      muted: !_sound,
                      onTap: () => setState(() => _sound = !_sound),
                    ),
                    const SizedBox(width: 20),
                    _GlassControl(
                      onTap: () => setState(() => _running = !_running),
                      width: 152,
                      height: 56,
                      radius: 1000,
                      fill: _running
                          ? const Color(0x29FAF8F5)
                          : const Color(0xB8F7F4EF),
                      border: _running
                          ? const Color(0xFFFAF8F5)
                          : const Color(0x17000000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _running ? 'Pause' : 'Resume',
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 28 / 18,
                              color: _running
                                  ? const Color(0xFFFFFFFF)
                                  : AppColors.ink,
                            ),
                          ),
                          const SizedBox(width: 4),
                          _running
                              ? SvgPicture.asset(
                                  'assets/images/breath/pause_icon.svg',
                                  width: 24,
                                  height: 24,
                                )
                              : SvgPicture.asset(
                                  'assets/images/breath/play.svg',
                                  width: 15,
                                  height: 18,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.ink,
                                    BlendMode.srcIn,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    _RoundToggle(
                      asset: 'assets/images/breath/haptic.svg',
                      muted: !_haptics,
                      onTap: () => setState(() => _haptics = !_haptics),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _PhaseSnapshot _phaseNow() {
    final intoCycleMs =
        _elapsed.inMilliseconds % (_pattern.cycleSeconds * 1000);
    var cursor = 0;
    for (final phase in _pattern.phases) {
      final phaseMs = phase.seconds * 1000;
      if (intoCycleMs < cursor + phaseMs || phase == _pattern.phases.last) {
        final into = intoCycleMs - cursor;
        final left = (phase.seconds - into / 1000).ceil().clamp(
          1,
          phase.seconds,
        );
        return _PhaseSnapshot(phase, left);
      }
      cursor += phaseMs;
    }
    return _PhaseSnapshot(_pattern.phases.first, _pattern.phases.first.seconds);
  }

  String _phaseName(BreathingPhaseType type) {
    return switch (type) {
      BreathingPhaseType.inhale => 'Inhale',
      BreathingPhaseType.hold => 'Hold',
      BreathingPhaseType.exhale => 'Exhale',
    };
  }

  String _clock(Duration value) {
    final minutes = value.inMinutes.remainder(60);
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _PhaseSnapshot {
  const _PhaseSnapshot(this.phase, this.secondsLeft);

  final BreathingPhase phase;
  final int secondsLeft;

  BreathingPhaseType get type => phase.type;
}

class _Ring extends StatelessWidget {
  const _Ring({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _RoundToggle extends StatelessWidget {
  const _RoundToggle({
    required this.asset,
    required this.onTap,
    this.muted = false,
  });

  final String asset;
  final VoidCallback onTap;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return _GlassControl(
      onTap: onTap,
      width: 52,
      height: 52,
      radius: 26,
      fill: const Color(0x24FAF8F5),
      border: const Color(0x99FAF8F5),
      child: Opacity(
        opacity: muted ? 0.45 : 1,
        child: SvgPicture.asset(asset, width: 24, height: 24),
      ),
    );
  }
}

class _GlassControl extends StatelessWidget {
  const _GlassControl({
    required this.onTap,
    required this.width,
    required this.height,
    required this.radius,
    required this.fill,
    required this.border,
    required this.child,
  });

  final VoidCallback onTap;
  final double width;
  final double height;
  final double radius;
  final Color fill;
  final Color border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(radius);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: shape,
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 1),
            blurRadius: 1,
            spreadRadius: -0.5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: shape,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Material(
            color: fill,
            child: InkWell(
              onTap: onTap,
              child: Ink(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: shape,
                  border: Border.all(color: border),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment(0, -0.15),
                            colors: [Color(0x1FFFFFFF), Color(0x00FFFFFF)],
                          ),
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhaseChip extends StatelessWidget {
  const _PhaseChip({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: active ? 36 : 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF33302C) : const Color(0xB3FAF8F5),
        borderRadius: BorderRadius.circular(999),
        border: active ? null : Border.all(color: const Color(0xFFDDD6CC)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Jost',
          fontSize: 14,
          height: 1,
          fontWeight: FontWeight.w500,
          color: active ? const Color(0xFFFAF8F5) : const Color(0xFF6E675F),
        ),
      ),
    );
  }
}
