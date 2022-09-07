import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/models/category.dart';
import 'package:chat_c6_online/modules/add_rooms/add_room_view_model.dart';
import 'package:chat_c6_online/modules/add_rooms/room_navigator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'AddRoom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends BaseState<AddRoom,AddRoomViewModel> implements AddRoomNavigator {
  
  var roomNameController=TextEditingController();

  var roomDescController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  var categories=Category
  .getCategories();
  late Category selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory=categories[0];
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c)=>viewModel,
      child: Stack(children: [
        Container(
          child: Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text(
            'Add Room'
          ),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0.0,),

        body:  Container(
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Form(
    key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Create New Room',style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                Image.asset('assets/images/room_bg.png'),
                TextFormField(
                  controller: roomNameController,
                  decoration: InputDecoration(
                    labelText: 'Room Name'
                  ),
                  validator: (text){
                    if(text==null || text.trim().isEmpty){
                      return 'Please Enter Room Name';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<Category>(
                        value: selectedCategory,

                          items: categories.map((catId) =>
                              DropdownMenuItem<Category>(
                                  value: catId,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(catId.image,height: 50,width: 60,),
                                  SizedBox(width: 12,),
                                  Text(catId.name),
                                ],
                              ))).toList(),
                          onChanged: (category){
                            if(category==null){
                              return;
                            }else{
                              selectedCategory=category;
                            }
                          }),
                    ),
                  ],
                ),
                TextFormField(
                  controller: roomDescController,
                  decoration: InputDecoration(
                      labelText: 'Room Description'
                  ),
                  validator: (text){
                    if(text==null || text.trim().isEmpty){
                      return 'Please Enter Room Description';
                    }
                    return null;
                  },
                ),
                ElevatedButton(onPressed: (){

                  validateForm();
    }, child: Text('Create Room'))

              ],
            ),
          ),
        ),
        )
      ]),
    );
  }
  validateForm(){
    if(formKey.currentState!.validate()==true){
      viewModel.createRoom(roomNameController.text,selectedCategory.id,
          roomDescController.text);
    }
  }
  @override
  AddRoomViewModel initalViewModel() {
    return AddRoomViewModel();
  }

  @override
  void roomCreated() {
    showMessage('Room Created Successfully ',actionName: 'Ok',voidCallback: (){
      hideDialog();
      Navigator.pop(context);
    });

  }
}
