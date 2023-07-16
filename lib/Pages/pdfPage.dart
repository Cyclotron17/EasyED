import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/Pages/addpdfscreen.dart';
import 'package:sapp/Pages/notesscreen.dart';
import 'package:sapp/widgets/widgets.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  nextScreen(context, AddPdfScreen());
                },
                child: Text("ADD PDF "),
              ),
              ElevatedButton(
                onPressed: () {
                  nextScreen(context, NotesScreen());
                },
                child: Text("Show PDF "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
