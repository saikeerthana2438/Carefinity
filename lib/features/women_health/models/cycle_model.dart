class CycleModel {
  final String? id;
  final DateTime lastPeriodDate;
  final int cycleLength;
  final int periodLength;
  final String mood;
  final List<String> symptoms;
  final String notes;
  final DateTime createdAt;

  CycleModel({
    this.id,
    required this.lastPeriodDate,
    required this.cycleLength,
    required this.periodLength,
    required this.mood,
    required this.symptoms,
    required this.notes,
    required this.createdAt,
  });

  factory CycleModel.fromMap(Map<String, dynamic> map) {
    return CycleModel(
      id: map['id'],
      lastPeriodDate: DateTime.parse(map['last_period_date']),
      cycleLength: map['cycle_length'],
      periodLength: map['period_length'],
      mood: map['mood'],
      symptoms: List<String>.from(map['symptoms'] ?? []),
      notes: map['notes'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
  if (id != null) 'id': id,
  'last_period_date': lastPeriodDate.toIso8601String(),
  'cycle_length': cycleLength,
  'period_length': periodLength,
  'mood': mood,
  'symptoms': symptoms,
  'notes': notes,
  'created_at': createdAt.toIso8601String(),
};
  }
}