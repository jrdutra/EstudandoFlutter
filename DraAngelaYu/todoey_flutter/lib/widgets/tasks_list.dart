import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child){
        return ListView.builder(itemBuilder: (context, index) {
          return TaskTile(
              taskTitle: taskData.tasks[index].name,
              isChecked: taskData.tasks[index].isDone,
              checkBoxCallBack: (bool checkBoxState) {
//          setState(() {
//            Provider.of<TaskData>(context).tasks[index].toggleDone();
//          });
              });
        }, itemCount: taskData.taskCount,);
      },
    );
  }
}
