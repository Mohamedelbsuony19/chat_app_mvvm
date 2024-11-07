import 'package:chat_c5/models/message.dart';
import 'package:chat_c5/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return userProvider.user?.id == message.senderId
        ? SendMessage(message)
        : RecevedMessage(message);
  }
}

class SendMessage extends StatelessWidget {
  final Message message;
  const SendMessage(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0xFFE7FFDB),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Column(
            children: [
              Text(
                message.senderName,
                style: const TextStyle(color: Colors.red),
              ),
              Text(message.content),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(DateFormat('HH:mm')
              .format(DateTime.fromMillisecondsSinceEpoch(message.dateTime))),
        ),
      ],
    );
  }
}

class RecevedMessage extends StatelessWidget {
  final Message message;
  const RecevedMessage(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Column(
            children: [
              Text(
                message.senderName,
                style: const TextStyle(color: Colors.red),
              ),
              Text(message.content),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(DateFormat('HH:mm')
              .format(DateTime.fromMillisecondsSinceEpoch(message.dateTime))),
        ),
      ],
    );
  }
}
