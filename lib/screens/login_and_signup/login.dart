import 'dart:convert';

import 'package:assistant/screens/homepage.dart';
import 'package:assistant/screens/login_and_signup/signup.dart';
import 'package:assistant/utils/global_context.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> fetchLoginDetails(String _userId, String _password) async {
  String url =
      'http://ass69.herokuapp.com/login?email=$_userId&password=$_password';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  int status = response.statusCode;
  print("status" + status.toString());

  switch (status) {
    case 202:
      print('login success!!');
      print(response.body);

      final decodedJson = json.decode(response.body);

      print("decode value" + decodedJson['code']);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('email', _userId);
      sharedPreferences.setString('userId', decodedJson['code']);
      Get.to(const HomepageScreen());
      TextToSpeechModel.speakText('Welcome to my assistant');

      break;
    case 401:
      const snackBar = SnackBar(
        content: Text('Invalid login credentials.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      print('incorrect credentials');
      print(response.body);
      break;
    default:
      const snackBar = SnackBar(
        content: Text('Something went wrong, please try again later.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      print('something went wrong!!');
      break;
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final bool changeButton = false;

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'route',
        child: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'MyAssistant',
                          textStyle: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          speed: const Duration(
                            milliseconds: 200,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Makes your life simple.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      controller: userIdController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),

                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.mail,
                          color: Colors.white,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Username cannot be empty";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.lock_fill,
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 8) {
                          return "Password cannot be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          fetchLoginDetails(
                              userIdController.text, passwordController.text);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 27, 3, 115),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.to(SignupScreen()),
                          child: const Text('Signup'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
