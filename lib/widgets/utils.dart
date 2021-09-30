import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

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
}
