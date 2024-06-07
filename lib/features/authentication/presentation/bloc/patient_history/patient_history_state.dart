import 'package:equatable/equatable.dart';

abstract class PatientHistoryState extends Equatable {
  const PatientHistoryState();

  @override
  List<Object> get props => [];
}

class PatientHistoryInitial extends PatientHistoryState {}

class PatientHistoryLoading extends PatientHistoryState {}

class PatientHistoryLoaded extends PatientHistoryState {
  final List<String> history;
  final List<String> prescriptions;

  const PatientHistoryLoaded({
    required this.history,
    required this.prescriptions,
  });

  @override
  List<Object> get props => [history, prescriptions];
}

class PatientHistoryError extends PatientHistoryState {
  final String error;

  const PatientHistoryError({required this.error});

  @override
  List<Object> get props => [error];
}
