import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        initialData: null,
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy('created_on', descending: true)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.hasData &&
              streamSnapshot.connectionState == ConnectionState.active) {
            final documents = streamSnapshot.data.docs;

            return ListView.builder(
                reverse: true,
                itemCount: documents.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    child: MessageBubble(
                      imageUrl: documents[index].data()['imageUrl'],
                      message: documents[index].data()['text'],
                      isMe: documents[index].data()['userId'] == user.uid,
                      time: documents[index].data()['created_on'],
                      userId: documents[index].data()['userId'],
                    ),
                    padding: EdgeInsets.all(8),
                  );
                });
          }
          return Container();
        });
  }
}
