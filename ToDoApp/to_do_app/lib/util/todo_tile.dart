// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
    final String taskName;
    final bool taskCompleted;

      Function(bool?)? onChanged;


  ToDoTile({
  super.key,
  required this.taskName,
  required this.taskCompleted,
  required this.onChanged});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Container(
        padding: EdgeInsets.all(24),
        child: Row(

          children: [

            Checkbox(
            value: taskCompleted ,
            onChanged: onChanged,
            activeColor : Colors.black,
),
            Text(
              taskName,
              style: TextStyle(decoration: taskCompleted? TextDecoration.lineThrough : TextDecoration.none),),
          ],
        ),

        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(14),
          ),
        
    ),
    );
  }
}