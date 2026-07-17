import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../screens/ai/ai_chat_screen.dart';
import '../../screens/reports/reports_screen.dart';
import '../../screens/medication/medication_screen.dart';
import '../../screens/doctor/doctor_screen.dart';
import '../../screens/diagnostics/diagnostics_screen.dart';
import '../../screens/family/family_profiles_screen.dart';

class HealthSummaryCard extends StatelessWidget {
  const HealthSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 0.9,
      children: [
        _FeatureCard(
          icon: Icons.smart_toy_rounded,
          color: Colors.blue,
          title: t.aiAssistant,
          subtitle: t.askHealthQuestions,
          page: const AiChatScreen(),
        ),

        _FeatureCard(
          icon: Icons.folder_copy_rounded,
          color: Colors.green,
          title: t.healthLocker,
          subtitle: t.medicalReports,
          page: const ReportsScreen(),
        ),

        _FeatureCard(
          icon: Icons.medication_rounded,
          color: Colors.orange,
          title: t.medicines,
          subtitle: t.medicineReminders,
          page: const MedicationScreen(),
        ),

        _FeatureCard(
          icon: Icons.calendar_month_rounded,
          color: Colors.red,
          title: t.appointments,
          subtitle: t.bookDoctors,
          page: const DoctorScreen(),
        ),

        _FeatureCard(
          icon: Icons.science_rounded,
          color: Colors.deepPurple,
          title: t.diagnostics,
          subtitle: t.bookLabTests,
          page: const DiagnosticsScreen(),
        ),

        _FeatureCard(
          icon: Icons.family_restroom,
          color: Colors.teal,
          title: t.family,
          subtitle: t.manageMembers,
          page: const FamilyProfilesScreen(),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final Widget page;

  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}