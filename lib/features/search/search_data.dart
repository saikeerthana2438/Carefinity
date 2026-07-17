import 'package:flutter/material.dart';

import 'models/search_item.dart';

import 'package:provider/provider.dart';

import 'package:my_first_app/features/report_ai/providers/report_chat_provider.dart';
import 'package:my_first_app/features/report_ai/screens/report_chat_screen.dart';
// Import your screens
import 'package:my_first_app/screens/doctor/doctor_screen.dart';
import 'package:my_first_app/screens/diagnostics/diagnostics_screen.dart';
import 'package:my_first_app/screens/diagnostics/diagnostic_booking_screen.dart';
import 'package:my_first_app/screens/diagnostics/diagnostic_center_screen.dart';
import 'package:my_first_app/screens/reports/reports_screen.dart';

import 'package:my_first_app/screens/ai/ai_chat_screen.dart';
import 'package:my_first_app/screens/medication/medication_screen.dart';
import 'package:my_first_app/screens/profile/profile_screen.dart';
import 'package:my_first_app/screens/family/family_profiles_screen.dart';
import 'package:my_first_app/screens/appointments/appointment_booking_screen.dart';
import 'package:my_first_app/features/health_challenges/screens/health_challenges_screen.dart';

class SearchData {
  static List<SearchItem> items(BuildContext context) {
    return [
      SearchItem(
        title: "Doctor Consultation",
        subtitle: "Consult specialist doctors",
        icon: Icons.medical_services,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DoctorScreen(),
            ),
          );
        },
      ),

      SearchItem(
        title: "Diagnostics",
        subtitle: "Book diagnostic tests",
        icon: Icons.biotech,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DiagnosticsScreen(),
            ),
          );
        },
      ),

      

      SearchItem(
        title: "Medical Reports",
        subtitle: "View uploaded reports",
        icon: Icons.description,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ReportsScreen(),
            ),
          );
        },
      ),

      SearchItem(
        title: "Analyze Report",
        subtitle: "AI Report Analysis",
        icon: Icons.analytics,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
  create: (_) => ReportChatProvider(),
  child: const ReportChatScreen(),
)
            ),
          );
        },
      ),

      SearchItem(
        title: "AI Health Assistant",
        subtitle: "Chat with Carefinity AI",
        icon: Icons.smart_toy,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AiChatScreen(),
            ),
          );
        },
      ),

      SearchItem(
        title: "Medication Reminder",
        subtitle: "Medicine reminders",
        icon: Icons.medication,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MedicationScreen(),
            ),
          );
        },
      ),

      SearchItem(
        title: "Family Profiles",
        subtitle: "Manage family members",
        icon: Icons.family_restroom,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FamilyProfilesScreen(),
            ),
          );
        },
      ),

      

      SearchItem(
        title: "Health Challenges",
        subtitle: "Track daily challenges",
        icon: Icons.emoji_events,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HealthChallengesScreen(),
            ),
          );
        },
      ),

      SearchItem(
        title: "Profile",
        subtitle: "Manage your account",
        icon: Icons.person,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );
        },
      ),
    ];
  }
}