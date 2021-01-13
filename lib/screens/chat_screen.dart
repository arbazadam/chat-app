import 'package:chat_app/screens/list_of_friends_screen.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              color: Colors.white,
                icon: RadiantGradientMask(child:FaIcon(FontAwesomeIcons.userFriends)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListOfFriends()));
                }),
            IconButton(
              //color: Colors.deepPurple,
              tooltip: 'Logout',
              icon:  RadiantGradientMask(child:FaIcon(FontAwesomeIcons.signOutAlt)),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
            // DropdownButton(
            //   items: [
            //     DropdownMenuItem(
            //       value: 'logout',
            //       child: Container(
            //         child: Row(
            //           children: [
            //             Icon(Icons.exit_to_app),
            //             Text('Logout'),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            //   icon: Icon(Icons.more_vert),
            //   onChanged: (identifier) {
            //     if (identifier == 'logout') {
            //       FirebaseAuth.instance.signOut();
            //     }
            //   },
            // )
          ],
          
          elevation: 0.0,
          
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

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.bottomLeft,
          radius: 0.5,
          colors: <Color>[
            Colors.teal,
            Colors.blue
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}