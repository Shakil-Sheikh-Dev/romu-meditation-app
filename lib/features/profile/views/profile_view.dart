import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/app/locale_controller.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/features/profile/viewmodels/account_view_model.dart';
import 'package:romu/features/profile/views/delete_account_view.dart';
import 'package:romu/features/profile/widgets/profile_avatar.dart';
import 'package:romu/l10n/app_localizations.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);
    final l10n = AppLocalizations.of(context);
    final language = ref.watch(localeProvider).languageCode == 'lt'
        ? l10n.languageLithuanian
        : l10n.languageEnglish;

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                bottom: false,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    Text(
                      l10n.profileTitle,
                      style: TextStyle(
                        fontFamily: 'Instrument Serif',
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        height: 1.15,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: _card,
                      child: Row(
                        children: [
                          ProfileAvatar(path: account.photoPath),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  account.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Jost',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    height: 26 / 19,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  account.email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Jost',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    height: 19 / 13,
                                    color: Color(0xFF7A7671),
                                  ),
                                ),
                                Text(
                                  l10n.profileMemberSince,
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 18 / 12,
                                    color: Color(0xFF9A938A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _Pill(
                            label: l10n.profileEdit,
                            background: const Color(0xFFF1EDE7),
                            foreground: const Color(0xFF6E675F),
                            onTap: () => context.push('/edit-profile'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _Stat(value: '7', label: l10n.profileDayStreak),
                        const SizedBox(width: 10),
                        _Stat(value: '428', label: l10n.profileMinutes),
                        const SizedBox(width: 10),
                        _Stat(value: '36', label: l10n.profileSessions),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6E9DF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFECD9C8)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Romù Premium',
                                      style: TextStyle(
                                        fontFamily: 'Jost',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        height: 24 / 17,
                                        color: AppColors.ink,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD89A72),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        child: Text(
                                          l10n.profileActive,
                                          style: TextStyle(
                                            fontFamily: 'Jost',
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                            color: Color(0xFFFAF8F5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  l10n.profileRenews,
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    height: 19 / 13,
                                    color: Color(0xFF8A6A52),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _Pill(
                            label: l10n.profileManage,
                            background: AppColors.ink,
                            foreground: Color(0xFFFAF8F5),
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            onTap: () => context.push('/manage-subscription'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _Menu(
                      rows: [
                        _MenuRow(
                          icon: 'assets/images/profile/edit.svg',
                          label: l10n.profileEditProfile,
                          onTap: () => context.push('/edit-profile'),
                        ),
                        _MenuRow(
                          icon: 'assets/images/profile/notifications.svg',
                          label: l10n.profileNotifications,
                          trailing: l10n.profileOn,
                          onTap: () => context.push('/notifications'),
                        ),
                        _MenuRow(
                          icon: 'assets/images/profile/language.svg',
                          label: l10n.profileLanguage,
                          trailing: language,
                          onTap: () => context.push('/language'),
                        ),
                        _MenuRow(
                          icon: 'assets/images/profile/help.svg',
                          label: l10n.profileHelp,
                          onTap: () => context.push('/help'),
                        ),
                        _MenuRow(
                          icon: 'assets/images/profile/privacy.svg',
                          label: l10n.profilePrivacy,
                          onTap: () => context.push('/privacy'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _Menu(
                      rows: [
                        _MenuRow(
                          icon: 'assets/images/profile/logout.svg',
                          label: l10n.profileLogOut,
                          showChevron: false,
                          onTap: () => context.go('/'),
                        ),
                        _MenuRow(
                          icon: 'assets/images/profile/delete.svg',
                          label: l10n.profileDelete,
                          danger: true,
                          showChevron: false,
                          onTap: () => showDeleteAccountSheet(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const AppNavBar(current: '/profile'),
          ],
        ),
      ),
    );
  }
}

const _card = BoxDecoration(
  color: Color(0xFFFDFCFA),
  borderRadius: BorderRadius.all(Radius.circular(20)),
  border: Border.fromBorderSide(BorderSide(color: Color(0xFFDDD6CC))),
);

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: padding,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1,
              color: foreground,
            ),
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _card,
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                height: 32 / 26,
                color: AppColors.ink,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 18 / 12,
                color: Color(0xFF7A7671),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuRow {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.danger = false,
    this.showChevron = true,
  });

  final String icon;
  final String label;
  final String? trailing;
  final bool danger;
  final bool showChevron;
  final VoidCallback onTap;
}

class _Menu extends StatelessWidget {
  const _Menu({required this.rows});

  final List<_MenuRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: _card,
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            if (index > 0) const Divider(height: 1, thickness: 1, color: Color(0xFFEFEBE5)),
            InkWell(
              onTap: rows[index].onTap,
              child: SizedBox(
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(rows[index].icon, width: 18, height: 18),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          rows[index].label,
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 24 / 16,
                            color: rows[index].danger ? const Color(0xFFC4554B) : AppColors.ink,
                          ),
                        ),
                      ),
                      if (rows[index].trailing != null) ...[
                        Text(
                          rows[index].trailing!,
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 19 / 13,
                            color: Color(0xFF7A7671),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      if (rows[index].showChevron)
                        SvgPicture.asset(
                          'assets/images/profile/chevron.svg',
                          width: 16,
                          height: 16,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
