import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRegenerate;

  const ChatBubble({
    super.key,
    required this.message,
    this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final theme = Theme.of(context);

    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              if (message.attachments.isNotEmpty)
                ...message.attachments.map(
                  (attachment) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [

                          Icon(
                            attachment.isPdf
                                ? Icons.picture_as_pdf
                                : Icons.image,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              attachment.fileName,
                              overflow:
                                  TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (isUser)
                Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              else
                MarkdownBody(
                  data: message.text,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color:
                          theme.colorScheme.onSurface,
                      fontSize: 15,
                    ),
                    h1: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    h2: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              if (!isUser) ...[
                const SizedBox(height: 12),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    IconButton(
                      icon: const Icon(Icons.copy),
                      tooltip: "Copy",
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: message.text,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text("Copied"),
                            duration:
                                Duration(seconds: 1),
                          ),
                        );
                      },
                    ),

                    IconButton(
                      icon:
                          const Icon(Icons.refresh),
                      tooltip: "Regenerate",
                      onPressed: onRegenerate,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}