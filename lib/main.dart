import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'providers/language_provider.dart';


import 'features/health_challenges/providers/challenge_provider.dart';
import 'features/health_challenges/providers/health_points_provider.dart';

import 'voice_assistant/controllers/voice_controller.dart';
import 'features/women_health/providers/cycle_provider.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  Gemini.init(
    apiKey: dotenv.env['GEMINI_API_KEY']!,
  );

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ChallengeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => HealthPointsProvider(),
      ),
      MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => VoiceController(),
      ),
      ChangeNotifierProvider(
        create: (_) => CycleProvider(),
      ),
    ],
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
      ],
    child: const CarefinityApp(),
  ),
);
