import 'package:flutter/material.dart';
import 'package:gemini/widget/chat_bubble_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final photoUrl = 'https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg';
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ChatBubble(isMine: false, photoUrl: photoUrl, message: 'This is message from me This is message from me This is message from me This is message from me This is message from me This is message from me This is message from me This is message from me '),
                ChatBubble(isMine: true, photoUrl: photoUrl, message: 'This is message from me This is message from me This is message from me This is message from me This is message from me This is message from me This is message from me This is message from me '),
              ],
            ),
          )
        ),
      ),
    );
  }
}