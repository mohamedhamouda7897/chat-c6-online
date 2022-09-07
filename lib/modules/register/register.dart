import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/models/my_user.dart';
import 'package:chat_c6_online/modules/home/home.dart';
import 'package:chat_c6_online/modules/login/login_screen.dart';
import 'package:chat_c6_online/modules/register/register_view_model.dart';
import 'package:chat_c6_online/modules/register/navigator.dart';
import 'package:chat_c6_online/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget{
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen,RegisterViewModel>
    implements RegisterNavigator {
  GlobalKey<FormState> keyForm=GlobalKey<FormState>();

  var firstNameController=TextEditingController();

  var lastNameController=TextEditingController();

  var userNameController=TextEditingController();

  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  @override
  RegisterViewModel initalViewModel() {

    return RegisterViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c)=>viewModel,
      child: Stack(
        children: [
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
              title: Text('Create Account'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your First name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Last name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(labelText: 'UserName'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        // format email valid
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Email not valid';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        if (text.length < 6) {
                          return 'Password should be at least 6 char';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(onPressed: () {
                      RegisterButtonFunction();
                    }, child: Text('Create Email')),
                    InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                        child: Text("Already Have An Account",style: TextStyle(fontSize:12,color: Colors.blue),))

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void RegisterButtonFunction()async{
    if(keyForm.currentState!.validate()){
      // create account with firebase
      viewModel.CreateAccount(emailController.text,passwordController.text,firstNameController.text,
      lastNameController.text,userNameController.text);
    }
  }

  @override
  void goToHome(MyUser user) {
    var userProvider=Provider.of<UserProvider>(context);
    userProvider.user=user;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }



}
