import '../../models/voice_intent.dart';

class BookingContext {
  String? testName;
  DateTime? date;
  String? time;
  String? centerName;
  bool? homeCollection;

  bool get isComplete {
    return testName != null &&
        date != null &&
        time != null &&
        centerName != null &&
        homeCollection != null;
  }

  void clear() {
    testName = null;
    date = null;
    time = null;
    centerName = null;
    homeCollection = null;
  }
}

class ConversationManager {
  static final ConversationManager instance =
      ConversationManager._();

  ConversationManager._();

  final BookingContext booking = BookingContext();

  String? update(VoiceIntent intent) {
    if (intent.testName != null) booking.testName = intent.testName;
    if (intent.date != null) booking.date = intent.date;
    if (intent.time != null) booking.time = intent.time;
    if (intent.centerName != null) booking.centerName = intent.centerName;
    if (intent.homeCollection != null) {
      booking.homeCollection = intent.homeCollection;
    }

    if (booking.testName == null) {
      return "Which diagnostic test would you like to book?";
    }
    if (booking.date == null) {
      return "On which date would you like to book the test?";
    }
    if (booking.time == null) {
      return "What time would you prefer?";
    }
    if (booking.centerName == null) {
      return "Which diagnostic center would you like to visit?";
    }
    if (booking.homeCollection == null) {
      return "Do you need home sample collection?";
    }

    return null;
  }

  void reset() {
    booking.clear();
  }
}