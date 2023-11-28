// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../models/task_model.dart';
// import '../../shared/firebase/firebase_functions.dart';
//
// class EditTask extends StatefulWidget {
//   static const String routeName = "EditTask";
//
//   @override
//   State<EditTask> createState() => _EditTaskState();
// }
//
// class _EditTaskState extends State<EditTask> {
//   late DateTime selectedDataGlobal;
//
//   var formKey = GlobalKey<FormState>();
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//
//   TaskModel? task;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     if (task == null) {
//       task = ModalRoute.of(context)?.settings.arguments as TaskModel;
//       titleController.text = task!.title;
//       descriptionController.text = task!.description;
//       var selectedDateMS = task!.date!;
//       DateTime selectedDate =
//       DateTime.fromMillisecondsSinceEpoch(selectedDateMS);
//       selectedDataGlobal = selectedDate;
//     }
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(title: Text("To Do List")),
//       body: Center(
//         child: Container(
//           height: screenSize.height * 0.8,
//           width: screenSize.width * 0.9,
//           child: Card(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 120, right: 10, left: 10),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   //////for keyboard padding bottom
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       "Edit Task",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "please enter task title";
//                           }
//                           return null;
//                         },
//                         controller: titleController,
//                         decoration: InputDecoration(
//                             hintText: "enter your task",
//                             hintStyle: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey))),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "please enter task description";
//                           }
//                           return null;
//                         },
//                         controller: descriptionController,
//                         decoration: InputDecoration(
//                             hintText: "enter description",
//                             hintStyle: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey))),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text("Select Date",
//                         style: GoogleFonts.poppins(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black)),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         selectDate(context);
//                       },
//                       child: Text(
//                           selectedDataGlobal.toString().substring(0, 10),
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.blue)),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             task = TaskModel(
//                                 title: titleController.text??"",
//                                 description: descriptionController.text??"",
//                                 date: DateUtils.dateOnly(selectedDataGlobal)
//                                     .millisecondsSinceEpoch??0);
//
//                             //////////////////////////////////in case local database
//                             FirebaseFunctions.updateTask(task!);
//                             print("task edit successfully");
//                             // Navigator.pushNamed(context, HomeLayout.routeName);
//                             Navigator.pop(context);
//                           }
//                         },
//                         child: Text("Save Changes"))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void selectDate(BuildContext context) async {
//     DateTime? chosenDate = await showDatePicker(
//         context: context,
//         // builder: (context, child) {
//         //   return Theme(data: data, child: child)
//         // },
//         initialDate: selectedDataGlobal,
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 365)));
//     //////////////////////if press cancel
//     if (chosenDate == null)
//       return;
//     else
//       selectedDataGlobal = chosenDate;
//
//     setState(() {});
//   }
// }
