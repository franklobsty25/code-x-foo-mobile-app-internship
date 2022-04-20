import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ign/models/article.dart';
import 'package:http/http.dart' as http;

class ArticleProvider extends ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles {
    return [..._articles];
  }

  Future getArticlesFromUrl() async {
    try {
      final response = await http.get(Uri.parse(
          'https://ign-apis.herokuapp.com/articles?startIndex=30&count=30'));

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
}
