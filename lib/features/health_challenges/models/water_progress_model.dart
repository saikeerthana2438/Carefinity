class WaterProgressModel {
  final int waterMl;
  final bool completed;

  const WaterProgressModel({
    required this.waterMl,
    required this.completed,
  });

  factory WaterProgressModel.fromMap(Map<String, dynamic> map) {
    return WaterProgressModel(
      waterMl: map['water_ml'] ?? 0,
      completed: map['completed'] ?? false,
    );
  }
}