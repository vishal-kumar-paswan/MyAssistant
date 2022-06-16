import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

//TODO: Add the open other app how to use

void _launchDesktopSite() async {
  if (await canLaunch('https://mywebassistant.herokuapp.com')) {
    await launch('https://mywebassistant.herokuapp.com');
  }
}

class HowToUseSection extends StatelessWidget {
  const HowToUseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How to use?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.nunito().fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MyAssistant is a voice assistant app for managing all your daily tasks with ease.\nTap on the microphone button and speak any command to perform your tasks.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.phone,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Call YourContactName" to make a call.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.mail,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Send a message to YourContactName" to send a text.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.music_note_2,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Play some music" to groove on some beats.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.pen,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Add notes" to add some notes.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.pencil_ellipsis_rectangle,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Open notes" to access all your notes.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.bell,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Set a reminder" to get reminders of your important tasks.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.alarm,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Set an alarm" to set an alarm.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.arrow_right_square,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Say "Open AppName" to open any application.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.share,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: const Text(
                        'Say "Share files" to send files to your PC.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Just visit the url on your PC given below and sign in with your login credentials.',
                            style: TextStyle(
                              // fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: _launchDesktopSite,
                            child: Text(
                              'https://mywebassistant.herokuapp.com',
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                // fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}