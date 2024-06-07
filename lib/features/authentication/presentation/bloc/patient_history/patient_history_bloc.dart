// patient_history_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'patient_history_event.dart';
import 'patient_history_state.dart';

class PatientHistoryBloc
    extends Bloc<PatientHistoryEvent, PatientHistoryState> {
  PatientHistoryBloc() : super(PatientHistoryLoading());

  @override
  Stream<PatientHistoryState> mapEventToState(
      PatientHistoryEvent event) async* {
    if (event is FetchPatientHistory) {
      try {
        await Future.delayed(Duration(seconds: 2));
        yield PatientHistoryLoaded(
          history: [
            'Blood report',
            'CT Scan report',
          ],
          prescriptions: [
            '26 March 2022 Prescription',
            '13 April 2022 Prescription',
          ],
        );
      } catch (e) {
        yield PatientHistoryError(error: 'Failed to load patient history.');
      }
    }
  }
}
