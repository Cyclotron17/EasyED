import 'package:flutter/material.dart';
import 'package:sapp/Pages/pdfviewerpage.dart';
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/pdf_api.dart';

import 'package:sapp/widgets/drawer.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sapp/widgets/widgets.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Notesbox> subjectBoxlist = [
    Notesbox(
      "Basic Properties",
    ),
    Notesbox(
      "Basic Properties",
    ),
    Notesbox(
      "Basic Properties",
    ),
    Notesbox(
      "Basic Properties",
    ),
    Notesbox(
      "Basic Properties",
    ),
  ];

  List<Teacher> teacherslist = [];
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
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 1.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 23,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SizedBox(
                        //   width: 22,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Circle",
                                style: TextStyle(
                                    color: Color.fromRGBO(11, 18, 31, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 26),
                              ),
                              Text(
                                "Rituraj Sharma",
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 116, 126, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        CircleAvatar(
                          radius: 46,
                          backgroundImage:
                              AssetImage("assets/Rectangle 129.png"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: deviceheight * 0.5,
                width: devicewidth * 0.78,
                child: FutureBuilder(
                    future: getTeacherdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: teacherslist.length,
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
    Notesbox subjectwidget = subjectBoxlist[index];
    Teacher teacherdata = teacherslist[index];
    return GestureDetector(
      onTap: () {
        print(index);
        if (index == 0) {}
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 13, bottom: 13),
        child: GestureDetector(
          onTap: () async {
            final url = teacherdata.notes[index].notesPdfLink;
            final file = await PDFApi.loadNetwork(url);

            openPDF(context, file);
          },
          child: Container(
            height: deviceheight * 0.06,
            width: devicewidth * 0.73,
            decoration: BoxDecoration(
              // color: Colors.red,
              color: Color.fromRGBO(255, 255, 255, 1),
              border: Border.all(),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 1.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13.0, right: 8.0, top: 3),
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset("assets/pdf.png"),
                            height: 27,
                            width: 27,
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          Container(
                            width: 140,
                            child: Text(
                              teacherdata.notes[index].topic,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(38, 50, 56, 1)),
                            ),
                          ),
                          SizedBox(
                            width: 64,
                          ),
                          Container(
                            child: Icon(Icons.download),
                            height: 27,
                            width: 27,
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

  void openPDF(BuildContext context, File file) {
    nextScreen(
        context,
        PDFViewerPage(
          file: file,
        ));
  }
}

class Notesbox {
  final String contentname;

  Notesbox(
    this.contentname,
  );
}
