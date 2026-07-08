import '../../services/diagnostic_history_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../family/family_profiles_screen.dart';
import '../../services/appointment_history_service.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AppointmentHistoryService _historyService =
      AppointmentHistoryService();
  final DiagnosticHistoryService _diagnosticHistoryService =
    DiagnosticHistoryService();

  final AuthService _authService = AuthService();

  late Future<List<Map<String, dynamic>>> appointments;
  late Future<List<Map<String, dynamic>>> diagnostics;
  @override
  void initState() {
    super.initState();
    appointments = _historyService.getAppointments();
    diagnostics = _diagnosticHistoryService.getBookings();
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
  child: ListTile(
    leading: const CircleAvatar(
      child: Icon(Icons.person),
    ),
    title: const Text("Logged in as"),
    subtitle: Text(user?.email ?? "Unknown User"),
  ),
),
                 
          

const SizedBox(height: 15),

Card(
  child: ListTile(
    leading: const CircleAvatar(
      backgroundColor: Color(0xFFE3F2FD),
      child: Icon(
        Icons.family_restroom,
        color: Colors.blue,
      ),
    ),
    title: const Text(
      "Family Profiles",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: const Text(
      "Manage family members",
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FamilyProfilesScreen(),
        ),
      );
    },
  ),
),



            const SizedBox(height: 20),

            const Text(
              "Appointment History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            
  FutureBuilder<List<Map<String, dynamic>>>(
                future: appointments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No appointments found."),
                    );
                  }

                  final data = snapshot.data!;

                  return ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: data.length,
  itemBuilder: (context, index) {
                      final appointment = data[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                          ),
                          title: Text(
                            appointment["doctor_name"],
                          ),
                          subtitle: Text(
                            "${appointment["appointment_date"]} • ${appointment["appointment_time"]}",
                          ),
                          trailing: Text(
                            appointment["status"],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          

          const SizedBox(height: 20),

const Text(
  "Diagnostic History",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

FutureBuilder<List<Map<String, dynamic>>>(
    future: diagnostics,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text("No diagnostic bookings found."),
        );
      }

      final data = snapshot.data!;

      return ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: data.length,
  itemBuilder: (context, index) {
          final booking = data[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.science,
                color: Colors.deepPurple,
              ),
              title: Text(
                booking["test_name"] ?? "",
              ),
              subtitle: Text(
                "${booking["center_name"]}\n${booking["booking_date"]} • ${booking["booking_time"]}",
              ),
              trailing: Text(
                booking["status"] ?? "",
              ),
            ),
          );
        },
      );
    },
  ),


const SizedBox(height: 20),


            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  await _authService.signOut();

                  if (!mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                    (_) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
                    ],
        ),
      ),
    ),
  );
}
}
