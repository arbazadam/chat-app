import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final message;
  final isMe;
  MessageBubble({this.message, this.isMe});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          liked = !liked;
        });
      },
      child: Row(
        mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  child: Text(widget.message,
                      style: TextStyle(
                          color: widget.isMe ? Colors.white : Colors.black)
                      // Theme.of(context).accentTextTheme.headline1.color),
                      ),
                  width: 140,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                      gradient: widget.isMe
                          ? LinearGradient(colors: [
                             Colors.blue,
                              Colors.teal[200]
                            ])
                          : LinearGradient(
                              colors: [Colors.grey[300], Colors.grey[300]]),
                      borderRadius: BorderRadius.only(
bottomLeft: widget.isMe?Radius.circular(15):Radius.zero,
bottomRight: Radius.circular(15),
topLeft: Radius.circular(15),
                          topRight: !widget.isMe
                              ? Radius.circular(15)
                              : Radius.elliptical(3, 4)))),
              if (liked)
                Icon(
                  Icons.favorite,
                  color: Theme.of(context).errorColor,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
