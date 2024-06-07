import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:practice_work/features/authentication/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/doctor/doctor_event.dart';
import 'package:practice_work/features/authentication/presentation/bloc/doctor/doctor_state.dart';
import 'package:practice_work/features/authentication/presentation/pages/patient_history_screen.dart';
import 'Initial_page.dart';
import 'package:practice_work/features/repositories/authentication_repository.dart';

class DoctorScreen extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorBloc(
        authenticationRepository: _authenticationRepository,
      )..add(LoadAppointments()),
      child: Scaffold(
        body: Row(
          children: [
            NavigationDrawer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello!",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Dr. Amol",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage( 'assets/images/doctor.jpg'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Today's Appointments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppointmentCard(
                          title: 'Pending Appointments',
                          count: 19,
                          total: 40,
                          color: Color(0xFF7E91D4),
                        ),
                        SizedBox(width: 10),
                        AppointmentCard(
                          title: 'Completed Appointments',
                          count: 21,
                          total: 40,
                          color: Color(0xFF7E91D4),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF13235A),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Wednesday, March 7",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {}
                            },
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: BlocBuilder<DoctorBloc, DoctorState>(
                        builder: (context, state) {
                          if (state is DoctorLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is DoctorLoaded) {
                            return ListView.builder(
                              itemCount: state.appointments.length,
                              itemBuilder: (context, index) {
                                final appointment = state.appointments[index];
                                return AppointmentRow(
                                  time: appointment.time,
                                  patientName: appointment.patientName,
                                  status: appointment.status,
                                  clockColor: appointment.clockColor,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PatientHistoryScreen(),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else if (state is DoctorError) {
                            return Center(child: Text(state.message));
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color(0xFF13235A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF13235A),
            ),
            child: Center(
              child: Text(
                'SAPDOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _createDrawerItem(
            icon: Icons.category,
            text: 'Categories',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.calendar_today,
            text: 'Appointment',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.chat,
            text: 'Chat',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => InitialPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String title;
  final int count;
  final int total;
  final Color color;

  const AppointmentCard({
    required this.title,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = count / total;

    return Container(
      width: 150,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 10.0,
            percent: percentage,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$count/$total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            progressColor: Colors.white,
            backgroundColor: Colors.grey,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AppointmentRow extends StatelessWidget {
  final String time;
  final String patientName;
  final String status;
  final VoidCallback onTap;
  final Color clockColor;

  const AppointmentRow({
    required this.time,
    required this.patientName,
    required this.status,
    required this.onTap,
    required this.clockColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF7E91D4),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.access_time,
                color: clockColor,
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF7E91D4),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: clockColor,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'X years',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
