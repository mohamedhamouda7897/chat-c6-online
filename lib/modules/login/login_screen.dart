import 'package:chat_c6_online/base.dart';
import 'package:chat_c6_online/models/my_user.dart';
import 'package:chat_c6_online/modules/home/home.dart';
import 'package:chat_c6_online/modules/login/login_viewmodel.dart';
import 'package:chat_c6_online/modules/login/navigtor.dart';
import 'package:chat_c6_online/modules/register/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel> implements LoginNavigator {

  var keyForm=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
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
                      LoginButtonFunction();
                    }, child: Text('Login')),

                    InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                        },
                        child: Text("Don't Have An Account",style: TextStyle(fontSize:12,color: Colors.blue),))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void LoginButtonFunction(){
    if(keyForm.currentState!.validate()==true){
      // please login
      viewModel.login(emailController.text,passwordController.text);
    }
  }
  @override
  LoginViewModel initalViewModel() {
    return LoginViewModel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }

  @override
  void goToHome(MyUser user) {
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    userProvider.user=user;
    Navigator.pushReplacementNamed(context,HomeScreen.routeName);
  }
}
