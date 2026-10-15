enum BreathingPhaseType { inhale, hold, exhale }

class BreathingPhase {
  const BreathingPhase({required this.type, required this.seconds});

  final BreathingPhaseType type;
  final int seconds;
}
