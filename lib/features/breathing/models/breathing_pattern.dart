import 'package:romu/features/breathing/models/breathing_phase.dart';

class BreathingPattern {
  const BreathingPattern({required this.id, required this.phases});

  final String id;
  final List<BreathingPhase> phases;

  int get cycleSeconds {
    return phases.fold(0, (total, phase) => total + phase.seconds);
  }

  static const fourSix = BreathingPattern(
    id: '4-6',
    phases: [
      BreathingPhase(type: BreathingPhaseType.inhale, seconds: 4),
      BreathingPhase(type: BreathingPhaseType.exhale, seconds: 6),
    ],
  );

  static const box = BreathingPattern(
    id: '4-4-4-4',
    phases: [
      BreathingPhase(type: BreathingPhaseType.inhale, seconds: 4),
      BreathingPhase(type: BreathingPhaseType.hold, seconds: 4),
      BreathingPhase(type: BreathingPhaseType.exhale, seconds: 4),
      BreathingPhase(type: BreathingPhaseType.hold, seconds: 4),
    ],
  );

  static const fourSevenEight = BreathingPattern(
    id: '4-7-8',
    phases: [
      BreathingPhase(type: BreathingPhaseType.inhale, seconds: 4),
      BreathingPhase(type: BreathingPhaseType.hold, seconds: 7),
      BreathingPhase(type: BreathingPhaseType.exhale, seconds: 8),
    ],
  );

  static const predefined = <BreathingPattern>[fourSix, box, fourSevenEight];
}
