import 'package:chat_c6_online/modules/add_rooms/add_room.dart';
import 'package:chat_c6_online/modules/home/home.dart';
import 'package:chat_c6_online/modules/login/login_screen.dart';
import 'package:chat_c6_online/modules/register/register.dart';
import 'package:chat_c6_online/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (c) => UserProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      routes: {
        RegisterScreen.routeName: (c) => RegisterScreen(),
        LoginScreen.routeName: (c) => LoginScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
        AddRoom.routeName: (c) => AddRoom(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
