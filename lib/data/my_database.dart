import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["Stay A Wake", false],
      ["Do Exercise", false]
    ];
  }

  void loadDataBase() {
   toDoList = _myBox.get("ToDoList");
  }

  void updateDataBase() {
    _myBox.put("ToDoList", toDoList);
  }
}
