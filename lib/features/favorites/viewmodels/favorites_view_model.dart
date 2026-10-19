import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPractice {
  const SavedPractice({
    required this.title,
    required this.detail,
    required this.kind,
    required this.minutes,
    this.patternId,
    this.art = const [Color(0xFFC9CFD6), Color(0xFF8A96A0)],
  });

  final String title;
  final String detail;
  final String kind;
  final int minutes;
  final String? patternId;
  final List<Color> art;
}

final favoritesProvider = NotifierProvider<FavoritesViewModel, List<SavedPractice>>(
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
        art: [Color(0xFFC9CFD6), Color(0xFF8A96A0)],
      ),
      SavedPractice(
        title: "When you can't settle",
        detail: '7 min · Elena Rostova',
        kind: 'meditation',
        minutes: 7,
        art: [Color(0xFFE2CFC2), Color(0xFFBFA18C)],
      ),
      SavedPractice(
        title: 'Evening body scan',
        detail: '18 min · Elena Rostova',
        kind: 'meditation',
        minutes: 18,
        art: [Color(0xFFCFD8CF), Color(0xFF93A693)],
      ),
      SavedPractice(
        title: 'Quiet the loop',
        detail: '6 min · Jonas Petrauskas',
        kind: 'meditation',
        minutes: 6,
        art: [Color(0xFFD8CFE0), Color(0xFFA394B0)],
      ),
      SavedPractice(
        title: 'Calm down',
        detail: '4-2-6 · 3 min',
        kind: 'breathing',
        minutes: 3,
        patternId: '4-6',
        art: [Color(0xFFDCE9E4), Color(0xFFA9C6BB)],
      ),
      SavedPractice(
        title: 'Box breathing',
        detail: '4-4-4-4 · 5 min',
        kind: 'breathing',
        minutes: 5,
        patternId: '4-4-4-4',
        art: [Color(0xFFF6E2D6), Color(0xFFDCB69B)],
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
