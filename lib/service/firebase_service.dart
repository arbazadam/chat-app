import 'package:chat_app/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirebaseService {
  final collection = FirebaseFirestore.instance.collection('users');
  Future<List<User>> getAllUsersExceptMe(String docId) async {
    final doc = await collection.doc(docId).get();
    final email = User.fromJSON(doc.data(), doc.id).email;

    final listOfUsers =
        await collection.where('email', isNotEqualTo: email).get();
    return listOfUsers.docs.map((e) {
      return User.fromJSON(e.data(), e.id);
    }).toList();
  }

  void addFriend(String myId, String friendId, String action) async {
    try {
      if (action == 'send') {
        //add the friend's uid to the requests array of myId
        await collection.doc(myId).update({
          'requests': FieldValue.arrayUnion([friendId])
        });
      }
      if (action == 'accepted') {
//remove the uid from the requests array and add it to friends array for the given my id.
        await collection.doc(friendId).update({
          'friends': FieldValue.arrayUnion([myId])
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<User>> showFriends(String myId) async {
    final doc = await collection.doc(myId).get();
    final data = doc.data();
  }

  Stream<User> getUserByUidS(String uid) async *{
      final doc = await collection.doc(uid).get();
       yield User.fromJSON(doc.data());
   
  }
  Future<User> getUserByUidF(String uid) async {
      final doc = await collection.doc(uid).get();
       return User.fromJSON(doc.data());
   
  }
  // Stream<String> getUsernameByUid(String uid){
  //   print('The uid of the newly created user is: $uid');
  //   final doc=collection.doc(uid).snapshots();
  //   return doc;
  // }
}
