import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/datebase/database_utils.dart';
import 'package:chat_c6_online/modules/add_rooms/room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator>{
  void createRoom(String title,String catId,String desc)async{
    navigator?.showLoading('Creating Room...',false);
    String? message = null;
    try{
      var result=await DateBaseUtils.createRoom(title, catId, desc);
    }catch(e){
      message=e.toString();
      message='something went wrong';
    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }else{
      navigator?.roomCreated();
    }

  }

}