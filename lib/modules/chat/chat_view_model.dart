import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/datebase/database_utils.dart';
import 'package:chat_c6_online/models/message.dart';
import 'package:chat_c6_online/models/my_user.dart';
import 'package:chat_c6_online/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator>{


  late Room room;
  late MyUser currentUser;

  void AddMessageToChat(String messageContent)async{

    Message message= Message(roomId: room.id,
        content: messageContent,
        dateTime: DateTime.now().microsecondsSinceEpoch
        , SenderId: currentUser.id,
        SenderName: currentUser.username);
    try{
      var res= await DateBaseUtils.InsertMessageToFireStore(message);
      navigator?.clearForm();
    }catch (e){
      navigator?.showMessage(e.toString());
    }

  }

  Stream<QuerySnapshot<Message>> listenToUpdatesMessages(){

    return  DateBaseUtils.getMessageStreams(room.id);

  }

}

abstract class ChatNavigator extends BaseNavigator{


  void clearForm();
}