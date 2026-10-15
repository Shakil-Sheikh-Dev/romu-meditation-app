import 'dart:math' as math;

import 'package:romu/features/breathing/models/breathing_pattern.dart';
import 'package:romu/features/breathing/models/breathing_phase.dart';
import 'package:romu/features/breathing/models/breathing_session_plan.dart';

class BreathingFrame {
  const BreathingFrame({
    required this.phase,
    required this.scale,
    required this.cycleIndex,
    required this.isComplete,
  });

  final BreathingPhaseType phase;
  final double scale;
  final int cycleIndex;
  final bool isComplete;
}

abstract final class BreathingClock {
  static const minScale = 0.60;
  static const maxScale = 1.0;

  static BreathingFrame at({
    required BreathingSessionPlan plan,
    required Duration elapsed,
  }) {
    final totalMicros = plan.totalSeconds * Duration.microsecondsPerSecond;
    final elapsedMicros = elapsed.inMicroseconds;

    if (elapsedMicros >= totalMicros) {
      final lastIndex = plan.pattern.phases.length - 1;
      return BreathingFrame(
        phase: plan.pattern.phases[lastIndex].type,
        scale: _scaleAtPhaseEnd(plan.pattern, lastIndex),
        cycleIndex: plan.cycleCount - 1,
        isComplete: true,
      );
    }

    final cycleMicros = plan.pattern.cycleSeconds * Duration.microsecondsPerSecond;
    final cycleIndex = elapsedMicros ~/ cycleMicros;
    var intoCycle = elapsedMicros - (cycleIndex * cycleMicros);
    final phases = plan.pattern.phases;

    for (var index = 0; index < phases.length; index++) {
      final phaseMicros = phases[index].seconds * Duration.microsecondsPerSecond;
      final isLast = index == phases.length - 1;
      if (intoCycle < phaseMicros || isLast) {
        final progress = phaseMicros == 0 ? 1.0 : intoCycle / phaseMicros;
        return BreathingFrame(
          phase: phases[index].type,
          scale: _scaleFor(plan.pattern, index, progress),
          cycleIndex: cycleIndex,
          isComplete: false,
        );
      }
      intoCycle -= phaseMicros;
    }

    throw StateError('Elapsed time did not map to a breathing phase.');
  }

  static double easeInOutSine(double t) {
    final progress = t.clamp(0.0, 1.0);
    return -(math.cos(math.pi * progress) - 1) / 2;
  }

  static double _scaleFor(
    BreathingPattern pattern,
    int phaseIndex,
    double progress,
  ) {
    switch (pattern.phases[phaseIndex].type) {
      case BreathingPhaseType.inhale:
        return _lerp(minScale, maxScale, easeInOutSine(progress));
      case BreathingPhaseType.exhale:
        return _lerp(maxScale, minScale, easeInOutSine(progress));
      case BreathingPhaseType.hold:
        return _scaleAtPhaseEnd(pattern, phaseIndex - 1);
    }
  }

  static double _scaleAtPhaseEnd(BreathingPattern pattern, int phaseIndex) {
    if (phaseIndex < 0) {
      return minScale;
    }

    switch (pattern.phases[phaseIndex].type) {
      case BreathingPhaseType.inhale:
        return maxScale;
      case BreathingPhaseType.exhale:
        return minScale;
      case BreathingPhaseType.hold:
        return _scaleAtPhaseEnd(pattern, phaseIndex - 1);
    }
  }

  static double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }
}
