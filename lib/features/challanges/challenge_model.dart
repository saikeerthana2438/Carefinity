class Challenge {
  final String title;
  final String icon;
  final int goal;
  int progress;
  bool completed;

  Challenge({
    required this.title,
    required this.icon,
    required this.goal,
    this.progress = 0,
    this.completed = false,
  });

  double get percentage => progress / goal;
}