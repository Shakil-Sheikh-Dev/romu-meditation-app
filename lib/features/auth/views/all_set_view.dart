import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_button.dart';
import 'package:romu/l10n/app_localizations.dart';

class AllSetView extends StatelessWidget {
  const AllSetView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 28 + bottomInset),
          child: Column(
            children: [
              const Expanded(child: Center(child: _AllSetMark())),
              const SizedBox(height: 28),
              AppText(
                l10n.allSetTitle,
                variant: AppTextVariant.display,
                color: AppColors.ink,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppText(
                l10n.allSetBody,
                variant: AppTextVariant.prompt,
                color: AppColors.muted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AppButton(
                label: l10n.startPractice,
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.onImage,
                borderColor: Colors.transparent,
                onPressed: () => context.go('/subscription'),
              ),
              const SizedBox(height: 16),
              AppTextButton(
                label: l10n.exploreAlone,
                variant: AppTextVariant.link,
                color: AppColors.muted,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllSetMark extends StatefulWidget {
  const _AllSetMark();

  @override
  State<_AllSetMark> createState() => _AllSetMarkState();
}

class _AllSetMarkState extends State<_AllSetMark> with TickerProviderStateMixin {
  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void initState() {
    super.initState();
    _enter.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulse.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _enter.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final size = available < 300 ? available : 300.0;
        return AnimatedBuilder(
      animation: Listenable.merge([_enter, _pulse]),
      builder: (context, child) {
        final enter = Curves.easeOutBack.transform(_enter.value);
        final pulse = 1 + (_pulse.value * 0.06);
        return Opacity(
          opacity: _enter.value.clamp(0, 1),
          child: Transform.scale(
            scale: (0.72 + (0.28 * enter)) * (_enter.isCompleted ? pulse : 1),
            child: child,
          ),
        );
      },
          child: SizedBox(
            width: size,
            height: size,
            child: FittedBox(
              child: SvgPicture.asset('assets/images/auth/all_set.svg'),
            ),
          ),
        );
      },
    );
  }
}
