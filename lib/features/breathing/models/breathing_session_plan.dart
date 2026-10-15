import 'package:romu/features/breathing/models/breathing_pattern.dart';

class BreathingSessionPlan {
  const BreathingSessionPlan({
    required this.pattern,
    required this.requested,
    required this.cycleCount,
    required this.totalSeconds,
  });

  final BreathingPattern pattern;
  final Duration requested;
  final int cycleCount;
  final int totalSeconds;

  static const supportedDurations = <Duration>[
    Duration(minutes: 1),
    Duration(minutes: 3),
    Duration(minutes: 5),
  ];

  factory BreathingSessionPlan.forDuration(
    BreathingPattern pattern,
    Duration requested,
  ) {
    final cycleSeconds = pattern.cycleSeconds;
    if (cycleSeconds <= 0) {
      throw ArgumentError.value(
        cycleSeconds,
        'pattern',
        'Cycle length must be greater than zero.',
      );
    }

    final cycles = requested.inSeconds ~/ cycleSeconds;
    final cycleCount = cycles < 1 ? 1 : cycles;
    return BreathingSessionPlan(
      pattern: pattern,
      requested: requested,
      cycleCount: cycleCount,
      totalSeconds: cycleCount * cycleSeconds,
    );
  }
}
