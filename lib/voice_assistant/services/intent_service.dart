import '../models/voice_intent.dart';

class IntentService {
  VoiceIntent detectIntent(String text) {
    final command = text.toLowerCase();

    // ===============================
    // Follow-up conversation replies
    // ===============================

    if (command == "tomorrow") {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        date: DateTime.now().add(const Duration(days: 1)),
      );
    }

    if (command == "today") {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        date: DateTime.now(),
      );
    }

    if (command.contains("9")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        time: "09:00 AM",
      );
    }

    if (command.contains("10")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        time: "10:00 AM",
      );
    }

    if (command.contains("11")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        time: "11:00 AM",
      );
    }

    if (command.contains("apollo")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        centerName: "Apollo Diagnostics",
      );
    }

    if (command.contains("thyrocare")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        centerName: "Thyrocare",
      );
    }

    if (command.contains("vijaya")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        centerName: "Vijaya Diagnostics",
      );
    }

    if (command == "yes") {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        homeCollection: true,
      );
    }

    if (command == "no") {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        homeCollection: false,
      );
    }

    // ===============================
    // Test Booking
    // ===============================

    if (command.contains("blood") || command.contains("cbc")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "CBC",
        date: command.contains("tomorrow")
            ? DateTime.now().add(const Duration(days: 1))
            : null,
        time: command.contains("morning")
            ? "09:00 AM"
            : null,
        homeCollection: command.contains("home"),
      );
    }

    if (command.contains("sugar")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "Blood Sugar",
      );
    }

    if (command.contains("thyroid")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "Thyroid",
      );
    }

    if (command.contains("mri")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "MRI",
      );
    }

    if (command.contains("ct")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "CT Scan",
      );
    }

    if (command.contains("ecg")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "ECG",
      );
    }

    if (command.contains("xray") || command.contains("x-ray")) {
      return VoiceIntent(
        type: VoiceIntentType.bookTest,
        testName: "X-Ray",
      );
    }

    // ===============================
    // Reports
    // ===============================

    if (command.contains("report")) {
      return VoiceIntent(
        type: VoiceIntentType.openReports,
      );
    }

    // ===============================
    // Doctor Appointment
    // ===============================

    if (command.contains("appointment") ||
        command.contains("doctor")) {

      String? speciality;

      if (command.contains("cardiologist")) {
        speciality = "Cardiologist";
      } else if (command.contains("dermatologist")) {
        speciality = "Dermatologist";
      } else if (command.contains("pediatrician")) {
        speciality = "Pediatrician";
      }

      return VoiceIntent(
        type: VoiceIntentType.bookAppointment,
        doctorSpeciality: speciality,
      );
    }

    // ===============================
    // Profile Switching
    // ===============================

    if (command.contains("mother")) {
      return VoiceIntent(
        type: VoiceIntentType.switchProfile,
        profileName: "Mother",
      );
    }

    if (command.contains("father") || command.contains("dad")) {
      return VoiceIntent(
        type: VoiceIntentType.switchProfile,
        profileName: "Father",
      );
    }

    if (command.contains("wife")) {
      return VoiceIntent(
        type: VoiceIntentType.switchProfile,
        profileName: "Wife",
      );
    }

    return VoiceIntent(
      type: VoiceIntentType.unknown,
    );
  }
}