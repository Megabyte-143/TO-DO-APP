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
  TextEditingController _editingController = TextEditingController();
  GlobalKey<ScaffoldState> _profileScaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isEditingText = false;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.todoTitle);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TodosProvider provider = Provider.of<TodosProvider>(
      context,
      listen: false,
    );

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
                provider.todoStatus(
                  widget.todoID,
                  widget.todoStatus,
                );
                Utils.showSnackBar(
                  context,
                  !widget.todoStatus
                      ? "Task marked Completed"
                      : "Task marked Incompleted",
                );
              },
              icon: Icon(
                Icons.check_circle,
                color: widget.todoStatus ? Colors.green : null,
              ),
            ),
            Expanded(
              child: _isEditingText
                  ? Form(
                      key: _profileScaffoldKey,
                      child: TextField(
                        onSubmitted: (newValue) {
                          setState(() {
                            provider.updateTodo(newValue, widget.todoID);
                            _isEditingText = false;
                          });
                        },
                        keyboardType: TextInputType.text,
                        // autofocus: true,
                        controller: _editingController,
                      ),
                    )
                  : Text(
                      widget.todoTitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
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
                      _isEditingText = true;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: () {
                    provider.deleteTodo(widget.todoID);
                    Utils.showSnackBar(context, "Deleted the Task");
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
