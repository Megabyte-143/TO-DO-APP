import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/widgets/utils.dart';

class TodoField {
  static const createdTime = "createdTime";
}

class Todo {
  Todo({
    required this.createdTime,
    required this.title,
    this.isComplete = false,
    required this.id,
  });
  DateTime createdTime;
  String title;
  bool isComplete;
  String id;

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json["createdTime"] as Timestamp ),
        title: json["title"].toString(),
        id: json["id"].toString(),
        isComplete: json["isComplete"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "createdTime": Utils.fromDateTimeToJson(createdTime),
        "title": title,
        "id": id,
        "isComplete": isComplete
      };
}
