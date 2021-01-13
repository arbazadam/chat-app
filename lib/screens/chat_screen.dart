import 'package:chat_app/screens/list_of_friends_screen.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListOfFriends()));
                }),
            DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        Text('Logout'),
                      ],
                    ),
                  ),
                )
              ],
              icon: Icon(Icons.more_vert),
              onChanged: (identifier) {
                if (identifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
          elevation: 0,
          title: Text("Chat App"),
          centerTitle: true,
        ),
        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.add),
        //     onPressed: () {
        //       FirebaseFirestore.instance
        //           .collection("/chats/pQtWldT5sNdqOXMOPXtz/messages")
        //           .add({"text": "Aur bachhi bolna"});
        //     }),
        body: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ));
  }
}
