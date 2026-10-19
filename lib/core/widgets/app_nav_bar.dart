import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/l10n/app_localizations.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key, required this.current});

  final String current;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final l10n = AppLocalizations.of(context);
    return Container(
      height: 64 + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.onImage,
        border: Border(top: BorderSide(color: AppColors.stroke)),
      ),
      child: Row(
        children: [
          _item(context, 'assets/images/nav/home.svg', l10n.navHome, '/home'),
          _item(
            context,
            'assets/images/nav/library.svg',
            l10n.navLibrary,
            '/library',
            activeIcon: 'assets/images/nav/library_selected.svg',
          ),
          _item(context, 'assets/images/nav/breathwork.svg', l10n.navBreathwork, '/breathwork'),
          _item(
            context,
            'assets/images/nav/favorites.svg',
            l10n.navFavorites,
            '/favorites',
            activeIcon: 'assets/images/nav/favorites_selected.svg',
            activeFontFamily: 'Instrument Sans',
          ),
          _item(
            context,
            'assets/images/nav/profile.svg',
            l10n.navProfile,
            '/profile',
            activeIcon: 'assets/images/nav/profile_selected.svg',
            activeFontFamily: 'Instrument Sans',
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String icon,
    String label,
    String path, {
    String? activeIcon,
    String? activeFontFamily,
  }) {
    final active = current == path;
    final color = active ? AppColors.ink : AppColors.textLight;
    return Expanded(
      child: InkWell(
        onTap: active ? null : () => context.go(path),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              active && activeIcon != null ? activeIcon : icon,
              width: 26,
              height: 26,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            AppText(
              label,
              variant: AppTextVariant.caption,
              color: color,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontFamily: active ? activeFontFamily : null,
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
