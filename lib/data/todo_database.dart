import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  // reference box
  final _mybox = Hive.box("Todo_Database");

  // initial data for first time
  void createInitialData() {
    todoList = [
      ["Do Ecercise", false],
      ["Code an App", false],
      ["Learn AI", false],
    ];
  }

  // load data from database
  void loadData() {
    todoList = _mybox.get("TODOLIST");
  }

  // update database
  void updateDatabase() {
    _mybox.put("TODOLIST", todoList);
  }
}
