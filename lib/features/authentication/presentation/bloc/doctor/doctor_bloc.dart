import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';
import 'package:practice_work/features/repositories/authentication_repository.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final AuthenticationRepository authenticationRepository;

  DoctorBloc({required this.authenticationRepository})
      : super(DoctorInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
  }

  void _onLoadAppointments(
      LoadAppointments event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());

    try {
      final appointments = await authenticationRepository.getAppointments();
      emit(DoctorLoaded(appointments: appointments));
    } catch (e) {
      emit(DoctorError(message: 'Failed to load appointments'));
    }
  }
}
