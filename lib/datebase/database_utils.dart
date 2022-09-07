import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/my_user.dart';
import '../models/room.dart';

class DateBaseUtils{

  static CollectionReference<MyUser>getUserCollection(){
    return  FirebaseFirestore.instance.collection(MyUser.CollectionName)
        .withConverter(fromFirestore: (snapshot,_)=>MyUser.fromJson(snapshot.data()!),
        toFirestore: (user,_)=>user.toJson());
  }
  static CollectionReference<Room>getRoomsCollection(){
    return  FirebaseFirestore.instance.collection(Room.CollectionRoomName)
        .withConverter(fromFirestore: (snapshot,_)=>Room.fromJson(snapshot.data()!),
        toFirestore: (room,_)=>room.toJson());
  }

   static Future<void> createRoom(String title,String catId,String desc){
   var roomsCollection= getRoomsCollection();
   var docRef=roomsCollection.doc();
   Room room=Room(id: docRef.id, title: title, desc: desc, catId: catId);
   return docRef.set(room);
  }

  static Future<void> createDBUser(MyUser user){
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser> readUser(String userId)async{
    var userSnapShot=await getUserCollection().doc(userId).get();
    return userSnapShot.data()!;
  }
}