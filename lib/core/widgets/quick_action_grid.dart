import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../screens/ai/ai_chat_screen.dart';
import '../../screens/diagnostics/diagnostics_screen.dart';
import '../../screens/doctor/doctor_screen.dart';
import '../../screens/medication/medication_screen.dart';
import '../../screens/reports/reports_screen.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      childAspectRatio: 0.90,
      children: [
        _QuickActionCard(
          title: lang.appointments,
          subtitle: "Consult specialists",
          icon: Icons.medical_services_rounded,
          color: const Color(0xFF2563EB),
          page: const DoctorScreen(),
        ),
        _QuickActionCard(
          title: lang.diagnostics,
          subtitle: "Book lab tests",
          icon: Icons.science_rounded,
          color: const Color(0xFF10B981),
          page: const DiagnosticsScreen(),
        ),
        _QuickActionCard(
          title: "AI Assistant",
          subtitle: "Health guidance",
          icon: Icons.smart_toy_rounded,
          color: const Color(0xFFF59E0B),
          page: const AiChatScreen(),
        ),
        _QuickActionCard(
          title: lang.medicines,
          subtitle: "Medicine reminders",
          icon: Icons.medication_rounded,
          color: const Color(0xFFEF4444),
          page: const MedicationScreen(),
        ),
        _QuickActionCard(
          title: lang.reports,
          subtitle: "Medical reports",
          icon: Icons.description_rounded,
          color: const Color(0xFF8B5CF6),
          page: const ReportsScreen(),
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

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
  padding: const EdgeInsets.all(18),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          icon,
          color: color,
          size: 28,
        ),
      ),

      const SizedBox(height: 14),

      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      Expanded(
        child: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ),

      Row(
        children: [
          Text(
            "Open",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_forward_rounded,
            size: 18,
            color: color,
          ),
        ],
      ),
    ],
  ),
),
        ),
      ),
    );
  }
}