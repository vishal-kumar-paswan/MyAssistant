// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/permission_requests.dart';
import '../screens/camera.dart';
import '../screens/homepage.dart';
import '../screens/login.dart';
import '../screens/signup.dart';

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
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      routes: {
        '/': (context) => HomepageScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/homepage': (context) => HomepageScreen(),
        '/camera': (context) => const CameraScreen(),
      },
      initialRoute: '/homepage',
    );
  }
}
