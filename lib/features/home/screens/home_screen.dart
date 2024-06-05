import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/home/providers/news_provider.dart';
import 'package:smart_farm/features/home/widgets/news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, provider, _) {
        
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: provider.articles.length,
              cacheExtent: 20,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final article = provider.articles[index];

                return NewsTemplate(
                  urlToImage: article.urlToImage,
                  title: article.title,
                  url: article.url,
                  description: article.description,
                  publishedAt: article.publishedAt,
                );
              });
        }
      },
    );
  }
}
