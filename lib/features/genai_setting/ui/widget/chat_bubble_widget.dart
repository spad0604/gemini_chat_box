import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatBubble extends StatelessWidget {
  final bool isMine;
  final String? photoUrl;
  final String message;

  final _iconSize = 24.0;

  const ChatBubble(
      {required this.isMine,
      required this.photoUrl,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    // user avatar
    widgets.add(ClipRRect(
        borderRadius: BorderRadius.circular(_iconSize),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: photoUrl == null
              ? const _DefaultPersonWidget()
              : CachedNetworkImage(
                  imageUrl: photoUrl!,
                  width: _iconSize,
                  height: _iconSize,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const _DefaultPersonWidget(),
                  placeholder: (context, url) => const _DefaultPersonWidget()),
        )));

    //message bubble
    widgets.add(Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isMine ? Colors.black26 : Colors.black54),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Text(message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
      ),
    ));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: isMine ? widgets.reversed.toList() : widgets
      ),
    );
  }
}

class _DefaultPersonWidget extends StatelessWidget {
  const _DefaultPersonWidget({super.key});

  @override
  Widget build(BuildContext context) => const Icon(
        Icons.person,
        color: Colors.black,
        size: 24,
      );
}
