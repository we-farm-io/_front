
import 'package:flutter/material.dart';
import 'package:smart_farm/features/home/models/news_model.dart';
import 'package:smart_farm/shared/services/news_api.dart';

class NewsProvider extends ChangeNotifier {
  final _service = NewsService();
  bool isLoading = false;
  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  Future<void> getNews() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.fetchNews();
    _articles = response;
    isLoading = false;
    notifyListeners();
  }
}
