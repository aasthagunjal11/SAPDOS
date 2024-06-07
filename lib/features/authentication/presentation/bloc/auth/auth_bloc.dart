import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:practice_work/features/repositories/authentication_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;

  AuthBloc({required this.authenticationRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final success = await authenticationRepository.login(
          event.emailOrPhone, event.password);

      if (success) {
        if (event.emailOrPhone == 'doctor@gmail.com') {
          emit(AuthSuccessDoctor());
        } else {
          emit(AuthSuccessPatient());
        }
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError('An error occurred'));
    }
  }
}
