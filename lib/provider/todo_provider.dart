import "package:flutter/material.dart";
import "../api/Firebase_api.dart";
import "../model/todo.dart";

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = <Todo>[];
  List<Todo> get todos => _todos;

  void addTodo(Todo todo) => FirebaseApi.addTodo(todo);

  // void setTodos(List<Todo> todos) =>
  //     WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
  //       _todos = todos;
  //       notifyListeners();
  //     });

  void deleteTodo(String todoID) => FirebaseApi.deleteTodo(todoID);

  void todoStatus(String todoID, bool todoStatus) {
    // todo.isComplete = !todo.isComplete;
    FirebaseApi.updateTodoStatus(todoStatus, todoID);
    notifyListeners();
    //return todo.isComplete;
  }

  void updateTodo(String newValue, String todoID) {
    // todo.title = newValue;
    FirebaseApi.updateTodoText(newValue, todoID);
  }
}
