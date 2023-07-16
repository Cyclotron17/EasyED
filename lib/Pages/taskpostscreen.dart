import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sapp/Pages/addquestionscreen.dart';
import 'package:sapp/Pages/studentscreen.dart';
import 'package:sapp/auth/login_page.dart';
import 'package:sapp/helper/helper_function.dart';
import 'package:sapp/models/Datamodel.dart';

import 'package:http/http.dart' as http;
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/service/auth_service.dart';
import 'package:sapp/widgets/widgets.dart';

class TaskPostScreen extends StatefulWidget {
  final String taskid;
  const TaskPostScreen({super.key, required this.taskid});

  @override
  State<TaskPostScreen> createState() => _TaskPostScreenState();
}

class _TaskPostScreenState extends State<TaskPostScreen> {
  bool submitteddata = false;
  Teacher teacherdata = Teacher(
      id: "",
      commons: [],
      userDetails: [],
      educationalDetails: [],
      tasks: [],
      notes: [],
      videoLecture: [],
      students: [],
      v: 1);

  Task taskdata = Task(
      creator: "",
      taskClass: "",
      subject: "",
      topic: "",
      questions: [],
      id: "");

  // DataModel modeldata =
  //     DataModel(name: "name", job: "job", id: "id", createdAt: DateTime.now());
  TextEditingController creatorcontroller = TextEditingController();
  TextEditingController classcontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController topiccontroller = TextEditingController();
  // TextEditingController question1controller = TextEditingController();
  // TextEditingController question1typecontroller = TextEditingController();
  // TextEditingController answer1acontroller = TextEditingController();
  // TextEditingController answer1bcontroller = TextEditingController();
  // TextEditingController answer1ccontroller = TextEditingController();
  // TextEditingController answer1dcontroller = TextEditingController();

