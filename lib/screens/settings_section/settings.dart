import 'package:assistant/screens/login_and_signup/login.dart';
import 'package:assistant/screens/settings_section/about.dart';
import 'package:assistant/screens/settings_section/development_team.dart';
import 'package:assistant/screens/settings_section/how_to_use.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? _lights;
SharedPreferences? sharedPreferences;

class SettingsSection extends StatefulWidget {
  const SettingsSection({Key? key}) : super(key: key);

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  void toggleTemperatureFormat(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (value) {
      setState(() {
        sharedPreferences!.setString('temperature', 'fahrenheit');
      });
    } else {
      setState(() {
        sharedPreferences!.setString('temperature', 'celsius');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.nunito().fontFamily,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Temperature Format',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  const Text(
                    '°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      activeColor: const Color.fromARGB(255, 4, 53, 187),
                      value:
                          sharedPreferences?.get('temperature') == 'fahrenheit'
                              ? true
                              : false,
                      onChanged: (bool value) {
                        toggleTemperatureFormat(value);
                      },
                    ),
                  ),
                  const Text(
                    '°F',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(const HowToUseSection());
                },
                child: const Text(
                  'How to use?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.to(const DevelopmentTeamSection()),
                child: const Text(
                  'Development Team',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.to(const AboutSection()),
                child: const Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('email');
                  sharedPreferences.remove('userId');
                  Get.to(LoginScreen());
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              const Center(
                child: Text(
                  'Made with ❤️ using Flutter and Next.js',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
