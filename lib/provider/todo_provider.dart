import "package:flutter/material.dart";
import 'package:todo_app/api/Firebase_api.dart';
import "../model/todo.dart";

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = <Todo>[];
  List<Todo> get todos => _todos.toList();

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
        _todos = todos;
        notifyListeners();
      });

  void deleteTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  bool todoStatus(Todo todo) {
    todo.isComplete = !todo.isComplete;
    FirebaseApi.updateTodo(todo);
    return todo.isComplete;
  }

  void updateTodo(String newValue, Todo todo) {
    todo.title = newValue;
    FirebaseApi.updateTodo(todo);
  }
}
