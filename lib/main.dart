// ignore_for_file: avoid_print
import 'package:assistant/screens/notes_section/note_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/permission_requests.dart';
import '../screens/camera.dart';
import '../screens/homepage.dart';
import 'screens/login_and_signup/login.dart';
import 'screens/login_and_signup/signup.dart';
import 'screens/reminders_section/reminders.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionRequests.permissionRequests();
  runApp(const Assistant());
}

class Assistant extends StatelessWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      routes: {
        '/': (context) => const HomepageScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/homepage': (context) => const HomepageScreen(),
        '/camera': (context) => const CameraScreen(),
        '/notesSection': (context) => const NotesSection(),
        '/remindersSection': (context) => const ReminderSection()
      },
      initialRoute: '/login',
    );
  }
}
