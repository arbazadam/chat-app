import 'package:chat_app/widgets/chat/send_message_widget.dart';

import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return SendMessage();
  }
}
