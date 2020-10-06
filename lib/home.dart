import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import './video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File file;
  String pathVideo = "";
  String text = 'No File Chosen';

  Future<void> _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['mp4', 'mkv', '3gp']);

    if (result != null) {
      file = File(result.files.first.path);

      setState(() {
        pathVideo = file.path;
      });

      PlatformFile files = result.files.first;

      setState(() {
        text = files.name;
      });

      print(files.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(color: Colors.black)),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Pick Video',
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
                onPressed: _pickFile),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Play Video',
                style: GoogleFonts.roboto(color: Colors.white),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoPlayer(file, text)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
