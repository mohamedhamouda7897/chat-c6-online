import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/constant.dart';
import 'package:chat_c6_online/models/my_user.dart';
import 'package:chat_c6_online/modules/register/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../datebase/database_utils.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator>{


 // null
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   void CreateAccount(String email,String password,String fName,String lName,String username) async{
     String? message=null;
      try {
        navigator?.showLoading('Loading...',false);
        var result=await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        var user=MyUser(id: result.user?.uid??"", fName: fName,
            lName: lName, username: username, email: email);
       var userData= await DateBaseUtils.createDBUser(user);
       navigator?.hideDialog();
       navigator?.goToHome(user);

      } on FirebaseAuthException catch (e) {
        if (e.code == FirebaseErrors.WEEKPASSWORD) {
       message='The password provided is too weak.';
        } else if (e.code == FirebaseErrors.INUSE) {
          message='The account already exists for that email.';
        }

        navigator?.hideDialog();
        if(message!=null){
          navigator?.showMessage(message);
        }
      } catch (e) {
        print(e);
      }
  }
}