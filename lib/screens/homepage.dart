import 'package:assistant/screens/settings_section/settings.dart';
import 'package:assistant/utils/assistant_operations.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:weather/weather.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final WeatherFactory wf = WeatherFactory('6d7b8aa0f6a34dd44744f2dc19f95b2f');
  final Position? position = Get.arguments[0];
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  late bool? _speechEnabled;
  late String _lastWords = '';
  late bool isDataAvailable = true;
  late int? temperature = 0;
  late String? description = 'null';
  late String? location = 'null';
  bool isMicActive = false;

  @override
  void initState() {
    _initSpeech();
    fetchWeatherData();
    TextToSpeechModel.speakText('Welcome to my assistant');
    super.initState();
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
    });

    AssistantOperations.selectTask(_lastWords);
  }

  void fetchWeatherData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    print('temperature value: ');
    print(sharedPreferences.get('temperature'));
    if (sharedPreferences.get('temperature') == 'celsius') {
      if (position != null) {
        Weather weatherData = await wf.currentWeatherByLocation(
            position!.latitude, position!.longitude);
        setState(() {
          temperature = weatherData.temperature?.celsius?.round();
          description = weatherData.weatherDescription;
          location = weatherData.areaName;
        });
      } else {
        List<Weather> weatherDataList =
            await wf.fiveDayForecastByCityName('New Delhi');
        setState(() {
          temperature = weatherDataList[0].temperature?.celsius?.round();
          description = weatherDataList[0].weatherDescription;
          location = weatherDataList[0].areaName;
        });
      }
    } else if (sharedPreferences.get('temperature') == 'fahrenheit') {
      if (position != null) {
        Weather weatherData = await wf.currentWeatherByLocation(
            position!.latitude, position!.longitude);
        setState(() {
          temperature = weatherData.temperature?.fahrenheit?.round();
          description = weatherData.weatherDescription;
          location = weatherData.areaName;
        });
      } else {
        List<Weather> weatherDataList =
            await wf.fiveDayForecastByCityName('New Delhi');
        setState(() {
          temperature = weatherDataList[0].temperature?.fahrenheit?.round();
          description = weatherDataList[0].weatherDescription;
          location = weatherDataList[0].areaName;
        });
      }
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
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const SettingsSection());
              },
              icon: const Icon(
                CupertinoIcons.settings_solid,
                color: Colors.white,
              ))
        ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.location,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(
                  width: 2.5,
                ),
                Text(
                  location!,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.thermometer,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 2.5,
                  ),
                  Text(
                    '${temperature!.toString()}°C, $description',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                ],
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
