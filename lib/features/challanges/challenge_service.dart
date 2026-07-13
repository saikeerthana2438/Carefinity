import 'challenge_model.dart';

class ChallengeService {

  List<Challenge> challenges = [

    Challenge(
      title: "Walk 10,000 Steps",
      icon: "🚶",
      goal: 10000,
    ),

    Challenge(
      title: "Drink 2L Water",
      icon: "💧",
      goal: 8,
    ),

    Challenge(
      title: "Sleep 8 Hours",
      icon: "😴",
      goal: 8,
    ),

    Challenge(
      title: "30-Day Yoga",
      icon: "🧘",
      goal: 30,
    ),

  ];

  int streak = 5;

  List<String> badges = [
    "🥉 Beginner",
    "🔥 7-Day Streak",
  ];

  void updateProgress(Challenge challenge, int value) {

    challenge.progress += value;

    if(challenge.progress >= challenge.goal){

      challenge.progress = challenge.goal;
      challenge.completed = true;

      if(!badges.contains("🏆 ${challenge.title}")){
        badges.add("🏆 ${challenge.title}");
      }
    }
  }
}