import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_f_connection/models/user_model.dart';
import 'package:todo_f_connection/shared/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel =
        await FirebaseFunctions.readUserFromFirestore(firebaseUser!.uid);
    notifyListeners();
  }
}
