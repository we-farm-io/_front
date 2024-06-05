import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/home/providers/news_provider.dart';
import 'package:smart_farm/shared/services/locale_provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    String locale = AppLocalizations.of(context)!.localeName;
    final double width = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.language,
          style: TextStyle(fontFamily: "poppins", fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(const Locale("en"));
              Provider.of<NewsProvider>(context, listen: false)
                  .getNews(context);
            },
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: locale == 'en'
                          ? Color(0xff34c759)
                          : Color(0xffF3f4f6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.english,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            locale == 'en' ? Colors.white : Color(0xff666c8e),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (locale == 'en')
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(const Locale("ar"));
              Provider.of<NewsProvider>(context, listen: false)
                  .getNews(context);
            },
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: locale == 'ar'
                          ? Color(0xff34c759)
                          : Color(0xffF3f4f6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.arabic,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            locale == 'ar' ? Colors.white : Color(0xff666c8e),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (locale == 'ar')
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
