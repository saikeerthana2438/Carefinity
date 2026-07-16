import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/voice_controller.dart';

class FloatingMicButton extends StatelessWidget {
  const FloatingMicButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<VoiceController>(context);

    return FloatingActionButton(
      child: Icon(
        controller.isListening ? Icons.mic : Icons.mic_none,
      ),
      onPressed: () async {
        if (!controller.isListening) {
          await controller.initialize();
          await controller.startListening();
        } else {
          await controller.stopListening();
        }
      },
    );
  }
}