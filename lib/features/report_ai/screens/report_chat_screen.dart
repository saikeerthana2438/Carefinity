import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/report_chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/typing_indicator.dart';

class ReportChatScreen extends StatefulWidget {
  const ReportChatScreen({super.key});

  @override
  State<ReportChatScreen> createState() =>
      _ReportChatScreenState();
}

class _ReportChatScreenState
    extends State<ReportChatScreen> {

  final ScrollController _scrollController =
      ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildWelcome() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(
              Icons.health_and_safety,
              size: 80,
            ),

            SizedBox(height: 20),

            Text(
              "Carefinity AI",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Upload your medical reports and chat with AI just like ChatGPT or Gemini.",
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Try asking:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: Icon(Icons.description),
                title: Text("Explain this report"),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.monitor_heart),
                title: Text("Which values are abnormal?"),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.restaurant),
                title: Text("What foods should I avoid?"),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text("Give me a health summary"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ReportChatProvider>(
      builder: (context, provider, child) {

        _scrollToBottom();

        return Scaffold(

          appBar: AppBar(
            title: const Text("Carefinity AI"),
            centerTitle: false,

            actions: [

              IconButton(
                icon: const Icon(Icons.add_comment),
                tooltip: "New Chat",
                onPressed: provider.newChat,
              ),

            ],
          ),

          body: Column(
            children: [

              Expanded(
                child: provider.messages.isEmpty
                    ? _buildWelcome()
                    : ListView.builder(
                        controller: _scrollController,
                        padding:
                            const EdgeInsets.all(16),
                        itemCount:
                            provider.messages.length,
                        itemBuilder: (context, index) {

                          final message =
                              provider.messages[index];

                          return ChatBubble(
  message: message,
  onRegenerate: () async {
    await provider.askFollowUp(
      "Please regenerate your previous response.",
    );
  },
);

                        },
                      ),
              ),

              if (provider.isTyping)
                const TypingIndicator(),

              ChatInput(
  attachments: provider.attachments,

  isLoading: provider.isTyping,

  onGallery: () async {
    await provider.pickGallery();
  },

  onCamera: () async {
    await provider.pickCamera();
  },

  onPdf: () async {
    await provider.pickPdf();
  },

  onRemoveAttachment: (attachment) {
    provider.removeAttachment(attachment);
  },

  onSend: (message) async {
    await provider.sendMessage(message);

    if (!mounted) return;

    _scrollToBottom();
  },
),


            ],
          ),
        );
      },
    );
  }
}