import 'package:google_generative_ai/google_generative_ai.dart';

class GenAiModel {
  late final GenerativeModel _model;

  GenAiModel() {
    final apiKey = "AIzaSyDUjO0Mt6T-okamHp8DXruDmaoFOYMlM4M";

    _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  Future<GenerateContentResponse> sendMessage(List<Content> content) => _model.generateContent(content);
}