import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/l10n/app_localizations.dart';

class PracticeCategory {
  const PracticeCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.practices,
  });

  final String id;
  final String title;
  final String image;
  final List<(String, int)> practices;

  static const all = <PracticeCategory>[
    PracticeCategory(
      id: 'calm',
      title: 'Calm down',
      image: 'assets/images/categories/calm.png',
      practices: [
        ("When you can't settle", 7),
        ('Finding peace in chaos', 5),
        ('The art of letting go', 8),
        ('Embracing uncertainty', 6),
        ('Softening the jaw', 4),
        ('A slower breath', 9),
      ],
    ),
    PracticeCategory(
      id: 'overthinking',
      title: 'Overthinking',
      image: 'assets/images/categories/overthinking.png',
      practices: [
        ('Quiet the loop', 6),
        ('Untangle the day', 9),
        ("When the mind won't stop", 11),
        ('Naming the thought', 7),
        ('Letting the story go', 8),
        ('Room to think', 12),
      ],
    ),
    PracticeCategory(
      id: 'sleep',
      title: 'For sleep',
      image: 'assets/images/categories/sleep.png',
      practices: [
        ('Letting go of the day', 14),
        ('Evening body scan', 18),
        ("When sleep won't come", 9),
        ('A quiet mind at night', 16),
        ('Slow descent', 20),
        ('Drifting off', 12),
      ],
    ),
    PracticeCategory(
      id: 'mornings',
      title: 'For mornings',
      image: 'assets/images/categories/mornings.png',
      practices: [
        ('A softer morning', 8),
        ('Before the day starts', 6),
        ('Waking slowly', 9),
        ('Setting the tone', 5),
        ('Morning light', 10),
        ('One good breath', 4),
      ],
    ),
  ];

  static PracticeCategory byId(String id) {
    return all.firstWhere((item) => item.id == id, orElse: () => all.first);
  }
}

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.category});

  final PracticeCategory category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  var _filter = 'all';

  List<(String, int)> get _visible {
    final practices = widget.category.practices;
    return switch (_filter) {
      'under' => [
        for (final practice in practices)
          if (practice.$2 < 10) practice,
      ],
      'over' => [
        for (final practice in practices)
          if (practice.$2 >= 10) practice,
      ],
      _ => practices,
    };
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final practices = _visible;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: AssetImage(widget.category.image), fit: BoxFit.cover),
          const ColoredBox(color: Color(0x14000000)),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => context.pop(),
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(Icons.chevron_left, color: AppColors.ink, size: 28),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                  child: AppText(
                    switch (widget.category.id) {
                      'calm' => AppLocalizations.of(context).feelingCalm,
                      'overthinking' => AppLocalizations.of(context).feelingOverthinking,
                      'sleep' => AppLocalizations.of(context).feelingSleep,
                      _ => AppLocalizations.of(context).feelingMornings,
                    },
                    variant: AppTextVariant.display,
                    color: Colors.white,
                    style: const TextStyle(fontSize: 40, height: 1.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: AppLocalizations.of(context).categoryAll(widget.category.practices.length),
                        selected: _filter == 'all',
                        onTap: () => setState(() => _filter = 'all'),
                      ),
                      _FilterChip(
                        label: AppLocalizations.of(context).categoryUnder,
                        selected: _filter == 'under',
                        onTap: () => setState(() => _filter = 'under'),
                      ),
                      _FilterChip(
                        label: AppLocalizations.of(context).categoryOver,
                        selected: _filter == 'over',
                        onTap: () => setState(() => _filter = 'over'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottomInset),
                    itemCount: practices.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final practice = practices[index];
                      return _PracticeRow(
                        title: practice.$1,
                        minutes: practice.$2,
                        tint: _tints[index % _tints.length],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _tints = <Color>[
  Color(0xFFC9CFD6),
  Color(0xFFE6D3B8),
  Color(0xFFE4C8BE),
  Color(0xFFC9B4A4),
  Color(0xFFC5D5CE),
  Color(0xFFC9D4DE),
];

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.ink : const Color(0xE6FFFFFF),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AppText(
            label,
            variant: AppTextVariant.caption,
            color: selected ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}

class _PracticeRow extends StatelessWidget {
  const _PracticeRow({
    required this.title,
    required this.minutes,
    required this.tint,
  });

  final String title;
  final int minutes;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFDFCFA),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => context.push(
          '/meditation?title=${Uri.encodeComponent(title)}&minutes=$minutes',
        ),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(title, variant: AppTextVariant.fieldLabel, maxLines: 2),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 13, color: Color(0xFF7A7671)),
                        const SizedBox(width: 4),
                        AppText(
                          AppLocalizations.of(context).minutesShort(minutes),
                          variant: AppTextVariant.caption,
                          color: const Color(0xFF7A7671),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFEBE5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded, color: Color(0xFF1C1B1A), size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
