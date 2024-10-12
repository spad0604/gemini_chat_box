import 'package:flutter/material.dart';
import 'package:gemini/widget/chat_bubble_widget.dart';
import 'package:gemini/widget/message_box_widget.dart';
import 'package:gemini/worker/genai_worker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GenAiWorking _worker = GenAiWorking();

  final photoUrl =
      'https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg';

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<List<ChatContent>>(
                        stream: _worker.stream,
                        builder: (context, snapshot) {
                          final List<ChatContent> data = snapshot.data ?? [];

                          return ListView(
                              children: data.map((e) {
                                final bool isMine = e.sender == Sender.user;
                                //final String? photoUrl = isMine ? null : photoUrl;
                                return ChatBubble(isMine: isMine,
                                    photoUrl: photoUrl,
                                    message: e.message
                                );
                              }
                              ).toList()
                          );
                        }
                    )),
                MessageBox(
                  onSendMessage: (value) {
                    _worker.sendToGemini(value);
                  },
                )
              ],
            )),
      ),
    );
  }
}
