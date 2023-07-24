import 'dart:convert';
import 'dart:ffi';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sapp/Pages/addpostscreen.dart';
import 'package:sapp/Pages/globalvariables.dart';
import 'package:sapp/Pages/modelsheetscreen.dart';
import 'package:sapp/Pages/pdfviewerpage.dart';
import 'package:sapp/models/Student.dart';
import 'package:sapp/models/Teacher.dart';
import 'package:sapp/models/post.dart';
import 'package:sapp/pdf_api.dart';
import 'package:sapp/video_player_item.dart';
import 'package:sapp/widgets/examplemenu.dart';
import 'package:sapp/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ShowPostScreen extends StatefulWidget {
  const ShowPostScreen({super.key});

  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  String alreadylikedmessage = "Post already liked";
  bool isalreadyliked = false;

  String alreadynotlikedmessage = "Post has not yet been liked";
  bool isalreadyunliked = false;
  bool isloading = false;

  Future onReturn() async => setState(() => getpostdata());
  TextEditingController commentcontroller = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // List<Student> samplestudents = [];
  List<Teacher> teacherslist = [];

  List<Post> postlist = [];

  List<Comment> commentlist = [];

  bool islike = false;

  String currentpostid = "";

  bool? isCurrentUserLiked = false;

  bool iscurrentindexpostisavideo = false;

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
    double deviceheight = MediaQuery.of(context).size.height;
    double appbarheight = 45;

    double devicewidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: ScaffoldMessenger(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // islike ? Text("like") : Text("unlike"),
                Container(
                  height: deviceheight * 0.12,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 14.0,
                      right: 14.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "EASY",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30),
                            ),
                            Text(
                              "ED",
                              style: TextStyle(
                                  color: Color.fromRGBO(38, 90, 232, 1),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                        InkWell(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      Color.fromRGBO(38, 90, 232, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              onPressed: () async {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: AddPostScreen(),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );

                                // nextScreen(context, AddPostScreen());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "+ ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    "Add Post",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: deviceheight * 0.7759,
                  child: FutureBuilder(
                      future: getpostdata(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await refreshdata();
                            },
                            child: ListView.builder(
                                itemCount: postlist.length,
                                itemBuilder: (context, index) {
                                  bool iscurrentindexpostalreadylikedbyuser =
                                      postlist[index].likes.any(
                                          (element) => element.user == uid);

                                  if (postlist[index].postFormat != null) {
                                    // if (postlist[index]
                                    //         .postFormat!
                                    //         .contains("video") ||
                                    //     postlist[index]
                                    //         .postFormat!
                                    //         .contains("application")) {
                                    //   iscurrentindexpostisavideo = true;
                                    // }
                                    iscurrentindexpostisavideo = postlist[index]
                                            .postFormat!
                                            .contains("video") ||
                                        postlist[index]
                                            .postFormat!
                                            .contains("application");
                                    // iscurrentindexpostisavideo = postlist[index]
                                    //     .postFormat!
                                    //     .contains("application");
                                  }

                                  commentlist =
                                      commentlist = List<Comment>.from(
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
                                    color: Colors.white,
                                    height: 620,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Text("Teacher json"),

                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.grey,
                                              //     offset: const Offset(
                                              //       5.0,
                                              //       5.0,
                                              //     ),
                                              //     blurRadius: 1.0,
                                              //     spreadRadius: 1.0,
                                              //   ), //BoxShadow
                                              //   // BoxShadow(
                                              //   //   color: Colors.white,
                                              //   //   offset: const Offset(0.0, 0.0),
                                              //   //   blurRadius: 0.0,
                                              //   //   spreadRadius: 0.0,
                                              //   // ), //BoxShadow
                                              // ],
                                            ),
                                            height: 600,
                                            width: 600,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    // color: Colors.red,
                                                    height: 45,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                radius: 26,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  postlist[
                                                                          index]
                                                                      .avatar,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 160,
                                                                // color: Colors.red,
                                                                child: Text(
                                                                  postlist[
                                                                          index]
                                                                      .userId,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              height: 20,
                                                              width: 30,
                                                              child:
                                                                  ExampleMenu(
                                                                unlikepostfunction:
                                                                    () async {
                                                                  await unlikepost(
                                                                      postid:
                                                                          postlist[index]
                                                                              .id,
                                                                      userid:
                                                                          uid);

                                                                  final snackBar =
                                                                      SnackBar(
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    margin: EdgeInsets
                                                                        .only(),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .black,
                                                                    duration: Duration(
                                                                        seconds:
                                                                            1),
                                                                    dismissDirection:
                                                                        DismissDirection
                                                                            .horizontal,
                                                                    content:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          const Text(
                                                                        'Post Disliked Sucessfully.',
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();

                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);

                                                                  setState(() {
                                                                    islike =
                                                                        true;
                                                                  });
                                                                },
                                                                builder: (_,
                                                                        showMenu) =>
                                                                    CupertinoButton(
                                                                  onPressed:
                                                                      showMenu,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  pressedOpacity:
                                                                      1,
                                                                  child:
                                                                      ImageIcon(
                                                                    AssetImage(
                                                                        'assets/more.png'),
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            138,
                                                                            84,
                                                                            192,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   height: 300,
                                                  //   width: 600,
                                                  //   child: Image.network(
                                                  //     postlist[index].post,
                                                  //     fit: BoxFit.fitWidth,
                                                  //   ),
                                                  // ),
                                                  Container(
                                                      height: 300,
                                                      width: 600,
                                                      child:
                                                          iscurrentindexpostisavideo
                                                              ? VideoPlayerItem(
                                                                  videoUrl:
                                                                      postlist[
                                                                              index]
                                                                          .post,
                                                                )
                                                              : InstaImageViewer(
                                                                  disableSwipeToDismiss:
                                                                      true,
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        postlist[index]
                                                                            .post,
                                                                    placeholder: (context, url) => Container(
                                                                        // color: Colors.red,
                                                                        height: 300,
                                                                        width: 600,
                                                                        child: Center(
                                                                            child: CircularProgressIndicator(
                                                                          color: Color.fromRGBO(
                                                                              38,
                                                                              90,
                                                                              232,
                                                                              1),
                                                                        ))),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.error),
                                                                    fadeOutDuration:
                                                                        const Duration(
                                                                            seconds:
                                                                                1),
                                                                    fadeInDuration:
                                                                        const Duration(
                                                                            seconds:
                                                                                3),
                                                                  ),
                                                                )),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          radius: 26,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            postlist[index]
                                                                .avatar,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Container(
                                                            // color: Colors.red,
                                                            width: devicewidth *
                                                                0.75,
                                                            child: Text(
                                                              "${postlist[index].content}",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // DATA PRINT

                                                  // // Text(snapshot.data![index].avatar),
                                                  // Text(
                                                  //     "postid: ${postlist[index].id}"),
                                                  // Text(
                                                  //     "userId: ${postlist[index].userId}"),
                                                  // Text(
                                                  //     "avatar: ${postlist[index].avatar}"),
                                                  // Text(
                                                  //     "content: ${postlist[index].content}"),
                                                  // Text(
                                                  //     "isBLocked: ${postlist[index].isBlocked.toString()}"),
                                                  // Text(
                                                  //     "date: ${postlist[index].date.toString()}"),
                                                  // Text(
                                                  //     "userId: ${postlist[index].id}"),

                                                  // Text(
                                                  //     "Likes:  ${postlist[index].likes.length}"),

                                                  //////////////////////////////////////
                                                  // Text("uid $uid"),
                                                  // islike
                                                  //     ? ElevatedButton(
                                                  //         onPressed: () async {
                                                  //           await postaddlike(
                                                  //               postid:
                                                  //                   postlist[index]
                                                  //                       .id,
                                                  //               userid: uid);

                                                  //           final snackBar = SnackBar(
                                                  //             behavior:
                                                  //                 SnackBarBehavior
                                                  //                     .floating,
                                                  //             margin:
                                                  //                 EdgeInsets.only(),
                                                  //             backgroundColor:
                                                  //                 Colors.black,
                                                  //             duration: Duration(
                                                  //                 seconds: 1),
                                                  //             dismissDirection:
                                                  //                 DismissDirection
                                                  //                     .horizontal,
                                                  //             content: Container(
                                                  //               height: 30,
                                                  //               child: const Text(
                                                  //                 'Post Liked Sucessfully.',
                                                  //                 style: TextStyle(),
                                                  //               ),
                                                  //             ),
                                                  //           );

                                                  //           ScaffoldMessenger.of(
                                                  //                   context)
                                                  //               .hideCurrentSnackBar();

                                                  //           ScaffoldMessenger.of(
                                                  //                   context)
                                                  //               .showSnackBar(
                                                  //                   snackBar);

                                                  //           setState(() {
                                                  //             islike = false;
                                                  //           });

                                                  //           // setState(() {
                                                  //           //   postlist[index].likes.length;
                                                  //           // });
                                                  //         },
                                                  //         child: Text("add Like"))
                                                  //     : ElevatedButton(
                                                  //         onPressed: () async {
                                                  //           await unlikepost(
                                                  //               postid:
                                                  //                   postlist[index]
                                                  //                       .id,
                                                  //               userid: uid);

                                                  //           final snackBar = SnackBar(
                                                  //             behavior:
                                                  //                 SnackBarBehavior
                                                  //                     .floating,
                                                  //             margin:
                                                  //                 EdgeInsets.only(),
                                                  //             backgroundColor:
                                                  //                 Colors.black,
                                                  //             duration: Duration(
                                                  //                 seconds: 1),
                                                  //             dismissDirection:
                                                  //                 DismissDirection
                                                  //                     .horizontal,
                                                  //             content: Container(
                                                  //               height: 30,
                                                  //               child: const Text(
                                                  //                 'Post UnLiked Sucessfully.',
                                                  //                 style: TextStyle(),
                                                  //               ),
                                                  //             ),
                                                  //           );
                                                  //           ScaffoldMessenger.of(
                                                  //                   context)
                                                  //               .hideCurrentSnackBar();

                                                  //           ScaffoldMessenger.of(
                                                  //                   context)
                                                  //               .showSnackBar(
                                                  //                   snackBar);

                                                  //           setState(() {
                                                  //             islike = true;
                                                  //           });
                                                  //         },
                                                  //         child: Text("unlike post")),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              // isalreadyliked
                                                              //     ?
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await postaddlike(
                                                                      postid:
                                                                          postlist[index]
                                                                              .id,
                                                                      userid:
                                                                          uid);

                                                                  final snackBar =
                                                                      SnackBar(
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    margin: EdgeInsets
                                                                        .only(),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .black,
                                                                    duration: Duration(
                                                                        seconds:
                                                                            1),
                                                                    dismissDirection:
                                                                        DismissDirection
                                                                            .horizontal,
                                                                    content:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          const Text(
                                                                        'Post Liked Sucessfully.',
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                    ),
                                                                  );

                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();

                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);

                                                                  print("data");

                                                                  print(uid);
                                                                  print(index);

                                                                  isCurrentUserLiked = postlist[
                                                                          index]
                                                                      .likes
                                                                      .any((like) =>
                                                                          like.user ==
                                                                          uid);

                                                                  // return ; // Key1 value not found

                                                                  // print(postlist[
                                                                  //         index]
                                                                  //     .likes.contains()
                                                                  //     );

                                                                  print(
                                                                      isCurrentUserLiked);

                                                                  setState(() {
                                                                    currentpostid =
                                                                        postlist[index]
                                                                            .id;
                                                                  });

                                                                  // setState(() {
                                                                  //   postlist[index].likes.length;
                                                                  // });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 26,
                                                                  width: 26,
                                                                  child:
                                                                      ImageIcon(
                                                                          color: iscurrentindexpostalreadylikedbyuser
                                                                              ? Colors.blue
                                                                              : Colors.black,
                                                                          AssetImage(
                                                                            "assets/likes.png",
                                                                          )),
                                                                ),
                                                              ),
                                                              // SizedBox(
                                                              //   width: 50,
                                                              // ),
                                                              // GestureDetector(
                                                              //   onTap: () async {
                                                              //     await unlikepost(
                                                              //         postid:
                                                              //             postlist[index]
                                                              //                 .id,
                                                              //         userid:
                                                              //             uid);

                                                              //     final snackBar =
                                                              //         SnackBar(
                                                              //       behavior:
                                                              //           SnackBarBehavior
                                                              //               .floating,
                                                              //       margin:
                                                              //           EdgeInsets
                                                              //               .only(),
                                                              //       backgroundColor:
                                                              //           Colors
                                                              //               .black,
                                                              //       duration:
                                                              //           Duration(
                                                              //               seconds:
                                                              //                   1),
                                                              //       dismissDirection:
                                                              //           DismissDirection
                                                              //               .horizontal,
                                                              //       content:
                                                              //           Container(
                                                              //         height: 30,
                                                              //         child:
                                                              //             const Text(
                                                              //           'Likes Updated Sucessfully.',
                                                              //           style:
                                                              //               TextStyle(),
                                                              //         ),
                                                              //       ),
                                                              //     );
                                                              //     ScaffoldMessenger.of(
                                                              //             context)
                                                              //         .hideCurrentSnackBar();

                                                              //     ScaffoldMessenger.of(
                                                              //             context)
                                                              //         .showSnackBar(
                                                              //             snackBar);

                                                              //     setState(() {
                                                              //       islike = true;
                                                              //     });
                                                              //   },
                                                              //   child: Container(
                                                              //     height: 30,
                                                              //     width: 30,
                                                              //     child: ImageIcon(
                                                              //         color: Colors.black,
                                                              //         AssetImage(
                                                              //           "assets/likes.png",
                                                              //         )),
                                                              //   ),
                                                              // ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  postlist[
                                                                          index]
                                                                      .likes
                                                                      .length
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showdownSheet(
                                                                  context:
                                                                      context,
                                                                  index1:
                                                                      index);
                                                            },
                                                            child: Container(
                                                              height: 26,
                                                              width: 26,
                                                              child: ImageIcon(
                                                                  AssetImage(
                                                                      "assets/comment.png")),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14.0),
                                                    child: TextFormField(
                                                      controller:
                                                          commentcontroller,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 3,
                                                            color: Color(
                                                                0xFF265AE8),
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 3,
                                                            color: Colors.black,
                                                          ), //<-- SEE HERE
                                                        ),
                                                        hintText:
                                                            "Enter comment..",
                                                        suffixIcon: IconButton(
                                                          iconSize: 20,
                                                          onPressed: () async {
                                                            setState(() {
                                                              isloading = true;
                                                            });

                                                            String userid = uid;
                                                            String comment =
                                                                commentcontroller
                                                                    .text;

                                                            await addcommentpost(
                                                                avatarphoto:
                                                                    globalteacherdata
                                                                        .userDetails[
                                                                            0]
                                                                        .avatar,
                                                                postid: postlist[
                                                                        index]
                                                                    .id,
                                                                comment:
                                                                    comment,
                                                                userid: userid);

                                                            commentcontroller
                                                                .text = "";

                                                            setState(() {
                                                              isloading = false;
                                                            });

                                                            final snackBar =
                                                                SnackBar(
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              margin: EdgeInsets
                                                                  .only(),
                                                              backgroundColor:
                                                                  Colors.black,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                              dismissDirection:
                                                                  DismissDirection
                                                                      .horizontal,
                                                              content:
                                                                  Container(
                                                                height: 30,
                                                                child:
                                                                    const Text(
                                                                  'Comment added Sucessfully.',
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                              ),
                                                            );

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          },
                                                          icon: isloading
                                                              ? Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: CircularProgressIndicator(
                                                                      color: Color.fromRGBO(
                                                                          38,
                                                                          90,
                                                                          232,
                                                                          1)),
                                                                )
                                                              : ImageIcon(
                                                                  AssetImage(
                                                                      'assets/sent.png'),
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  // ElevatedButton(
                                                  //     onPressed: () async {
                                                  //       String userid = uid;
                                                  //       String comment =
                                                  //           commentcontroller.text;

                                                  //       await addcommentpost(
                                                  //           postid:
                                                  //               postlist[index].id,
                                                  //           comment: comment,
                                                  //           userid: userid);
                                                  //     },
                                                  //     child: Text("post comment")),

                                                  // postlist[index].comments.isNotEmpty
                                                  //     ? Container(
                                                  //         height: 200,
                                                  //         child: ListView.builder(
                                                  //             itemCount:
                                                  //                 commentlist.length,
                                                  //             itemBuilder:
                                                  //                 (context, ind) {
                                                  //               return Column(
                                                  //                 children: [
                                                  //                   Row(
                                                  //                     mainAxisAlignment:
                                                  //                         MainAxisAlignment
                                                  //                             .spaceBetween,
                                                  //                     children: [
                                                  //                       Text(commentlist[
                                                  //                               ind]
                                                  //                           .comment),
                                                  //                       Text(commentlist[
                                                  //                               ind]
                                                  //                           .id),
                                                  //                       TextButton(
                                                  //                           onPressed:
                                                  //                               () async {
                                                  //                             // String
                                                  //                             //     commentid =
                                                  //                             //     ;
                                                  //                             await deletecommentpost(
                                                  //                                 postid:
                                                  //                                     postlist[index].id,
                                                  //                                 commentid: postlist[index].comments[ind].id,
                                                  //                                 userid: postlist[index].comments[ind].user);

                                                  //                             // print(index);
                                                  //                           },
                                                  //                           child:
                                                  //                               Text(
                                                  //                             "delete",
                                                  //                             style: TextStyle(
                                                  //                                 color:
                                                  //                                     Colors.red),
                                                  //                           ))
                                                  //                     ],
                                                  //                   ),
                                                  //                 ],
                                                  //               );
                                                  //             }),
                                                  //       )
                                                  //     : Text("no comments"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
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
  Future<void> refreshdata() async {
    await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ShowPostScreen()))
        .then((value) => onReturn());
  }

  Future addcommentpost(
      {required String avatarphoto,
      required String postid,
      required String comment,
      required String userid}) async {
    var response = await http.post(
      // Uri.https(
      //     'easyed-social-media-backend.onrender.com', '/comment/${postid}'),
      Uri.http('ec2-35-154-170-37.ap-south-1.compute.amazonaws.com',
          '/comment/${postid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode(
          {"userId": userid, "comment": comment, "avatar": avatarphoto}),
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
      // Uri.https('easyed-social-media-backend.onrender.com',
      //     '/comment/${postid}/${commentid}'),
      Uri.http('ec2-35-154-170-37.ap-south-1.compute.amazonaws.com',
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
      // Uri.https(
      //     'easyed-social-media-backend.onrender.com', '/unlike/${postid}'),
      Uri.http('ec2-35-154-170-37.ap-south-1.compute.amazonaws.com',
          '/unlike/${postid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode({"userId": userid}),
    );

    var data = response.body;

    if (data.contains("msg")) {
      if (alreadynotlikedmessage ==
          jsonDecode(response.body.toString())["msg"]) {
        // print("object");
        isalreadyunliked = true;
        print("isalreadyunliked: " + isalreadyunliked.toString());
      }
    } else {
      isalreadyunliked = false;
    }

    print(data);
  }

  Future postaddlike({required String postid, required String userid}) async {
    var response = await http.put(
      // Uri.https('easyed-social-media-backend.onrender.com', '/like/${postid}'),
      Uri.http('ec2-35-154-170-37.ap-south-1.compute.amazonaws.com',
          '/like/${postid}'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(sendData),
      body: json.encode({"userId": userid}),
    );

    var data = response.body;

    // print(jsonDecode(response.body.toString())["msg"]);
    if (data.contains("msg")) {
      if (alreadylikedmessage == jsonDecode(response.body.toString())["msg"]) {
        // print("object");
        isalreadyliked = true;
        print("isalreadyliked: " + isalreadyliked.toString());
      }
    } else {
      isalreadyliked = false;
    }

    print(data);
  }

  Future<List<Post>> getpostdata() async {
    final response = await http.get(
        // Uri.parse('https://easyed-social-media-backend.onrender.com/api/post'));
        Uri.parse(
            'http://ec2-35-154-170-37.ap-south-1.compute.amazonaws.com/api/post'));
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

  Stream<List<Post>> getstreampostdata() async* {
    yield await getpostdata();
  }

  void showdownSheet({
    required BuildContext context,
    required int index1,
  }) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: ModelSheetScreen(index1: index1),
            );
          }),
    );
  }
}
