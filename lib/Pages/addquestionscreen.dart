import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/Pages/studentscreen.dart';
import 'package:sapp/auth/login_page.dart';
import 'package:sapp/helper/helper_function.dart';
import 'package:sapp/models/Datamodel.dart';

import 'package:http/http.dart' as http;
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/service/auth_service.dart';
import 'package:sapp/widgets/widgets.dart';

class AddQuestionScreen extends StatefulWidget {
  final String taskid;
  const AddQuestionScreen({super.key, required this.taskid});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  bool submitteddata = false;

  Question questiondata1 =
      Question(question: "", questionType: "", options: [], id: "");

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
  // TextEditingController creatorcontroller = TextEditingController();
  // TextEditingController classcontroller = TextEditingController();
  // TextEditingController subjectcontroller = TextEditingController();
  // TextEditingController topiccontroller = TextEditingController();
  TextEditingController question1controller = TextEditingController();
  TextEditingController question1typecontroller = TextEditingController();
  TextEditingController answer1acontroller = TextEditingController();
  TextEditingController answer1bcontroller = TextEditingController();
  TextEditingController answer1ccontroller = TextEditingController();
  TextEditingController answer1dcontroller = TextEditingController();

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
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print("uid from AddQuestionScreen  ${uid}");
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
                  "ADD NEW QUESTION HERE!",
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
                // TextField(
                //   controller: idcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter id"),
                // ),
                // TextField(
                //   controller: creatorcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Creator Name"),
                // ),
                // TextField(
                //   controller: classcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Class Name"),
                // ),
                // TextField(
                //   controller: subjectcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter Subject"),
                // ),
                // TextField(
                //   controller: topiccontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter topic name"),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: question1controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter question 1 "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: question1typecontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter question 1 type "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: answer1acontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter option a "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: answer1bcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter option b "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: answer1ccontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter option c "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: answer1dcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.black), //<-- SEE HERE
                        ),
                        hintText: "Enter option d "),
                  ),
                ),
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
                    // String id = uid;
                    // String creatorname = creatorcontroller.text;
                    // String classnames = classcontroller.text;
                    // String subjectname = subjectcontroller.text;
                    // String topicname = topiccontroller.text;
                    String question1text = question1controller.text;
                    String question1type = question1typecontroller.text;
                    String answer1a = answer1acontroller.text;
                    String answer1b = answer1bcontroller.text;
                    String answer1c = answer1ccontroller.text;
                    String answer1d = answer1dcontroller.text;

                    Question questiondata = Question(
                        question: question1text,
                        questionType: question1type,
                        options: [
                          Option(
                              optionNumber: "A",
                              optionText: answer1a,
                              id: "649ec068b4a2118b5424695d"),
                          Option(
                              optionNumber: "B",
                              optionText: answer1b,
                              id: "649ec068b4a2118b5424695e"),
                          Option(
                              optionNumber: "C",
                              optionText: answer1c,
                              id: "649ec068b4a2118b5424695f"),
                          Option(
                              optionNumber: "D",
                              optionText: answer1d,
                              id: "649ec068b4a2118b54246960"),
                        ],
                        id: "649ec068b4a2118b5424695c");

                    // Task taskdata = Task(
                    //     creator: creatorname,
                    //     taskClass: classnames,
                    //     subject: subjectname,
                    //     topic: topicname,
                    //     questions: [
                    //       Question(
                    //         question: question1text,
                    //         questionType: question1type,
                    //         options: [
                    //           Option(
                    //               optionNumber: "A",
                    //               optionText: answer1a,
                    //               id: "649ec068b4a2118b5424695d"),
                    //           Option(
                    //               optionNumber: "B",
                    //               optionText: answer1b,
                    //               id: "649ec068b4a2118b5424695e"),
                    //           Option(
                    //               optionNumber: "C",
                    //               optionText: answer1c,
                    //               id: "649ec068b4a2118b5424695f"),
                    //           Option(
                    //               optionNumber: "D",
                    //               optionText: answer1d,
                    //               id: "649ec068b4a2118b54246960"),
                    //         ],
                    //         id: "649ec068b4a2118b5424695c",
                    //       )
                    //     ],
                    //     id: "649ec068b4a2118b5424695b");

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

                    // Task datatask =
                    //     await submitdata(taskdata: taskdata, id: id, uid: uid);

                    Question dataquestion =
                        await submitdata(questiondata: questiondata, uid: uid);

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
                      questiondata1 = dataquestion;
                    });

                    submitteddata = true;

                    // nextScreen(context, StudentScreen());
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      if (submitteddata == false) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                          dismissDirection: DismissDirection.horizontal,
                          content: const Text(
                            'Please Submit this question first',
                            style: TextStyle(),
                          ),
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        setState(() {
                          // creatorcontroller.text = "";
                          // classcontroller.text = "";
                          // subjectcontroller.text = "";
                          // topiccontroller.text = "";
                          question1controller.text = "";
                          question1typecontroller.text = "";
                          answer1acontroller.text = "";
                          answer1bcontroller.text = "";
                          answer1ccontroller.text = "";
                          answer1dcontroller.text = "";
                          submitteddata = false;
                        });
                      }
                    },
                    child: Text("Next question ",
                        style: TextStyle(color: Colors.white, fontSize: 16)))
              ],
            )),
      ),
    );
  }

  Future<Question> submitdata(
      {required Question questiondata,
      // required DateTime createdOn,
      // required DateTime updatedOn,
      // required String id,
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
      Uri.https('easyed-backend.onrender.com',
          '/api/teacher/${uid}/task/${widget.taskid}/addquestion'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode(questiondata),
    );

    var data = response.body;

    print(data);

    // taskdata = Task.fromJson(json.decode(data));

    if (response.statusCode == 201) {
      // String responsestring = response.body;
      // teacherFromJson(responsestring);

      return questiondata;
    } else {
      return questiondata;
    }
  }
}
