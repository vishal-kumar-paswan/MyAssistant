// ignore_for_file: avoid_print

import 'package:assistant/screens/homepage.dart';
import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../utils/text_to_speech.dart';

Future<dynamic> signUpDetails(
    String _name, String _email, String _username, String _password) async {
  String url =
      'https://myassistantbackend.herokuapp.com/signup?email=$_email&password=$_password';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  int status = response.statusCode;
  print("status" + status.toString());

  switch (status) {
    case 201:
      Get.to(const HomepageScreen());
      TextToSpeechModel.speakText('Welcome to my assistant');
      print('signup success!!');
      print(response.body);
      break;
    case 205:
      print('check credentials');
      const snackBar = SnackBar(
        content: Text('Signup credentials already in use.'),
      );

      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
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

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey there,',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 26.0,
                      ),
                    ),
                    const Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.person,
                          color: Colors.white,
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Name cannot be empty";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.mail,
                          color: Colors.white,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Email cannot be empty";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.at,
                          color: Colors.white,
                        ),
                        hintText: 'Username',
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
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
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
                        horizontal: 50.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          signUpDetails(
                            _nameController.text,
                            _emailController.text,
                            _usernameController.text,
                            _passwordController.text,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: const Center(
                            child: Text(
                              'Sign Up',
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
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed('/login'),
                          child: const Text('Login'),
                        )
                      ],
                    )
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
