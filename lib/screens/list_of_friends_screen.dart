import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/friends.dart';
import 'package:chat_app/screens/pending_friends_screen.dart';
import 'package:flutter/material.dart';

class ListOfFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
            tabs: [Text('Friends'), Text('Pending friends')],
          )),
          body: TabBarView(children: [FriendsScreen(),PendingFriends()],),
        ));
  }
}
