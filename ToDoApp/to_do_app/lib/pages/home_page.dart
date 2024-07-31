import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the hive box
  final _mybox = Hive.box('mybox');
  // Text controller
  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false, DateTime.now()]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  db.toDoList.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                db.updateDataBase();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void editTask(int index) {
    final TextEditingController _controller = TextEditingController(text: db.toDoList[index][0]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedTaskName = _controller.text;
                if (updatedTaskName.isNotEmpty) {
                  setState(() {
                    db.toDoList[index][0] = updatedTaskName;
                  });
                  Navigator.of(context).pop();
                  db.updateDataBase();
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _filterTasks(String filterType) {
    setState(() {
      if (filterType == 'A-Z') {
        db.toDoList.sort((a, b) => a[0].compareTo(b[0]));
      } else if (filterType == 'Not Done / Done') {
        db.toDoList.sort((a, b) => a[1].toString().compareTo(b[1].toString()));
      } else if (filterType == 'Latest') {
        db.toDoList.sort((a, b) => b[2].compareTo(a[2]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    centerTitle: true,
    title: const Text('To Do List'),
    actions: [
      PopupMenuButton<String>(
        onSelected: _filterTasks,
        itemBuilder: (BuildContext context) {
          return {'A-Z', 'Not Done / Done'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
        icon: const Icon(Icons.filter_list),
      ),
    ],
  ),
  body: Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('lib/images/wallpaper.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (int) => deleteTask(index),
            editFunction: (int) => editTask(index),
            index: index,
          );
        },
      ),
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: createNewTask,
    child: const Icon(Icons.add),
  ),
);
  }
}
