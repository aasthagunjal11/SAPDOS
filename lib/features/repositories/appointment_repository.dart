class AppointmentRepository {
  Future<List<String>> fetchAvailableSlots() async {
    return [
      '10:00 - 10:15 AM',
      '10:15 - 10:30 AM',
      '10:30 - 10:45 AM',
      '10:45 - 11:00 AM',
      '11:00 - 11:15 AM',
      '11:15 - 11:30 AM',
      '11:30 - 11:45 AM',
      '11:45 - 12:00 PM',
      '12:00 - 12:15 PM'
    ];
  }
}
