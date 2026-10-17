import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
class BreathPractice {
  const BreathPractice({
    required this.title,
    required this.subtitle,
    required this.pattern,
    required this.patternId,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String pattern;
  final String patternId;
  final String description;

  static const all = <BreathPractice>[
    BreathPractice(
      title: 'Calm down',
      subtitle: 'Settle your nervous system',
      pattern: '4 · 2 · 6',
      patternId: '4-6',
      description: 'A longer exhale to settle the nervous system when the body feels tight.',
    ),
    BreathPractice(
      title: 'Focus',
      subtitle: 'Sharpen and steady the mind',
      pattern: '4 · 4 · 4 · 4',
      patternId: '4-4-4-4',
      description:
          'A 4-4-4-4 cadence used by professionals and athletes to regain composure under tension.',
    ),
    BreathPractice(
      title: 'Sleep',
      subtitle: 'Wind down towards rest',
      pattern: '4 · 7 · 8',
      patternId: '4-7-8',
      description: 'A slow pattern for evenings, when you want the body to drift toward rest.',
    ),
    BreathPractice(
      title: 'Box Breathing',
      subtitle: 'Settle your nervous system',
      pattern: '4 · 4 · 4 · 4',
      patternId: '4-4-4-4',
      description:
          'A 4-4-4-4 cadence used by professionals and athletes to regain composure under tension.',
    ),
  ];
}

void showBreathSetup(BuildContext context, BreathPractice practice) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BreathSetupSheet(practice: practice),
  );
}

class BreathSetupView extends StatelessWidget {
  const BreathSetupView({
    super.key,
    required this.title,
    required this.patternId,
  });

  final String title;
  final String patternId;

  @override
  Widget build(BuildContext context) {
    final practice = BreathPractice.all.firstWhere(
      (item) => item.patternId == patternId && item.title == title,
      orElse: () => BreathPractice.all.first,
    );
    return Scaffold(
      backgroundColor: const Color(0x66000000),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: BreathSetupSheet(practice: practice),
      ),
    );
  }
}

class BreathSetupSheet extends StatefulWidget {
  const BreathSetupSheet({super.key, required this.practice});

  final BreathPractice practice;

  @override
  State<BreathSetupSheet> createState() => _BreathSetupSheetState();
}

class _BreathSetupSheetState extends State<BreathSetupSheet> {
  var _minutes = 3;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF7F4EF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: AppColors.ink),
            ),
          ),
          AppText(
            widget.practice.title,
            variant: AppTextVariant.headline,
            color: AppColors.ink,
            style: const TextStyle(fontSize: 28, height: 1.1),
          ),
          const SizedBox(height: 8),
          AppText(
            widget.practice.description,
            variant: AppTextVariant.field,
            color: const Color(0xFF7A7671),
          ),
          const SizedBox(height: 22),
          const AppText(
            'How long ?',
            variant: AppTextVariant.link,
            color: AppColors.ink,
            style: TextStyle(fontFamily: 'Jost', fontSize: 18, fontWeight: FontWeight.w500, height: 1.2),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final minutes in [1, 3, 5]) ...[
                if (minutes != 1) const SizedBox(width: 10),
                Expanded(
                  child: _DurationCard(
                    minutes: minutes,
                    selected: _minutes == minutes,
                    onTap: () => setState(() => _minutes = minutes),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),
          Material(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(1000),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                context.push(
                  '/breath-start?title=${Uri.encodeComponent(widget.practice.title)}&pattern=${widget.practice.patternId}&minutes=$_minutes',
                );
              },
              borderRadius: BorderRadius.circular(1000),
              child: const SizedBox(
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      'Begin breathing',
                      variant: AppTextVariant.button,
                      color: Color(0xFFFAF8F5),
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 28 / 18,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, color: Color(0xFFFAF8F5), size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationCard extends StatelessWidget {
  const _DurationCard({
    required this.minutes,
    required this.selected,
    required this.onTap,
  });

  final int minutes;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.ink : const Color(0xFFFDFCFA),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.ink : const Color(0xFFE4DDD4),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                '$minutes',
                color: selected ? const Color(0xFFFAF8F5) : AppColors.ink,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Instrument Serif',
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  height: 34 / 30,
                ),
              ),
              AppText(
                minutes == 1 ? 'minute' : 'minutes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                  color: selected ? const Color(0xFFC9C2B8) : const Color(0xFF7A7671),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
