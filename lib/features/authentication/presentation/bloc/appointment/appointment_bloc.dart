import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_events.dart';
import 'appointment_states.dart';
import '../../../../repositories/appointment_repository.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository _appointmentRepository;

  AppointmentBloc({
    required AppointmentRepository appointmentRepository,
  })  : _appointmentRepository = appointmentRepository,
        super(AppointmentInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<SelectSlot>(_onSelectSlot);
    on<SelectDate>(_onSelectDate);
  }

  Future<void> _onLoadAppointments(
      LoadAppointments event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      final slots = await _appointmentRepository.fetchAvailableSlots();
      emit(AppointmentLoaded(
        slots: slots,
        selectedSlot: -1,
        selectedDate: DateTime.now(),
      ));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  void _onSelectSlot(SelectSlot event, Emitter<AppointmentState> emit) {
    if (state is AppointmentLoaded) {
      final currentState = state as AppointmentLoaded;
      emit(currentState.copyWith(selectedSlot: event.slot));
    }
  }

  void _onSelectDate(SelectDate event, Emitter<AppointmentState> emit) {
    if (state is AppointmentLoaded) {
      final currentState = state as AppointmentLoaded;
      emit(currentState.copyWith(selectedDate: event.date));
    }
  }
}
