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
  final TheToDoList = ToDo.todoList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
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
                  for (ToDo todoo in todosList)
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
                  decoration: InputDecoration(
                      hintText: "  Add a new to do", border: InputBorder.none),
                ),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {},
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

  void _TodoDelete() {}

  void _handleToDo(ToDo todo) {
    setState(() {
      todo.isDone = !todo
          .isDone; //We've placed it inside to make sure the change is dynamic and seeable.
      print("Pressed to change.");
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
      backgroundColor: tdBGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
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
