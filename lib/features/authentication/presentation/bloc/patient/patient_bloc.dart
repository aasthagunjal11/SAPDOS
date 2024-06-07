import 'package:flutter_bloc/flutter_bloc.dart';
import 'patient_event.dart';
import 'patient_state.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientInitial()) {
    on<LoadDoctors>((event, emit) async {
      emit(PatientInitial());
      await Future.delayed(Duration(seconds: 2));
      final doctors = await loadDoctors();
      emit(DoctorsLoaded(doctors));
    });
  }

  Future<List<Doctor>> loadDoctors() async {
    final String response = await rootBundle.loadString('assets/json/doctors.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Doctor.fromJson(json)).toList();
  }
}