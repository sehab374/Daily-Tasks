import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../models/task_model.dart';
import '../../shared/firebase/firebase_functions.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //////for keyboard padding bottom
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter task title";
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "enter your task",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter task description";
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "enter description",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Select Date",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Text(selectedDate.toString().substring(0, 10),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);

                    //////////////////////////////////in case remote database
                    // FirebaseFunctions.addTask(taskModel)
                    //     .then((value) => Navigator.pop(context));

                    //////////////////////////////////in case local database
                    FirebaseFunctions.addTask(taskModel);
                    Navigator.pop(context);
                  }
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  void selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        // builder: (context, child) {
        //   return Theme(data: data, child: child)
        // },
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    //////////////////////if press cancel
    if (chosenDate == null)
      return;
    else
      selectedDate = chosenDate;

    setState(() {});
  }
}
