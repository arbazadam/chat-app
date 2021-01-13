import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        initialData: null,
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy('created_on', descending: true)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting &&
              streamSnapshot.data == null) {
            Center(child: CircularProgressIndicator());
          }
          if (streamSnapshot.hasData) {
            final documents = streamSnapshot.data.docs;

            return ListView.builder(
                reverse: true,
                itemCount: documents.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    child: MessageBubble(message: documents[index]['text'],isMe: documents[index]['userId']==user.uid,),
                    padding: EdgeInsets.all(8),
                  );
                });
          }
          return Container();
        });
  }
}
