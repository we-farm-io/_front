import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsTemplate extends StatefulWidget {
  const NewsTemplate(
      {super.key,
      this.title,
      this.url,
      this.description,
      this.urlToImage,
      this.publishedAt});

  final String? title, description, url, urlToImage;
  final DateTime? publishedAt;
  @override
  State<NewsTemplate> createState() => _NewsTemplateState();
}

class _NewsTemplateState extends State<NewsTemplate> {
  final browser = ChromeSafariBrowser();
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          await browser.open(
              url: WebUri(widget.url ?? ''),
              settings: ChromeSafariBrowserSettings(
                  shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  barCollapsingEnabled: true));
        },
        child: Column(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/noPhoto.png'),
                placeholder: (context, url) => const Image(
                    image: AssetImage("assets/images/LoadingPicture.gif")),
                imageUrl: widget.urlToImage ?? '',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title ?? '',
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            //TODO description is disabled for now
            // Text(
            //   widget.description ?? '',
            //   textDirection: TextDirection.ltr,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 15,
            //     color: Colors.grey[800],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Builder(builder: (context) {
                  final difference = now.difference(widget.publishedAt!);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2, right: 3),
                          child: SvgPicture.asset(
                            "assets/icons/clock.svg",
                            height: 17,
                          ),
                        ),
                        Text(
                          difference.inMinutes < 60
                              ? '${difference.inMinutes}min ago'
                              : difference.inHours < 24
                                  ? '${difference.inHours}h ago'
                                  : difference.inDays < 30
                                      ? '${difference.inDays}d ago'
                                      : widget.publishedAt
                                              ?.toString()
                                              .split(' ')[0] ??
                                          '',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            letterSpacing: 0.12,
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
