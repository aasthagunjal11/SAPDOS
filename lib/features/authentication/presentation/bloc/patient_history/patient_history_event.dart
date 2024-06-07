import 'package:equatable/equatable.dart';

abstract class PatientHistoryEvent extends Equatable {
  const PatientHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchPatientHistory extends PatientHistoryEvent {}
