// import 'package:chat_app/service/firebase_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class FriendsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: FirebaseService()
//             .getUserByUid(FirebaseAuth.instance.currentUser.uid),
//         builder: (context, snapshot) => snapshot.hasData
//             ? Scaffold(
//                 body: ListView.separated(
//                     separatorBuilder: (context, index) => Divider(),
//                     itemCount: 10,
//                     itemBuilder: (context, index) => ListTile(
//                         trailing: Text(
//                           '7:30',
//                           style:
//                               TextStyle(fontSize: 10, color: Colors.grey[400]),
//                         ),
//                         onTap: () {},
//                         title: Text('Friend $index'),
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                               'https://image.shutterstock.com/image-photo/dubai-skyline-beautiful-city-close-600w-429620146.jpg'),
//                         ))),
//               )
//             : Center(
//                 child: Text('Goodbye'),
//               ));
//   }
// }
