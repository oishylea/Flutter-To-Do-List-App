import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //list of todo task

  List toDoList = [
    ["Cooking",false,],
    ["Swimming",false,],

  ];

  void checkBoxChanged(bool? value, int index){

    setState((){
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
      return DialogBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 140, 203),
      appBar: AppBar(
        centerTitle: true,
        title: Align(
          alignment: Alignment.center,
          child: const Text('To Do'),
        ),
      ),

    floatingActionButton: FloatingActionButton(
      onPressed: createNewTask,
      child: Icon(Icons.add),
    ),


      body: ListView.builder(

        itemCount: toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value,index), );
        }

      )
      
    );
  }
}