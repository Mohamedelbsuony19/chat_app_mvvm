import 'package:chat_c5/models/room.dart';
import 'package:flutter/material.dart';

import '../screens/chat/chat_screen.dart';

class RoomWidget extends StatelessWidget {
  final Room room;
  const RoomWidget(this.room, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context)
              .pushNamed(ChatScreen.routeName, arguments: room);
        });

        //
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffbfdae0),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${room.catid}.png',
              width: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(room.title)
          ],
        ),
      ),
    );
  }
}
