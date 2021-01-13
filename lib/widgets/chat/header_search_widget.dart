import 'package:chat_app/widgets/chat/search_box_widget.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
          alignment: Alignment.center,
         
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 54,
          decoration: BoxDecoration(
            color: Color(0xFFD6D6D6),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Colors.grey.withOpacity(0.23),
              ),
            ],
          ),
          child: Search()),
    )],
      ),
    );
  }
}
