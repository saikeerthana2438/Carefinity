import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiChatService {
  GeminiChatService() {
    _chat = _model.startChat();
  }

  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-3.5-flash',
    apiKey: dotenv.env['GEMINI_API_KEY']!,
  );

  late ChatSession _chat;

  /// Keeps track of uploaded reports in the current conversation.
  final List<File> uploadedReports = [];

  /// Starts a fresh conversation.
  void startNewChat() {
    _chat = _model.startChat();
    uploadedReports.clear();
  }

  /// Send a normal text message.
  Future<String> sendMessage(String message) async {
    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );

      return response.text ?? "No response received.";
    } catch (e) {
      return "Error: $e";
    }
  }

  /// Analyze an uploaded medical report image.
  Future<String> analyzeReportImage(
    File image, {
    String? userPrompt,
  }) async {
    try {
      uploadedReports.add(image);

      final bytes = await image.readAsBytes();

      final prompt = userPrompt?.trim().isNotEmpty == true
          ? userPrompt!
          : '''
You are Carefinity AI, an expert medical report assistant.

Analyze the uploaded medical report.

Explain the report in simple language.

Include:

## Summary

## Normal Findings

## Abnormal Findings

## Medical Significance

## Diet Recommendations

## Lifestyle Advice

## Whether a doctor consultation is recommended.

Do NOT diagnose with certainty.

Always recommend consulting a doctor if serious abnormalities are found.
''';

      final response = await _model.generateContent([
        Content.multi([
          TextPart(prompt),
          DataPart(
            'image/jpeg',
            bytes,
          ),
        ])
      ]);

      return response.text ?? "Unable to analyze report.";
    } catch (e) {
      return "Error: $e";
    }
  }

  /// Continue chatting after a report has already been analyzed.
  Future<String> askFollowUp(String question) async {
    try {
      final response = await _chat.sendMessage(
        Content.text(question),
      );

      return response.text ?? "No response.";
    } catch (e) {
      return "Error: $e";
    }
  }
}