import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient_history/patient_history_event.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient_history/patient_history_state.dart';

class PatientHistoryBloc extends Bloc<PatientHistoryEvent, PatientHistoryState> {
  PatientHistoryBloc() : super(PatientHistoryInitial()) {
    on<FetchPatientHistory>(_onFetchPatientHistory);
  }

  void _onFetchPatientHistory(
      FetchPatientHistory event, Emitter<PatientHistoryState> emit) async {
    emit(PatientHistoryLoading());
    try {
      await Future.delayed(Duration(seconds: 2));
      final history = ['Blood report', 'CT Scan report'];
      final prescriptions = ['26 March 2022', '26 March 2022'];
      emit(PatientHistoryLoaded(history: history, prescriptions: prescriptions));
    } catch (e) {
      emit(PatientHistoryError(error: e.toString()));
    }
  }
}
