import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,});

  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          TextField(

            controller: controller,

            decoration: InputDecoration(border: OutlineInputBorder(),
            hintText: "Add a new task"),
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              MyButton(text: "Save", onPressed: onSave),
              const SizedBox(width: 8,),
              MyButton(text: "Cancel", onPressed: onCancel),

              

          ],),
        ],
        )
        ,),

      
    );
  }
}