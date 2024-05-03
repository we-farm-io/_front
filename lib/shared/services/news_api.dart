import 'dart:convert';

import 'package:http/http.dart';
import 'package:smart_farm/features/home/models/news_model.dart';

class NewsService {
  Future<List<ArticleModel>> fetchNews() async {
    // Step 4: Fetch Dat
    final response = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=agriculture&sortBy=publishedat&apiKey=014f1282a1964550b09c963fc5c19c49"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // ignore: no_leading_underscores_for_local_identifiers
      final _articles = (jsonData['articles'] as List)
          .where((articleData) =>
              articleData['urlToImage'] != null &&
              articleData['description'] != null)
          .map((articleData) => ArticleModel(
                title: articleData['title'],
                description: articleData['description'],
                urlToImage: articleData['urlToImage'],
                url: articleData['url'],
                publishedAt:
                    DateTime.parse(articleData['publishedAt']).toLocal(),
              ))
          .toList();
      print(_articles[0].publishedAt);
      return _articles; // Step 5: Update State
    } else {
      throw Exception('Failed to load news');
    }
  }
}