  // TextEditingController mobile = TextEditingController();
  // TextEditingController jobcontroller = TextEditingController();
  String userName = "";
  String email = "";
  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
  }

  void initState() {
    super.initState();

    gettingUserData();
  }

  @override
  Widget build(BuildContext context) {
    // final String taskid = randomNumeric(24);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print("uid from TaskPostScreen  ${uid}");
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Text(userName),
                // Text(email),
                // Text(uid),
                // Text(widget.taskid),

                Text(
                  "ADD YOUR TASK HERE!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),

                // GestureDetector(
                //     onTap: () async {
                //       await authService.signOut();
                //       Navigator.of(context).pushAndRemoveUntil(
                //           MaterialPageRoute(
                //               builder: (context) => const LoginPage()),
                //           (route) => false);
                //     },
                //     child: Text("Signout")),
                SizedBox(
                  height: 30,
                ),

                // TextField(
                //   controller: idcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter id"),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: creatorcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Creator Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: classcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Class Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: subjectcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter Subject"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: topiccontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter topic name"),
                  ),
                ),
                // TextField(
                //   controller: question1controller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter question 1 "),
                // ),
                // TextField(
                //   controller: question1typecontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter question 1 type "),
                // ),
                // TextField(
                //   controller: answer1acontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter option a "),
                // ),
                // TextField(
                //   controller: answer1bcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter option b "),
                // ),
                // TextField(
                //   controller: answer1ccontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter option c "),
                // ),
                // TextField(
                //   controller: answer1dcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter option d "),
                // ),
                SizedBox(
                  height: 20,
                ),
                // TextField(
                //   controller: jobcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "job title"),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () async {
                    String id = uid;
                    String creatorname = creatorcontroller.text;
                    String classnames = classcontroller.text;
                    String subjectname = subjectcontroller.text;
                    String topicname = topiccontroller.text;
                    // String question1text = question1controller.text;
                    // String question1type = question1typecontroller.text;
                    // String answer1a = answer1acontroller.text;
                    // String answer1b = answer1bcontroller.text;
                    // String answer1c = answer1ccontroller.text;
                    // String answer1d = answer1dcontroller.text;

                    Task taskdata = Task(
                      creator: creatorname,
                      taskClass: classnames,
                      subject: subjectname,
                      topic: topicname,
                      id: widget.taskid,
                      questions: [
                        // Question(
                        //   question: question1text,
                        //   questionType: question1type,
                        //   options: [
                        //     Option(
                        //         optionNumber: "A",
                        //         optionText: answer1a,
                        //         id: "649ec068b4a2118b5424695d"),
                        //     Option(
                        //         optionNumber: "B",
                        //         optionText: answer1b,
                        //         id: "649ec068b4a2118b5424695e"),
                        //     Option(
                        //         optionNumber: "C",
                        //         optionText: answer1c,
                        //         id: "649ec068b4a2118b5424695f"),
                        //     Option(
                        //         optionNumber: "D",
                        //         optionText: answer1d,
                        //         id: "649ec068b4a2118b54246960"),
                        //   ],
                        //   id: "649ec068b4a2118b5424695c",
                        // )
                      ],
                    );

                    // Teacher teacherdata = Teacher(
                    //     id: uid,
                    //     commons: [
                    //       Common(
                    //         createdOn:
                    //             DateTime.parse("2023-06-30T09:00:00.000Z"),
                    //         updatedOn:
                    //             DateTime.parse("2023-06-30T09:00:00.000Z"),
                    //         id: "649ebfb5b4a2118b5424694e",
                    //       )
                    //     ],
                    //     userDetails: [
                    //       UserDetail(
                    //           firstName: firstname,
                    //           lastName: lastname,
                    //           email: email,
                    //           mobile: mobile,
                    //           avatar: "",
                    //           id: "649ebfb5b4a2118b5424694e")
                    //     ],
                    //     educationalDetails: [
                    //       EducationalDetail(
                    //           instituteName: institutename,
                    //           educationalDetailClass: classname,
                    //           id: "649ebfb5b4a2118b5424694e")
                    //     ],
                    //     tasks: [],
                    //     notes: [],
                    //     videoLecture: [],
                    //     students: [],
                    //     v: 91);
                    ///////String job = jobcontroller.text;

                    // Teacher data = await submitdata(
                    //   teacherdata: teacherdata,
                    //   id: id,

                    Task datatask =
                        await submitdata(taskdata: taskdata, id: id, uid: uid);

                    ///////// createdOn: DateTime.now(),
                    ////////// updatedOn: DateTime.now());
                    // );

                    // await FirebaseFirestore.instance
                    //     .collection("users")
                    //     .doc(uid)
                    //     .update({
                    //   "filldetails": true,
                    // });

                    setState(() {
                      taskdata = datatask;
                    });

                    submitteddata = true;
                    nextScreen(
                        context,
                        AddQuestionScreen(
                          taskid: widget.taskid,
                        ));
                    // nextScreen(context, StudentScreen());
                  },
                  child: Text(
                    "ADD QUESTIONS",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                // ElevatedButton(
                //   onPressed: () {
                //     if (submitteddata == false) {
                //       final snackBar = SnackBar(
                //         backgroundColor: Colors.red,
                //         duration: Duration(seconds: 1),
                //         dismissDirection: DismissDirection.horizontal,
                //         content: const Text(
                //           'Please Submit this question first',
                //           style: TextStyle(),
                //         ),
                //       );
                //       ScaffoldMessenger.of(context).hideCurrentSnackBar();

                //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //     } else {
                //       setState(() {
                //         creatorcontroller.text = "";
                //         classcontroller.text = "";
                //         subjectcontroller.text = "";
                //         topiccontroller.text = "";
                //         // question1controller.text = "";
                //         // question1typecontroller.text = "";
                //         // answer1acontroller.text = "";
                //         // answer1bcontroller.text = "";
                //         // answer1ccontroller.text = "";
                //         // answer1dcontroller.text = "";
                //         submitteddata = false;
                //       });
                //     }
                //   },
                //   child: Text("Next question "),
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       nextScreen(
                //           context,
                //           AddQuestionScreen(
                //             taskid: widget.taskid,
                //           ));
                //     },
                //     child: Text("add questions "))
              ],
            )),
      ),
    );
  }

  Future<Task> submitdata(
      {required Task taskdata,
      // required DateTime createdOn,
      // required DateTime updatedOn,
      required String id,
      required String uid}) async {
    // List<Common> commonlist = <Common>[
    //   Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
    // ];
    // String jsonpayload = teacherToJson(teacherdata);

    // print(jsonpayload);
    // print(Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
    //     .toJson()
    //     .toString());
    // print("printing respose body part");
    // print(
    //   {
    //     "_id": id,
    //     "commons": json.encode([
    //       Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
    //           .toJson()
    //       // "createdOn": "2022-01-01T09:00:00.000Z",
    //       // "updatedOn": "2022-01-01T09:00:00.000Z"
    //     ])
    //   },
    // );

    var response = await http.post(
      Uri.https('easyed-backend.onrender.com', '/api/teacher/${uid}/task'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode(taskdata),
    );

    var data = response.body;

    print(data);

    // taskdata = Task.fromJson(json.decode(data));

    if (response.statusCode == 201) {
      // String responsestring = response.body;
      // teacherFromJson(responsestring);

      return taskdata;
    } else {
      return taskdata;
    }
  }
}
