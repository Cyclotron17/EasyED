import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sapp/Pages/LecturePage.dart';
import 'package:sapp/Pages/chapterscreen.dart';
import 'package:sapp/Pages/lecturesscreen.dart';
import 'package:sapp/Pages/pdfPage.dart';
import 'package:sapp/Pages/pdfviewerpage.dart';
import 'package:sapp/Pages/taskscreen.dart';
import 'package:sapp/pdf_api.dart';
import 'package:sapp/widgets/drawer.dart';
import 'package:sapp/widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Gamelist> gameimageurls = [
    Gamelist("assets/game.png"),
    Gamelist("assets/game.png"),
    Gamelist("assets/game.png"),
    Gamelist("assets/game.png"),
    Gamelist("assets/game.png"),
  ];

  late int selectedPage;
  late final PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void handleClick(String value) {
    switch (value) {
      case 'Option 1':
        break;
      case 'Option 2':
        break;
    }
  }

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = gameimageurls.length;
    double deviceheight = MediaQuery.of(context).size.height;
    double appbarheight = 45;

    double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: Column(
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
                    _scaffoldKey.currentState!.openDrawer();
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
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  height: 178,
                  width: 250,
                  // color: Colors.red,
                  child: PageView.builder(
                    allowImplicitScrolling: true, pageSnapping: true,
                    // dragStartBehavior: DragStartBehavior.start,
                    scrollBehavior: ScrollBehavior(
                        androidOverscrollIndicator:
                            AndroidOverscrollIndicator.glow),

                    controller: _pageController,
                    itemBuilder: buildlistitem,

                    itemCount: gameimageurls.length,
                    onPageChanged: (page) {
                      setState(() {
                        selectedPage = page;
                      });
                    },
                    // children: List.generate(pageCount, (index) {
                    //   return Container(
                    //     child: Center(
                    //       child: Text('Page $index'),
                    //     ),
                    //   );
                    // }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: PageViewDotIndicator(
                  currentItem: selectedPage,
                  count: pageCount,
                  unselectedColor: Colors.black26,
                  selectedColor: Colors.black,
                  duration: Duration(milliseconds: 200),
                  boxShape: BoxShape.circle,
                ),
              ),
              SizedBox(
                height: 2,
              ),
            ],
          ),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              "Embrace the thrill of\n learning.",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PdfPage(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(38, 90, 232, 1),
                      ),
                      child: Center(child: Image.asset("assets/notes.png")),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      // screen: TaskScreen(),
                      screen: TaskScreen(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(38, 90, 232, 1),
                      ),
                      child: Center(child: Image.asset("assets/task.png")),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, LecturePage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(38, 90, 232, 1),
                      ),
                      child: Center(
                          child: Container(
                              height: 35,
                              width: 35,
                              child: Image.asset("assets/lectures.png"))),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () async {
                //     final url =
                //         'https://cdn.filestackcontent.com/7w7wb68oSvGPstbLvtSB';
                //     final file = await PDFApi.loadNetwork(url);

                //     openPDF(context, file);
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       height: 50,
                //       width: 80,
                //       color: Colors.red,
                //       child: Center(child: Text("pdf download")),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildlistitem(BuildContext context, int index) {
    Gamelist gamewidget = gameimageurls[index];
    // return SizedBox(
    //   width: MediaQuery.of(context).size.width - 20,
    //   height: 300,
    //   child: Container(
    //     // key: itemKey,
    //     // color: Colors.red,
    //     height: 30,
    //     width: MediaQuery.of(context).size.width - 20,
    //     child: Column(
    //       children: [
    //         // Container(
    //         //   height: 2,
    //         //   width: 108,
    //         //   color: Colors.black,
    //         // ),
    //         Container(
    //           height: 30,
    //         ),
    //         Row(
    //           children: [
    //             // Container(
    //             //   height: 52,
    //             //   width: 7,
    //             //   color: Colors.black,
    //             // ),
    //             Container(
    //               height: 10,
    //               width: 22,
    //             ),
    //             Container(
    //               // color: Colors.red,
    //               width: MediaQuery.of(context).size.width - 80,
    //               height: 40,
    //               child: FittedBox(
    //                 fit: BoxFit.fitWidth,
    //                 child: Text(
    //                   textwidget.imageurl,
    //                   style: TextStyle(
    //                     color: Color.fromRGBO(136, 75, 197, 3),
    //                     fontSize: 24,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Container(
    //           height: 20,
    //         ),
    //         // Row(
    //         //   children: [
    //         //     SizedBox(
    //         //       width: 25,
    //         //     ),
    //         //     Container(
    //         //       height: 2,
    //         //       width: 108,
    //         //       color: Colors.black,
    //         //     ),
    //         //   ],
    //         // ),
    //       ],
    //     ),
    //   ),
    // );

    // return Container(
    //   height: 50,
    //   color: Colors.yellow,
    //   width: 50,
    // );

    return Column(
      children: [
        Container(
          height: 178,
          width: 178,
          child: Transform.scale(
            scale: index == selectedPage ? 1 : 0.9,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  gamewidget.imageurl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void openPDF(BuildContext context, File file) {
    nextScreen(
        context,
        PDFViewerPage(
          file: file,
        ));
  }
}

class Gamelist {
  final String imageurl;

  Gamelist(this.imageurl);
}
