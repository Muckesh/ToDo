import 'package:flutter/material.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // todo controller

  final _todoController = TextEditingController();

  // List of TO DO's
  List todoList = [
    ["Code an App", false],
    ["Skillrack", false],
  ];

  // checkbox changed
  void checkboxChanged(bool? isCompleted, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  // save
  void save() {
    setState(() {
      todoList.add([_todoController.text, false]);
    });
    // pop
    Navigator.pop(context);
    // clear
    _todoController.clear();
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
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "TO DO",
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
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => checkboxChanged(todoList[index][1], index),
            child: TodoTile(
              todo: todoList[index][0],
              isCompleted: todoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
              deleteTodo: (context) => deleteTodo(index),
            ),
          );
        },
      ),
    );
  }
}
