import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final onTodoChanged;
  final TodoDeleted;
  const ToDoItems(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      this.TodoDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
          print("Pressed on the task.");
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              print("Delete requested.");

              AlertDialog(
                title: Text("Are you sure you'd like to remove the task?"),
              );
              TodoDeleted(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
