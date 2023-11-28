import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_f_connection/models/user_model.dart';
import 'package:todo_f_connection/providers/my_provider.dart';
import 'package:todo_f_connection/screens/login/login.dart';

import '../screens/settings/settings_tab.dart';
import '../screens/tasks/add_task_bottom_sheet.dart';
import '../screens/tasks/tasks_tab.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "lauout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    //var user = ModalRoute.of(context)?.settings.arguments as UserModel;
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      ////////////////////for floating action buttom background display
      extendBody: true,
      appBar:
          AppBar(title: Text("Hello  ${provider.userModel?.name}"), actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, Login.routeName, (route) => false);
            },
            icon: Icon(Icons.logout))
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list, size: 30),
                label: "",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30), label: "")
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSheet();
          },
          child: Icon(Icons.add),
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 4))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[index],
    );
  }

  void showSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
