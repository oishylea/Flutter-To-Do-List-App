import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 217, 161, 226),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          TextField(
            decoration: InputDecoration(border: OutlineInputBorder(),
            hintText: "Add a new task"),
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              MyButton(text: "Save", onPressed: (){}),
              MyButton(text: "Cancel", onPressed: (){}),

              

          ],),
        ],
        )
        ,),

      
    );
  }
}