import 'package:chat_app/screens/settings.dart';
import 'package:chat_app/service/firebase_service.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _user;
  @override
  void initState() {
    super.initState();
    _user =
        FirebaseService().getUserByUidF(FirebaseAuth.instance.currentUser.uid);
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print('On message handler $msg');
      return;
    }, onLaunch: (msg) {
      print('On launch handler $msg');
      return;
    }, onResume: (msg) {
      print('On Resume handler $msg');
      return;
    });
    fbm.getToken(); //This will get the token for the device and we can store it in the database to send notifications to a particular user.
    //Best usecase is when two participants are chatting with each other we can store the token of participant a and send the message from b as a push notification to participant a.
    fbm.subscribeToTopic('chat');
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          print('in the function');
          print(snapshot.data);
          print(snapshot.connectionState);
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            print('in the if');
            print(snapshot.data);
            print(snapshot.connectionState);
            return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  leading: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SettingsScreen.routeName);
                        },
                        child: CircleAvatar(
                          backgroundImage: snapshot.data.imageUrl != null
                              ? NetworkImage(snapshot.data.imageUrl)
                              : null,
                        ),
                      )),
                  title: Text(
                    snapshot.data.username,
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                        color: Colors.white,
                        icon: RadiantGradientMask(
                            child: FaIcon(FontAwesomeIcons.userFriends)),
                        onPressed: () {}),
                    IconButton(
                      tooltip: 'Logout',
                      icon: RadiantGradientMask(
                          child: FaIcon(FontAwesomeIcons.signOutAlt)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                actionsPadding:
                                    EdgeInsets.symmetric(horizontal: 2),
                                title: Text('Logging out'),
                                content:
                                    Text('Are you sure? You want to logout'),
                                actions: [
                                  GestureDetector(
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context).errorColor),
                                    ),
                                    onTap: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(_);
                                    },
                                  )
                                ],
                                backgroundColor: Colors.white,
                              );
                            });
                      },
                    )
                  ],
                  elevation: 0.5,
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(child: Messages()),
                    NewMessage(),
                  ],
                ));
          }
          print('in the else');
          print(snapshot.data);
          print(snapshot.connectionState);
          return Center(child: CircularProgressIndicator());
        });
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
          colors: <Color>[Colors.teal, Colors.blue],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
