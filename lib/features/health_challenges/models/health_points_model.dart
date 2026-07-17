class HealthPointsModel {
  final String userId;
  final int points;

  const HealthPointsModel({
    required this.userId,
    required this.points,
  });

  factory HealthPointsModel.fromMap(Map<String, dynamic> map) {
    return HealthPointsModel(
      userId: map['user_id'],
      points: map['points'] ?? 0,
    );
  }
}