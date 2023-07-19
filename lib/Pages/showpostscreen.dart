import 'dart:convert';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sapp/Pages/pdfviewerpage.dart';
import 'package:sapp/models/Student.dart';
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/models/post.dart';
import 'package:sapp/pdf_api.dart';
import 'package:sapp/video_player_item.dart';
import 'package:sapp/widgets/widgets.dart';

class ShowPostScreen extends StatefulWidget {
  const ShowPostScreen({super.key});

  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  TextEditingController commentcontroller = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // List<Student> samplestudents = [];
  List<Teacher> teacherslist = [];

  List<Post> postlist = [];

  List<Comment> commentlist = [];

  Post postdata = Post(
      id: '',
      userId: '',
      post: '',
      avatar: '',
      content: '',
      isBlocked: false,
      date: DateTime.now(),
      likes: [],
      comments: [],
      v: 1);
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
        child: Container(
          height: 800,
          child: FutureBuilder(
              future: getpostdata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: postlist.length,
                      itemBuilder: (context, index) {
                        commentlist = commentlist = List<Comment>.from(
                          postlist[index].comments.map(
                                (q) => Comment(
                                    user: q.user,
                                    comment: q.comment,
                                    avatar: q.avatar,
                                    id: q.id,
                                    date: q.date),
                              ),
                        );

                        return Container(
                          width: 300,
                          color: Colors.grey,
                          height: 900,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("Teacher json"),

                              Container(
                                color: Colors.white,
                                height: 870,
                                width: 600,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      width: 600,
                                      child: Image.network(
                                        postlist[index].post,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text("postid: ${postlist[index].id}"),
                                    Text("userId: ${postlist[index].userId}"),
                                    Text("avatar: ${postlist[index].avatar}"),
                                    Text("content: ${postlist[index].content}"),
                                    Text(
                                        "isBLocked: ${postlist[index].isBlocked.toString()}"),
                                    Text(
                                        "date: ${postlist[index].date.toString()}"),
                                    Text("userId: ${postlist[index].id}"),

                                    Text(
                                        "Likes:  ${postlist[index].likes.length}"),
                                    // Text("uid $uid"),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await postaddlike(
                                              postid: postlist[index].id,
                                              userid: uid);

                                          setState(() {});
                                        },
                                        child: Text("add Like")),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await unlikepost(
                                              postid: postlist[index].id,
                                              userid: uid);

                                          setState(() {});
                                        },
                                        child: Text("unlike post")),

                                    TextField(
                                      controller: commentcontroller,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              // borderRadius: BorderRadius.circular(20),
                                              ),
                                          hintText: "Enter comment.."),
                                    ),

                                    ElevatedButton(
                                        onPressed: () async {
                                          String userid = uid;
                                          String comment =
                                              commentcontroller.text;

                                          await addcommentpost(
                                              postid: postlist[index].id,
                                              comment: comment,
                                              userid: userid);
                                        },
                                        child: Text("post comment")),

                                    postlist[index].comments.isNotEmpty
                                        ? Container(
                                            height: 200,
                                            child: ListView.builder(
                                                itemCount: commentlist.length,
                                                itemBuilder: (context, ind) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(commentlist[ind]
                                                              .comment),
                                                          Text(commentlist[ind]
                                                              .id),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                // String
                                                                //     commentid =
                                                                //     ;
                                                                await deletecommentpost(
                                                                    postid:
                                                                        postlist[index]
                                                                            .id,
                                                                    commentid: postlist[
                                                                            index]
                                                                        .comments[
                                                                            ind]
                                                                        .id,
                                                                    userid: postlist[
                                                                            index]
                                                                        .comments[
                                                                            ind]
                                                                        .user);

                                                                // print(index);
                                                              },
                                                              child: Text(
                                                                "delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )
                                        : Text("no comments"),
                                  ],
                                ),
                              ),
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

  Future addcommentpost(
      {required String postid,
      required String comment,
      required String userid}) async {
    var response = await http.post(
      Uri.https(
          'easyed-social-media-backend.onrender.com', '/comment/${postid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode(
          {"userId": userid, "comment": comment, "avatar": "www.avatar.com"}),
    );

    var data = response.body;

    print(data);
  }

  Future deletecommentpost(
      {required String postid,
      required String commentid,
      required String userid}) async {
    print(commentid);
    print(postid);
    var response = await http.delete(
      Uri.https('easyed-social-media-backend.onrender.com',
          '/comment/${postid}/${commentid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode({"userId": userid}),
    );

    var data = response.body;

    print(data);
  }

  Future unlikepost({required String postid, required String userid}) async {
    var response = await http.put(
      Uri.https(
          'easyed-social-media-backend.onrender.com', '/unlike/${postid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode({"userId": userid}),
    );

    var data = response.body;

    print(data);
  }

  Future postaddlike({required String postid, required String userid}) async {
    var response = await http.put(
      Uri.https('easyed-social-media-backend.onrender.com', '/like/${postid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode({"userId": userid}),
    );

    var data = response.body;

    print(data);
  }

  Future<List<Post>> getpostdata() async {
    final response = await http.get(
        Uri.parse('https://easyed-social-media-backend.onrender.com/api/post'));
    var data = jsonDecode(response.body.toString());

    // print(data.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        postlist.add(Post.fromJson(index));
      }

      // print(sampleteachers.toString());
      // for (Map<String, dynamic> index in data) {
      //   sampleteachers.add(Teacher.fromJson(index));
      // }
      return postlist;
    } else {
      return postlist;
    }
  }
}
