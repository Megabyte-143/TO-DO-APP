import "package:cloud_firestore/cloud_firestore.dart";

import "../model/todo.dart";

class FirebaseApi {

  static Future<void> addTodo(Todo todo) async {
    await FirebaseFirestore.instance.collection("todos").doc(todo.todoID).set({
      "createdTime": todo.createdTime,
      "todoTitle": todo.title,
      "todoStatus": todo.isComplete,
      "todoID": todo.todoID,
    });
  }

  static Future<void> updateTodoStatus(
    bool todoStatus,
    String todoID,
  ) async {
    await FirebaseFirestore.instance.collection("todos").doc(todoID).update({
      "todoStatus": !todoStatus,
    });
  }
  static Future<void> updateTodoText(
   String newValue,
    String todoID,
  ) async {
    await FirebaseFirestore.instance.collection("todos").doc(todoID).update({
      "title": newValue,
    });
  }

  static Future<void> deleteTodo(String todoID) async {
    await FirebaseFirestore.instance.collection("todos").doc(todoID).delete();
  }
}
