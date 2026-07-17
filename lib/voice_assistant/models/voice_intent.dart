enum VoiceIntentType {
  bookTest,
  bookAppointment,
  openReports,
  openProfile,
  switchProfile,
  navigation,
  healthQuestion,
  unknown,
}

class VoiceIntent {
  final VoiceIntentType type;

  final String? entity;
  final String? value;

  final String? testName;
  final String? doctorSpeciality;
  final String? centerName;
  final String? profileName;
  final DateTime? date;
  final String? time;
  final bool? homeCollection;

  const VoiceIntent({
    required this.type,
    this.entity,
    this.value,
    this.testName,
    this.doctorSpeciality,
    this.centerName,
    this.profileName,
    this.date,
    this.time,
    this.homeCollection,
  });
}