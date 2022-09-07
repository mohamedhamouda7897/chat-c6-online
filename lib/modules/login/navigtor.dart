import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/models/my_user.dart';

abstract class LoginNavigator extends BaseNavigator{


  void goToHome(MyUser user);
}