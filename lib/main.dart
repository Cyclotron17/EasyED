import 'package:flutter/material.dart';
import 'package:sapp/Pages/dashboardscreen.dart';
import 'package:sapp/Pages/lecturesscreen.dart';
import 'package:sapp/Pages/notesscreen.dart';

import 'package:sapp/Pages/studentscreen.dart';
import 'package:sapp/Pages/test1screen.dart';
import 'package:sapp/Pages/test2screen.dart';
import 'package:sapp/Pages/testpage.dart';
import 'package:sapp/Pages/testscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: test2screen(),
    );
  }
}
