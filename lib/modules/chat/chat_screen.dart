import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/models/message.dart';
import 'package:chat_c6_online/modules/chat/chat_view_model.dart';
import 'package:chat_c6_online/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/room.dart';
import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  String messageContent='';
  var messageContentController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;

  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)?.settings.arguments as Room;
    var provider=Provider.of<UserProvider>(context);
    viewModel.room=room;
    viewModel.currentUser=provider.user!;
    viewModel.listenToUpdatesMessages();
    return Stack(children: [
      Container(
        child: Image.asset(
          'assets/images/main_bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(room.title),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.listenToUpdatesMessages(),
                    builder: (c,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()),);
                      }
                      var messages=snapshot.data?.docs.map((mess) =>mess.data()).toList();
                     return ListView.builder(
                          itemCount: messages?.length??0,
                          itemBuilder:(c,index){
                        return MessageWidget(messages![index]);
                      } );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (text){
                        messageContent=text;
                      },
                      controller: messageContentController,
                      decoration: InputDecoration(
                          hintText: 'Message Here',
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)))),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      viewModel.AddMessageToChat(messageContent);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Text(
                            'Send',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }

  @override
  ChatViewModel initalViewModel() => ChatViewModel();

  @override
  void clearForm() {
   messageContentController.clear();
  }
}
