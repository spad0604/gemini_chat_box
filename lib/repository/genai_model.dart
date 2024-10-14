import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GenAiModel {
  late final GenerativeModel _model;
  late final ChatSession _session;

  GenAiModel() {
    final apiKey = dotenv.env['API_KEY'] ?? '';

    _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
    _session = _model.startChat();
  }

  Future<GenerateContentResponse> sendMessage(Content content) => _session.sendMessage(content);
}
