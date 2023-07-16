import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:random_string/random_string.dart';
import 'package:sapp/Pages/quizpage.dart';
import 'package:sapp/Pages/showtaskpage.dart';
import 'package:sapp/Pages/taskpostscreen.dart';
import 'package:sapp/widgets/drawer.dart';
import 'package:sapp/widgets/widgets.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final String taskid = randomNumeric(24);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<SubjectBoxlist> subjectBoxlist = [
    SubjectBoxlist("assets/Rectangle2.png", "ADD TASK", "Rituraj Sharma"),
    SubjectBoxlist("assets/Rectangle1.png", "SHOW TASK", "Rituraj Sharma"),
  ];

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
                height: 208,
                width: devicewidth * 0.95,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  // border: Border.all(),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 22,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hola, sayef!",
                              style: TextStyle(
                                  color: Color.fromRGBO(11, 18, 31, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26),
                            ),
                            Text(
                              "What do you wanna learn today?",
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 116, 126, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        CircleAvatar(
                          radius: 23,
                          backgroundImage: AssetImage("assets/profilepic.png"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      height: 46,
                      width: 292,
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            suffixIconColor: Color.fromRGBO(255, 255, 255, 1),
                            suffixIcon: ImageIcon(
                                AssetImage("assets/searchicon.png"),
                                size: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            hintText: "search here",
                            fillColor: Color.fromRGBO(38, 90, 232, 1)),
                      ),
                    ),
                    // Text(uid),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: deviceheight * 0.5,
                width: devicewidth * 0.78,
                // color: Colors.red,

                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return buildlistitem(context, index);
                  },
                  itemCount: subjectBoxlist.length,
                ),
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
    SubjectBoxlist subjectwidget = subjectBoxlist[index];
    return GestureDetector(
      onTap: () {
        print(index);
        if (index == 0) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: TaskPostScreen(
              taskid: taskid,
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }

        if (index == 1) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: QuizPage(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              // border: Border.all(),
              borderRadius: BorderRadius.only(
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
            height: deviceheight * 0.21,
            width: devicewidth * 0.73,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      child: Image.asset(
                        subjectwidget.imageurl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // SizedBox(
                        //   width: 12,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  subjectwidget.subjectname,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromRGBO(38, 50, 56, 1)),
                                ),
                              ],
                            ),
                            // Text(
                            //   subjectwidget.mentorname,
                            //   style: TextStyle(
                            //       fontSize: 9,
                            //       fontWeight: FontWeight.w200,
                            //       color: Color.fromRGBO(38, 50, 56, 1)),
                            // ),
                          ],
                        ),
                      ],
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
}

class SubjectBoxlist {
  final String imageurl;
  final String subjectname;
  final String mentorname;

  SubjectBoxlist(
    this.imageurl,
    this.subjectname,
    this.mentorname,
  );
}
