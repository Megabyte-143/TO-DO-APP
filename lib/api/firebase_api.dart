import "package:cloud_firestore/cloud_firestore.dart";
import 'package:todo_app/widgets/utils.dart';

import "../model/todo.dart";

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo");
    todo.id = docTodo.id;
    await docTodo.add(todo.toJson());
    return docTodo.id;
  }

  // static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
  //     .collection('todo')
  //     .orderBy(TodoField.createdTime, descending: true)
  //     .snapshots()
  //     .transform(Utils.transformer(Todo.fromJson));

  // static Stream<List<Todo>> readTodos() {
  //   final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
  //       .collection("todo")
  //       .orderBy(TodoField.createdTime, descending: true)
  //       .snapshots();
  //   return stream.map(
  //     (event) => event.docs
  //         .map(
  //           (e) => Todo(
  //             createdTime: e.data()["createdTime"] as DateTime,
  //             title: e.data()["title"] as String,
  //             id: e.id,
  //             isComplete: e.data()["isComplete"] as bool,
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo").doc(todo.id);
    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo").doc(todo.id);
    await docTodo.delete();
  }
}
