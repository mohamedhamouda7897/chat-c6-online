import 'package:chat_c6_online/models/message.dart';
import 'package:chat_c6_online/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return userProvider.user?.id==message.SenderId?Padding(
      padding: const EdgeInsets.all(8.0),
      child: SendMessage(message),
    ):Padding(
      padding: const EdgeInsets.all(8.0),
      child: RecivedMessage(message),
    );
  }
}

class SendMessage extends StatelessWidget {
  Message message;
  SendMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(message.dateTime.toString()),
        Expanded(child: Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(topRight:Radius.circular(12) ,topLeft:Radius.circular(12)
                  ,bottomLeft:Radius.circular(12) ),
            ),
            child: Text(message.content,style: TextStyle(color: Colors.white),))),

      ],
    );
  }
}

class RecivedMessage extends StatelessWidget {
  Message message;
  RecivedMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(topRight:Radius.circular(12)
                  ,topLeft:Radius.circular(12)
                  ,bottomLeft:Radius.circular(12) ),
            ),
            child: Text(message.content,style: TextStyle(color: Colors.black),))),
        Text(message.dateTime.toString()),
      ],
    );
  }
}
