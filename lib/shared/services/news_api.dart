import 'dart:convert';

import 'package:http/http.dart';
import 'package:smart_farm/features/home/models/news_model.dart';

class NewsService {
  Future<List<ArticleModel>> fetchNews() async {
    // Step 4: Fetch Data

    final response = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=الزراعة&sortBy=popularity&apiKey=014f1282a1964550b09c963fc5c19c49"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final _articles = (jsonData['articles'] as List)
          .where((articleData) =>
              articleData['urlToImage'] != null &&
              articleData['description'] != null)
          .map((articleData) => ArticleModel(
                title: articleData['title'],
                description: articleData['description'],
                urlToImage: articleData['urlToImage'],
                url: articleData['url'],
              ))
          .toList();
      return _articles; // Step 5: Update State
    } else {
      throw Exception('Failed to load news');
    }
  }
}
