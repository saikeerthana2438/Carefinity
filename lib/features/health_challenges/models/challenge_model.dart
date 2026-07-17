class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final int target;
  final String unit;
  final int durationDays;
  final String badge;
  final int rewardPoints;

  const ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.target,
    required this.unit,
    required this.durationDays,
    required this.badge,
    required this.rewardPoints,
  });

  factory ChallengeModel.fromMap(Map<String, dynamic> map) {
    return ChallengeModel(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      target: map['target'] ?? 0,
      unit: map['unit'] ?? '',
      durationDays: map['duration_days'] ?? 0,
      badge: map['badge'] ?? '',
      rewardPoints: map['reward_points'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'target': target,
      'unit': unit,
      'duration_days': durationDays,
      'badge': badge,
      'reward_points': rewardPoints,
    };
  }
}