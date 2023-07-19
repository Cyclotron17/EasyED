import 'package:flutter/material.dart';
import 'package:sapp/Pages/addpostscreen.dart';
import 'package:sapp/Pages/showpostscreen.dart';
import 'package:sapp/widgets/widgets.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  nextScreen(context, AddPostScreen());
                },
                child: Text("Add Post")),
            ElevatedButton(
                onPressed: () {
                  nextScreen(context, ShowPostScreen());
                },
                child: Text("Show Post")),
          ],
        ),
      )),
    );
  }
}
