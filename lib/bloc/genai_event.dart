part of 'genai_bloc.dart';

sealed class GenaiEvent extends Equatable {
  const GenaiEvent();
}

class SendMessageEvent extends GenaiEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
