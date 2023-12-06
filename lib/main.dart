import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_f_connection/providers/lang-provider.dart';
import 'package:todo_f_connection/providers/my_provider.dart';
import 'firebase_options.dart';
import 'layout/home-screen.dart';
import 'screens/login/login-tab.dart';
import 'screens/login/login.dart';
import 'screens/login/sign-up-tab.dart';
import 'screens/settings/settings_tab.dart';
import 'screens/tasks/edit-task.dart';
import 'screens/tasks/tasks_tab.dart';
import 'shared/styles/myThemeData.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /////////////////////////////////to make database local
  //FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MyProvider()),
    ChangeNotifierProvider(create: (context) => LangProvider())
  ], child: const MyApp())

      //     ChangeNotifierProvider(
      //     create: (context) => MyProvider(), child: const MyApp()
      // )

      );

  //child: const MyApp()
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var langProvider = Provider.of<LangProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],

      locale: Locale(langProvider.languageCode),
      debugShowCheckedModeBanner: false,
      initialRoute: Login.routeName,

      // provider.firebaseUser != null
      //     ? HomeLayout.routeName
      //     : Login.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        SettingsTab.routeName: (context) => SettingsTab(),
        TasksTab.routeName: (context) => TasksTab(),
        Login.routeName: (context) => Login(),
        //EditTask.routeName: (context) => EditTask(),
        LoginTab.routeName: (context) => LoginTab(),
        SignUpTab.routeName: (context) => SignUpTab()
      },
      theme: MyThemeData.lighttheme,
    );
  }
}
