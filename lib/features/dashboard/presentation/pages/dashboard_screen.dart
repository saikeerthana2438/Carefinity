import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../navigation/bottom_navigation.dart';
import '../../../../voice_assistant/controllers/voice_controller.dart';
import '../../../../voice_assistant/widgets/floating_mic_button.dart';

import 'home_screen.dart';
import '../../../../screens/reports/reports_screen.dart';
import '../../../../screens/medication/medication_screen.dart';
import '../../../../screens/ai/ai_chat_screen.dart';
import '../../../../screens/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ReportsScreen(),
    MedicationScreen(),
    AiChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final voiceController = Provider.of<VoiceController>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),

            if (voiceController.recognizedText.isNotEmpty)
              Positioned(
                left: 20,
                right: 20,
                bottom: 100,
                child: Card(
                  elevation: 6,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "You",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(voiceController.recognizedText),

                            const SizedBox(height: 16),

                            const Text(
                              "Carefinity",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(voiceController.assistantResponse),
                          ],
                        ),
                      ),

                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          tooltip: "Close",
                          onPressed: () {
                            voiceController.clearConversation();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const Positioned(
              right: 20,
              bottom: 20,
              child: FloatingMicButton(),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}