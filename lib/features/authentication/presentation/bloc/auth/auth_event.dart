import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String emailOrPhone;
  final String password;
  final bool rememberMe;

  const LoginRequested({
    required this.emailOrPhone,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object> get props => [emailOrPhone, password, rememberMe];
}
