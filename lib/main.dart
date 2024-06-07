import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/initial/initial_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/appointment/appointment_events.dart';
import 'package:practice_work/features/authentication/presentation/pages/doctor_screen.dart';
import 'package:practice_work/features/authentication/presentation/pages/initial_page.dart';
import 'package:practice_work/features/authentication/presentation/pages/login_page.dart';
import 'package:practice_work/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:practice_work/features/authentication/presentation/pages/appointment.dart';
import 'package:practice_work/features/authentication/presentation/pages/patient_screen.dart';
import 'package:practice_work/features/authentication/presentation/pages/patient_history_screen.dart';
import 'package:practice_work/features/repositories/authentication_repository.dart';
import 'package:practice_work/features/repositories/appointment_repository.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient/patient_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient/patient_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitialBloc>(
          create: (context) => InitialBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authenticationRepository: _authenticationRepository),
        ),
        BlocProvider<PatientBloc>(
          create: (context) => PatientBloc()..add(LoadDoctors()),
        ),
        BlocProvider<AppointmentBloc>(
          create: (context) => AppointmentBloc(
            appointmentRepository: _appointmentRepository,
          )..add(LoadAppointments()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SAPDOS',
        initialRoute: '/',
        routes: {
          '/': (context) => const InitialPage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/doctor': (context) => DoctorScreen(),
          '/patient': (context) => PatientScreen(),
          '/appointment': (context) => AppointmentScreen(),
          '/patient_history': (context) => PatientHistoryScreen(),
        },
      ),
    );
  }
}
