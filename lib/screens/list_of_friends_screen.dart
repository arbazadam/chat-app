import 'package:chat_app/screens/add_friends_screen.dart';
import 'package:chat_app/screens/added_friends_screen.dart';

import 'package:chat_app/screens/pending_friends_screen.dart';
import 'package:flutter/material.dart';

class ListOfFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
            tabs: [
              Text('Chats'),
              Text('Pending friends'),
              Text('Add Friends'),
            ],
          )),
          body: TabBarView(
            children: [
              //FriendsScreen(),
              PendingFriends(),
              AddFriends(),
            ],
          ),
        ));
  }
}
