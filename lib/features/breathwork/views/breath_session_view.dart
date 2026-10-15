import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
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
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _enter.forward();
    _ticker = Timer.periodic(const Duration(milliseconds: 50), (_) {
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

    return Scaffold(
      backgroundColor: const Color(0xFF7E9486),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Spacer(),
                  AppText(_clock(remaining.isNegative ? Duration.zero : remaining), variant: AppTextVariant.field, color: Colors.white),
                ],
              ),
              const Spacer(),
              ScaleTransition(
                scale: CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic),
                child: Transform.scale(
                  scale: frame.scale,
                  child: Container(
                    width: 240,
                    height: 240,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Color(0xFFFFE7CC), Color(0x66FFD7B0), Color(0x00FFD7B0)],
                      ),
                    ),
                    child: AppText(
                      '${phase.secondsLeft}',
                      variant: AppTextVariant.display,
                      color: AppColors.ink,
                      style: const TextStyle(fontSize: 64),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AppText(label, variant: AppTextVariant.headline, color: Colors.white),
              const SizedBox(height: 6),
              AppText(guide, variant: AppTextVariant.field, color: Colors.white, textAlign: TextAlign.center),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (final step in _pattern.phases)
                    _PhaseChip(
                      label: '${_phaseName(step.type)} ${step.seconds}s',
                      active: step == phase.phase,
                    ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () => setState(() => _running = !_running),
                icon: Icon(
                  _running ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.white,
                  size: 72,
                ),
              ),
              AppText(_running ? 'Pause' : 'Resume', variant: AppTextVariant.caption, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  _PhaseSnapshot _phaseNow() {
    final intoCycleMs = _elapsed.inMilliseconds % (_pattern.cycleSeconds * 1000);
    var cursor = 0;
    for (final phase in _pattern.phases) {
      final phaseMs = phase.seconds * 1000;
      if (intoCycleMs < cursor + phaseMs || phase == _pattern.phases.last) {
        final into = intoCycleMs - cursor;
        final left = (phase.seconds - into / 1000).ceil().clamp(1, phase.seconds);
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

class _PhaseChip extends StatelessWidget {
  const _PhaseChip({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.white : const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: AppText(
        label,
        variant: AppTextVariant.caption,
        color: active ? AppColors.ink : Colors.white,
      ),
    );
  }
}
