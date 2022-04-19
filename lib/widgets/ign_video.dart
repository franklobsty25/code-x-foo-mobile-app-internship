import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IgnVideo extends StatefulWidget {
  final String? url;
  const IgnVideo({Key? key, this.url}) : super(key: key);

  @override
  State<IgnVideo> createState() => _IgnVideoState();
}

class _IgnVideoState extends State<IgnVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url!)
      ..initialize().then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: FractionalOffset.bottomLeft +
                    const FractionalOffset(0.04, 0.08),
                children: [
                  VideoPlayer(
                    _controller,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow_outlined,
                      ),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
