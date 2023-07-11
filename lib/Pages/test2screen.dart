import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/models/Datamodel.dart';

import 'package:http/http.dart' as http;
import 'package:sapp/models/Teacher.dart';

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
  // String jsonpayload = teacherToJson(teacherdata);

  // print(jsonpayload);
  // print(Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
  //     .toJson()
  //     .toString());

//   print(
//     {
//       "_id": id,
//       "common":
// json.encode([
//         Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
//             .toJson()
//         // "createdOn": "2022-01-01T09:00:00.000Z",
//         // "updatedOn": "2022-01-01T09:00:00.000Z"
//       ] )
//     },
//   );

  var response = await http.post(
    Uri.parse('easyed-backend.onrender.com/api/teacher'),
    headers: {'Content-Type': 'application/json'},
    body: {
      "_id": id,
      "common": json.encode([
        Common(createdOn: DateTime.now(), updatedOn: DateTime.now(), id: id)
            .toJson()

        // "createdOn": "2022-01-01T09:00:00.000Z",
        // "updatedOn": "2022-01-01T09:00:00.000Z"
      ])
    },
    // body: jsonpayload,
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
  // TextEditingController jobcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: idcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      hintText: "Enter id"),
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
                    onPressed: () async {
                      String id = idcontroller.text;

                      Teacher teacherdata = Teacher(
                          id: id,
                          commons: [],
                          userDetails: [],
                          educationalDetails: [],
                          tasks: [],
                          notes: [],
                          videoLecture: [],
                          students: [],
                          v: 91);
                      // String job = jobcontroller.text;

                      Teacher data = await submitdata(
                        teacherdata: teacherdata,
                        id: id,
                        // createdOn: DateTime.now(),
                        // updatedOn: DateTime.now());
                      );

                      setState(() {
                        teacherdata = data;
                      });
                    },
                    child: Text("Submit"))
              ],
            )),
      ),
    );
  }
}
