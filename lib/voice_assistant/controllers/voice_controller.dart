import 'package:flutter/material.dart';
import '../services/speech_service.dart';
import '../services/intent_service.dart';
import '../models/voice_intent.dart';
import '../services/command_processor.dart';

class VoiceController extends ChangeNotifier {
  final SpeechService _speechService = SpeechService();
  final IntentService _intentService = IntentService();
  final CommandProcessor _commandProcessor = CommandProcessor();

  String recognizedText = "";
  bool isListening = false;
  VoiceIntent? detectedIntent;
  String assistantResponse = "";

  Future<void> initialize() async {
    await _speechService.initialize();
  }

  Future<void> startListening() async {
    isListening = true;
    notifyListeners();

    await _speechService.startListening(
      onResult: (text) async {
        // Store what the user said
        recognizedText = text;

        // Detect the user's intent
        detectedIntent = _intentService.detectIntent(text);

        // Process the command
        assistantResponse =
            await _commandProcessor.process(detectedIntent!);

        debugPrint("Recognized Text: $recognizedText");
        debugPrint("Assistant: $assistantResponse");

        notifyListeners();

        debugPrint("notifyListeners called");
      },
    );
  }

  Future<void> stopListening() async {
    await _speechService.stopListening();

    isListening = false;
    notifyListeners();
  }

  // ==========================
  // Clear conversation
  // ==========================
  void clearConversation() {
    recognizedText = "";
    assistantResponse = "";
    detectedIntent = null;
    notifyListeners();
  }
}