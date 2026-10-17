import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:romu/app/app.dart';
import 'package:romu/features/onboarding/models/onboarding_story.dart';
import 'package:romu/features/onboarding/views/onboarding_flow_view.dart';
import 'package:romu/l10n/app_localizations.dart';
import 'package:romu/features/breathing/engine/breathing_clock.dart';
import 'package:romu/features/breathing/models/breathing_pattern.dart';
import 'package:romu/features/breathing/models/breathing_phase.dart';
import 'package:romu/features/breathing/models/breathing_session_plan.dart';

Future<void> openWelcome(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: App()));
  await tester.pump();
  GoRouter.of(tester.element(find.byType(Scaffold))).go('/');
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('welcome screen shows the start actions', (tester) async {
    await openWelcome(tester);

    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Your day demands a lot from you'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await openWelcome(tester);
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Create your account'), findsOneWidget);
    await tester.ensureVisible(find.text('Continue with email'));
    await tester.tap(find.text('Continue with email'));
    await tester.pumpAndSettle();

    expect(find.text('Create account'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Ada Lovelace');
    await tester.enterText(find.byType(TextFormField).at(1), 'ada@romu.app');
    await tester.enterText(find.byType(TextFormField).at(2), 'secret1');
    await tester.enterText(find.byType(TextFormField).at(3), 'secret1');
    await tester.ensureVisible(find.byKey(const Key('accept-terms')));
    await tester.tap(find.byKey(const Key('accept-terms')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Create Account'));
    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    expect(find.text('Enter Code'), findsOneWidget);
    final boxes = find.byType(TextField);
    for (var index = 0; index < 6; index++) {
      await tester.enterText(boxes.at(index), '${index + 1}');
    }
    await tester.tap(find.text('Verify OTP'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('You’re all set'), findsOneWidget);
    await tester.tap(find.text('Start your first practice'));
    await tester.pumpAndSettle();
    expect(find.text('Start 7 days free'), findsOneWidget);
    await tester.ensureVisible(find.text('Start 7 days free'));
    await tester.tap(find.text('Start 7 days free'));
    await tester.pumpAndSettle();
    expect(find.text('Natasha'), findsOneWidget);
  });

  testWidgets('onboarding stories swipe backward', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            return OnboardingFlowView(
              stories: OnboardingStory.pages(AppLocalizations.of(context)),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Don’t know how to calm down?'), findsOneWidget);

    await tester.fling(find.byType(PageView), const Offset(500, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Your day demands a lot from you'), findsOneWidget);
  });

  testWidgets('onboarding screens fit a small phone', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(() {
      tester.platformDispatcher.clearTextScaleFactorTestValue();
      tester.binding.setSurfaceSize(null);
    });

    await openWelcome(tester);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Your day demands a lot from you'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('a three-minute 4-7-8 session finishes nine full cycles', () {
    final plan = BreathingSessionPlan.forDuration(
      BreathingPattern.fourSevenEight,
      const Duration(minutes: 3),
    );

    expect(plan.cycleCount, 9);
    expect(plan.totalSeconds, 171);
  });

  test('session length is rounded down to whole cycles', () {
    final oneMinuteBox = BreathingSessionPlan.forDuration(
      BreathingPattern.box,
      const Duration(minutes: 1),
    );
    final fiveMinutePattern = BreathingSessionPlan.forDuration(
      BreathingPattern.fourSevenEight,
      const Duration(minutes: 5),
    );

    expect(oneMinuteBox.cycleCount, 3);
    expect(oneMinuteBox.totalSeconds, 48);
    expect(fiveMinutePattern.cycleCount, 15);
    expect(fiveMinutePattern.totalSeconds, 285);
  });

  test('the orb expands, holds still, then contracts from elapsed time', () {
    final plan = BreathingSessionPlan.forDuration(
      BreathingPattern.fourSevenEight,
      const Duration(minutes: 3),
    );

    final start = BreathingClock.at(plan: plan, elapsed: Duration.zero);
    final midInhale = BreathingClock.at(
      plan: plan,
      elapsed: const Duration(seconds: 2),
    );
    final hold = BreathingClock.at(
      plan: plan,
      elapsed: const Duration(seconds: 4),
    );
    final stillHolding = BreathingClock.at(
      plan: plan,
      elapsed: const Duration(seconds: 8),
    );
    final exhale = BreathingClock.at(
      plan: plan,
      elapsed: const Duration(seconds: 11),
    );
    final finished = BreathingClock.at(
      plan: plan,
      elapsed: const Duration(seconds: 171),
    );

    expect(start.phase, BreathingPhaseType.inhale);
    expect(start.scale, BreathingClock.minScale);
    expect(midInhale.scale, closeTo(0.8, 0.0001));
    expect(hold.phase, BreathingPhaseType.hold);
    expect(hold.scale, BreathingClock.maxScale);
    expect(stillHolding.scale, BreathingClock.maxScale);
    expect(exhale.phase, BreathingPhaseType.exhale);
    expect(exhale.scale, BreathingClock.maxScale);
    expect(finished.isComplete, isTrue);
    expect(finished.scale, BreathingClock.minScale);
  });

  test('the hold after an exhale keeps the orb contracted', () {
    final plan = BreathingSessionPlan.forDuration(
      BreathingPattern.box,
      const Duration(minutes: 1),
    );
    final hold = BreathingClock.at(
      plan: plan,
      elapsed: const Duration(seconds: 12),
    );

    expect(hold.phase, BreathingPhaseType.hold);
    expect(hold.scale, BreathingClock.minScale);
  });
}
