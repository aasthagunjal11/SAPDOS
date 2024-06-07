import 'package:equatable/equatable.dart';
import 'package:practice_work/features/models/appointment.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<Appointment> appointments;

  const DoctorLoaded({required this.appointments});

  @override
  List<Object> get props => [appointments];
}

class DoctorError extends DoctorState {
  final String message;

  const DoctorError({required this.message});

  @override
  List<Object> get props => [message];
}
