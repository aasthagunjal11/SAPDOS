import 'package:meta/meta.dart';

@immutable
abstract class SignUpEvent {}

class SignUpRequested extends SignUpEvent {
  final String emailOrPhone;
  final String password;
  final String confirmPassword;

  SignUpRequested({
    required this.emailOrPhone,
    required this.password,
    required this.confirmPassword,
  });
}
