import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/shared/services/locale_provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.change_language),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(Locale("en"));
            },
            child: Text(AppLocalizations.of(context)!.english),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(Locale("ar"));
            },
            child: Text(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }
}
