import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:todo_app/widgets/task_widget.dart';

import "../model/todo.dart";

import "../provider/todo_provider.dart";

class MainView extends StatefulWidget {
  MainView({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference _todos = FirebaseFirestore.instance.collection("todo");

    return FutureBuilder<Object>(
        future: _todos.doc().get(),
        builder: (context, AsyncSnapshot<Object> snapshot) {
          final List<Todo> todos =
              json.decode(json.encode(snapshot.data)) as List<Todo>;
          final TodosProvider provider = Provider.of<TodosProvider>(context);
          provider.setTodos(todos);
          return Container(
            height: widget.height * 0.7,
            padding: EdgeInsets.only(
              left: widget.width * 0.03,
              right: widget.width * 0.03,
              bottom: widget.height * 0.03,
            ),
            child: todos.isEmpty
                ? const Center(
                    child: Text("No Todos"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, int i) {
                      return TaskWidget(
                        height: widget.height,
                        width: widget.width,
                        index: i,
                        todos: todos,
                      );
                    },
                    itemCount: todos.length,
                  ),
          );
        });
  }
}
