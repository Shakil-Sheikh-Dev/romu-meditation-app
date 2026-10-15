import 'package:flutter_riverpod/flutter_riverpod.dart';

final intentViewModelProvider = NotifierProvider<IntentViewModel, String?>(
  IntentViewModel.new,
);

class IntentViewModel extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String id) {
    state = id;
  }
}
