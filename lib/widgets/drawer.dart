import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sapp/Pages/editprofilesecreen.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(38, 90, 232, 1),
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        // _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                        height: 20,
                        width: 30,
                        child: Image.asset(
                          "assets/iconmenu.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 59,
                        width: 59,
                        // color: Colors.red,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/Ellipse1.png"),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tushar Singh",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "@tushar",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                height: 1,
                width: 400,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            ListTile(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: EditProfileScreen(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              leading: Icon(Icons.edit, color: Colors.white),
              title: Text(
                "Edit profile",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(CupertinoIcons.share, color: Colors.white),
              title: Text(
                "Share the app",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(CupertinoIcons.mail_solid, color: Colors.white),
              title: Text(
                "Contact us",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(CupertinoIcons.settings_solid, color: Colors.white),
              title: Text(
                "Language",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {},
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text(
                "Log out",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
