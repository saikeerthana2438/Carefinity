import '../../../../core/widgets/health_challenge_card.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/features/search/widgets/search_bar_widget.dart';
import '../../../../core/widgets/women_health_card.dart';
import '../../../../core/widgets/appointment_card.dart';
import '../../../../core/widgets/doctor_card.dart';
import '../../../../core/widgets/greeting_card.dart';
import '../../../../core/widgets/health_summary_card.dart';
import '../../../../core/widgets/health_tip_card.dart';
import '../../../../core/widgets/quick_action_grid.dart';
import '../../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GreetingCard(),
            children: [
              const GreetingCard(),

SizedBox(height: 20),

SearchBarWidget(),

const SizedBox(height: 28),

              HealthSummaryCard(),

              SizedBox(height: 24),

              WomenHealthCard(),

              const SizedBox(height: 30),

            Text(
                t.quickActions,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const QuickActionGrid(),

SizedBox(height: 28),

Text(
  "Health Challenges",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

SizedBox(height: 16),

HealthChallengeCard(),

const SizedBox(height: 30),

Text(
  t.topDoctors,
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

              const SizedBox(height: 16),

              const DoctorCard(),

              const SizedBox(height: 30),

              Text(
                t.upcomingAppointment,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const AppointmentCard(),

              const SizedBox(height: 30),

              Text(
                t.todaysHealthTip,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const HealthTipCard(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}