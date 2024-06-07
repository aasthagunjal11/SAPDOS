import 'package:equatable/equatable.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<String> slots;
  final int selectedSlot;
  final DateTime selectedDate;

  const AppointmentLoaded({
    required this.slots,
    required this.selectedSlot,
    required this.selectedDate,
  });

  AppointmentLoaded copyWith({
    List<String>? slots,
    int? selectedSlot,
    DateTime? selectedDate,
  }) {
    return AppointmentLoaded(
      slots: slots ?? this.slots,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object> get props => [slots, selectedSlot, selectedDate];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object> get props => [message];
}
