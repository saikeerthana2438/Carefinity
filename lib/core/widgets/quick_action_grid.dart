import 'package:flutter/material.dart';
import '../../screens/reports/reports_screen.dart';
import '../../screens/doctor/doctor_screen.dart';
import '../../screens/diagnostics/diagnostics_screen.dart';
import '../../screens/medication/medication_screen.dart';
import '../../screens/ai/ai_chat_screen.dart';
class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.90,
      children:  [
  _QuickActionCard(
    title: "Book Doctor",
    subtitle: "Consult specialists",
    icon: Icons.medical_services,
    color: Color(0xFF2563EB),
    page: DoctorScreen(),
  ),
  _QuickActionCard(
    title: "Diagnostics",
    subtitle: "Book lab tests",
    icon: Icons.science,
    color: Color(0xFF10B981),
    page: DiagnosticsScreen(),
  ),
  _QuickActionCard(
    title: "AI Assistant",
    subtitle: "Health guidance",
    icon: Icons.smart_toy,
    color: Color(0xFFF59E0B),
    page: AiChatScreen(),
  ),
  _QuickActionCard(
    title: "Medication",
    subtitle: "Medicine Reminder",
    icon: Icons.medication,
    color: Color(0xFFEF4444),
    page: MedicationScreen(),
  ),
  _QuickActionCard(
  title: "Reports",
  subtitle: "Medical Reports",
  icon: Icons.description,
  color: Color(0xFF8B5CF6),
  page: ReportsScreen(),
),


],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget page;

   _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );
},
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}