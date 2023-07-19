import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sapp/Pages/pdfviewerpage.dart';
import 'package:sapp/Quiz/home.dart';
import 'package:sapp/models/Student.dart';
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/pdf_api.dart';
import 'package:sapp/video_player_item.dart';
import 'package:sapp/widgets/widgets.dart';

class ShowQuestions extends StatefulWidget {
  final String taskid;
  const ShowQuestions({super.key, required this.taskid});

  @override
  State<ShowQuestions> createState() => _ShowQuestionsState();
}

class _ShowQuestionsState extends State<ShowQuestions> {
  List _questions = [
    // {
    //   'questionText': 'What\'s your favorite color?',
    //   'answers': [
    //     {'text': 'Black', 'score': 1},
    //     {'text': 'Red', 'score': 0},
    //     {'text': 'Green', 'score': 0},
    //     {'text': 'White', 'score': 0},
    //   ],
    // },
    // {
    //   'questionText': 'What\'s your favorite animal?',
    //   'answers': [
    //     {'text': 'Rabbit', 'score': 1},
    //     {'text': 'Snake', 'score': 0},
    //     {'text': 'Elephant', 'score': 0},
    //     {'text': 'Lion', 'score': 0},
    //   ],
    // },
    // {
    //   'questionText': 'Who\'s your favorite instructor?',
    //   'answers': [
    //     {'text': 'Max', 'score': 1},
    //     {'text': 'Max', 'score': 0},
    //     {'text': 'Max', 'score': 0},
    //     {'text': 'Max', 'score': 0},
    //   ],
    // },
  ];

  Color aselectcolor = Colors.black;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<Student> samplestudents = [];
  List<Teacher> teacherslist = [];
  List<Task> taskslist = [];
  int count = -1;
  List<Question> questionslist = [];

