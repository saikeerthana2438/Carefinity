import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Row(
              children: [

                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.blue,
                    size: 34,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Dr. Sarah Johnson",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Cardiologist",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [

                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: Colors.blue,
                          ),

                          const SizedBox(width: 6),

                          const Text(
                            "Tomorrow • 10:30 AM",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [

                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Text(
                      "Carefinity Medical Center",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                    label: Text(lang.call),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility),
                    label: Text(lang.viewDetails), // Replace later with a dedicated "View Details" localization
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}