import 'package:flutter_bloc/flutter_bloc.dart';
import 'initial_event.dart';
import 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialState> {
  InitialBloc() : super(InitialInitial()) {
    on<NavigateToLogin>((event, emit) {
      emit(NavigateToLoginState());
      print("Welcome to Login page ");
    });

    on<NavigateToSignup>((event, emit) {
      emit(NavigateToSignupState());
      print("Welcome To Sign up page ");
    });

    on<ProceedAsGuest>((event, emit) {
      emit(ProceedAsGuestState());
    });
  }
}
