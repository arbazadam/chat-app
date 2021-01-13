import 'package:flutter/material.dart';

class ListOfFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: ListView.separated(
          itemBuilder: (context, itemCount) {
            return Text('Hie');
          },
          separatorBuilder: (context, index) {
            return Divider(thickness: 1.0,);
          },
          itemCount: 10),
    );
  }
}
