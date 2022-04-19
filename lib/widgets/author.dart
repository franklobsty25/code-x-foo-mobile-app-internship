import 'package:flutter/material.dart';

class Author extends StatelessWidget {
  final String? name;
  final String? thumbnail;
  const Author({Key? key, this.name, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          (thumbnail != '')
              ? CircleAvatar(
                  backgroundImage: NetworkImage(thumbnail!),
                )
              : const SizedBox(),
          const SizedBox(width: 10.0),
          Text(name!),
        ],
      ),
    );
  }
}
