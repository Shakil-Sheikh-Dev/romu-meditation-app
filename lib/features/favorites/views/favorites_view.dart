import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/features/favorites/viewmodels/favorites_view_model.dart';
import 'package:romu/l10n/app_localizations.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  var _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(favoritesProvider);
    final items = saved.where((item) {
      if (_filter == 'Meditations') return item.kind == 'meditation';
      if (_filter == 'Breathing') return item.kind == 'breathing';
      return true;
    }).toList();
    final l10n = AppLocalizations.of(context);
    final meditations = items.where((item) => item.kind == 'meditation').toList();
    final breathing = items.where((item) => item.kind == 'breathing').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                bottom: false,
                child: saved.isEmpty
                    ? _EmptyFavorites(onBrowse: () => context.go('/library'))
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        children: [
                          const _Title(),
                          const SizedBox(height: 16),
                          _Filters(
                            selected: _filter,
                            onSelected: (label) => setState(() => _filter = label),
                          ),
                          if (meditations.isNotEmpty) ...[
                            const SizedBox(height: 22),
                            _Group(
                              title: l10n.favoritesMeditations,
                              count: meditations.length,
                              items: meditations,
                              onOpen: _open,
                              onRemove: _remove,
                            ),
                          ],
                          if (breathing.isNotEmpty) ...[
                            const SizedBox(height: 22),
                            _Group(
                              title: l10n.favoritesBreathing,
                              count: breathing.length,
                              items: breathing,
                              onOpen: _open,
                              onRemove: _remove,
                            ),
                          ],
                          if (items.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 48),
                              child: Text(
                                l10n.favoritesEmptyFilter,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 15,
                                  color: Color(0xFF6E675F),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
            const AppNavBar(current: '/favorites'),
          ],
        ),
      ),
    );
  }

  void _open(SavedPractice item) {
    if (item.kind == 'breathing') {
      final pattern = item.patternId ?? '4-6';
      context.push(
        '/breath-session?title=${Uri.encodeComponent(item.title)}&minutes=${item.minutes}&pattern=$pattern',
      );
    } else {
      context.push(
        '/player?title=${Uri.encodeComponent(item.title)}&minutes=${item.minutes}',
      );
    }
  }

  void _remove(SavedPractice item) {
    ref.read(favoritesProvider.notifier).toggle(item);
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).favoritesTitle,
      style: TextStyle(
        fontFamily: 'Instrument Serif',
        fontSize: 40,
        fontWeight: FontWeight.w400,
        height: 1.15,
        color: AppColors.ink,
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filters = [
      ('All', l10n.favoritesAll),
      ('Meditations', l10n.favoritesMeditations),
      ('Breathing', l10n.favoritesBreathing),
    ];
    return Row(
      children: [
        for (final filter in filters) ...[
          if (filter.$1 != 'All') const SizedBox(width: 8),
          _FilterChip(
            label: filter.$2,
            selected: selected == filter.$1,
            onTap: () => onSelected(filter.$1),
          ),
        ],
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF33302C) : const Color(0xFFFDFCFA),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: selected ? null : Border.all(color: const Color(0xFFDDD6CC)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 14,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              height: 1,
              color: selected ? const Color(0xFFFAF8F5) : const Color(0xFF6E675F),
            ),
          ),
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    required this.title,
    required this.count,
    required this.items,
    required this.onOpen,
    required this.onRemove,
  });

  final String title;
  final int count;
  final List<SavedPractice> items;
  final ValueChanged<SavedPractice> onOpen;
  final ValueChanged<SavedPractice> onRemove;

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).favoritesSaved(count);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 28 / 18,
                  color: AppColors.ink,
                ),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 19 / 13,
                color: Color(0xFF7A7671),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var index = 0; index < items.length; index++) ...[
          if (index > 0) const SizedBox(height: 8),
          _FavoriteRow(
            item: items[index],
            onOpen: () => onOpen(items[index]),
            onRemove: () => onRemove(items[index]),
          ),
        ],
      ],
    );
  }
}

class _FavoriteRow extends StatelessWidget {
  const _FavoriteRow({required this.item, required this.onOpen, required this.onRemove});

  final SavedPractice item;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 1),
            blurRadius: 1,
            spreadRadius: -0.5,
          ),
        ],
      ),
      child: Material(
        color: const Color(0xFFFDFCFA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFDDD6CC)),
        ),
        child: InkWell(
          onTap: onOpen,
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: 75,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: item.art,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 24 / 16,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/favorites/clock.svg',
                              width: 13,
                              height: 13,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                item.detail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 21 / 14,
                                  color: Color(0xFF7A7671),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: const Color(0xFFEFEBE5),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onRemove,
                      customBorder: const CircleBorder(),
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/favorites/heart.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites({required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: _Title()),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).favoritesEmptyHint,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6E675F),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 128,
                  height: 128,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFCFA),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFDDD6CC)),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/favorites/heart_empty.svg',
                    width: 52,
                    height: 52,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  AppLocalizations.of(context).favoritesEmptyTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 300,
                  child: Text(
                    'Tap the heart on any meditation or breathing exercise and it will be waiting for you here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 24 / 15,
                      color: Color(0xFF6E675F),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Material(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: onBrowse,
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 17),
                      child: Text(
                        AppLocalizations.of(context).favoritesBrowse,
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFAF8F5),
                        ),
                      ),
                    ),
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
