import "package:flutter/material.dart";

import "widgets/adding_task.dart";
import "widgets/main_view.dart";

/// Main Screen of the App
class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).backgroundColor,
              height: height * 0.2,
              alignment: Alignment.topCenter,
              child: const Center(
                child: Text(
                  "TO DO App",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            AddingTask(
              width: width,
              height: height,
            ),
            MainView(
              height: height,
              width: width,
            )
          ],
        ),
      ),
    );
  }
}
