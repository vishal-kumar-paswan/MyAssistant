import 'package:assistant/utils/assistant_operations.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
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
  late bool isDataAvailable = false;
  late double? temperature = 0;
  late String? description = '';
  late Future<WeatherModel?> getWeatherDetails;
  WeatherModel? weatherModel;
  bool isMicActive = false;

  @override
  void initState() {
    // getWeatherDetails = GetWeatherDetails().fetchWeatherDetails();
    // weatherModel = await getWeatherDetails;
    super.initState();
    // getData();
    _initSpeech();
  }

  //TODO : Debug weather section
  // void getData() async {
  //   Future.delayed(const Duration(seconds: 2), () async {
  //     weatherModel = await GetWeatherDetails().fetchWeatherDetails;
  //   }).whenComplete(() {
  //     if (weatherModel != null) {
  //       setState(() {
  //         temperature = weatherModel?.temperature;
  //         description = weatherModel?.description;
  //         isDataAvailable = true;
  //       });
  //     }
  //   });
  // }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    setState(() {
      _lastWords = _speechEnabled == false
          ? "User denied microphone permissions"
          : "Hi there!";
    });
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      partialResults: false,
    );
    setState(() {
      isMicActive = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _lastWords = "Hi there!";
      isMicActive = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      // print("last words : $_lastWords");
    });
    // print("recognised words: " + _lastWords);
    // if (_lastWords != 'Hi there!') {
    AssistantOperations.selectTask(_lastWords);
    // }
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
            Visibility(
              visible: isDataAvailable,
              child: Text(
                temperature.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Visibility(
              visible: isDataAvailable,
              child: Text(
                description.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
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
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _startListening();
                        // print("recognised words: " + _lastWords);
                        // if (_lastWords != 'Hi there!') {
                        //   AssistantOperations.selectTask(_lastWords);
                        // }
                        Future.delayed(
                            const Duration(
                              seconds: 6,
                            ), () {
                          _stopListening();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.redAccent,
                        ),
                        width: 75,
                        height: 75,
                        child: Icon(
                          isMicActive
                              ? Icons.mic_rounded
                              : Icons.mic_off_rounded,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isMicActive,
                      child: SizedBox(
                        height: 100,
                        child: WaveWidget(
                          isLoop: true,
                          size: const Size(double.infinity, double.infinity),
                          config: CustomConfig(
                            gradients: [
                              [
                                const Color.fromARGB(255, 255, 83, 83),
                                const Color.fromARGB(119, 255, 53, 53)
                              ],
                              [
                                const Color.fromARGB(255, 205, 80, 80),
                                const Color.fromARGB(255, 200, 30, 30)
                              ],
                              [
                                const Color.fromARGB(255, 255, 111, 100),
                                const Color.fromARGB(235, 221, 42, 42)
                              ],
                              // [Colors.yellow, const Color(0x55FFEB3B)],
                            ],
                            durations: [3500, 1944, 1580],
                            heightPercentages: [0.20, 0.23, 0.25],
                            blur: const MaskFilter.blur(BlurStyle.solid, 10),
                            gradientBegin: Alignment.bottomLeft,
                            gradientEnd: Alignment.topRight,
                          ),
                          waveAmplitude: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
