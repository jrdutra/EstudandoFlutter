import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          'This is a task.',
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: TaskCheckBox(
          checkBoxState: isChecked,
          toggleCheckBoxSate: (bool checkBoxState){
            setState(() {
              isChecked = checkBoxState;
            });
          },
        )
    );
  }
}

class TaskCheckBox extends StatelessWidget {
  final bool checkBoxState;
  final Function toggleCheckBoxSate;

  TaskCheckBox({this.checkBoxState, this.toggleCheckBoxSate});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.lightBlueAccent,
      value: checkBoxState,
      onChanged: toggleCheckBoxSate,
    );
  }
}
