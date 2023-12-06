import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_f_connection/bottom-sheets/language-bottom-sheet.dart';

class SettingsTab extends StatefulWidget {
  static const String routeName = "settings";

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () {
              showLanguageButtonSheet();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.blue)),
              child: Text(AppLocalizations.of(context)!.english,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(AppLocalizations.of(context)!.themeing,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.blue)),
            child: Text(AppLocalizations.of(context)!.light,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  void showLanguageButtonSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: OutlineInputBorder(
          //borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) => LanguageBottomSheet(),
    );
  }
}
