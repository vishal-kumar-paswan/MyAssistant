import 'package:assistant/utils/text_to_speech.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

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

class ReminderSection extends StatefulWidget {
  const ReminderSection({Key? key}) : super(key: key);

  @override
  State<ReminderSection> createState() => _ReminderSectionState();
}

class _ReminderSectionState extends State<ReminderSection> {
  late String taskName;
  late int hour, minute;
  late String time;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool setReminder = true;

  final _taskKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    const androidInitialize = AndroidInitializationSettings('flutter');
    const iosinitialize = IOSInitializationSettings();
    const initializeSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosinitialize,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onSelectNotification: notificationSelected,
    );
  }

  Future _showNotification() async {
    if (_taskKey.currentState!.validate()) {
      setState(() {
        setReminder = false;
      });
      const androidDetails = AndroidNotificationDetails(
        "MyAssistant ID",
        "MyAssistant",
        importance: Importance.max,
      );
      const iOSDetails = IOSNotificationDetails();
      const generalNotificationDetails =
          NotificationDetails(android: androidDetails, iOS: iOSDetails);

      var scheduledTime = DateTime.parse(time);

      // ignore: deprecated_member_use
      flutterLocalNotificationsPlugin.schedule(
        0,
        taskName,
        "Get your task done!",
        scheduledTime,
        generalNotificationDetails,
      );
      TextToSpeechModel.speakText('Reminder added');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: setReminder,
      replacement: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: screenBackground,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Task Scheduled!',
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () => Get.toNamed('/homepage'),
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 33, 8, 120),
                    ),
                    child: Center(
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          color: Colors.black,
                          fontSize: 13,
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
          automaticallyImplyLeading: false,
          title: Text(
            'MyReminders',
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: screenBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  key: _taskKey,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Your task cannot be empty";
                    }
                    return null;
                  },
                  showCursor: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your task',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.nunito().fontFamily,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 33, 8, 120),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (_val) {
                    taskName = _val;
                  },
                ),
              ),
              const SizedBox(height: 10),
              DateTimePicker(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select time',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  color: Colors.black,
                  fontSize: 20,
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
                onTap: _showNotification,
                child: Container(
                  height: 54,
                  width: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 33, 8, 120),
                  ),
                  child: Center(
                    child: Text(
                      'Schedule Task',
                      style: TextStyle(
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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

  Future notificationSelected(String? payload) async {
    setState(() {
      setReminder = true;
    });
  }
}
