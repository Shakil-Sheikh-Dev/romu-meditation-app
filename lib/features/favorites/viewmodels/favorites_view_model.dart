import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPractice {
  const SavedPractice({
    required this.title,
    required this.detail,
    required this.kind,
    required this.minutes,
  });

  final String title;
  final String detail;
  final String kind;
  final int minutes;
}

final favoritesProvider =
    NotifierProvider<FavoritesViewModel, List<SavedPractice>>(
      FavoritesViewModel.new,
    );

class FavoritesViewModel extends Notifier<List<SavedPractice>> {
  @override
  List<SavedPractice> build() {
    return const [
      SavedPractice(
        title: 'Letting go of the day',
        detail: '14 min · Elena Rostova',
        kind: 'meditation',
        minutes: 14,
      ),
      SavedPractice(
        title: "When you can't settle",
        detail: '7 min · Elena Rostova',
        kind: 'meditation',
        minutes: 7,
      ),
      SavedPractice(
        title: 'Calm down',
        detail: '4-2-6 · 3 min',
        kind: 'breathing',
        minutes: 3,
      ),
    ];
  }

  bool contains(String title) => state.any((item) => item.title == title);

  void toggle(SavedPractice practice) {
    if (contains(practice.title)) {
      state = [
        for (final item in state)
          if (item.title != practice.title) item,
      ];
    } else {
      state = [...state, practice];
    }
  }
}
