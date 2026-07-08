import 'package:flutter_gemini/flutter_gemini.dart';

class ReportAIService {
  final Gemini gemini = Gemini.instance;

  Future<String> analyzeReport(String reportText) async {
    try {
      final response = await gemini.text(
        """
You are an experienced physician.

Analyze the following medical report.

Provide your answer in this format:

## Summary

## Abnormal Findings

## Possible Causes

## Lifestyle Recommendations

## Diet Recommendations

## Follow-up Advice

## Disclaimer

Medical Report:

$reportText
""",
      );

      return response?.output ??
          "Unable to analyze the report.";
    } catch (e) {
      return "Error: $e";
    }
  }
}