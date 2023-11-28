import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/task_model.dart';
import '../../shared/firebase/firebase_functions.dart';
import '../../shared/styles/colors.dart';
import 'edit-task.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(task.id);
              },
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              label: "Delete",
              icon: Icons.delete,
              backgroundColor: Colors.red,
            ),
            SlidableAction(
              onPressed: (context) {
                ///////////////////////////////////////for edit task
                // Navigator.pushNamed(context, EditTask.routeName,
                //     arguments: task);
              },
              label: "Edit",
              icon: Icons.edit,
              backgroundColor: primaryColor,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  child: VerticalDivider(
                    color: primaryColor,
                    thickness: 3,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        style: task.isDone
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Color(0xff61E757))
                            : Theme.of(context).textTheme.titleLarge),
                    Text(task.description)
                  ],
                ),
                Spacer(),
                task.isDone
                    ? Text("Done !",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Color(0xff61E757), fontSize: 22))
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              task.isDone = true;
                              FirebaseFunctions.updateTask(task);
                            },
                            icon: Icon(
                              Icons.done,
                              size: 30,
                            )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
