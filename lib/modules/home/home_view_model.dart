import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/datebase/database_utils.dart';
import 'package:chat_c6_online/modules/home/navigator.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{


  List<Room> rooms=[];
  // HomeViewModel(){
  //   getRooms();
  // }
  void getRooms()async{
   rooms= await DateBaseUtils.getRoomsFromFireStore();
  }
}