import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Comment extends StatefulWidget {
  final String? contentId;
  Comment({Key? key, this.contentId}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List _content = [];
  int _count = 0;

  _getArticleCommentCounts(String contentId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://ign-apis.herokuapp.com/comments?ids=' + contentId));

      if (response.statusCode == 200) {
        final countData = jsonDecode(response.body);

        _content = countData['content'];

        setState(() {
          this._count = _content[0]['count'];
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _getArticleCommentCounts(widget.contentId!);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.comment),
          SizedBox(
            width: 8.0,
          ),
          Text('${this._count}'),
        ],
      ),
    );
  }
}
