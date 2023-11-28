import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../models/user_model.dart';

class FirebaseFunctions {
//////////////////////////////////////// hold tasks collection
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.tojson();
      },
    );
  }

  static Future<void> addTask(TaskModel taskModel) {
    ////////////////////////////////////////////////////create collection if it is not exist
    var collection = getTasksCollection();

    ////////////////////////////////////////////////////create document in case of i want to send id
    //var docRef = collection.doc("sdxcfgvhjnklbvt");

    ////////////////////////////////////////////////////create document in case of i want id auto increament
    var docRef = collection.doc();

    //////////////////////////////////////////////////// pass id of document to object of task model
    taskModel.id = docRef.id;

    //////////////////////////////////////////////////// save  object of task model as a document
    return docRef.set(taskModel);
  }

  Future<QuerySnapshot<TaskModel>> getAllTasks() {
    return getTasksCollection().get();
  }

  /////////to work with real time changes
  //// 1- replace future with stream in return type of function
  //// 2- replace get() with snapshots()
  ////in ui : replace future builder with stream builder and future with stream

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    return getTasksCollection()
    .where("userId",isEqualTo:FirebaseAuth.instance.currentUser!.uid )
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        //.orderBy("date")
        .snapshots();
  }

//
// // to work with one time read
// static Future<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
//   return getTasksCollection()
//       .where("date",
//           isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
//       //.orderBy("date")
//       .get();
// }

  static void deleteTask(String id) {
    getTasksCollection().doc(id).delete();
  }

  ///////////////////////////////////////////update isDone
  // static void updateTask(String id, bool isDone) {
  //   getTasksCollection().doc(id).update({"isDone": isDone});
  // }

  //////////////////////////////////update is done another way (more generic)
  static void updateTask(TaskModel task) {
    getTasksCollection().doc(task.id).update(task.tojson());
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static Future<void> creatUser(String userName, int userAge, String email,
      String pass, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (credential.user?.uid != null) {
        //////////////////////////////////////////////////////
        UserModel user = UserModel(
            id: credential.user!.uid,
            name: userName,
            email: email,
            age: userAge);
        addUserToFirestore(user).then((value) {
          onSuccess();
        });
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        ////////////////remove this 2 lines when i create provider
        // var user=await readUserFromFirestore(credential.user!.uid);
        // onSuccess(user);
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addUserToFirestore(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);

    return docRef.set(userModel);
  }

  static Future<UserModel?> readUserFromFirestore(String id) async {
    DocumentSnapshot<UserModel> doc = await getUsersCollection().doc(id).get();
    return doc.data();
  }
}
