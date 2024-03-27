import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTemplate extends StatelessWidget {
  const NewsTemplate(
      {super.key, this.title, this.url, this.description, this.urlToImage});

  final String? title, description, url, urlToImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: urlToImage ?? '',
              width: 380,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title ?? '',
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            description ?? '',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.grey[800],
            ),
          )
        ],
      ),
    );
  }
}
