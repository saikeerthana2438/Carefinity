import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/language_provider.dart';

import '../../services/appointment_history_service.dart';
import '../../services/auth_service.dart';
import '../../services/diagnostic_history_service.dart';

import '../auth/login_screen.dart';
import '../family/family_profiles_screen.dart';

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
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.profile),
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
                  title: Text(t.loggedInAs),
                  subtitle: Text(
                    user?.email ?? t.unknownUser,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Card(
                child: Consumer<LanguageProvider>(
                  builder: (context, provider, child) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE8F5E9),
                        child: Icon(
                          Icons.language,
                          color: Colors.green,
                        ),
                      ),

                      title: Text(t.language),

                      subtitle: Text(
                        provider.locale.languageCode == "en"
                            ? t.english
                            : provider.locale.languageCode == "hi"
                                ? t.hindi
                                : t.telugu,
                      ),

                      trailing: const Icon(Icons.arrow_forward_ios),

                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  ListTile(
                                    title: Text(t.english),
                                    onTap: () async {
                                      await provider.changeLanguage("en");

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),

                                  ListTile(
                                    title: Text(t.hindi),
                                    onTap: () async {
                                      await provider.changeLanguage("hi");

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),

                                  ListTile(
                                    title: Text(t.telugu),
                                    onTap: () async {
                                      await provider.changeLanguage("te");

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
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
                  title: Text(
                    t.familyProfiles,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    t.manageFamilyMembers,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const FamilyProfilesScreen(),
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
  future: diagnostics,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(
        child: Text(t.noDiagnostics),
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
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFEDE7F6),
              child: Icon(
                Icons.science,
                color: Colors.deepPurple,
              ),
            ),
            title: Text(
              booking["test_name"] ?? "",
            ),
            subtitle: Text(
              "${booking["center_name"]}\n${booking["booking_date"]} • ${booking["booking_time"]}",
            ),
            isThreeLine: true,
            trailing: Text(
              _translateStatus(
                booking["status"] ?? "",
                t,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  },
),

const SizedBox(height: 30),

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
    label: Text(t.logout),
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  String _translateStatus(
    String status,
    AppLocalizations t,
  ) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return t.confirmed;

      case "pending":
        return t.pending;

      case "completed":
        return t.completed;

      case "cancelled":
        return t.cancelled;

      default:
        return status;
    }
  }
}