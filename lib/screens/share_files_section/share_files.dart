import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

_asyncFileUpload(File file, BuildContext ctx) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String _userId = sharedPreferences.get('userId').toString();

  String url = 'https://myassistantbackend.herokuapp.com/file?userId=$_userId';

  var request = http.MultipartRequest("POST", Uri.parse(url));
  var pic = await http.MultipartFile.fromPath("file_field", file.path);
  request.files.add(pic);
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  if (responseString != 'File uploaded') {
    showAlertDialog(ctx, 'Oops! 😶',
        'An error occured while uploading, please check your internet connection and try again.');
  } else {
    showAlertDialog(ctx, 'Yaay! 😄', 'File uploaded.');
  }
}

showAlertDialog(BuildContext context, String title, String description) {
  Widget okButton = TextButton(
    child: const Text(
      "OK",
      style: TextStyle(
        fontSize: 15,
      ),
    ),
    onPressed: () => Navigator.pop(context),
  );

  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
    content: Text(
      description,
      style: const TextStyle(
        fontSize: 15,
      ),
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ShareFileSection extends StatefulWidget {
  const ShareFileSection({Key? key}) : super(key: key);

  @override
  State<ShareFileSection> createState() => _ShareFileSectionState();
}

class _ShareFileSectionState extends State<ShareFileSection> {
  String fileName = 'No files selected';
  late File file;
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'MyShare',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xFFfdfbfb),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  setState(() {
                    fileName = result!.files.first.name;
                  });
                  file = File(result!.files.single.path.toString());
                } else {
                  setState(() {
                    fileName = 'No files selected';
                  });
                }
              },
              child: Text(
                fileName,
                style: TextStyle(
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (() {
                if (result != null) {
                  _asyncFileUpload(file, context);
                }
              }),
              child: Container(
                height: 54,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 33, 8, 120),
                ),
                child: Center(
                  child: Text(
                    'Share',
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
