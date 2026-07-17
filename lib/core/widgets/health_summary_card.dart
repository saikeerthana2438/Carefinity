import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

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
      childAspectRatio: 1.8,
      children: [
        _FeatureCard(
          icon: Icons.smart_toy_rounded,
          color: Colors.blue,
          title: t.aiAssistant,
          subtitle: t.askHealthQuestions,
        ),

        _FeatureCard(
          icon: Icons.folder_copy_rounded,
          color: Colors.green,
          title: t.healthLocker,
          subtitle: t.medicalReports,
        ),

        _FeatureCard(
          icon: Icons.medication_rounded,
          color: Colors.orange,
          title: t.medicines,
          subtitle: t.medicineReminders,
        ),

        _FeatureCard(
          icon: Icons.calendar_month_rounded,
          color: Colors.red,
          title: t.appointments,
          subtitle: t.bookDoctors,
        ),

        _FeatureCard(
          icon: Icons.science_rounded,
          color: Colors.deepPurple,
          title: t.diagnostics,
          subtitle: t.bookLabTests,
        ),

        _FeatureCard(
          icon: Icons.family_restroom,
          color: Colors.teal,
          title: t.family,
          subtitle: t.manageMembers,
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

  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
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
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: color.withOpacity(.15),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
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