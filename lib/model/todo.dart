class Todo {
  Todo({
    required this.createdTime,
    required this.title,
    this.isComplete = false,
    required this.todoID,
  });

  ///
  DateTime createdTime;

  ///
  String title;

  ///
  bool isComplete;

  ///
  String todoID;
}
