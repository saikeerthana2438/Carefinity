import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:provider/provider.dart';
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
  ChangeNotifierProvider(
    create: (_) => CycleProvider(),
    child: const CarefinityApp(),
  ),
);
}