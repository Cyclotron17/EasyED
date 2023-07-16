import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';

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
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class AddVideoScreen extends StatefulWidget {
  // final String taskid;
  const AddVideoScreen({
    super.key,
  });

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  bool isloading = false;
  VideoLecture lecturedata = VideoLecture(
      subject: "", topic: "", videoLink: "", videoTitle: "", id: "");
  bool submitteddata = false;
  // Teacher teacherdata = Teacher(
  //     id: "",
  //     commons: [],
  //     userDetails: [],
  //     educationalDetails: [],
  //     tasks: [],
  //     notes: [],
  //     videoLecture: [],
  //     students: [],
  //     v: 1);

  // Task taskdata = Task(
  //     creator: "",
  //     taskClass: "",
  //     subject: "",
  //     topic: "",
  //     questions: [],
  //     id: "");

  // DataModel modeldata =
  //     DataModel(name: "name", job: "job", id: "id", createdAt: DateTime.now());
  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController topiccontroller = TextEditingController();
  TextEditingController videotitlecontroller = TextEditingController();
  // TextEditingController videocontroller = TextEditingController();
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

  File? uploadvideo;
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

  // Future<File?> pickVideoFromGallery(BuildContext context) async {
  //   File? video;
  //   try {
  //     final pickedVideo =
  //         await ImagePicker().pickVideo(source: ImageSource.gallery);

  //     if (pickedVideo != null) {
  //       video = File(pickedVideo.path);
  //     }
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  //   return video;
  // }

  void showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  Future selectVideo() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (File(file!.files.single.path!) != null) {
      uploadvideo = File(file.files.single.path!);

      setState(() {
        uploadvideo = File(file.files.single.path!);
      });

      // await sendFileMessage(video, MessageEnum.video, currentuserid, sp,
      //     widget.partnercode, widget.connectcode, widget.getgrouprank);
    }
  }

  void initState() {
    super.initState();

    gettingUserData();
  }

  void _showSnackBarMsg(String msg) {
    var snackBar = SnackBar(content: Text('Hello World'));
    _globalKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // final String taskid = randomNumeric(24);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print("uid from AddVideoScreen  ${uid}");
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(userName),
                Text(email),
                Text(uid),
                // Text(widget.taskid),

                GestureDetector(
                    onTap: () async {
                      await authService.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false);
                    },
                    child: Text("Signout")),
                // TextField(
                //   controller: idcontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter id"),
                // ),
                TextField(
                  controller: subjectcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Subject Name"),
                ),
                TextField(
                  controller: topiccontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Topic Name"),
                ),
                TextField(
                  controller: videotitlecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Enter video title"),
                ),

                ElevatedButton(
                    onPressed: (() async {
                      setState(() {
                        isloading = true;
                      });

                      await selectVideo();

                      setState(() {
                        isloading = false;
                      });
                    }),
                    child: Text("Upload")),
                // TextField(
                //   controller: topiccontroller,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           // borderRadius: BorderRadius.circular(20),
                //           ),
                //       hintText: "Enter topic name"),
                // ),
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
                  onPressed: () async {
                    String id = uid;
                    String subjectname = subjectcontroller.text;
                    String topicname = topiccontroller.text;
                    String videotitlename = videotitlecontroller.text;

                    // String question1text = question1controller.text;
                    // String question1type = question1typecontroller.text;
                    // String answer1a = answer1acontroller.text;
                    // String answer1b = answer1bcontroller.text;
                    // String answer1c = answer1ccontroller.text;
                    // String answer1d = answer1dcontroller.text;

                    // Task taskdata = Task(
                    //   creator: creatorname,
                    //   taskClass: classnames,
                    //   subject: subjectname,
                    //   topic: topicname,
                    //    id:" widget.taskid",
                    //   questions: [
                    //     // Question(
                    //     //   question: question1text,
                    //     //   questionType: question1type,
                    //     //   options: [
                    //     //     Option(
                    //     //         optionNumber: "A",
                    //     //         optionText: answer1a,
                    //     //         id: "649ec068b4a2118b5424695d"),
                    //     //     Option(
                    //     //         optionNumber: "B",
                    //     //         optionText: answer1b,
                    //     //         id: "649ec068b4a2118b5424695e"),
                    //     //     Option(
                    //     //         optionNumber: "C",
                    //     //         optionText: answer1c,
                    //     //         id: "649ec068b4a2118b5424695f"),
                    //     //     Option(
                    //     //         optionNumber: "D",
                    //     //         optionText: answer1d,
                    //     //         id: "649ec068b4a2118b54246960"),
                    //     //   ],
                    //     //   id: "649ec068b4a2118b5424695c",
                    //     // )
                    //   ],
                    // );

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

                    submitdata(
                        filepath: uploadvideo,
                        subjectname: subjectname,
                        topic: topicname,
                        videotitle: videotitlename,
                        uid: uid);

                    ///////// createdOn: DateTime.now(),
                    ////////// updatedOn: DateTime.now());
                    // );

                    // await FirebaseFirestore.instance
                    //     .collection("users")
                    //     .doc(uid)
                    //     .update({
                    //   "filldetails": true,
                    // });

                    // setState(() {
                    //   taskdata = datatask;
                    // });

                    submitteddata = true;

                    // nextScreen(context, StudentScreen());
                  },
                  child: Text("Submit"),
                ),

                ElevatedButton(
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
                        videotitlecontroller.text = "";
                        subjectcontroller.text = "";
                        topiccontroller.text = "";
                        uploadvideo = null;
                        // question1controller.text = "";
                        // question1typecontroller.text = "";
                        // answer1acontroller.text = "";
                        // answer1bcontroller.text = "";
                        // answer1ccontroller.text = "";
                        // answer1dcontroller.text = "";
                        submitteddata = false;
                      });
                    }
                  },
                  child: Text("Next Video "),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       nextScreen(
                //           context,
                //           AddQuestionScreen(
                //             taskid: "widget.taskid",
                //           ));
                //     },
                //     child: Text("add questions "))
              ],
            )),
      ),
    );
  }

  void submitdata(
      {required File? filepath,
      required String subjectname,
      required String topic,
      required String videotitle,
      // required Task taskdata,
      // required DateTime createdOn,
      // required DateTime updatedOn,
      // required String id,
      required String uid}) async {
    String filename = basename(filepath!.path);

    print("file base name ${filename}");

    try {
      FormData formdata = FormData.fromMap({
        "subject": subjectname,
        "topic": topic,
        "videotitle": videotitle,
        "video":
            await MultipartFile.fromFile(filepath.path, filename: filename),
      });

      Response response = await Dio().post(
          "https://easyed-backend.onrender.com/api/teacher/$uid/lectures",
          data: formdata);

      print("File upload response: $response");
      _showSnackBarMsg(response.data['message']);
    } catch (e) {
      print("expectation Caugch: $e");
    }
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

    // var response = await http.post(
    //   Uri.https('easyed-backend.onrender.com', '/api/teacher/${uid}/task'),
    //   headers: {'Content-Type': 'application/json'},
    //   // body: json.encode(sendData),
    //   body: json.encode(taskdata),
    // );

    // taskdata = Task.fromJson(json.decode(data));

    // if (response.statusCode == 201) {
    //   // String responsestring = response.body;
    //   // teacherFromJson(responsestring);

    //   return taskdata;
    // } else {
    //   return taskdata;
    // }
  }
}
