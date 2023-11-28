import 'package:flutter/material.dart';


import 'login-tab.dart';
import 'sign-up-tab.dart';

class Login extends StatelessWidget {
  static const String routeName = "Login";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Text("To Do List"),
              bottom: TabBar(tabs: [
                Tab(
                  child: Text("Login",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white)),
                  icon: Icon(Icons.login),
                ),
                Tab(
                  child: Text("Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white)),
                  icon: Icon(Icons.ac_unit),
                )
              ])),
          body: TabBarView(children: [LoginTab(), SignUpTab()]),
        ));
  }
}
