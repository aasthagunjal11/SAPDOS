import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient_history/patient_history_bloc.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient_history/patient_history_event.dart';
import 'package:practice_work/features/authentication/presentation/bloc/patient_history/patient_history_state.dart';

class PatientHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientHistoryBloc()..add(FetchPatientHistory()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<PatientHistoryBloc, PatientHistoryState>(
                  builder: (context, state) {
                    if (state is PatientHistoryLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PatientHistoryLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildExpansionTile(
                              title: 'Patient History',
                              icon: Icons.history,
                              items: state.history
                                  .map((item) =>
                                      _buildListTile(item, Icons.visibility))
                                  .toList(),
                            ),
                            SizedBox(height: 20),
                            _buildExpansionTile(
                              title: 'Prescription',
                              icon: Icons.receipt,
                              items: state.prescriptions
                                  .map((item) =>
                                      _buildListTile(item, Icons.visibility))
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    } else if (state is PatientHistoryError) {
                      return Center(
                        child: Text(
                          'Error loading patient history: ${state.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('assets/images/patient.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.contact_phone, size: 18, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Patient Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Patient Age',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Issue description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF13235A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: items,
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        trailing: Icon(icon, color: Colors.grey),
      ),
    );
  }
}
