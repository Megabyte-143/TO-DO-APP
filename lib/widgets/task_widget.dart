import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../model/todo.dart";
import "../provider/todo_provider.dart";

import 'utils.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.index,
    required this.todos,
  }) : super(key: key);
  final double height;
  final double width;
  final int index;
  final List<Todo> todos;
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController _textController = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Todo> todos = widget.todos;
    final int i = widget.index;

    void deleteTodo(BuildContext context, Todo todo) {
      final TodosProvider provider = Provider.of<TodosProvider>(
        context,
        listen: false,
      );
      provider.deleteTodo(todo);
      Utils.showSnackBar(context, "Delted the Task");
    }

    void todoStatus(BuildContext context, Todo todo) {
      final TodosProvider provider = Provider.of<TodosProvider>(
        context,
        listen: false,
      );
      final bool isComplete = provider.todoStatus(todo);
      Utils.showSnackBar(
        context,
        isComplete ? "Task marked Completed" : "Task marked Incompleted",
      );
    }

    void saveTodo(String value, Todo todo) {
      final TodosProvider provider = Provider.of<TodosProvider>(
        context,
        listen: false,
      );
      provider.updateTodo(value, todo);
    }

    return Material(
      elevation: 4,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        height: widget.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 3,
              offset: Offset.fromDirection(
                2,
                3,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          top: widget.height * 0.02,
          left: widget.width * 0.03,
          right: widget.width * 0.03,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                todoStatus(context, todos[i]);
              },
              icon: Icon(
                Icons.check_circle,
                color: todos[i].isComplete ? Colors.green : null,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: todos[i].title,
                  border: InputBorder.none,
                ),
                controller: _textController,
                enabled: _isEnabled,
                onSubmitted: (String value) {
                  setState(() {
                    saveTodo(value, todos[i]);
                    _isEnabled = false;
                    _textController.clear();
                  });
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                  ),
                  onPressed: () {
                    setState(() {
                      _isEnabled = true;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: () {
                    deleteTodo(context, todos[i]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
