import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/todo_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // reference box
  final _mybox = Hive.box("Todo_Database");
  // reference database
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    // if this is the 1st time ever openin this app
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // if data exists
      db.loadData();
    }
    super.initState();
  }

  // todo controller

  final _todoController = TextEditingController();

  // List of TO DO's
  // List todoList = [
  //   ["Code an App", false],
  //   ["Skillrack", false],
  // ];

  // checkbox changed
  void checkboxChanged(bool? isCompleted, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    // update
    db.updateDatabase();
  }

  // save
  void save() {
    if (_todoController.text != '') {
      setState(() {
        db.todoList.add([_todoController.text, false]);
        // clear
        _todoController.clear();
      });
    }
    // pop
    Navigator.pop(context);
    // update
    db.updateDatabase();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    _todoController.clear();
  }

  // add to do
  void addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            save: save, cancel: cancel, todoController: _todoController);
      },
    );
  }

  // delete todo
  void deleteTodo(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    // update
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "T A S K   S P O T",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: addTodo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => checkboxChanged(db.todoList[index][1], index),
            child: TodoTile(
              todo: db.todoList[index][0],
              isCompleted: db.todoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
              deleteTodo: (context) => deleteTodo(index),
            ),
          );
        },
      ),
    );
  }
}
