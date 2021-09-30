import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../provider/todo_provider.dart";

import "utils.dart";

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.index,
    required this.todoID,
    required this.todoStatus,
    required this.todoTitle,
  }) : super(key: key);
  final double height;
  final double width;
  final int index;
  final bool todoStatus;
  final String todoTitle;
  final String todoID;

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController _textController = TextEditingController();
  bool? _isEnabled;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TodosProvider provider = Provider.of<TodosProvider>(
      context,
      listen: false,
    );
    void deleteTodo(String todoID) {
      provider.deleteTodo(todoID);
      Utils.showSnackBar(context, "Deleted the Task");
    }

    void todoStatus(String todoID, bool todoStatus) {
      provider.todoStatus(todoID, todoStatus);
      Utils.showSnackBar(
        context,
        !todoStatus ? "Task marked Completed" : "Task marked Incompleted",
      );
    }

    void saveTodo(String value, String todoID) {
      provider.updateTodo(value, todoID);
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
                todoStatus(
                  widget.todoID,
                  widget.todoStatus,
                );
              },
              icon: Icon(
                Icons.check_circle,
                color: widget.todoStatus ? Colors.green : null,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: widget.todoTitle,
                  border: InputBorder.none,
                ),
                controller: _textController,
                enabled: _isEnabled,
                onSubmitted: (String value) {
                  setState(() {
                    saveTodo(value, widget.todoID);
                    _isEnabled = false;
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
                    deleteTodo(widget.todoID);
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
