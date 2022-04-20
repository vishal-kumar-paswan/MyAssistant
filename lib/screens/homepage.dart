import 'package:assistant/utils/assistant_operations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import '../models/weather_model.dart';
import '../utils/get_weather_details.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  late bool? _speechEnabled;
  late String _lastWords = '';
  late int? temperature = 0;
  late String? description = '';
  late Future<WeatherModel> getWeatherDetails;

  bool isMicActive = false;

  @override
  void initState() {
    super.initState();
    getWeatherDetails = GetWeatherDetails().getLocation();
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

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    AssistantOperations.selectTask(_lastWords);

    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      _lastWords = "Hi there!";
    });
  }

  void _micActivity() {
    if (isMicActive == false) {
      setState(() {
        isMicActive = true;
      });
    } else {
      setState(() {
        isMicActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "MyAssistant",
          style: TextStyle(
            fontSize: 30,
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
            Text(
              '°C',
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              description.toString(),
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  _lastWords,
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () {
                    _micActivity();
                    _startListening();
                    _micActivity();
                  },
                  child: AvatarGlow(
                    animate: isMicActive,
                    endRadius: 150,
                    duration: const Duration(seconds: 1),
                    glowColor: const Color.fromARGB(255, 251, 92, 92),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
