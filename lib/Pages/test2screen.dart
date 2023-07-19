import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sapp/Pages/studentscreen.dart';
import 'package:sapp/auth/login_page.dart';
import 'package:sapp/helper/helper_function.dart';
import 'package:sapp/models/Datamodel.dart';

import 'package:http/http.dart' as http;
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/service/auth_service.dart';
import 'package:sapp/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

class test2screen extends StatefulWidget {
  const test2screen({super.key});

  @override
  State<test2screen> createState() => _test2screenState();
}

Future<Teacher> submitdata({
  required Teacher teacherdata,
  // required DateTime createdOn,
  // required DateTime updatedOn,
  required String id,
}) async {
  List<Common> commonlist = <Common>[
    Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
  ];
  String jsonpayload = teacherToJson(teacherdata);

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
    Uri.https('easyed-backend.onrender.com', '/api/teacher'),
    headers: {'Content-Type': 'application/json'},
    // body: json.encode(sendData),
    body: json.encode(teacherdata),
  );

  var data = response.body;

  print(data);

  if (response.statusCode == 201) {
    String responsestring = response.body;
    teacherFromJson(responsestring);

    return Teacher.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(" Failed");
  }
}

class _test2screenState extends State<test2screen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  File? selectedImage;

  String? avatarurl;

  void showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      // final pickedImage =
      //     await ImagePicker().pickImage(source: ImageSource.gallery);
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    return image;
  }

  Future getImage() async {
    var image = await pickImageFromGallery(context);

    setState(() {
      selectedImage = image;
    });

    print(selectedImage);
  }

  Future uploadavatar() async {
    if (selectedImage != null) {
      setState(() {});

      // DateTime now = DateTime.now();
      // String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      /// upload image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("UserAvatarImages")
          .child(uid)
          .child("${randomAlphaNumeric(9)}.jpg");

      ///create a task to upload this data to our storage
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downoadUrl = await (await task).ref.getDownloadURL();
      print("this is url $downoadUrl");

      avatarurl = downoadUrl;
    } else {}
  }

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

  // DataModel modeldata =
  //     DataModel(name: "name", job: "job", id: "id", createdAt: DateTime.now());
  TextEditingController idcontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController instituteNamecontroller = TextEditingController();
  TextEditingController classcontroller = TextEditingController();

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
    print("uid from test2screen  ${uid}");
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
                  controller: firstnamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "First Name"),
                ),
                TextField(
                  controller: lastnamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Last Name"),
                ),
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Enter Email"),
                ),
                TextField(
                  controller: mobilecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Enter Mobile number"),
                ),
                TextField(
                  controller: instituteNamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Enter Institute Name"),
                ),
                TextField(
                  controller: classcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Enter Class "),
                ),
                SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text("get image")),
                ElevatedButton(
                    onPressed: () {
                      uploadavatar();
                    },
                    child: Text("upload image")),
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
                      String firstname = firstnamecontroller.text;
                      String lastname = lastnamecontroller.text;
                      String email = emailcontroller.text;
                      String mobile = mobilecontroller.text;
                      String institutename = instituteNamecontroller.text;
                      String classname = classcontroller.text;

                      Teacher teacherdata = Teacher(
                          id: id,
                          commons: [
                            Common(
                              createdOn:
                                  DateTime.parse("2023-06-30T09:00:00.000Z"),
                              updatedOn:
                                  DateTime.parse("2023-06-30T09:00:00.000Z"),
                              id: "649ebfb5b4a2118b5424694e",
                            )
                          ],
                          userDetails: [
                            UserDetail(
                                firstName: firstname,
                                lastName: lastname,
                                email: email,
                                mobile: mobile,
                                avatar: avatarurl!,
                                id: "649ebfb5b4a2118b5424694e")
                          ],
                          educationalDetails: [
                            EducationalDetail(
                                instituteName: institutename,
                                educationalDetailClass: classname,
                                id: "649ebfb5b4a2118b5424694e")
                          ],
                          tasks: [],
                          notes: [],
                          videoLecture: [],
                          students: [],
                          v: 91);
                      ///////String job = jobcontroller.text;

                      Teacher data = await submitdata(
                        teacherdata: teacherdata,
                        id: id,

                        ///////// createdOn: DateTime.now(),
                        ////////// updatedOn: DateTime.now());
                      );

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .update({
                        "filldetails": true,
                      });

                      setState(() {
                        teacherdata = data;
                      });

                      nextScreen(context, StudentScreen());
                    },
                    child: Text("Submit"))
              ],
            )),
      ),
    );
  }
}
