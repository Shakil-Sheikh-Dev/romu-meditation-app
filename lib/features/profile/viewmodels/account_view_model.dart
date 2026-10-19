import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountProfile {
  const AccountProfile({
    required this.name,
    required this.email,
    this.photoPath,
  });

  final String name;
  final String email;
  final String? photoPath;

  AccountProfile copyWith({String? name, String? email, String? photoPath}) {
    return AccountProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}

final accountProvider = NotifierProvider<AccountViewModel, AccountProfile>(
  AccountViewModel.new,
);

class AccountViewModel extends Notifier<AccountProfile> {
  @override
  AccountProfile build() {
    return const AccountProfile(
      name: 'Natasha Kazlauskaitė',
      email: 'natasha.k@email.com',
    );
  }

  void update({required String name, required String email}) {
    state = state.copyWith(name: name, email: email);
  }

  void setPhoto(String path) {
    state = state.copyWith(photoPath: path);
  }
}
