import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageBubble extends StatefulWidget {
  final message;
  final isMe;
  final time;
  final userId;
  final imageUrl;
  MessageBubble({this.message, this.isMe, this.time, this.userId,this.imageUrl});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (){
        print('swiped to right');
      },
          child: GestureDetector(
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
                    child: widget.message!=null?Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            initialData: null,
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .get(),
                            builder: (context, snapshot) => snapshot.hasData &&
                                    snapshot.connectionState !=
                                        ConnectionState.waiting
                                ? Text(
                                    snapshot.data['username'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : CircularProgressIndicator(),
                          ),
                          SizedBox(height: 5),
                          Text(widget.message,
                              style: TextStyle(
                                  color:
                                      widget.isMe ? Colors.white : Colors.black)
                              // Theme.of(context).accentTextTheme.headline1.color),
                              ),
                        ],
                      ),
                    ):Container(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            initialData: null,
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .get(),
                            builder: (context, snapshot) => snapshot.hasData &&
                                    snapshot.connectionState !=
                                        ConnectionState.waiting
                                ? Text(
                                    snapshot.data['username'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : CircularProgressIndicator(),
                          ),
                        Image.network(widget.imageUrl),
                      ],
                    )),
                    width: 140,
                    padding:widget.imageUrl==null? EdgeInsets.symmetric(vertical: 10, horizontal: 14):null,
                    decoration:widget.imageUrl==null? BoxDecoration(
                        boxShadow: [
                          widget.isMe
                              ? BoxShadow(
                                  color: Colors.teal[50].withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 20,
                                  offset:
                                      Offset(2, 8), // changes position of shadow
                                )
                              : BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2)),
                        ],
                        gradient: widget.isMe
                            ? LinearGradient(
                                colors: [Colors.blue, Colors.teal[200]])
                            : LinearGradient(
                                colors: [Colors.grey[300], Colors.grey[300]]),
                        borderRadius: BorderRadius.only(
                            bottomLeft:
                                widget.isMe ? Radius.circular(15) : Radius.zero,
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: !widget.isMe
                                ? Radius.circular(15)
                                : Radius.elliptical(3, 4))):null),
                if (liked)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                    child: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                      size: 19,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
