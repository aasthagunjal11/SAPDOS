import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../repositories/authentication_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authenticationRepository;

  SignUpBloc({required this.authenticationRepository}) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpRequested) {
      yield SignUpLoading();
      try {
        await authenticationRepository.signUp(
          event.emailOrPhone,
          event.password,
          event.confirmPassword,
        );
        yield SignUpSuccess('Sign-up successful');
      } catch (error) {
        yield SignUpFailure('Sign-up failed: $error');
      }
    }
  }
}
