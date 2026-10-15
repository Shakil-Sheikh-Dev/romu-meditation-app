import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              children: [
                const AppText(
                  'Library',
                  variant: AppTextVariant.display,
                  color: AppColors.ink,
                  style: TextStyle(fontSize: 40, height: 1.1),
                ),
                const SizedBox(height: 20),
                _category(
                  context,
                  'Calm down',
                  'For anxiety, tension and strong emotions',
                  const Color(0xFFDCE9E4),
                  'calm',
                ),
                _category(
                  context,
                  'Overthinking',
                  'When your head is loud and focus is hard',
                  const Color(0xFFF6E2D6),
                  'overthinking',
                ),
                _category(
                  context,
                  'For sleep',
                  'For evenings, winding down and easier rest',
                  const Color(0xFFEBE8E3),
                  'sleep',
                ),
                _category(
                  context,
                  'For mornings',
                  'A clear start, before the day gets loud',
                  const Color(0xFFF7E9C8),
                  'mornings',
                ),
                const SizedBox(height: 8),
                const AppText('Popular Practices', variant: AppTextVariant.link, color: AppColors.ink),
                const SizedBox(height: 12),
                _practice(context, "When you can't settle", '7 min', 7),
                _practice(context, 'Finding peace in chaos', '5 min', 5),
                _practice(context, 'The art of letting go', '8 min', 8),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: const AppNavBar(current: '/library'),
          ),
        ],
      ),
    );
  }

  Widget _category(
    BuildContext context,
    String title,
    String body,
    Color tint,
    String id,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/category/$id'),
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFCFA),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.stroke),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(25)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(title, variant: AppTextVariant.fieldLabel),
                    AppText(body, variant: AppTextVariant.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _practice(BuildContext context, String title, String length, int minutes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => context.push(
          '/player?title=${Uri.encodeComponent(title)}&minutes=$minutes',
        ),
        tileColor: const Color(0xFFFDFCFA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.stroke),
        ),
        title: AppText(title, variant: AppTextVariant.fieldLabel),
        subtitle: AppText(length, variant: AppTextVariant.caption),
        trailing: const Icon(Icons.play_circle_outline, color: AppColors.ink),
      ),
    );
  }
}
