import 'package:assistant/utils/assistant_operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  RxString homescreenMessage = 'Hi there!'.obs;

  bool isMicActive = false;
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  late bool? _speechEnabled;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();

    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    setState(() {
      _lastWords = _speechEnabled == false
          ? "User denied microphone permissions"
          : "Hi there!";
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    AssistantOperations().selectTask(_lastWords);
  }

  void _micActivity() {
    if (isMicActive == false) {
      isMicActive = true;
      setState(() {});
    } else {
      isMicActive = false;
      setState(() {});
    }
  }

  void permissionRequests() async {
    await [
      Permission.camera,
      Permission.contacts,
      Permission.microphone,
      Permission.sms,
      Permission.phone,
      Permission.accessNotificationPolicy,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "MyAssistant",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xff050208),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 13, 4, 44),
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  _lastWords,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // Icon(CupertinoIcons.settings),
                  // Icon(
                  //   CupertinoIcons.moon,
                  // )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          _micActivity();
          _startListening();
          _micActivity();
        },
        child: AvatarGlow(
          animate: isMicActive,
          endRadius: 150,
          duration: const Duration(seconds: 1),
          glowColor: const Color.fromARGB(255, 2, 80, 215),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
            width: 75,
            height: 75,
            child: Icon(
              isMicActive ? Icons.mic_rounded : Icons.mic_off_rounded,
              size: 26,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
