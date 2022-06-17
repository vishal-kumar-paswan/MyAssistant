import 'package:assistant/utils/text_to_speech.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

import '../../constants.dart';

class AlarmClockSection extends StatefulWidget {
  const AlarmClockSection({Key? key}) : super(key: key);

  @override
  State<AlarmClockSection> createState() => _AlarmClockSectionState();
}

class _AlarmClockSectionState extends State<AlarmClockSection> {
  late String time;
  late int hour = 0, minute = 0;
  bool setAlarm = true;

  void _setAlarm() {
    setState(() {
      setAlarm = false;
    });

    hour = int.parse(time.substring(time.indexOf(' ') + 1, time.indexOf(':')));
    minute = int.parse(time.substring(time.indexOf(':') + 1));
    FlutterAlarmClock.createAlarm(hour, minute);
    TextToSpeechModel.speakText(
        'Alarm added for $hour hours and $minute minutes');
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: setAlarm,
      replacement: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xFFfdfbfb),
          leading: IconButton(
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/homepage", (Route<dynamic> route) => false);
              }),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: screenBackground,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Alarm added for $hour:$minute',
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    color: const Color.fromARGB(255, 85, 18, 241),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/homepage", (Route<dynamic> route) => false);
                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 85, 18, 241),
                    ),
                    child: Center(
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xFFfdfbfb),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'MyAlarm',
            style: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: Container(
          decoration: screenBackground,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DateTimePicker(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select time',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 22,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  color: const Color.fromARGB(255, 85, 18, 241),
                  fontSize: 30,
                ),
                type: DateTimePickerType.time,
                initialValue: '',
                firstDate: DateTime(2022),
                lastDate: DateTime(2023),
                dateLabelText: 'Date',
                onChanged: (val) {
                  String currentDateTimeTime = DateTime.now().toString();
                  String currentDate = currentDateTimeTime.substring(
                      0, currentDateTimeTime.indexOf(' '));
                  val = currentDate + " " + val;
                  time = val;
                },
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _setAlarm,
                child: Container(
                  height: 54,
                  width: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 85, 18, 241),
                  ),
                  child: Center(
                    child: Text(
                      'Set Alarm',
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
      ),
    );
  }
}
