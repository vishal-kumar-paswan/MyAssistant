// ignore_for_file: avoid_print

import 'package:assistant/screens/alarm_section/alarms.dart';
import 'package:assistant/screens/query_page/query_result.dart';
import 'package:assistant/screens/settings_section/development_team.dart';
import 'package:assistant/screens/settings_section/how_to_use.dart';
import 'package:assistant/screens/share_files_section/share_files.dart';
import 'package:assistant/screens/splash_screen.dart';
import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/homepage.dart';
import 'screens/login_and_signup/login.dart';
import 'screens/login_and_signup/signup.dart';
import 'screens/notes_section/notes_page.dart';
import 'screens/reminders_section/reminders.dart';
import 'screens/settings_section/about.dart';
import 'screens/settings_section/settings.dart';

Future<void> checkIfAllPermissionsAreAllowed() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  bool bluetoothPermission = await Permission.bluetooth.status.isDenied;
  bool bluetoothConnectPermission =
      await Permission.bluetoothConnect.status.isDenied;
  bool contactsPermission = await Permission.contacts.status.isDenied;
  bool microphonePermission = await Permission.microphone.status.isDenied;
  bool smsPermission = await Permission.sms.status.isDenied;
  bool phonePermission = await Permission.phone.status.isDenied;
  bool locationPermission = await Permission.location.status.isDenied;

  bluetoothPermission &&
          bluetoothConnectPermission &&
          contactsPermission &&
          smsPermission &&
          microphonePermission &&
          phonePermission &&
          locationPermission
      ? sharedPreferences.setBool('allPermissionsAllowed', true)
      : sharedPreferences.setBool('allPermissionsAllowed', false);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.contacts,
    Permission.microphone,
    Permission.sms,
    Permission.phone,
    Permission.location,
  ].request().whenComplete(() {
    checkIfAllPermissionsAreAllowed().whenComplete(
      () => runApp(const Assistant()),
    );
  });
}

class Assistant extends StatelessWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/homepage': (context) => const HomepageScreen(),
        '/notesSection': (context) => const NotesSection(),
        '/remindersSection': (context) => const ReminderSection(),
        '/alarmSection': (context) => const AlarmClockSection(),
        '/shareFileSection': (context) => ShareFileSection(),
        '/querySection': (context) => QuerySection(),
        '/settingsSection': (context) => const SettingsSection(),
        '/developementTeamSection': (context) => const DevelopmentTeamSection(),
        '/aboutSection': (context) => const AboutSection(),
        '/howToUseSection': (context) => const HowToUseSection(),
      },
      initialRoute: '/',
    );
  }
}
