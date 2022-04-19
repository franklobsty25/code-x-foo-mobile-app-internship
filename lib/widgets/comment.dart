import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Icon(Icons.comment),
          SizedBox(
            width: 8.0,
          ),
          Text('971'), // Comments property not found on url
        ],
      ),
    );
  }
}
