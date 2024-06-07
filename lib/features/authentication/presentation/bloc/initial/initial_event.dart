import 'package:equatable/equatable.dart';

abstract class InitialEvent extends Equatable {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

class NavigateToLogin extends InitialEvent {}

class NavigateToSignup extends InitialEvent {}

class ProceedAsGuest extends InitialEvent {}
