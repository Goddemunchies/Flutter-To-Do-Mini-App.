import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

double Width = 40;
double Height = 40;

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _TextEditingController = TextEditingController();
  final TheToDoList = ToDo.todoList();
  bool _switch = true;
  List<ToDo> _foundToDo = [];
  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = TheToDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _switch ? tdBGColor : Colors.black,
      appBar: _buildAppBar(),
      body: _buildBody(TheToDoList),
    );
  }

  Stack _buildBody(List<ToDo> todosList) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              _searchBox(),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: Text(
                      "All The ToDos", //To solve the null case.
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (ToDo todoo in _foundToDo.reversed)
                    ToDoItems(
                      todo: todoo,
                      onTodoChanged:
                          _handleToDo, // Passing on a function? How or why?
                      TodoDeleted: _TodoDelete,
                    ),
                ],
              ))
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(
                              0.0, 0.0)), // To make it look like it's hovering.
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: _TextEditingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: "  Add a new to do",
                      border: InputBorder.none),
                ),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    _AddTask(_TextEditingController.text);
                  },
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    elevation: 10,
                    minimumSize: Size(50, 50),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _showTimedDelay() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text(' You must add a task first! =)'),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.redAccent,
              elevation: 4,
            );
          });
    });
  }

  void _AddTask(String todo) {
    if (todo.isNotEmpty) {
      setState(() {
        int X = TheToDoList.length + 1;
        String ID = X.toString();

        TheToDoList.add(ToDo(id: ID, todoText: todo));
      });

      _TextEditingController.clear();
    } else {
      setState(() {
        _showTimedDelay();
      });
    }
  }

  void _TodoDelete(String id) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Are you sure you would like to remove the task?"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      TheToDoList.removeWhere((item) => item.id == id);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                )
              ],
            ),
          );
        });
  }

  void _Fliter(String search) {
    List<ToDo>? results = [];
    if (search.isEmpty) {
      results = TheToDoList;
    } else {
      results = TheToDoList.where((item) =>
          item.todoText!.toLowerCase().contains(search.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = results!;
    });
  }

  void _handleToDo(ToDo todo) {
    setState(() {
      todo.isDone = !todo
          .isDone; //We've placed it inside to make sure the change is dynamic and seeable.
      // print("Pressed to change.");
      print(todo.isDone);
      print(todo.id);
    });
  }

  Container _searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _Fliter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            hintText: "Search",
            border: InputBorder.none),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0, // Provides what looks like a shadow for w/e
      backgroundColor: _switch ? tdBGColor : Colors.black,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {
            setState(() {
              _switch = !_switch;
            });
          },
          icon: Icon(_switch ? Icons.brightness_4 : Icons.brightness_2),
          color: _switch ? Colors.yellow : Colors.white,
        ),
        Text(
          "My Humble ToDo App",
          style: TextStyle(color: tdBlack),
        ),
        Container(
          height: Height,
          width: Width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        )
      ]),
    );
  }
}
