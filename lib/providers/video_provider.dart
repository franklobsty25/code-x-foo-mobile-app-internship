import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ign/models/video.dart';
import 'package:http/http.dart' as http;

class VideoProvider extends ChangeNotifier {
  List<Video> _videos = [];

  List<Video> get videos {
    return [..._videos];
  }

  Future getVideosFromUrl() async {
    try {
      final response = await http.get(Uri.parse(
          'https://ign-apis.herokuapp.com/videos?startIndex=30&count=30'));

      if (response.statusCode == 200) {
        final videoData = jsonDecode(response.body);

        _videos = (videoData['data'] as List)
            .map((video) => Video.fromJson(video))
            .toList();

        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
