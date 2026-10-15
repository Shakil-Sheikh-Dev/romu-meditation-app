import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';

class BreathStartView extends StatefulWidget {
  const BreathStartView({
    super.key,
    required this.title,
    required this.patternId,
    required this.minutes,
  });

  final String title;
  final String patternId;
  final int minutes;

  @override
  State<BreathStartView> createState() => _BreathStartViewState();
}

class _BreathStartViewState extends State<BreathStartView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    _enter.forward();
  }

  @override
  void dispose() {
    _enter.dispose();
    super.dispose();
  }

  String get _counts => switch (widget.patternId) {
    '4-7-8' => '4 · 7 · 8',
    '4-6' => '4 · 6',
    _ => '4 · 4 · 4 · 4',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8FA394),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
              const Spacer(),
              ScaleTransition(
                scale: CurvedAnimation(parent: _enter, curve: Curves.easeOutBack),
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0xFFFFE3C4), Color(0x00FFE3C4)],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AppText(
                widget.title,
                variant: AppTextVariant.display,
                color: Colors.white,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 8),
              AppText(
                _counts,
                variant: AppTextVariant.field,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButton(
                label: 'Start',
                backgroundColor: Colors.white,
                foregroundColor: AppColors.ink,
                borderColor: Colors.transparent,
                leading: const Icon(Icons.play_arrow, color: AppColors.ink),
                onPressed: () {
                  context.push(
                    '/breath-session?title=${Uri.encodeComponent(widget.title)}&pattern=${widget.patternId}&minutes=${widget.minutes}',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
