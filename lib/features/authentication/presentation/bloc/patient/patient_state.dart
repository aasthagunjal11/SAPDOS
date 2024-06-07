abstract class PatientState {}

class PatientInitial extends PatientState {}

class DoctorsLoaded extends PatientState {
  final List<String> doctors;

  DoctorsLoaded(this.doctors);
}
