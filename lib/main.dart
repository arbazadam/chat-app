import 'package:chat_app/screens/added_friends_screen.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen()
      },
      title: 'Chat_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.pink,
        primarySwatch: Colors.teal,
        backgroundColor: Colors.pink,
        accentColor: Colors.teal,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.teal[200],
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ParentApp(),
    );
  }
}

class ParentApp extends StatelessWidget {
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                return ChatScreen();
              } else {
                return AuthScreen();
              }
            },
            stream: FirebaseAuth.instance.authStateChanges()));
  }
}
