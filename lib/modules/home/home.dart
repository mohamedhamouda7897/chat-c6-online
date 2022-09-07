import 'package:chat_c6_online/modules/add_rooms/add_room.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Image.asset(
          'assets/images/main_bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text('Chat App'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AddRoom.routeName);
          },
          child: Icon(Icons.add),
        ),
        body: Container(),
      )
    ]);
  }
}
