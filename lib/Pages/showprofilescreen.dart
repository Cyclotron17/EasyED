import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sapp/Pages/pdfviewerpage.dart';
import 'package:sapp/models/Student.dart';
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/pdf_api.dart';
import 'package:sapp/video_player_item.dart';
import 'package:sapp/widgets/widgets.dart';

class ShowProfileScreen extends StatefulWidget {
  const ShowProfileScreen({super.key});

  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // List<Student> samplestudents = [];
  List<Teacher> teacherslist = [];

  // List<Student> sampleteachers = [];
  Teacher sampleteachers = Teacher(
      id: 'id',
      commons: [],
      userDetails: [],
      educationalDetails: [],
      tasks: [],
      notes: [],
      videoLecture: [],
      students: [],
      v: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   height: 300,
            //   child: FutureBuilder(
            //       future: getStudentdata(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return ListView.builder(
            //               itemCount: 1,
            //               itemBuilder: (context, index) {
            //                 return Container(
            //                   width: 300,
            //                   color: Colors.yellow,
            //                   height: 150,
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text("Student Json"),
            //                       // SizedBox(
            //                       //   height: 40,
            //                       // ),
            //                       Text("IN USER DETAILS :"),
            //                       Text(
            //                           "first Name : ${samplestudents[index].userDetails[index].firstName}"),

            //                       Text(
            //                           "avatar url : ${samplestudents[index].userDetails[index].avatar}"),
            //                       SizedBox(
            //                         height: 40,
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               });
            //         } else {
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       }),
            // ),
            Container(
              height: 600,
              child: FutureBuilder(
                  future: getTeacherdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: teacherslist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300,
                              color: Colors.grey,
                              height: 600,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text("Teacher json"),
                                  CircleAvatar(
                                    // height: 150,
                                    // width: 400,
                                    radius: 90,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        sampleteachers.userDetails[0].avatar,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "Firstname: ${sampleteachers.userDetails[0].firstName}"),
                                  Text(
                                      "LastName: ${sampleteachers.userDetails[0].lastName}"),
                                  Text(
                                      "email: ${sampleteachers.userDetails[0].email}"),
                                  Text(
                                      "Mobile No.: ${sampleteachers.userDetails[0].mobile}"),
                                  Text(
                                      "InstituteName.: ${sampleteachers.educationalDetails[0].instituteName}"),
                                  Text(
                                      "Class: ${sampleteachers.educationalDetails[0].educationalDetailClass}"),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // Future<List<Student>> getStudentdata() async {
  //   final response = await http
  //       .get(Uri.parse('https://easyed-backend.onrender.com/api/student'));
  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  //     for (Map<String, dynamic> index in data) {
  //       samplestudents.add(Student.fromJson(index));
  //     }
  //     return samplestudents;
  //   } else {
  //     return samplestudents;
  //   }
  // }

  Future<Teacher> getTeacherdata() async {
    final response = await http.get(
        Uri.parse('https://easyed-backend.onrender.com/api/teacher/${uid}'));
    var data = jsonDecode(response.body.toString());

    // print(data.toString());

    if (response.statusCode == 200) {
      sampleteachers = Teacher.fromJson(data);
      // sampleteachers. = dat;

      teacherslist.add(sampleteachers);

      // print(sampleteachers.toString());
      // for (Map<String, dynamic> index in data) {
      //   sampleteachers.add(Teacher.fromJson(index));
      // }
      return sampleteachers;
    } else {
      return sampleteachers;
    }
  }
}
