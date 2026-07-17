import 'dart:io';

import '../services/gemini_chat_service.dart';
import '../services/report_upload_service.dart';

class ReportChatRepository {
  ReportChatRepository({
    GeminiChatService? geminiService,
    ReportUploadService? uploadService,
  })  : _geminiService = geminiService ?? GeminiChatService(),
        _uploadService = uploadService ?? ReportUploadService();

  final GeminiChatService _geminiService;
  final ReportUploadService _uploadService;

  /// Starts a new AI conversation
  void startNewChat() {
    _geminiService.startNewChat();
  }

  /// Send a normal chat message
  Future<String> sendMessage(String message) async {
    return await _geminiService.sendMessage(message);
  }

  /// Continue conversation after report analysis
  Future<String> askFollowUp(String question) async {
    return await _geminiService.askFollowUp(question);
  }

  /// Analyze uploaded report image
  Future<String> analyzeReport(
    File image, {
    String? prompt,
  }) async {
    return await _geminiService.analyzeReportImage(
      image,
      userPrompt: prompt,
    );
  }

  /// Upload Services

  Future<File?> pickFromGallery() async {
    return await _uploadService.pickFromGallery();
  }

  Future<File?> pickFromCamera() async {
    return await _uploadService.pickFromCamera();
  }

  Future<File?> pickPdf() async {
    return await _uploadService.pickPdf();
  }

  Future<List<File>> pickMultipleImages() async {
    return await _uploadService.pickMultipleImages();
  }
}