import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import '../../models/task_model.dart';
import '../../shared/firebase/firebase_functions.dart';
import '../../shared/styles/colors.dart';
import 'task_item.dart';

class TasksTab extends StatefulWidget {
  static const String routeName = "tasks";

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
          leftMargin: 20,
          //showYears: true,

          monthColor: primaryColor,
          dayColor: primaryColor.withOpacity(0.7),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primaryColor,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true
          //date.day != 23
          ,
          locale: 'en',
        ),

        StreamBuilder(
          stream: FirebaseFunctions.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(child: Text("sorry, some thing went wrong"));
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if (tasks.isEmpty) {
              return Center(child: Text("No Tasks"));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
        // FutureBuilder(
        //   future: FirebaseFunctions.getTasks(selectedDate),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting)
        //       return Center(child: CircularProgressIndicator());
        //     if (snapshot.hasError)
        //       return Center(child: Text("sorry, some thing went wrong"));
        //     List<TaskModel> tasks =
        //         snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
        //     return Expanded(
        //       child: ListView.builder(
        //         itemBuilder: (context, index) {
        //           return TaskItem(
        //             task: tasks[index],
        //           );
        //         },
        //         itemCount: tasks.length,
        //       ),
        //     );
        //   },
        // )
      ],
    );
  }
}
