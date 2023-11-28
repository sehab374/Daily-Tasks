import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_f_connection/providers/my_provider.dart';

import '../../layout/home-screen.dart';
import '../../shared/firebase/firebase_functions.dart';

class LoginTab extends StatelessWidget {
  static const String routeName = "LoginTab";

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "please enter your email";
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[com]+")
                            .hasMatch(value);
                        if (!emailValid) return "please enter valid email";
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                  ),
                  // (?=.*[A-Z])       // should contain at least one upper case
                  //   (?=.*[a-z])       // should contain at least one lower case
                  //   (?=.*?[0-9])      // should contain at least one digit
                  //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
                  //     .{8,}             // Must be at least 8 characters in length

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "please enter your password";
                        final bool regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(value);
                        if (!regex) return "please enter valid password";
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // formKey.currentState!.validate();
                        if (formKey.currentState!.validate()) {
                          FirebaseFunctions.login(
                              emailController.text, passwordController.text,
                              () {
                                provider.initUser();
                            Navigator.pushNamedAndRemoveUntil(context,
                                HomeLayout.routeName, (route) => false);

                          }, (errorMessage) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                  title: Text("some errors"),
                                  content: Text(errorMessage),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("okay"))
                                  ]),
                            );
                          });
                        }
                      },
                      child: Text("Login"))
                ],
              ),
            ],
          )),
    );
  }
}
