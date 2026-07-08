import '../../../../screens/reports/reports_screen.dart';
import '../../../../screens/diagnostics/diagnostics_screen.dart';
import '../../../../screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../../screens/medication/medication_screen.dart';
import '../../../../core/widgets/bottom_nav.dart';
import 'home_screen.dart';
import '../../../../screens/doctor/doctor_screen.dart';
import '../../../../screens/ai/ai_chat_screen.dart';

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
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNav(
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