  Task sampletask = Task(
      creator: "",
      taskClass: "",
      subject: "",
      topic: "",
      questions: [],
      id: "");

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
        child: Padding(
          padding: const EdgeInsets.all(40.0),
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
              Text(uid),

              Container(
                height: 600,
                child: FutureBuilder(
                    future: gettingtaskdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: questionslist.length,
                            itemBuilder: (context, index) {
                              if (count < questionslist.length) {
                                count++;
                                _questions.add({
                                  'questionText': index.toString() +
                                      ": " +
                                      questionslist[index].question,
                                  'answers': [
                                    {
                                      'text': questionslist[index]
                                          .options[0]
                                          .optionText,
                                      'score': 1
                                    },
                                    {
                                      'text': questionslist[index]
                                          .options[1]
                                          .optionText,
                                      'score': 0
                                    },
                                    {
                                      'text': questionslist[index]
                                          .options[2]
                                          .optionText,
                                      'score': 0
                                    },
                                    {
                                      'text': questionslist[index]
                                          .options[3]
                                          .optionText,
                                      'score': 0
                                    },
                                  ],
                                });
                              }
                              print(_questions.length);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // _questions list that send to quiz
                                  // Text(_questions[index]['questionText']
                                  //     .toString()),
                                  // Text(_questions[index]['answers'][0]['text']),
                                  // Text(_questions[index]['answers'][1]['text']),
                                  // Text(_questions[index]['answers'][2]['text']),
                                  // Text(_questions[index]['answers'][3]['text']),

                                  // Text(_questions.length.toString()),
                                  // Text("Teacher json"),
                                  // Text("In tasks "),
                                  // Text("creator : ${sampletask.creator} "),
                                  Text(
                                    index.toString() +
                                        ": " +
                                        questionslist[index].question,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("A: " +
                                      questionslist[index]
                                          .options[0]
                                          .optionText),
                                  Text("B: " +
                                      questionslist[index]
                                          .options[1]
                                          .optionText),
                                  Text("C: " +
                                      questionslist[index]
                                          .options[2]
                                          .optionText),
                                  Text("D: " +
                                      questionslist[index]
                                          .options[3]
                                          .optionText),

                                  // Text(sampletask.questions)
                                  // Text("class : ${taskslist[0].taskClass}"),
                                  // Text("Subject ${taskslist[0].subject}"),

                                  // SizedBox(
                                  //   height: 30,
                                  // )

                                  // Text("Question ${index}" +
                                  //     ": " +
                                  //     taskslist[index].questions[0].question),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),

                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       print(index);
                                  //       if (index == 0) {
                                  //         aselectcolor = Colors.blue;
                                  //       }
                                  //     });
                                  //   },
                                  //   child: Text(
                                  //     "A" +
                                  //         ": " +
                                  //         taskslist[index]
                                  //             .questions[0]
                                  //             .options[0]
                                  //             .optionText,
                                  //     style: index == 0
                                  //         ? TextStyle(color: aselectcolor)
                                  //         : TextStyle(color: Colors.black),
                                  //   ),
                                  // ),

                                  // Text("B" +
                                  //     ": " +
                                  //     taskslist[index]
                                  //         .questions[0]
                                  //         .options[1]
                                  //         .optionText),
                                  // Text("C" +
                                  //     ": " +
                                  //     taskslist[index]
                                  //         .questions[0]
                                  //         .options[2]
                                  //         .optionText),
                                  // Text("D" +
                                  //     ": " +
                                  //     taskslist[index]
                                  //         .questions[0]
                                  //         .options[3]
                                  //         .optionText),

                                  // Text("In notes"),
                                  // Text(
                                  //     "topic : ${sampleteachers.notes[index].topic}"),
                                  // GestureDetector(
                                  //   onTap: () async {
                                  //     final url = sampleteachers
                                  //         .notes[index].notesPdfLink;
                                  //     final file =
                                  //         await PDFApi.loadNetwork(url);

                                  //     openPDF(context, file);
                                  //   },
                                  //   child: Container(
                                  //     color: Colors.pink,
                                  //     height: 20,
                                  //     width: 30,
                                  //     child: Text("pdf"),
                                  //   ),
                                  // ),
                                  // Text(
                                  //     "notesPDFLink ${sampleteachers.notes[index].notesPdfLink}"),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Text("In videoLecture"),
                                  // Text(
                                  //     "videoTitle : ${sampleteachers.videoLecture[index].videoTitle}"),
                                  // Text(
                                  //     "videoLink : ${sampleteachers.videoLecture[index].videoLink} "),
                                  // VideoPlayerItem(
                                  //     videoUrl: sampleteachers
                                  //         .videoLecture[index].videoLink)
                                ],
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),

              ElevatedButton(
                  onPressed: () {
                    nextScreen(context, HomeScreen(questions: _questions));
                  },
                  child: Text("Quiz")),

              // ElevatedButton(
              //     onPressed: () {
              //       nextScreen(context, HomeScreen(questions: _questions));
              //     },
              //     child: Text("Quiz")),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Student>> getStudentdata() async {
    final response = await http
        .get(Uri.parse('https://easyed-backend.onrender.com/api/student'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplestudents.add(Student.fromJson(index));
      }
      return samplestudents;
    } else {
      return samplestudents;
    }
  }

  Future<List<Task>> gettaskdata() async {
    final response = await http.get(Uri.parse(
        'https://easyed-backend.onrender.com/api/teacher/${uid}/task'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        taskslist.add(Task.fromJson(index));
      }
      return taskslist;
    } else {
      return taskslist;
    }
  }

  Future<List<Question>> gettingtaskdata() async {
    final response = await http.get(Uri.parse(
        'https://easyed-backend.onrender.com/api/teacher/${uid}/task/${widget.taskid}'));
    var data = jsonDecode(response.body.toString());

    // print(data.toString());

    if (response.statusCode == 200) {
      // print(data);
      sampletask = Task.fromJson(data);
      // sampleteachers. = dat;

      questionslist = questionslist = List<Question>.from(sampletask.questions
          .map((q) => Question(
              question: q.question,
              questionType: q.questionType,
              options: q.options,
              id: q.id)));

      print(questionslist[0].toJson());

      // teacherslist.add(sampleteachers);

      // print(sampleteachers.toString());
      // for (Map<String, dynamic> index in data) {
      //   sampleteachers.add(Teacher.fromJson(index));
      // }
      return questionslist;
    } else {
      return questionslist;
    }
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