import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  Future<String> getHealthResponse(String prompt) async {
    try {
      final response = await Gemini.instance.text(
        '''
You are Carefinity AI, a helpful healthcare assistant.

Rules:
- Never diagnose with certainty.
- Give general health guidance only.
- Suggest consulting a doctor if symptoms are serious.
- Keep answers short and easy to understand.

User Question:
$prompt
''',
      );

      return response?.output ?? "Sorry, I couldn't generate a response.";
    } catch (e) {
      return "Error: $e";
    }
  }
}