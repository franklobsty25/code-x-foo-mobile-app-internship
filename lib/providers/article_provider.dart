import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ign/models/article.dart';
import 'package:http/http.dart' as http;

class ArticleProvider extends ChangeNotifier {
  List<Article> _articles = [];
  List _content = [];
  int _count = 0;

  List<Article> get articles {
    return [..._articles];
  }

  int get count {
    return _count;
  }

  Future getArticlesFromUrl() async {
    try {
      final response =
          await http.get(Uri.parse('https://ign-apis.herokuapp.com/articles'));

      if (response.statusCode == 200) {
        final articleData = jsonDecode(response.body);

        _articles = (articleData['data'] as List)
            .map((article) => Article.fromJson(article))
            .toList();

        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getArticleCommentsCount(String contentId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://ign-apis.herokuapp.com/comments?ids=' + contentId));

      if (response.statusCode == 200) {
        final countData = jsonDecode(response.body);

        _content.add(countData['content'][0]);

        if (_content.isNotEmpty) {
          _content.retainWhere((content) => content['id'] == contentId);

          print(_content.length);

          _count = _content[0]['count'];

          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
