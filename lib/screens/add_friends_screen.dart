import 'package:chat_app/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final service=FirebaseService();
  final myId=FirebaseAuth.instance.currentUser.uid;
  
  @override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: service.getAllUsersExceptMe(myId),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => ListTile(
                        trailing: Wrap(
                          spacing: 18,
                          children: [
                            GestureDetector(child: FaIcon(FontAwesomeIcons.plus),onTap: (){
                              print('tap');
                            service.addFriend(myId,snapshot.data[index].id,'send');
                            },),
                            GestureDetector(child: FaIcon(FontAwesomeIcons.times),onTap: null,)
                          ],
                        ),
                        leading: CircleAvatar(
                          child: Text(snapshot.data[index].username
                              .toString()
                              .substring(0, 1)
                              .toUpperCase()),
                        ),
                        title: Text(snapshot.data[index].username)))
                : Center(child: CircularProgressIndicator())));
  }
  
}
