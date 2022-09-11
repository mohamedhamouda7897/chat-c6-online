import 'package:chat_c6_online/modules/add_rooms/add_room.dart';
import 'package:chat_c6_online/modules/home/home.dart';
import 'package:chat_c6_online/modules/login/login_screen.dart';
import 'package:chat_c6_online/modules/register/register.dart';
import 'package:chat_c6_online/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'modules/chat/chat_screen.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await setupFlutterNotifications();
  showFlutterNotification(message);
  print("Handling a background message: ${message.messageId}");
}
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Notification Chat', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null ) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  printTOkenData();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  setupFlutterNotifications();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (c) => UserProvider())
  ], child: MyApp()));
}


Future<String?> printTOkenData()async{
  String? token = await messaging.getToken();
  print("token:${token??""}");
  return token;
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

    });
  }
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
        ChatScreen.routeName:(c)=>ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
