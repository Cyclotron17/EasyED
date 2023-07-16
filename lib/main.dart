import 'package:flutter/material.dart';
import 'package:sapp/Pages/addVideoScreen.dart';
import 'package:sapp/Pages/addpdfscreen.dart';
import 'package:sapp/Pages/dashboardscreen.dart';
import 'package:sapp/Pages/lecturesscreen.dart';
import 'package:sapp/Pages/notesscreen.dart';
import 'package:sapp/Pages/quizpage.dart';

import 'package:sapp/Pages/studentscreen.dart';
import 'package:sapp/Pages/taskpostscreen.dart';
import 'package:sapp/Pages/taskscreen.dart';
import 'package:sapp/Pages/test1screen.dart';
import 'package:sapp/Pages/test2screen.dart';
import 'package:sapp/Pages/testpage.dart';
import 'package:sapp/Pages/testscreen.dart';
import 'package:sapp/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sapp/helper/helper_function.dart';
import 'dart:io';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getgroupRank;
    getUserLoggedInStatus();
  }

  getgroupRank(
    int rank,
    var data,
    String? uid,
  ) {
    for (int i = 0; i < data.length; i++) {
      if ("${uid}" == data[i].reference.id) {
        rank = i + 1;
      }
    }

    return rank;

    // if (rank == data.length) {
    //   return -1;
    // } else {
    //   return rank;
    // }
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    final String? uid =
        _isSignedIn ? FirebaseAuth.instance.currentUser!.uid : "";
    // print(FirebaseAuth.instance.currentUser!.uid);
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          var data = snapshot.data!.docs;
          int rank = 0;

          int grouprank = getgroupRank(rank, data, uid) - 1;

          bool isshow = grouprank == -1
              ? false
              : snapshot.data.docs[grouprank].data()['filldetails'];

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: LecturesScreen(),
            home: _isSignedIn
                ? isshow
                    ? StudentScreen()
                    : test2screen()
                : LoginPage(),
          );
        });
  }
}
