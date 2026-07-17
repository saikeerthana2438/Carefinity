import 'package:flutter/material.dart';

import '../models/attachment_model.dart';
import 'attachment_preview.dart';
import 'upload_button.dart';

class ChatInput extends StatefulWidget {
  final List<AttachmentModel> attachments;
  final Function(String) onSend;
  final Function(AttachmentModel) onRemoveAttachment;
  final VoidCallback onGallery;
  final VoidCallback onCamera;
  final VoidCallback onPdf;
  final bool isLoading;

  const ChatInput({
    super.key,
    required this.attachments,
    required this.onSend,
    required this.onRemoveAttachment,
    required this.onGallery,
    required this.onCamera,
    required this.onPdf,
    this.isLoading = false,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty && widget.attachments.isEmpty) {
      return;
    }

    widget.onSend(text);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              if (widget.attachments.isNotEmpty)
  AttachmentPreview(
    attachments: widget.attachments,
    onRemove: widget.onRemoveAttachment,
  ),

              if (widget.attachments.isNotEmpty)
                const SizedBox(height: 12),

              Row(
                children: [

                  UploadButton(
                    onGallery: widget.onGallery,
                    onCamera: widget.onCamera,
                    onPdf: widget.onPdf,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      textCapitalization:
                          TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText:
                            "Ask Carefinity AI anything...",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(28),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  IconButton.filled(
                    onPressed:
                        widget.isLoading ? null : _send,
                    icon: widget.isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}