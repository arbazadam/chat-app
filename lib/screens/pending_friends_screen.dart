import 'package:chat_app/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PendingFriends extends StatefulWidget {
  @override
  _PendingFriendsState createState() => _PendingFriendsState();
}

class _PendingFriendsState extends State<PendingFriends> {
  FirebaseService service=FirebaseService();
  final myId=FirebaseAuth.instance.currentUser.uid;
  var future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
future=service.showFriends(myId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(builder: (context,snapshot){
        if(snapshot.hasData && snapshot.connectionState==ConnectionState.active)
        {
          return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) => ListTile(
                trailing: Wrap(
    spacing: 18, // space between two icons
    children: <Widget>[
      FaIcon(FontAwesomeIcons.check), // icon-1
      FaIcon(FontAwesomeIcons.times), // icon-2
    ],
  ),
                title: Text('Friend $index'),
                leading: CircleAvatar(
                  child: FaIcon(FontAwesomeIcons.user),
                ),
              ));
        }
        else
        {
          return Center(child: Text('No pending friend requests'),);
        }
      },future: future,)
    );
  }
}
