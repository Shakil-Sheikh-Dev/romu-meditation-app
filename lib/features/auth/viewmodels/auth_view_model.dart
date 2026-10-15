import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSession {
  const AuthSession({
    this.name = '',
    this.email = '',
    this.password = '',
  });

  final String name;
  final String email;
  final String password;

  String get maskedEmail {
    final parts = email.split('@');
    if (parts.length != 2 || parts.first.isEmpty) {
      return email;
    }
    return '${parts.first.substring(0, 1)}••••••@${parts.last}';
  }
}

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthSession>(
  AuthViewModel.new,
);

class AuthViewModel extends Notifier<AuthSession> {
  @override
  AuthSession build() => const AuthSession();

  void save({
    required String email,
    String name = '',
    String password = '',
  }) {
    state = AuthSession(name: name, email: email.trim(), password: password);
  }
}
