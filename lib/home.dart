import 'package:flutter/material.dart';
import 'package:todo_app_v3/dialog.dart';
import 'package:todo_app_v3/list.dart';
import 'package:todo_app_v3/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [];

  _addTodo() async {
    final todo = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return TodoDialog();
        });
    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
    // print(todos.length);
  }

  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  _removeTodo(Todo todo) {
    List<Todo> newTodos = [...todos];
    newTodos.removeWhere((item) => item.title == todo.title);
    setState(() {
      todos = newTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List App')),
      body: MyList(
        todos: todos,
        onRemoveTodo: _removeTodo,
        onTodoToggle: _toggleTodo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add_outlined),
      ),
    );
  }
}
