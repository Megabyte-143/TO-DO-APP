import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "home_page_screen.dart";

import "provider/todo_provider.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

/// Root Widget of the App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodosProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo App",
        theme: ThemeData(
          backgroundColor: Colors.grey.shade400,
          primarySwatch: Colors.grey,
        ),
        home: HomePageScreen(),
      ),
    );
  }
}
