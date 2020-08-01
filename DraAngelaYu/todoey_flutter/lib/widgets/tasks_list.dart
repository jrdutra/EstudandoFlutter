import 'package:flutter/material.dart';
import 'package:todoeyflutter/models/task.dart';
import 'task_tile.dart';

class TasksList extends StatefulWidget {

  final List<Task> tasks;

  TasksList(this.tasks);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {



  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return TaskTile(
        taskTitle: widget.tasks[index].name,
        isChecked: widget.tasks[index].isDone,
        checkBoxCallBack: (bool checkBoxState) {
          setState(() {
            widget.tasks[index].toggleDone();
          });
        });
    }, itemCount: widget.tasks.length,);
  }
}
