import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/favorites/viewmodels/favorites_view_model.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  var _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(favoritesProvider).where((item) {
      if (_filter == 'Meditations') {
        return item.kind == 'meditation';
      }
      if (_filter == 'Breathing') {
        return item.kind == 'breathing';
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: AppBackground(
        child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              children: [
                const AppText(
                  'Favorites',
                  variant: AppTextVariant.display,
                  color: AppColors.ink,
                  style: TextStyle(fontSize: 40, height: 1.1),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final label in ['All', 'Meditations', 'Breathing'])
                      ChoiceChip(
                        label: Text(label),
                        selected: _filter == label,
                        onSelected: (_) => setState(() => _filter = label),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Column(
                      children: [
                        const AppText(
                          'Nothing saved yet',
                          variant: AppTextVariant.headline,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const AppText(
                          'Tap the heart on any meditation or breathing exercise and it will be waiting for you here.',
                          variant: AppTextVariant.field,
                          color: AppColors.muted,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.go('/library'),
                          child: const Text('Browse the library'),
                        ),
                      ],
                    ),
                  )
                else
                  for (final item in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        tileColor: const Color(0xFFFDFCFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(color: AppColors.stroke),
                        ),
                        title: AppText(item.title, variant: AppTextVariant.fieldLabel),
                        subtitle: AppText(item.detail, variant: AppTextVariant.caption),
                        trailing: const Icon(Icons.play_arrow),
                        onTap: () {
                          if (item.kind == 'breathing') {
                            context.push(
                              '/breath-session?title=${Uri.encodeComponent(item.title)}&minutes=${item.minutes}&pattern=4-6',
                            );
                          } else {
                            context.push(
                              '/player?title=${Uri.encodeComponent(item.title)}&minutes=${item.minutes}',
                            );
                          }
                        },
                      ),
                    ),
              ],
            ),
          ),
          const AppNavBar(current: '/favorites'),
        ],
      ),
      ),
    );
  }
}
