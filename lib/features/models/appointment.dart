import 'package:flutter/material.dart';

class Appointment {
  final String time;
  final String patientName;
  final String status;
  final Color clockColor;

  Appointment({
    required this.time,
    required this.patientName,
    required this.status,
    required this.clockColor,
  });

  get patientId => null;
}
