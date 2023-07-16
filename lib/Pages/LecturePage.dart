import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/Pages/addVideoScreen.dart';
import 'package:sapp/Pages/lecturesscreen.dart';
import 'package:sapp/widgets/widgets.dart';

class LecturePage extends StatefulWidget {
  const LecturePage({super.key});

  @override
  State<LecturePage> createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  nextScreen(context, AddVideoScreen());
                },
                child: Text("Add Videos")),
            ElevatedButton(
                onPressed: () {
                  nextScreen(context, LecturesScreen());
                },
                child: Text("Show Videos")),
          ],
        ),
      )),
    );
  }
}
