import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ReportAIService {

final GenerativeModel _model = GenerativeModel(
  model: 'gemini-3.5-flash',
  apiKey: dotenv.env['GEMINI_API_KEY']!,
);
  
  Future<Map<String, dynamic>> extractReportValues(File image) async {
    try {
      final bytes = await image.readAsBytes();

      final prompt = TextPart("""
You are an expert medical report analyzer.

Analyze the uploaded blood test report.

Extract ONLY these values if available:

- Hemoglobin
- Blood Sugar
- HbA1c
- Total Cholesterol
- LDL
- HDL
- Triglycerides
- Vitamin D
- Vitamin B12
- Creatinine
- Urea
- AST
- ALT

Return ONLY valid JSON.

Example:

{
  "hemoglobin": 11.6,
  "blood_sugar": 118,
  "hba1c": 5.7,
  "cholesterol": 165,
  "ldl": 98,
  "hdl": 55,
  "triglycerides": 140,
  "vitamin_d": 31,
  "vitamin_b12": 420,
  "creatinine": 0.9,
  "urea": 24,
  "ast": 28,
  "alt": 30
}

If a value is missing, return null.

Do not include markdown.
Do not explain anything.
""");

      final imagePart = DataPart(
        "image/jpeg",
        bytes,
      );

      final response = await _model.generateContent([
        Content.multi([
          prompt,
          imagePart,
        ])
      ]);

      final output = response.text ?? "{}";

      return jsonDecode(output);
    } catch (e) {
      throw Exception("Failed to analyze report: $e");
    }
  }
}