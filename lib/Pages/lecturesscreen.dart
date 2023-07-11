import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sapp/Pages/videoplayerscreen.dart';
import 'package:sapp/models/Teacher.dart';
import 'package:http/http.dart' as http;
import 'package:sapp/video_player_item.dart';

import 'package:sapp/widgets/drawer.dart';
import 'package:sapp/widgets/widgets.dart';

class LecturesScreen extends StatefulWidget {
  const LecturesScreen({super.key});

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<videoBoxlist> subjectBoxlist = [
    videoBoxlist(
      imageurl: "assets/pic1.png",
      livestatus: "Live at 04:20",
      mentorname: "By xyyscyvsuc",
      rating: "4.5",
      topicname: "Circle",
    ),
    videoBoxlist(
      imageurl: "assets/pic2.png",
      livestatus: "Live at 04:20",
      mentorname: "By AKO  School",
      rating: "4.2",
      topicname: "Ellipse ",
    ),
    videoBoxlist(
      imageurl: "assets/pic3.png",
      livestatus: "Live at 04:20",
      mentorname: "By xyyscyvsuc",
      rating: "4.4",
      topicname: "Circle",
    ),
    videoBoxlist(
      imageurl: "assets/pic1.png",
      livestatus: "Live at 05:30",
      mentorname: "By AKO  School",
      rating: "4.4",
      topicname: "Periphrases",
    ),
    videoBoxlist(
      imageurl: "assets/pic2.png",
      livestatus: "Live at 06:30",
      mentorname: "By AKO Language School",
      rating: "4.1",
      topicname: "Imperfect",
    ),
  ];

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

  void handleClick(String value) {
    switch (value) {
      case 'Option 1':
        break;
      case 'Option 2':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double appbarheight = 45;

    double devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 90 - appbarheight,
              ),
              Container(
                width: devicewidth,
                child: Row(
                  children: [
                    SizedBox(
                      width: 29,
                    ),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                        height: 20,
                        width: 30,
                        child: Image.asset("assets/iconmenu.png"),
                      ),
                    ),
                    SizedBox(
                      width: devicewidth * 0.7,
                    ),
                    PopupMenuButton<String>(
                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        return {'Option 1', 'Option 2'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: devicewidth * 0.95,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 23,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 22,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Video Course",
                                style: TextStyle(
                                    color: Color.fromRGBO(11, 18, 31, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              Text(
                                "All Cousre",
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 116, 126, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
              Container(
                height: deviceheight * 0.59,
                width: devicewidth * 0.95,
                child: FutureBuilder(
                    future: getTeacherdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return buildlistitem(context, index);
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildlistitem(BuildContext context, int index) {
    double deviceheight = MediaQuery.of(context).size.height;

    double devicewidth = MediaQuery.of(context).size.width;
    videoBoxlist subjectwidget = subjectBoxlist[index];
    Teacher teacherdata = teacherslist[index];

    return GestureDetector(
      onTap: () {
        // print(index);
        // if (index == 0) {}

        final String videourl = teacherdata.videoLecture[index].videoLink;
        nextScreen(context, VideoPlayerScreen(videourl: videourl));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          height: deviceheight * 0.135,
          width: devicewidth * 0.73,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 108,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        subjectwidget.imageurl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              child: Image.asset("assets/star.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                subjectwidget.rating!,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(38, 50, 56, 1)),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          subjectwidget.topicname!,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(38, 50, 56, 1)),
                        ),
                        Text(
                          subjectwidget.mentorname!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(117, 124, 142, 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(175, 179, 193, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                subjectwidget.livestatus!,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Teacher> getTeacherdata() async {
    final response = await http.get(Uri.parse(
        'https://easyed-backend.onrender.com/api/teacher/sonamWangchik'));
    var data = jsonDecode(response.body.toString());

    // print(data.toString());

    if (response.statusCode == 200) {
      sampleteachers = Teacher.fromJson(data);
      // sampleteachers. = dat;
      int check = 0;

      if (teacherslist.contains(sampleteachers)) {
        check = 1;
      }

      if (check == 0) {
        teacherslist.add(sampleteachers);
      }
      // teacherslist.add(sampleteachers);

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

class videoBoxlist {
  final String? rating;
  final String? imageurl;
  final String? topicname;
  final String? livestatus;
  final String? mentorname;

  videoBoxlist({
    required this.mentorname,
    required this.imageurl,
    required this.rating,
    required this.topicname,
    required this.livestatus,
  });
}