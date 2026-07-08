import '../../services/gemini_service.dart';
import 'package:flutter/material.dart';


class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();

  bool _isLoading = false;
  final List<Map<String, dynamic>> _messages = [
    {
      "isUser": false,
      "text":
          "👋 Hello! I'm Carefinity AI. Describe your symptoms and I'll provide general health guidance.",
    }
  ];

  Future<void> sendMessage() async {
  final text = _controller.text.trim();

  if (text.isEmpty) return;

  setState(() {
    _messages.add({
      "isUser": true,
      "text": text,
    });

    _isLoading = true;
  });

  _controller.clear();

  final response = await _geminiService.getHealthResponse(text);

  if (!mounted) return;

  setState(() {
    _messages.add({
      "isUser": false,
      "text": response,
    });

    _isLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Health Assistant"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
  child: Column(
    children: [
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final message = _messages[index];
            final isUser = message["isUser"] as bool;

            return Align(
              alignment: isUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                constraints: const BoxConstraints(maxWidth: 320),
                decoration: BoxDecoration(
                  color: isUser
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message["text"],
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          },
        ),
      ),

      if (_isLoading)
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: CircularProgressIndicator(),
        ),
    ],
  ),
),
          
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(),
                      decoration: const InputDecoration(
                        hintText: "Describe your symptoms...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FloatingActionButton(
                    onPressed: sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}