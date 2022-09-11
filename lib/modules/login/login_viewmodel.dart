import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/constant.dart';
import 'package:chat_c6_online/modules/login/navigtor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../datebase/database_utils.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  var firebaseAuth=FirebaseAuth.instance;
  void login(String email,String password)async{
    String? message=null;
    try {
      navigator?.showLoading('Loading...', false);
      var result=await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      var user=await DateBaseUtils.readUser(result.user?.uid??"");
      if(user ==null){
        message='Failed to complete sign in , please try again later..';
      }else{
        navigator?.hideDialog();
        navigator?.goToHome(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.USERNOTFOUND) {
        message='No user found for that email.';
      } else if (e.code == FirebaseErrors.WRONGPASS) {
        message='Wrong password provided for that user.';
      }
      if (e.code == FirebaseErrors.WEEKPASSWORD) {
        message='The password provided is too weak.';
      } else if (e.code == FirebaseErrors.INUSE) {
        message='The account already exists for that email.';
      }
      navigator?.hideDialog();
      if(message !=null){
        navigator?.showMessage(message);
      }
    } catch (e) {
      print(e);
    }
  }
}