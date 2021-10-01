import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

import "task_widget.dart";

class MainView extends StatefulWidget {
  const MainView({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.7,
      padding: EdgeInsets.only(
        left: widget.width * 0.03,
        right: widget.width * 0.03,
        bottom: widget.height * 0.03,
      ),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("todos").snapshots(),
        builder: (
          BuildContext context,
          snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> list =
                snapshot.data!.docs;
            return list.isEmpty
                ? const Center(
                    child: Text(
                      "Add Some TODOs",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (
                      BuildContext ctx,
                      int i,
                    ) {
                      return TaskWidget(
                        height: widget.height,
                        width: widget.width,
                        index: i,
                        todoID: list[i]["todoID"].toString(),
                        todoStatus: list[i]["todoStatus"] as bool,
                        todoTitle: list[i]["todoTitle"].toString(),
                      );
                    },
                    itemCount: list.length,
                  );
          } else {
            return const Center(
              child: Text(
                "No to dos",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
