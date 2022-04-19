import 'package:flutter/material.dart';
import 'package:ign/widgets/detail.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Detail(isVideo: true);
  }
}
