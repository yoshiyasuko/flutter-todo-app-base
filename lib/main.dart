import 'package:flutter/material.dart';
import 'package:flutter_todo_app_base/todo_list/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter ToDo App Base', home: TodoList());
  }
}
