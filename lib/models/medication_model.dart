class MedicationModel {
  final String id;
  final String medicineName;
  final String dosage;
  final String frequency;
  final String reminderTime;
  final DateTime startDate;
  final DateTime endDate;

  MedicationModel({
    required this.id,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.reminderTime,
    required this.startDate,
    required this.endDate,
  });

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      id: map['id'].toString(),
      medicineName: map['medicine_name'] ?? '',
      dosage: map['dosage'] ?? '',
      frequency: map['frequency'] ?? '',
      reminderTime: map['reminder_time'] ?? '',
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicine_name': medicineName,
      'dosage': dosage,
      'frequency': frequency,
      'reminder_time': reminderTime,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}