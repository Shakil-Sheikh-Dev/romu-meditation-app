import 'package:flutter/material.dart';

enum AppWash {
  peach,
  sage,
  session,
  breath,
  player,
  breathSession,
}

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.wash = AppWash.peach,
  });

  final Widget child;
  final AppWash wash;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF1EDE7),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _Wash(wash: wash),
          child,
        ],
      ),
    );
  }
}

class _Wash extends StatelessWidget {
  const _Wash({required this.wash});

  final AppWash wash;

  @override
  Widget build(BuildContext context) {
    final full = wash == AppWash.player || wash == AppWash.breathSession;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: full ? null : _height,
      bottom: full ? 0 : null,
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: _gradient),
      ),
    );
  }

  double get _height => switch (wash) {
    AppWash.session || AppWash.breath => 500,
    _ => 300,
  };

  LinearGradient get _gradient => switch (wash) {
    AppWash.peach => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFD89A72), Color(0x00F1EDE7)],
    ),
    AppWash.session => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFC9CFD6), Color(0xFFDCD4CA), Color(0xFFF1EDE7)],
      stops: [0, 0.55, 1],
    ),
    AppWash.sage => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF6E85A2), Color(0x80768CA5), Color(0x00F1EDE7)],
      stops: [0, 0.55, 1],
    ),
    AppWash.breath => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF6E85A2), Color(0x80768CA5), Color(0x00F1EDE7)],
      stops: [0, 0.55, 1],
    ),
    AppWash.player => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFF3EFE9),
        Color(0xFFEFE9E2),
        Color(0xFFD8D1CA),
        Color(0xFF9B938C),
        Color(0xFF6B645E),
      ],
      stops: [0, 0.26, 0.55, 0.78, 1],
    ),
    AppWash.breathSession => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFF0F1F4), Color(0xFFCFD7E1), Color(0xFF93A7BD)],
      stops: [0, 0.55, 1],
    ),
  };
}
