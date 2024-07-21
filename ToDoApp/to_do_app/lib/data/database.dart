import 'package:hive/hive.dart';

class ToDoDatabase{

  List toDoList = [];
  //reference box

  final _myBox = Hive.box('mybox');

  void createInitialData(){
    toDoList = [
      ["Cook dinner",false],
      ["Swimming class",false],
    ];
  }

  void loadData(){
    toDoList =_myBox.get("TODOLIST");

  }

  void updateDataBase(){
    _myBox.put("TODOLIST",toDoList);
  }
}