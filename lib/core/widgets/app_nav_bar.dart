import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key, required this.current});

  final String current;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.onImage,
        border: Border(top: BorderSide(color: AppColors.stroke)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _item(context, Icons.home, 'Home', '/home'),
          _item(context, Icons.library_books_outlined, 'Library', '/library'),
          _item(context, Icons.air, 'Breathwork', '/breathwork'),
          _item(context, Icons.favorite_border, 'Favorites', '/favorites'),
          _item(context, Icons.person_outline, 'Profile', '/profile'),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String label, String path) {
    final active = current == path;
    final color = active ? AppColors.ink : AppColors.textLight;
    return InkWell(
      onTap: active ? null : () => context.go(path),
      child: SizedBox(
        width: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            AppText(
              label,
              variant: AppTextVariant.caption,
              color: color,
              style: TextStyle(
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
