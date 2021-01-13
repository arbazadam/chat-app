import 'dart:io';

import 'package:chat_app/widgets/chat/header_search_widget.dart';
import 'package:chat_app/widgets/chat/search_box_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';
  User user = FirebaseAuth.instance.currentUser;
  File mediaFile;

  void _recordAudio() {
    print('record audio');
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    //FirebaseStorage.instance.ref('sentMedia/${user.uid}').putFile(mediaFile);
    //String url =
    //  await FirebaseStorage.instance.ref('sentMedia').getDownloadURL();
    //FirebaseFirestore.instance
    //     .collection('chat')
    //     .doc(user.uid)
    //     .set({'imageUrl': url});

    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': _enteredMessage, 'created_on': Timestamp.now()});
    _controller.clear();
  }

  void _openCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        mediaFile = File(pickedFile.path);
      }
    } catch (e) {
      print(e);
    }
  }

//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//                   child: HeaderWithSearchBox(
//             size: MediaQuery.of(context).size,
//           ),
//         ),
//         CircleAvatar(child: IconButton(icon: Icon(Icons.mic,color: Colors.white,),onPressed: null,),)
//       ],
//     );
//   }
// }

@override
Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(icon: Icon(Icons.camera), onPressed: _openCamera),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(icon: Icon(Icons.image), onPressed: _openCamera),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                  const Radius.circular(18.0),
                ))),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          ),
        ),
        IconButton(
            icon:
                _enteredMessage.trim().isEmpty ? getMicroPhoneIcon() : Icon(Icons.send,color: Theme.of(context).primaryColor,),
            onPressed:
                _enteredMessage.trim().isEmpty ? _recordAudio : _sendMessage)
      ],
    ),
  );
}

Widget getMicroPhoneIcon() {
  return GestureDetector(
    onLongPress: (){
      print('release me asap');
    },
        child: CircleAvatar(radius:28,child: Icon(Icons.mic),)
  );
}
}
