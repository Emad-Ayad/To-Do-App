import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/my_database.dart';
import 'package:todo_app/util/todo_tile.dart';
import '../util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox =Hive.box('mybox');
  final _controller = TextEditingController();
  ToDoDataBase db=ToDoDataBase();

  @override
  void initState() {
    if(_myBox.get('ToDoList')==null){
      db.createInitialData();
    }else{
      db.loadDataBase();
    }
    super.initState();
  }
  


  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = ! db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask (){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask ,
        onCancel: () => Navigator.of(context).pop() ,
      );
    },);
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

   edit (int index){
    setState(() {
      //TODO The problem is here!!!!!!
      db.toDoList[index][0] = Text(_controller.text).toString();
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //ToDo make this edit function work
  void updateTask (int index){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: ()=> edit(index) ,
        onCancel: () => Navigator.of(context).pop() ,
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0Xff222222),
        title: const Center(
          child: Text(
            "TO DO List",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 50,
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add)
      ),
      body: ListView.builder(
        itemCount:  db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName:  db.toDoList[index][0],
            taskCompleted:  db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            updateFunction: (context) => updateTask(index),
          );
        },
      ),
    );
  }
}
