import 'package:flutter/material.dart';



class Search extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            cursorColor: Theme.of(context).accentColor,
            onChanged: (value) {

            },
            decoration: InputDecoration(
              hintText: "Type a message",
              hintStyle: TextStyle(
                color: Theme.of(context).accentColor,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              // surffix isn't working properly  with SVG
              // thats why we use row
              // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
            ),
          ),
        ),
     IconButton(icon: Icon(Icons.send),onPressed: (){
       
     },)
      ],
    );
  }
}
