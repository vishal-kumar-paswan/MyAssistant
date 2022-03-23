import 'package:assistant/utils/assistant_operations.dart';
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
    permissionRequests();
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
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyAssistant",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _lastWords,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ]),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            _micActivity();
            _startListening();
            _micActivity();
          },
          child: AvatarGlow(
            animate: isMicActive,
            endRadius: 150,
            duration: const Duration(seconds: 1),
            glowColor: Colors.redAccent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.redAccent,
              ),
              width: 90,
              height: 90,
              child: Icon(
                isMicActive ? Icons.mic_rounded : Icons.mic_off_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
