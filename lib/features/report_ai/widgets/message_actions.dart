import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageActions extends StatelessWidget {
  final String message;
  final VoidCallback? onRegenerate;

  const MessageActions({
    super.key,
    required this.message,
    this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: "Copy",
          icon: const Icon(Icons.copy_outlined),
          onPressed: () async {
            await Clipboard.setData(
              ClipboardData(text: message),
            );

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Copied to clipboard"),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),

        IconButton(
          tooltip: "Regenerate",
          icon: const Icon(Icons.refresh),
          onPressed: onRegenerate,
        ),

        IconButton(
          tooltip: "Helpful",
          icon: const Icon(Icons.thumb_up_alt_outlined),
          onPressed: () {},
        ),

        IconButton(
          tooltip: "Not Helpful",
          icon: const Icon(Icons.thumb_down_alt_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}