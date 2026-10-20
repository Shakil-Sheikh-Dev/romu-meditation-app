import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/l10n/app_localizations.dart';
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
    '4-6' => '4 · 2 · 6',
    _ => '4 · 4 · 4 · 4',
  };

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        wash: AppWash.sage,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 28 + bottom),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: AppColors.ink,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => context.pop(),
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(Icons.chevron_left, color: Color(0xFFFAF8F5), size: 26),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ScaleTransition(
                  scale: CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic),
                  child: const _Rings(),
                ),
                const SizedBox(height: 36),
                AppText(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 15),
                AppText(
                  _counts,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6E675F),
                  ),
                ),
                const Spacer(),
                Material(
                  color: const Color(0xFFD89A72),
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    onTap: () {
                      context.push(
                        '/breath-session?title=${Uri.encodeComponent(widget.title)}&pattern=${widget.patternId}&minutes=${widget.minutes}',
                      );
                    },
                    borderRadius: BorderRadius.circular(28),
                    child: SizedBox(
                      width: 152,
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).breathStart,
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4),
                          _PlayMark(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayMark extends StatelessWidget {
  const _PlayMark();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/breath/play.svg',
      width: 15,
      height: 18,
      fit: BoxFit.contain,
    );
  }
}

class _Rings extends StatelessWidget {
  const _Rings();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 296,
      height: 296,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _Ring(size: 296, color: Color(0x297E97B4)),
          _Ring(size: 236, color: Color(0x3D89A1BB)),
          _Ring(size: 184, color: Color(0x579AB1C8)),
          _Ring(size: 136, color: Color(0x99B6C7D8)),
        ],
      ),
    );
  }
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
