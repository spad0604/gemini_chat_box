import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/features/genai_setting/ui/widget/chat_bubble_widget.dart';
import 'package:gemini/features/genai_setting/ui/widget/message_box_widget.dart';

import '../bloc/genai_bloc.dart';
import '../../../data/chat_content.dart';

class GenaiSettingScreen extends StatelessWidget {
  final photoUrl =
      'https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg';

  const GenaiSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(child:
              BlocBuilder<GenaiBloc, GenaiState>(builder: (context, state) {
            final List<ChatContent> data = [];

            if (state is MessagesUpdate) {
              data.addAll(state.contents);
            }
            return ListView(
                children: data.map((e) {
              final bool isMine = e.sender == Sender.user;
              //final String? photoUrl = isMine ? null : photoUrl;
              return ChatBubble(
                  isMine: isMine, photoUrl: photoUrl, message: e.message);
            }).toList());
          })),
          MessageBox(
            onSendMessage: (value) {
              context.read<GenaiBloc>().add(SendMessageEvent(value));
            },
          )
        ],
      )),
    );
  }
}
