import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../model/todo.dart";
import "../provider/todo_provider.dart";

class AddingTask extends StatelessWidget {
  const AddingTask({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    void addTodo(String title) {
      final todo = Todo(
        id: DateTime.now().toIso8601String(),
        title: title,
        createdTime: DateTime.now(),
      );
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
    }

    final TextEditingController textController = TextEditingController();
    String title = "";
    return Container(
      //color: Theme.of(context).backgroundColor,
      //color: Colors.blue,
      padding: EdgeInsets.all(
        width * 0.05,
      ),
      height: height * 0.1,
      width: width,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Material(
                elevation: 5,
                color: Colors.transparent,
                child: Container(
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: textController,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Type something here...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onSubmitted: (_) {
                        addTodo(textController.text);
                        textController.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  addTodo(textController.text);
                },
                child: Container(
                  height: height * 0.1,
                  //color: Colors.yellow,
                  child: Center(
                    child: Icon(
                      Icons.add_circle,
                      size: height * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
