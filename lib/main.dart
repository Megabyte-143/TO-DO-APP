import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "api/Firebase_api.dart";

import "home_page_screen.dart";

import "model/todo.dart";

import "provider/todo_provider.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

/// Root Widget of the App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Todo App",
    theme: ThemeData(
      backgroundColor: Colors.grey.shade400,
      primarySwatch: Colors.grey,
    ),
    home: HomePageScreen(),
  );
}
