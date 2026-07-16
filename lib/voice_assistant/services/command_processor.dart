import '../models/voice_intent.dart';
import 'conversation/conversation_manager.dart';
import '../../services/diagnostic_booking_service.dart';

class CommandProcessor {
  final ConversationManager _conversation = ConversationManager.instance;
  final DiagnosticBookingService _bookingService =
      DiagnosticBookingService();

  Future<String> process(VoiceIntent intent) async {
    // Update conversation with latest information
    String? question = _conversation.update(intent);

    // If information is still missing, ask the next question
    if (question != null) {
      return question;
    }

    // All required information is available
    final booking = _conversation.booking;

    await _bookingService.bookDiagnostic(
      patientName: "Patient", // Replace later with logged-in user's name
      phoneNumber: "9999999999", // Replace later with user's phone number
      centerName: booking.centerName!,
      testName: booking.testName!,
      price: "0",
      bookingDate: booking.date!,
      bookingTime: booking.time!,
      homeCollection: booking.homeCollection!,
    );

    _conversation.reset();

    return "Your ${booking.testName} has been booked successfully at ${booking.centerName} on ${booking.date} at ${booking.time}.";
  }
}