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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.headline1.color),
                  ),
                  width: 140,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(12))),
              if (liked)
                 Icon(Icons.favorite,color: Theme.of(context).errorColor,),
                  
                
            ],
          ),
        ],
      ),
    );
  }
}
