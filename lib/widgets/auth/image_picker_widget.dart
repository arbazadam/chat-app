import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File f) _imagePickFn;
  UserImagePicker(this._imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File f;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 10,
                color: Colors.grey,
                spreadRadius: 2)
          ],
        ),
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: f != null ? FileImage(f) : null,
            radius: 40),
      ),

      // Positioned(
      //     child: CircleAvatar(
      //     backgroundColor: Colors.blue,
      //     radius: 16,
      //     child: IconButton(
      //       padding: EdgeInsets.zero,
      //       icon: Icon(Icons.camera),
      //       color: Colors.white,
      //       onPressed: () {},
      //     ),
      //   ),
      //     bottom: 1,
      //     right: 3)
      FlatButton.icon(
        textColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final picker = ImagePicker();
          final pickedFile = await picker.getImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              f = File(pickedFile.path);
            });
            widget._imagePickFn(f);
          }
        },
        icon: FaIcon(FontAwesomeIcons.camera),
        label: Text('Add image'),
      ),
    ]);
  }
}
