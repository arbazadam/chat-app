import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final controller = TextEditingController();
  var _enteredMessage = '';
  var file;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 3, 5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0xffd6d6d6),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      print('button pressed');
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.smile,
                      color: Colors.teal,
                    )),
                Expanded(
                  child: file == null
                      ? TextField(
                          onSubmitted: (value) {
                            _sendMessage();
                          },
                          controller: controller,
                          cursorColor: Colors.teal,
                          onChanged: (value) {
                            setState(() {
                              _enteredMessage = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                              color: Colors.teal,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // surffix isn't working properly  with SVG
                            // thats why we use row
                            // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        )
                      : Container(
                          height: 100,
                          child: Image.file(file),
                        ),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.image),
                  onPressed: () {
                    _getImageFromGallery(true);
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.camera),
                  onPressed: () {
                    _getImageFromGallery(false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
      IconButton(
        icon: _enteredMessage.isEmpty && file == null
            ? FaIcon(FontAwesomeIcons.microphone)
            : FaIcon(FontAwesomeIcons.paperPlane),
        onPressed:
            _enteredMessage.isEmpty && file == null ? _sendAudio : _sendMessage,
      )
    ]);
  }

  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (file == null) {
      FocusScope.of(context).unfocus();

      FirebaseFirestore.instance.collection('chat').add({
        'text': _enteredMessage,
        'created_on': Timestamp.now(),
        'userId': user.uid
      });
      controller.clear();
      setState(() {
        _enteredMessage = '';
      });
    } else {
      final ref = FirebaseStorage.instance
          .ref()
          .child('sharedMedia')
          .child(path.basename(file.path) + ".jpg");

      final task = ref.putFile(file);
      setState(() {
        file = null;
      });
      task.then(
          (element) async => FirebaseFirestore.instance.collection('chat').add({
                'created_on': Timestamp.now(),
                'userId': user.uid,
                'imageUrl': await ref.getDownloadURL()
              }));
    }
  }

  void _sendAudio() {
    print('send audio');
  }

  void _getImageFromGallery(bool source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: source ? ImageSource.gallery : ImageSource.camera,
          imageQuality: 80);
      if (pickedFile != null) {
        setState(() {
          file = File(pickedFile.path);
        });
      } else {
        //print('no file picked');
      }
    } catch (e) {
      print(e);
    }
  }
}
