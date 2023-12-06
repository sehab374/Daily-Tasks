import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/lang-provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LangProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(children: [
        InkWell(
          onTap: () {
            langProvider.changeLanguage("en");
          },
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.english,
                style: TextStyle(fontSize: 30),
              ),
              Spacer(),
              langProvider.languageCode == "en"
                  ? Icon(
                      Icons.done,
                      size: 35,
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
        InkWell(
          onTap: () {
            langProvider.changeLanguage("ar");
          },
          child: Row(
            children: [
              Text(AppLocalizations.of(context)!.arabic,
                  style: TextStyle(fontSize: 30)),
              Spacer(),
              langProvider.languageCode == "en"
                  ? SizedBox.shrink()
                  : Icon(
                      Icons.done,
                      size: 35,
                    )
            ],
          ),
        ),
      ]),
    );
  }
}
//SizedBox.shrink()
