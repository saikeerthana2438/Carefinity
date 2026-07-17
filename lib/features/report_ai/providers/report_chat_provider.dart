import 'dart:io';

import 'package:flutter/material.dart';

import '../models/attachment_model.dart';
import '../models/chat_message.dart';
import '../repositories/report_chat_repository.dart';

class ReportChatProvider extends ChangeNotifier {
  final ReportChatRepository _repository = ReportChatRepository();

  final List<ChatMessage> _messages = [];
  final List<AttachmentModel> _attachments = [];

  bool _isTyping = false;

  List<ChatMessage> get messages => _messages;
  List<AttachmentModel> get attachments => _attachments;
  bool get isTyping => _isTyping;

  void newChat() {
    _messages.clear();
    _attachments.clear();
    _repository.startNewChat();
    notifyListeners();
  }

  Future<void> pickGallery() async {
    final file = await _repository.pickFromGallery();

    if (file == null) return;

    _attachments.add(
      AttachmentModel.fromFile(file),
    );

    notifyListeners();
  }

  Future<void> pickCamera() async {
    final file = await _repository.pickFromCamera();

    if (file == null) return;

    _attachments.add(
      AttachmentModel.fromFile(file),
    );

    notifyListeners();
  }

  Future<void> pickPdf() async {
    final file = await _repository.pickPdf();

    if (file == null) return;

    _attachments.add(
      AttachmentModel.fromFile(file),
    );

    notifyListeners();
  }

  void removeAttachment(AttachmentModel attachment) {
    _attachments.remove(attachment);
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty && _attachments.isEmpty) {
      return;
    }

    _messages.add(
      ChatMessage.user(
        text: message,
        attachments: List.from(_attachments),
      ),
    );

    _isTyping = true;
    notifyListeners();

    String response;

    if (_attachments.isNotEmpty &&
        _attachments.first.isImage) {
      response = await _repository.analyzeReport(
        File(_attachments.first.localPath),
        prompt: message.isEmpty ? null : message,
      );
    } else {
      response = await _repository.sendMessage(
        message,
      );
    }

    _messages.add(
      ChatMessage.ai(
        text: response,
      ),
    );

    _attachments.clear();

    _isTyping = false;

    notifyListeners();
  }

  Future<void> askFollowUp(String question) async {
    _messages.add(
      ChatMessage.user(
        text: question,
      ),
    );

    _isTyping = true;
    notifyListeners();

    final response =
        await _repository.askFollowUp(question);

    _messages.add(
      ChatMessage.ai(
        text: response,
      ),
    );

    _isTyping = false;

    notifyListeners();
  }
}