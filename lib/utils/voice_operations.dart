// import 'package:assistant/screens/homepage.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:assistant/utils/assistant_operations.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class VoiceOperations {
//   bool isMicActive = false;
//   final SpeechToText _speechToText = SpeechToText();
//   static final HomeScreenMessage _homeScreenMessage = HomeScreenMessage();
//   HomeScreenMessage controller = _homeScreenMessage.getController();
//   late bool? speechEnabled;
//   String lastWords = '';

//   void initSpeech() async {
//     speechEnabled = await _speechToText.initialize();

//     // setState(() {
//     //   _lastWords = _speechEnabled == false
//     //       ? "User denied microphone permissions"
//     //       : "Hi there!";
//     // });
//   }

//   void startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     // setState(() {});
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) {
//     lastWords = result.recognizedWords;
//     _homeScreenMessage.updateMessage(lastWords);
//     AssistantOperations().selectTask(lastWords);
//   }
// }
