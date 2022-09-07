import 'package:flutter/material.dart';

class BaseViewModel<T extends BaseNavigator> extends ChangeNotifier{

  T? navigator=null;
}

abstract class BaseNavigator{
  void showLoading(String message , bool isDissmissable);
  void showMessage(String message);
  void hideDialog();

}

abstract class BaseState<T extends StatefulWidget , VM extends BaseViewModel>
    extends State<T> implements BaseNavigator{

  late VM viewModel;

  VM initalViewModel(); // object

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel=initalViewModel(); // object
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoading(String message,bool isDissmissable) {
    showDialog(context: context,
        barrierDismissible: isDissmissable
        ,builder: (c){
      return AlertDialog(
          title:
          Center(child: CircularProgressIndicator(),));
    });
  }

  @override
  void showMessage(String message,
      {String? actionName, VoidCallback? voidCallback}) {
    List<Widget> actions=[];
    if(actionName!=null){
      actions.add(TextButton(onPressed: voidCallback, child:Text(actionName)));
    }
    showDialog(context: context, builder: (c){
      return
        AlertDialog(
            actions: actions,
            title:Row(

          children: [
            Expanded(child: Text(message)),
          ],
        ));
    });
  }
}