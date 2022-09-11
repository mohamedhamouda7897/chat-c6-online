import 'package:chat_c6_online/modules/chat/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../models/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/${room.catId}.jpeg',
              width: MediaQuery.of(context).size.width * .19,
              height: 100,
              fit: BoxFit.fill,
            ),
            Text(room.title),
          ],
        ),
      ),
    );
  }
}
