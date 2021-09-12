import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:todo_app/model/todo.dart";

class Utils {
  static void showSnackBar(BuildContext context, String content) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(content)));

  static DateTime toDateTime(Timestamp value) {
    //if (value == null) return null;
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    //if (date == null) return null;
    return date.toUtc();
  }

  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final List<T> objects =
              snaps.map((Object? json) => fromJson(json as Map<String,dynamic>)).toList();

          sink.add(objects);
        },
      );
}
