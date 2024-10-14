import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gemini/worker/genai_worker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mocktail/mocktail.dart';

class MockGenerativeModel extends Mock implements GenerativeModelWrapper{
}

void main() {
  final MockGenerativeModel model = MockGenerativeModel();

  test('given generateContent respone succes, and text is null, '
    'when sendToGemini,'
    'then return preset respone', () async {
    final GenAiWorking worker = GenAiWorking(wrapper: model);

    List<ChatContent> contents = [];
    final StreamSubscription subscription = worker.stream.listen((event) {
      contents = event;
    });

    //given
    when(() => model.generateContent(any())).thenAnswer((invocation) => Future.value(GenerateContentResponse(
      [Candidate(Content('user', []), null, null, null, null)],
      null,
    )));

    //when
    await worker.sendToGemini('this is my message');

    //then
    expect(contents.length, 2);
    expect(contents.first.sender, Sender.user);
    expect(contents.first.message, 'This is my message');

    expect(contents.last.sender, Sender.gemini);
    expect(contents.last.message, 'Unable to generate respone');
    subscription.cancel();
  });
}