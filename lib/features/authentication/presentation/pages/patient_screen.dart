import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/patient/patient_bloc.dart';
import '../bloc/patient/patient_state.dart';
import '../bloc/patient/patient_event.dart';
import 'appointment.dart';

class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: Color(0xFF13235A),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  "SAPDOS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                ListTile(
                  leading: Icon(Icons.category, color: Colors.white),
                  title:
                      Text("Categories", style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.white),
                  title: Text("Appointment",
                      style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  leading: Icon(Icons.chat, color: Colors.white),
                  title: Text("Chat", style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title:
                      Text("Settings", style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text("Logout", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF13235A),
                            ),
                          ),
                          Text(
                            "Satish",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/patient.jpg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    color: Color(0xFF13235A),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0), 
                      child: Text(
                        "Doctor's List",
                        textAlign: TextAlign.left, 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<PatientBloc, PatientState>(
                      builder: (context, state) {
                        if (state is PatientInitial) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is DoctorsLoaded) {
                          final doctors = state.doctors;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppointmentScreen(),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundImage:
                                                  NetworkImage(doctor.image),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doctor.name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  doctor.specialization,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 20),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 20),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 20),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 20),
                                            Icon(Icons.star_border,
                                                color: Colors.yellow, size: 20),
                                            Spacer(),
                                            Text("${doctor.rating}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('No doctors found.'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}