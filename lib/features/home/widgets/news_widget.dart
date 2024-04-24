
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsTemplate extends StatefulWidget {
  const NewsTemplate(
      {super.key, this.title, this.url, this.description, this.urlToImage});

  final String? title, description, url, urlToImage;

  @override
  State<NewsTemplate> createState() => _NewsTemplateState();
}

class _NewsTemplateState extends State<NewsTemplate> {
  final browser = ChromeSafariBrowser();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            await browser.open(
                url: WebUri(widget.url ?? ''),
                settings: ChromeSafariBrowserSettings(
                    shareState: CustomTabsShareState.SHARE_STATE_OFF,
                    barCollapsingEnabled: true));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: widget.urlToImage ?? '',
                    width: 380,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.title ?? '',
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
                  widget.description ?? '',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
