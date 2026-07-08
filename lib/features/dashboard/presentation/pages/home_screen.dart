
import 'package:flutter/material.dart';

import '../../../../core/widgets/appointment_card.dart';
import '../../../../core/widgets/doctor_card.dart';
import '../../../../core/widgets/greeting_card.dart';
import '../../../../core/widgets/health_summary_card.dart';
import '../../../../core/widgets/health_tip_card.dart';
import '../../../../core/widgets/quick_action_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              GreetingCard(),

              SizedBox(height: 24),

              const Text(
  "Carefinity Features",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

              SizedBox(height: 16),

              HealthSummaryCard(),

              SizedBox(height: 28),

              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              QuickActionGrid(),

              SizedBox(height: 28),

              Text(
                "Featured Doctors",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              DoctorCard(),

              SizedBox(height: 28),

              Text(
                "Upcoming Appointment",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              AppointmentCard(),

              SizedBox(height: 28),

              Text(
                "Daily Health Tip",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              HealthTipCard(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}