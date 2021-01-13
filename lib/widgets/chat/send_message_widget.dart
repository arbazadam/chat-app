import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final controller = TextEditingController();
  var _enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,3,5),
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
                  child: TextField(
                    onSubmitted:(value){
_sendMessage();
                    } ,
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
        icon: _enteredMessage.isEmpty
            ? FaIcon(FontAwesomeIcons.microphone)
            : FaIcon(FontAwesomeIcons.paperPlane),
        onPressed: _enteredMessage.isEmpty ? _sendAudio : _sendMessage,
      )
    ]);
  }

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'created_on': Timestamp.now(),
      'userId': user.uid
    });
    controller.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  void _sendAudio() {
    print('send audio');
  }

  void _getImageFromGallery(bool source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: source ? ImageSource.gallery : ImageSource.camera);
      if (pickedFile != null) {
        print('file picked');
      } else {
        print('no file picked');
      }
    } catch (e) {
      print(e);
    }
  }
}
