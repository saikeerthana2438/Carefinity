import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/voice_controller.dart';

class VoiceButton extends StatelessWidget {
  const VoiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VoiceController>(
      builder: (context, controller, child) {
        return FloatingActionButton(
          onPressed: () async {
            if (controller.isListening) {
              await controller.stopListening();
            } else {
              await controller.startListening();
            }
          },
          child: Icon(
            controller.isListening ? Icons.mic : Icons.mic_none,
          ),
        );
      },
    );
  }
}