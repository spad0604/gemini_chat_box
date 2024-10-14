import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini/repository/genai_model.dart';
import 'package:gemini/worker/genai_worker.dart';
import 'package:gemini/utils/bloc_extension.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../data/chat_content.dart';

part 'genai_event.dart';
part 'genai_state.dart';

class GenaiBloc extends Bloc<GenaiEvent, GenaiState> {
  final List<ChatContent> _content = [];

  final GenAiModel _model = GenAiModel();

  GenaiBloc() : super(GenaiInitial()) {
    on<SendMessageEvent>(_sendMessage);
  }

  void _sendMessage(SendMessageEvent event, Emitter<GenaiState> emit) async{
    _content.add(ChatContent.user(event.message));
    emitSafely(MessagesUpdate(List.from(_content)));

    try {
      final respone = await _model.sendMessage([Content.text(event.message)]);

      final String? text = respone.text;

      if(text == null) {
        _content.add(const ChatContent.gemini('Error'));
      } else {
        _content.add(ChatContent.gemini(text));
      }
    } catch(e) {
      _content.add(const ChatContent.gemini('Error'));
    }

    emitSafely(MessagesUpdate(List.from(_content)));
  }
}
