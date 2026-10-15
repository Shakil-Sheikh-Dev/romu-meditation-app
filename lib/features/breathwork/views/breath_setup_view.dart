import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/profile/widgets/settings_page.dart';

class BreathSetupView extends StatefulWidget {
  const BreathSetupView({
    super.key,
    required this.title,
    required this.patternId,
  });

  final String title;
  final String patternId;

  @override
  State<BreathSetupView> createState() => _BreathSetupViewState();
}

class _BreathSetupViewState extends State<BreathSetupView> {
  late String _patternId = widget.patternId;
  var _minutes = 3;

  static const _options = <(String, String, String)>[
    ('Calm down', 'Settle your nervous system', '4-6'),
    ('Focus', 'Sharpen and steady the mind', '4-4-4-4'),
    ('Sleep', 'Wind down towards rest', '4-7-8'),
  ];

  String get _title {
    return _options.firstWhere((item) => item.$3 == _patternId, orElse: () => _options.first).$1;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Breathwork',
      subtitle: 'Practice',
      children: [
        for (final option in _options)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: _patternId == option.$3 ? const Color(0xFFE7EFE8) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color: _patternId == option.$3 ? const Color(0xFF8FA394) : AppColors.stroke,
                  ),
                ),
                title: AppText(option.$1, variant: AppTextVariant.fieldLabel),
                subtitle: AppText(option.$2, variant: AppTextVariant.caption),
                onTap: () => setState(() => _patternId = option.$3),
              ),
            ),
          ),
        const SizedBox(height: 12),
        const AppText('How long?', variant: AppTextVariant.fieldLabel),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final minutes in [1, 3, 5]) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(minutes == 1 ? '1 minute' : '$minutes minutes'),
                    selected: _minutes == minutes,
                    onSelected: (_) => setState(() => _minutes = minutes),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        const AppText(
          'Box breathing is a steady cadence used to regain composure.',
          variant: AppTextVariant.field,
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Begin  ·  $_minutes min',
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.onImage,
          borderColor: Colors.transparent,
          onPressed: () {
            context.push(
              '/breath-start?title=${Uri.encodeComponent(_title)}&pattern=$_patternId&minutes=$_minutes',
            );
          },
        ),
      ],
    );
  }
}
