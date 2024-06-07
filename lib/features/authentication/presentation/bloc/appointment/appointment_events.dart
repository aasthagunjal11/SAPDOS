import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentEvent {}

class SelectSlot extends AppointmentEvent {
  final int slot;

  const SelectSlot(this.slot);

  @override
  List<Object> get props => [slot];
}

class SelectDate extends AppointmentEvent {
  final DateTime date;

  const SelectDate(this.date);

  @override
  List<Object> get props => [date];
}
