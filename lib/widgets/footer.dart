import 'package:flutter/material.dart';
import 'package:ign/widgets/comment.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: const Text(
              'Comment link',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () async {
              try {
                await launch('https://ign.com');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          const Comment(),
        ],
      ),
    );
  }
}
