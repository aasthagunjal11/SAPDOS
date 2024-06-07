import 'package:flutter_bloc/flutter_bloc.dart';
import 'patient_event.dart';
import 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientInitial()) {
    on<LoadDoctors>((event, emit) async {
      emit(PatientInitial());
      await Future.delayed(Duration(seconds: 2));
      final doctors = [
        "Doctor 1",
        "Doctor 2",
        "Doctor 3",
        "Doctor 4",
        "Doctor 5",
        "Doctor 6"
      ];
      emit(DoctorsLoaded(doctors));
    });
  }
}
