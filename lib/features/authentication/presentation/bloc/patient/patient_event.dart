
import 'package:equatable/equatable.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class FetchPatients extends PatientEvent {}
class LoadDoctors extends PatientEvent {} // Add this if not already present
