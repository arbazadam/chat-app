import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
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
    Future<FirebaseApp> fb = Firebase.initializeApp();
    return Scaffold(
      body: FutureBuilder(
          future: fb,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder(builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return ChatScreen();
                }
                else
                {
                  return AuthScreen();
                }
              },stream: FirebaseAuth.instance.authStateChanges());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
