import 'package:assistant/models/contact_details.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:assistant/screens/camera.dart';
import 'package:assistant/utils/fetch_contact_details.dart';
import 'package:camera/camera.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:telephony/telephony.dart';
import 'package:device_apps/device_apps.dart';

import 'fetch_app_list.dart';

final FlutterTts flutterTts = FlutterTts();
final Telephony telephony = Telephony.instance;

class AssistantOperations {
  bool isMicActive = false;
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = 'Hello defaluhskdl';

  void _initSpeech() async {
    await _speechToText.initialize();
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
  }

  void openApplication(String _packageName) async {
    _packageName != ""
        ? await DeviceApps.openApp(_packageName.toString())
        : TextToSpeechModel.speak("App is not installed");
  }

  Future<void> selectTask(String operation) async {
    // For calling
    if (operation.toLowerCase().startsWith('call')) {
      String contactName = operation.substring(operation.indexOf(' ') + 1);
      ContactDetails _contactDetails =
          await FetchContactDetails().getContactNumber(contactName);

      if (_contactDetails.isContactFound) {
        await FlutterPhoneDirectCaller.callNumber(
            (_contactDetails.contactNumber).toString());
      }
    }
    //  For sending SMS
    else if (operation.toLowerCase().startsWith('send a message to')) {
      String contactName = operation.substring(operation.lastIndexOf(' ') + 1);
      ContactDetails _contactDetails =
          await FetchContactDetails().getContactNumber(contactName);

      if (_contactDetails.isContactFound) {
        _initSpeech();
        int check =
            await TextToSpeechModel.speak("What message you want to send");
        if (check == 0) {
          _startListening();
          await telephony.sendSmsByDefaultApp(
              to: _contactDetails.contactNumber.toString(),
              message: _lastWords);
        }
      } else {
        TextToSpeechModel.speak("Contact not found");
      }
    }

    //Add notes
    else if (operation.toLowerCase().compareTo('add notes') == 0 ||
        operation.toLowerCase().compareTo('open notes') == 0) {
      Get.toNamed('/notesSection');
    }
    //Set reminder
    else if (operation.toLowerCase().compareTo('set reminder') == 0) {
      Get.toNamed('/remindersSection');
    }
    // To open device apps
    else if (operation.toLowerCase().startsWith('open')) {
      String appName = operation.substring(operation.lastIndexOf(' ') + 1);
      String packageName = await FetchInstalledAppList.getPackageName(appName);
      openApplication(packageName);
    }
  }
}

// void openCamera() async {
//   var status = await Permission.camera.request().isGranted;
//   if (status) {
//     await availableCameras().then(
//       (value) => Get.to(
//         CameraScreen(
//           cameraList: value,
//         ),
//       ),
//     );
//   }
// }
