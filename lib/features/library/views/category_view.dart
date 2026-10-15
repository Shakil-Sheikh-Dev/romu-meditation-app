import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/auth/widgets/auth_back_button.dart';

class PracticeCategory {
  const PracticeCategory({
    required this.id,
    required this.title,
    required this.color,
    required this.practices,
    this.image,
  });

  final String id;
  final String title;
  final Color color;
  final String? image;
  final List<(String, int)> practices;

  static const all = <PracticeCategory>[
    PracticeCategory(
      id: 'calm',
      title: 'Calm down',
      color: Color(0xFF8AA89A),
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
      color: Color(0xFFC4A48A),
      practices: [
        ('Quiet the loop', 6),
        ('One thought at a time', 8),
        ('Put it down', 5),
      ],
    ),
    PracticeCategory(
      id: 'sleep',
      title: 'For sleep',
      color: Color(0xFF9AA0A8),
      practices: [
        ('Letting go of the day', 14),
        ('Evening body scan', 18),
        ('Soft landing', 10),
      ],
    ),
    PracticeCategory(
      id: 'mornings',
      title: 'For mornings',
      color: Color(0xFFD7B56A),
      practices: [
        ('A clear start', 6),
        ('Light on the water', 8),
        ('Before the day', 5),
      ],
    ),
  ];

  static PracticeCategory byId(String id) {
    return all.firstWhere((item) => item.id == id, orElse: () => all.first);
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});

  final PracticeCategory category;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: category.color,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (category.image != null)
            Image(image: AssetImage(category.image!), fit: BoxFit.cover)
          else
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [category.color, AppColors.surface],
                ),
              ),
            ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: AuthBackButton(onPressed: () => context.pop()),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: AppText(
                    category.title,
                    variant: AppTextVariant.display,
                    color: Colors.white,
                    style: const TextStyle(fontSize: 42),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottomInset),
                    itemCount: category.practices.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final practice = category.practices[index];
                      return Material(
                        color: const Color(0xFFFDFCFA),
                        borderRadius: BorderRadius.circular(18),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: AppText(practice.$1, variant: AppTextVariant.fieldLabel),
                          subtitle: AppText('${practice.$2} min', variant: AppTextVariant.caption),
                          trailing: const Icon(Icons.play_circle_outline),
                          onTap: () => context.push(
                            '/player?title=${Uri.encodeComponent(practice.$1)}&minutes=${practice.$2}',
                          ),
                        ),
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
